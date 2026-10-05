# Standalone Shared Edge Check: classification, HyperMesh adapter, and GUI.
# Shared-edge context checker for quadratic surface faces.
# scan_faces is pure Tcl: face rows are {config node-list}, and shared is a
# dictionary of node IDs present in both selected components.
namespace eval ::SharedEdgeContext {}

proc ::SharedEdgeContext::pair {a b} {
    if {$a < $b} {return "$a,$b"}
    return "$b,$a"
}

proc ::SharedEdgeContext::edge_nodes {pair} {
    return [split $pair ,]
}

proc ::SharedEdgeContext::face_edges {cfg nodes} {
    if {$cfg == 106 && [llength $nodes] >= 6} {
        set defs {{0 1 3} {1 2 4} {2 0 5}}
    } elseif {$cfg == 108 && [llength $nodes] >= 8} {
        set defs {{0 1 4} {1 2 5} {2 3 6} {3 0 7}}
    } else {
        return {}
    }
    set result {}
    foreach def $defs {
        lassign $def i j k
        lappend result [list [pair [lindex $nodes $i] [lindex $nodes $j]] [lindex $nodes $k]]
    }
    return $result
}

proc ::SharedEdgeContext::scan_faces {face_rows shared} {
    set faces {}
    set incidence [dict create]
    set corner_mids [dict create]
    set node_faces [dict create]
    foreach row $face_rows {
        lassign $row cfg nodes
        set edges [face_edges $cfg $nodes]
        if {![llength $edges]} {continue}
        set states {}
        set full 1
        set fid [llength $faces]
        foreach edge $edges {
            lassign $edge key mid
            lassign [edge_nodes $key] a b
            set corners [expr {[dict exists $shared $a] + [dict exists $shared $b]}]
            set mid_shared [dict exists $shared $mid]
            set complete [expr {$corners == 2 && $mid_shared}]
            if {!$complete} {set full 0}
            lappend states [list $key $mid $corners $mid_shared $complete]
            dict lappend incidence $key $fid
            dict set corner_mids $key $mid 1
        }
        foreach nid [lrange $nodes 0 [expr {$cfg == 106 ? 2 : 3}]] {
            dict lappend node_faces $nid $fid
        }
        lappend faces [list $states $full]
    }

    # Connected components of wholly shared surface faces. Adjacency is by an
    # entire quadratic edge, never by a corner alone.
    set clusters [dict create]
    set cluster_id 0
    for {set seed 0} {$seed < [llength $faces]} {incr seed} {
        if {![lindex [lindex $faces $seed] 1] || [dict exists $clusters $seed]} {continue}
        incr cluster_id
        dict set clusters $seed $cluster_id
        set queue [list $seed]
        for {set qi 0} {$qi < [llength $queue]} {incr qi} {
            set fid [lindex $queue $qi]
            foreach edge [lindex [lindex $faces $fid] 0] {
                set key [lindex $edge 0]
                foreach neighbor [dict get $incidence $key] {
                    if {[lindex [lindex $faces $neighbor] 1] && ![dict exists $clusters $neighbor]} {
                        dict set clusters $neighbor $cluster_id
                        lappend queue $neighbor
                    }
                }
            }
        }
    }
    set node_clusters [dict create]
    set full_nodes [dict create]
    set full_edges [dict create]
    dict for {nid fids} $node_faces {
        foreach fid $fids {
            if {[dict exists $clusters $fid]} {
                dict set node_clusters $nid [dict get $clusters $fid] 1
                dict set full_nodes $nid 1
            }
        }
    }
    dict for {fid cluster} $clusters {
        foreach edge [lindex [lindex $faces $fid] 0] {
            dict set full_edges [lindex $edge 0] 1
        }
    }

    set missing [dict create]
    set extra [dict create]
    set inconsistent [dict create]
    set complete_edges [dict create]
    dict for {key fids} $incidence {
        set mids [dict keys [dict get $corner_mids $key]]
        if {[llength $mids] != 1} {
            # Different mids on the same geometric edge need explicit review.
            dict set inconsistent $key [edge_nodes $key]
            continue
        }
        set mid [lindex $mids 0]
        lassign [edge_nodes $key] a b
        set corners [expr {[dict exists $shared $a] + [dict exists $shared $b]}]
        set mid_shared [dict exists $shared $mid]
        if {$corners == 2 && $mid_shared} {
            dict set complete_edges $key [list $a $b $mid]
        }
        if {$mid_shared && $corners < 2} {
            dict set inconsistent $key [list $a $b $mid]
            continue
        }
        if {$corners != 2} {continue}

        if {!$mid_shared} {
            # The four other edges of the two incident TRIA6 faces form a
            # closed, completely shared ring around the candidate. A single
            # missing mid in that ring is an interior hole, whereas a patch
            # boundary has one or more incomplete surrounding edges.
            if {[llength $fids] != 2} {continue}
            set qualified 1
            foreach fid $fids {
                set outer_count 0
                foreach edge [lindex [lindex $faces $fid] 0] {
                    lassign $edge other_key other_mid other_corners other_mid_shared complete
                    if {$other_key eq $key} {continue}
                    if {!$complete} {set qualified 0; break}
                    incr outer_count
                }
                if {!$qualified || $outer_count != 2} {set qualified 0; break}
            }
            if {$qualified} {
                dict set missing $key [list $a $b $mid]
            }
            continue
        }

        set touches_full 0
        foreach fid $fids {
            if {[dict exists $clusters $fid]} {set touches_full 1; break}
        }
        if {$touches_full} {continue}

        # A complete edge outside any complete face may be an isolated bridge.
        # If both ends belong to the same surrounding full-face region, the
        # evidence is ambiguous, so leave it for manual review.
        set ca [expr {[dict exists $node_clusters $a] ? [dict keys [dict get $node_clusters $a]] : {}}]
        set cb [expr {[dict exists $node_clusters $b] ? [dict keys [dict get $node_clusters $b]] : {}}]
        set same_region 0
        foreach c $ca {if {[lsearch -exact $cb $c] >= 0} {set same_region 1; break}}
        if {$same_region} {
            dict set inconsistent $key [list $a $b $mid]
        } else {
            dict set extra $key [list $a $b $mid]
        }
    }
    return [dict create missing $missing extra $extra inconsistent $inconsistent \
        full_edges $full_edges full_nodes $full_nodes \
        complete_edges $complete_edges faces [llength $faces] \
        full_faces [dict size $clusters] regions $cluster_id]
}

# A bridge is a complete edge whose removal separates two areas that each
# contain at least one wholly shared face. Iterative Tarjan DFS is linear in
# the shared-edge network and avoids Tcl's recursion-depth limit.
proc ::SharedEdgeContext::bridges_between_regions {complete_edges full_nodes} {
    set adjacency [dict create]
    dict for {key edge} $complete_edges {
        lassign $edge a b mid
        dict lappend adjacency $a [list $b $key]
        dict lappend adjacency $b [list $a $key]
    }
    set discovery [dict create]
    set low [dict create]
    set parent [dict create]
    set subtree_faces [dict create]
    set bridges [dict create]
    set tick 0
    dict for {root neighbors} $adjacency {
        if {[dict exists $discovery $root]} {continue}
        incr tick
        dict set discovery $root $tick
        dict set low $root $tick
        dict set subtree_faces $root [dict exists $full_nodes $root]
        set pending {}
        set top 0
        set stack($top) [list $root 0]
        while {$top >= 0} {
            lassign $stack($top) v index
            set nexts [dict get $adjacency $v]
            if {$index < [llength $nexts]} {
                set stack($top) [list $v [expr {$index + 1}]]
                lassign [lindex $nexts $index] w key
                if {![dict exists $discovery $w]} {
                    dict set parent $w [list $v $key]
                    incr tick
                    dict set discovery $w $tick
                    dict set low $w $tick
                    dict set subtree_faces $w [dict exists $full_nodes $w]
                    incr top
                    set stack($top) [list $w 0]
                } elseif {![dict exists $parent $v] ||
                    $w ne [lindex [dict get $parent $v] 0]} {
                    set old [dict get $low $v]
                    set seen [dict get $discovery $w]
                    if {$seen < $old} {dict set low $v $seen}
                }
            } else {
                unset stack($top)
                incr top -1
                if {[dict exists $parent $v]} {
                    lassign [dict get $parent $v] p key
                    set child_low [dict get $low $v]
                    if {$child_low < [dict get $low $p]} {dict set low $p $child_low}
                    dict incr subtree_faces $p [dict get $subtree_faces $v]
                    if {$child_low > [dict get $discovery $p]} {
                        lappend pending [list $key [dict get $subtree_faces $v]]
                    }
                }
            }
        }
        set total [dict get $subtree_faces $root]
        foreach item $pending {
            lassign $item key side
            if {$side > 0 && $total - $side > 0} {
                dict set bridges $key [list $side [expr {$total - $side}]]
            }
        }
    }
    return $bridges
}

# HyperMesh adapter for the quadratic shared-edge context checker.

namespace eval ::SharedEdgeContext {
    variable last_shared_nodes
    if {![info exists last_shared_nodes]} {set last_shared_nodes {}}
}
namespace eval ::SharedEdgeContext {
    variable last_report
    if {![info exists last_report]} {set last_report {}}
    variable report_script_dir [file dirname [file normalize [info script]]]
}

proc ::SharedEdgeContext::palette_color {rgb} {
    set best 1
    set distance_best 1000000000
    set index 0
    foreach swatch [hm_winfo entitycolors] {
        if {[llength $swatch] >= 3} {
            lassign $swatch r g b
            set dr [expr {$r - [lindex $rgb 0]}]
            set dg [expr {$g - [lindex $rgb 1]}]
            set db [expr {$b - [lindex $rgb 2]}]
            set distance [expr {$dr*$dr + $dg*$dg + $db*$db}]
            if {$distance < $distance_best} {
                set distance_best $distance
                set best [expr {$index + 1}]
            }
        }
        incr index
    }
    return $best
}

proc ::SharedEdgeContext::unique_name {prefix} {
    set name $prefix
    set serial 2
    while {![catch {hm_getvalue comps name=$name dataname=id} id] && $id ne "" && $id ne "0"} {
        set name "${prefix}_$serial"
        incr serial
    }
    return $name
}

proc ::SharedEdgeContext::source_faces {source_id source_config shared {element_rows __fetch__}} {
    set rows {}
    if {$element_rows eq "__fetch__"} {
        *createmark elems 1 "by node" {*}[dict keys $shared]
        set element_rows {}
        foreach cid [hm_getvalue elems mark=1 dataname=collector.id] \
            cfg [hm_getvalue elems mark=1 dataname=config] \
            ns [hm_getvalue elems mark=1 dataname=nodes] {
            if {$cid == $source_id} {lappend element_rows [list $cfg $ns]}
        }
    }
    if {$source_config < 200} {
        foreach row $element_rows {
            lassign $row cfg ns
            if {$cfg == 106 || $cfg == 108} {lappend rows $row}
        }
        return $rows
    }

    # Read the nearby Tet10/Tet4 connectivity in bulk. Face incidence by
    # corner triplet removes internal tetrahedral faces without *findfaces.
    set counts [dict create]
    set values [dict create]
    set unsupported 0
    foreach row $element_rows {
        lassign $row cfg ns
        if {$cfg == 210 && [llength $ns] >= 10} {
            set patterns {{0 1 2 4 5 6} {0 1 3 4 8 7} {0 2 3 6 9 7} {1 2 3 5 9 8}}
            set face_cfg 106
        } elseif {$cfg == 204 && [llength $ns] >= 4} {
            set patterns {{0 1 2} {0 1 3} {0 2 3} {1 2 3}}
            set face_cfg 103
        } else {
            set unsupported 1
            break
        }
        foreach pattern $patterns {
            set face {}
            foreach index $pattern {lappend face [lindex $ns $index]}
            set near 0
            foreach nid $face {if {[dict exists $shared $nid]} {set near 1; break}}
            if {!$near} {continue}
            set key [join [lsort -integer [lrange $face 0 2]] ,]
            dict incr counts $key
            if {![dict exists $values $key]} {dict set values $key [list $face_cfg $face]}
        }
    }
    if {!$unsupported} {
        dict for {key count} $counts {
            if {$count == 1} {lappend rows [dict get $values $key]}
        }
        return $rows
    }

    # Other solids use the HyperMesh exterior-face command. Never delete a
    # pre-existing ^faces component owned by the user.
    if {![catch {hm_getvalue comps name="^faces" dataname=id} old] && $old ne "" && $old ne "0"} {
        error "Temporary component ^faces already exists; rename it before checking"
    }
    *createmark comps 1 $source_id
    *findfaces comps 1
    set rc [catch {
        *createmark elems 1 "^faces"
        foreach cfg [hm_getvalue elems mark=1 dataname=config] ns [hm_getvalue elems mark=1 dataname=nodes] {
            if {$cfg == 106 || $cfg == 108} {lappend rows [list $cfg $ns]}
        }
    } err opts]
    catch {*createmark elems 1 "^faces"; *deletemark elems 1}
    catch {*createmark comps 1 "^faces"; *deletemark comps 1}
    if {$rc} {return -options $opts $err}
    return $rows
}

proc ::SharedEdgeContext::create_highlights {edges prefix color} {
    variable highlight_by_name
    if {![dict size $edges]} {return ""}
    set name [unique_name $prefix]
    *collectorcreateonly comps $name "" $color
    set rc [catch {
        *currentcollector comps $name
        set line_nodes {}
        dict for {key edge} $edges {
            lappend line_nodes [lindex $edge 0] [lindex $edge 1]
        }
        *createarray [llength $line_nodes] {*}$line_nodes
        *createelements 2 1 1 [llength $line_nodes]
        set cid [hm_getvalue comps name=$name dataname=id]
        *createmark elems 1 "by collector id" $cid
        set ids [hm_getmark elems 1]
        set actual [llength $ids]
        if {$actual != [dict size $edges]} {
            error "Highlight readback failed for $name: expected [dict size $edges], got $actual"
        }
        foreach eid $ids nodes [hm_getvalue elems mark=1 dataname=nodes] {
            if {[llength $nodes] == 2} {
                dict set highlight_by_name $name \
                    [pair [lindex $nodes 0] [lindex $nodes 1]] $eid
            }
        }
    } err opts]
    if {$rc} {
        catch {*createmark comps 1 $name; *deletemark comps 1}
        return -options $opts $err
    }
    return $name
}

proc ::SharedEdgeContext::default_colors {} {
    return [dict create missing [palette_color {255 0 0}] \
        extra [palette_color {255 255 0}] \
        inconsistent [palette_color {255 140 0}] \
        shared_faces [palette_color {0 170 255}]]
}

proc ::SharedEdgeContext::validate_colors {colors} {
    set count [llength [hm_winfo entitycolors]]
    foreach category {missing extra inconsistent} {
        if {![dict exists $colors $category]} {error "Missing color for $category"}
        set id [dict get $colors $category]
        if {![string is integer -strict $id] || $id < 1 || $id > $count} {
            error "Invalid HyperMesh palette color for $category: $id"
        }
    }
    if {[dict exists $colors shared_faces]} {
        set id [dict get $colors shared_faces]
        if {![string is integer -strict $id] || $id < 1 || $id > $count} {
            error "Invalid HyperMesh palette color for shared_faces: $id"
        }
    }
    return $colors
}

proc ::SharedEdgeContext::recolor_highlights {output_by_category colors} {
    validate_colors $colors
    set previous [dict create]
    set changed {}
    set rc [catch {
        dict for {category names} $output_by_category {
            foreach name $names {
            set cid [hm_getvalue comps name=$name dataname=id]
            if {$cid eq "" || $cid eq "0"} {error "Highlight component $name no longer exists"}
            dict set previous $cid [hm_getvalue comps id=$cid dataname=color]
            *createmark comps 1 "by id only" $cid
            *colormark components 1 [dict get $colors $category]
            if {[hm_getvalue comps id=$cid dataname=color] != [dict get $colors $category]} {
                error "Color readback failed for $name"
            }
            lappend changed $cid
            }
        }
    } err opts]
    if {$rc} {
        foreach cid $changed {
            catch {
                *createmark comps 1 "by id only" $cid
                *colormark components 1 [dict get $previous $cid]
            }
        }
        return -options $opts $err
    }
    catch {*redraw}
    return [llength $changed]
}

proc ::SharedEdgeContext::clear_shared_node_display {shared_nodes} {
    if {![llength $shared_nodes]} {return 0}
    *createmark nodes 2 {*}$shared_nodes
    set count [llength [hm_getmark nodes 2]]
    *nodemarkcleartempmark 2
    *clearmark nodes 2
    catch {*redraw}
    return $count
}

proc ::SharedEdgeContext::show_shared_node_display {shared_nodes} {
    if {![llength $shared_nodes]} {return 0}
    *createmark nodes 2 {*}$shared_nodes
    set count [llength [hm_getmark nodes 2]]
    *nodemarkaddtempmark 2
    *clearmark nodes 2
    catch {*redraw}
    return $count
}

# Only nodes used by displayed, non-plot elements in at least two components.
# First narrow the search to nodes shared by displayed components. For a small
# nearby set, query element visibility directly and avoid marking every element
# in the viewport. For a large set, use native mark intersection instead.
proc ::SharedEdgeContext::visible_shared_nodes {} {
    set rc [catch {
        set started [clock milliseconds]
        *createmark comps 1 "displayed"
        set shared [dict create]
        if {[hm_marklength comps 1] >= 2} {
            set displayed_comps [dict create]
            foreach cid [hm_getmark comps 1] {dict set displayed_comps $cid 1}
            *createmark nodes 2
            *findbetween nodes components 1 0 0 2
            set candidates [hm_getmark nodes 2]
            set candidate_ms [expr {[clock milliseconds] - $started}]
            if {[llength $candidates]} {
                set candidate_set [dict create]
                foreach nid $candidates {dict set candidate_set $nid 1}
                *createmark elems 2 "by node" {*}$candidates
                set nearby_count [hm_marklength elems 2]
                if {$nearby_count <= 8000} {
                    set method visibility_query
                } else {
                    set method displayed_mark
                    *createmark elems 1 "displayed"
                    *markintersection elems 2 elems 1
                }
                set filtered_ms [expr {[clock milliseconds] - $started}]
                set first_owner [dict create]
                foreach eid [hm_getmark elems 2] \
                    owner [hm_getvalue elems mark=2 dataname=collector.id] \
                    config [hm_getvalue elems mark=2 dataname=config] \
                    nodes [hm_getvalue elems mark=2 dataname=nodes] {
                    # Plot elements are only visual highlights, not FEM source elements.
                    if {$config == 2 || ![dict exists $displayed_comps $owner]} {continue}
                    if {$method eq "visibility_query" && ![hm_entityinfo visible elems $eid]} {continue}
                    foreach nid $nodes {
                        if {![dict exists $candidate_set $nid]} {continue}
                        if {[dict exists $shared $nid]} {continue}
                        if {![dict exists $first_owner $nid]} {
                            dict set first_owner $nid $owner
                        } elseif {[dict get $first_owner $nid] != $owner} {
                            dict set shared $nid 1
                        }
                    }
                }
                puts "Visible shared scan: candidates=[llength $candidates], nearby_elems=$nearby_count, method=$method, find=${candidate_ms} ms, mark=${filtered_ms} ms, total=[expr {[clock milliseconds] - $started}] ms."
            }
        }
        lsort -integer [dict keys $shared]
    } result opts]
    catch {*nodemarkcleartempmark 2}
    catch {*clearmark nodes 2}
    catch {*clearmark elems 1}
    catch {*clearmark elems 2}
    catch {*clearmark comps 1}
    if {$rc} {return -options $opts $result}
    return $result
}

# Use the same native find-between command as the HyperMesh panel. The output
# mark is read once; no element connectivity scan is needed to find the nodes.
proc ::SharedEdgeContext::shared_nodes_for_components {comp_ids} {
    set comp_ids [lsort -integer -unique $comp_ids]
    if {[llength $comp_ids] < 2} {return {}}
    set missing {}
    foreach cid $comp_ids {
        if {![string is integer -strict $cid] || $cid <= 0 ||
            [catch {hm_entityinfo exist comps $cid -byid} exists] || $exists ne "1"} {
            lappend missing $cid
        }
    }
    if {[llength $missing]} {
        error "Selected component IDs no longer exist in the model: [join $missing {, }]. Reselect the components."
    }
    set rc [catch {
        *createmark comps 1 "by id only" {*}$comp_ids
        *createmark nodes 2
        *findbetween nodes components 1 0 0 2
        set found [hm_getmark nodes 2]
        if {[llength $found]} {*nodemarkcleartempmark 2}
        set found
    } result opts]
    catch {*clearmark nodes 2}
    catch {*clearmark comps 1}
    if {$rc} {return -options $opts $result}
    return $result
}

proc ::SharedEdgeContext::classify_group {comp_ids shared faces_by_comp} {
    set missing [dict create]
    set extra [dict create]
    set inconsistent [dict create]
    set full_edges [dict create]
    set full_nodes [dict create]
    set complete_edges [dict create]
    set face_count 0
    set region_count 0
    set source_counts [dict create]
    foreach source $comp_ids {
        set faces {}
        foreach row [dict get $faces_by_comp $source] {
            foreach nid [lindex $row 1] {
                if {[dict exists $shared $nid]} {lappend faces $row; break}
            }
        }
        if {![llength $faces]} {continue}
        set scan [scan_faces $faces $shared]
        dict set source_counts $source [dict get $scan faces]
        incr face_count [dict get $scan faces]
        incr region_count [dict get $scan regions]
        foreach category {missing extra inconsistent full_edges full_nodes complete_edges} {
            dict for {key value} [dict get $scan $category] {
                dict set $category $key $value
            }
        }
    }
    # A valid boundary edge stays connected to its patch through another
    # shared-edge path. The only yellow edges are graph bridges joining two
    # areas that both contain fully shared faces.
    set region_bridges [bridges_between_regions $complete_edges $full_nodes]
    dict for {key edge} $extra {
        if {![dict exists $region_bridges $key] || [dict exists $full_edges $key]} {
            dict unset extra $key
        }
    }
    dict for {key edge} $missing {
        if {[dict exists $extra $key]} {
            dict set inconsistent $key $edge
            dict unset extra $key
        }
    }
    dict for {key edge} $inconsistent {
        if {[dict exists $missing $key]} {dict unset missing $key}
        if {[dict exists $extra $key]} {dict unset extra $key}
    }
    return [dict create missing $missing extra $extra inconsistent $inconsistent \
        bridge_details $region_bridges faces $face_count regions $region_count sources $source_counts]
}

# One HyperMesh mark yields the union of nodes shared by any selected pair.
# Record the owning component set for each node so pair mode cannot mix two
# different interfaces on a face of a third component.
proc ::SharedEdgeContext::pair_shared_nodes {owners} {
    set groups [dict create]
    dict for {nid comps} $owners {
        set comps [lsort -integer [dict keys $comps]]
        for {set i 0} {$i < [llength $comps]} {incr i} {
            for {set j [expr {$i + 1}]} {$j < [llength $comps]} {incr j} {
                set key [pair [lindex $comps $i] [lindex $comps $j]]
                dict set groups $key $nid 1
            }
        }
    }
    return $groups
}

# Copy selected source elements to a uniquely named component in one mark operation.
proc ::SharedEdgeContext::copy_face_component {name source_ids} {
    if {![llength $source_ids]} {return 0}
    *collectorcreateonly comps $name "" 1
    set rc [catch {
        *currentcollector comps $name
        *createmark elems 1 "by id only" {*}$source_ids
        *duplicatemark elems 1 1
        set cid [hm_getvalue comps name=$name dataname=id]
        *createmark elems 1 "by collector id" $cid
        set actual [hm_marklength elems 1]
        if {$actual != [llength $source_ids]} {
            error "Shared face readback failed for $name: expected [llength $source_ids], got $actual"
        }
    } err opts]
    if {$rc} {
        catch {*createmark comps 1 $name; *deletemark comps 1}
        return -options $opts $err
    }
    return [hm_marklength elems 1]
}

proc ::SharedEdgeContext::create_face_component_from_rows {name face_rows} {
    if {![llength $face_rows]} {return 0}
    *collectorcreateonly comps $name "" 1
    set rc [catch {
        *currentcollector comps $name
        set rows_by_config [dict create]
        foreach row $face_rows {
            lassign $row eid cfg nodes
            dict lappend rows_by_config $cfg $nodes
        }
        dict for {cfg rows} $rows_by_config {
            set connectivity {}
            foreach nodes $rows {foreach nid $nodes {lappend connectivity $nid}}
            set integer_count [llength $connectivity]
            *createarray $integer_count {*}$connectivity
            *createelements $cfg 1 1 $integer_count
        }
        set cid [hm_getvalue comps name=$name dataname=id]
        *createmark elems 1 "by collector id" $cid
        set actual [hm_marklength elems 1]
        if {$actual != [llength $face_rows]} {
            error "Shared face readback failed for $name: expected [llength $face_rows], got $actual"
        }
    } err opts]
    if {$rc} {
        catch {*createmark comps 1 $name; *deletemark comps 1}
        return -options $opts $err
    }
    return [hm_marklength elems 1]
}

# Cache the free faces of each solid component once, then filter that cache for
# every component pair. This avoids repeating a full *findfaces pass per pair.
proc ::SharedEdgeContext::find_shared_faces {comp_ids {progress_command ""}} {
    set comp_ids [lsort -integer -unique $comp_ids]
    if {[llength $comp_ids] < 2} {error "Select at least two different components"}
    set started [clock milliseconds]
    set old_collector ""
    catch {
        set old_id [hm_info currentcollector component]
        if {[string is integer -strict $old_id] && $old_id > 0} {
            if {[hm_entityinfo exist comps $old_id -byid]} {
                set old_collector [hm_getvalue comps id=$old_id dataname=name]
            }
        } elseif {$old_id ne "" && $old_id ne "0" && $old_id ne "-1" &&
            [hm_entityinfo exist comps $old_id -byname]} {
            set old_collector $old_id
        }
    }
    set outputs {}
    set made_temp_faces 0
    set find_calls 0
    set total 0
    set pair_count 0
    set processed_pairs 0
    set rc [catch {
        set shared_nodes [shared_nodes_for_components $comp_ids]
        if {[llength $shared_nodes]} {
            set selected [dict create]
            set shared [dict create]
            foreach cid $comp_ids {dict set selected $cid 1}
            foreach nid $shared_nodes {dict set shared $nid 1}
            set owners [dict create]
            set config_by_comp [dict create]
            set element_rows_by_comp [dict create]
            set shell_rows_by_comp [dict create]
            *createmark elems 1 "by node" {*}$shared_nodes
            foreach eid [hm_getmark elems 1] \
                cid [hm_getvalue elems mark=1 dataname=collector.id] \
                cfg [hm_getvalue elems mark=1 dataname=config] \
                nodes [hm_getvalue elems mark=1 dataname=nodes] {
                if {![dict exists $selected $cid]} {continue}
                dict set config_by_comp $cid $cfg 1
                dict lappend element_rows_by_comp $cid [list $cfg $nodes]
                if {$cfg >= 100 && $cfg < 200 && [llength $nodes]} {
                    dict lappend shell_rows_by_comp $cid [list $eid $nodes]
                }
                foreach nid $nodes {
                    if {[dict exists $shared $nid]} {dict set owners $nid $cid 1}
                }
            }
            set groups [pair_shared_nodes $owners]
            set pair_count [dict size $groups]
            if {$progress_command ne ""} {
                catch {uplevel #0 [list {*}$progress_command 0 $pair_count]}
            }
            set solid_jobs [dict create]
            set shell_jobs {}
            dict for {group pair_nodes} $groups {
                set pair_ids [split $group ,]
                set solid_source ""
                foreach cid $pair_ids {
                    if {[dict exists $config_by_comp $cid]} {
                        set has_solid 0
                        dict for {cfg ignored} [dict get $config_by_comp $cid] {
                            if {$cfg >= 200} {set has_solid 1; break}
                        }
                        if {$has_solid} {set solid_source $cid; break}
                    }
                }
                if {$solid_source ne ""} {
                    dict lappend solid_jobs $solid_source [list $group $pair_nodes]
                } else {
                    set source_ids {}
                    foreach cid $pair_ids {
                        if {![dict exists $shell_rows_by_comp $cid]} {continue}
                        foreach row [dict get $shell_rows_by_comp $cid] {
                            lassign $row eid nodes
                            set full [expr {[llength $nodes] > 0}]
                            foreach nid $nodes {
                                if {![dict exists $pair_nodes $nid]} {set full 0; break}
                            }
                            if {$full} {lappend source_ids $eid}
                        }
                    }
                    if {[llength $source_ids]} {lappend shell_jobs [list $group $source_ids]}
                }
            }
            if {[dict size $solid_jobs] &&
                ![catch {hm_getvalue comps name="^faces" dataname=id} existing] &&
                $existing ne "" && $existing ne "0"} {
                error "Component ^faces already exists; rename it before finding shared faces"
            }
            dict for {source jobs} $solid_jobs {
                set face_rows {}
                set source_rows [dict get $element_rows_by_comp $source]
                set tet_only [expr {[llength $source_rows] > 0}]
                set source_config ""
                foreach row $source_rows {
                    lassign $row cfg nodes
                    if {$source_config eq ""} {set source_config $cfg}
                    if {$cfg ni {204 210}} {set tet_only 0; break}
                }
                set used_findfaces 0
                if {$tet_only} {
                    foreach row [source_faces $source $source_config $shared $source_rows] {
                        lassign $row cfg nodes
                        lappend face_rows [list "" $cfg $nodes]
                    }
                } else {
                    *createmark elems 1 "by collector id" $source
                    set made_temp_faces 1
                    set used_findfaces 1
                    *findfaces elems 1
                    incr find_calls
                    *createmark elems 1 "^faces"
                    foreach eid [hm_getmark elems 1] \
                        cfg [hm_getvalue elems mark=1 dataname=config] \
                        nodes [hm_getvalue elems mark=1 dataname=nodes] {
                        lappend face_rows [list $eid $cfg $nodes]
                    }
                }
                foreach job $jobs {
                    lassign $job group pair_nodes
                    set keep {}
                    foreach row $face_rows {
                        lassign $row eid cfg nodes
                        set full [expr {[llength $nodes] > 0}]
                        foreach nid $nodes {
                            if {![dict exists $pair_nodes $nid]} {set full 0; break}
                        }
                        if {$full} {lappend keep $row}
                    }
                    if {[llength $keep]} {
                        set pair_ids [split $group ,]
                        set name [unique_name "Interface_[join $pair_ids _]"]
                        set count [create_face_component_from_rows $name $keep]
                        if {$count} {lappend outputs $name; incr total $count}
                    }
                    incr processed_pairs
                    if {$progress_command ne ""} {
                        catch {uplevel #0 [list {*}$progress_command $processed_pairs $pair_count]}
                    }
                }
                if {$used_findfaces} {
                    *createmark elems 1 "^faces"; *deletemark elems 1
                    *createmark comps 1 "^faces"; *deletemark comps 1
                    set made_temp_faces 0
                }
            }
            foreach job $shell_jobs {
                lassign $job group source_ids
                set pair_ids [split $group ,]
                set name [unique_name "Interface_[join $pair_ids _]"]
                set count [copy_face_component $name $source_ids]
                if {$count} {lappend outputs $name; incr total $count}
                incr processed_pairs
                if {$progress_command ne ""} {
                    catch {uplevel #0 [list {*}$progress_command $processed_pairs $pair_count]}
                }
            }
            while {$processed_pairs < $pair_count} {
                incr processed_pairs
                if {$progress_command ne ""} {
                    catch {uplevel #0 [list {*}$progress_command $processed_pairs $pair_count]}
                }
            }
        } else {
            set pair_count 0
        }
    } err opts]
    if {$made_temp_faces} {
        catch {*createmark elems 1 "^faces"; *deletemark elems 1}
        catch {*createmark comps 1 "^faces"; *deletemark comps 1}
    }
    if {$rc} {
        foreach name $outputs {catch {*createmark comps 1 $name; *deletemark comps 1}}
    }
    if {$old_collector ne ""} {catch {*currentcollector comps $old_collector}}
    catch {*clearmark elems 1}
    catch {*clearmark elems 2}
    catch {*clearmark comps 1}
    if {$rc} {return -options $opts $err}
    set elapsed [expr {[clock milliseconds] - $started}]
    puts "Shared face scan: components=[llength $comp_ids], pairs=$pair_count, faces=$total, findfaces=$find_calls, elapsed=${elapsed} ms."
    return [dict create outputs $outputs faces $total pairs $pair_count findfaces $find_calls elapsed $elapsed]
}

proc ::SharedEdgeContext::run_impl {comp_ids {mode pair} {colors {}}} {
    variable last_shared_nodes
    variable last_report
    variable highlight_by_name
    set last_shared_nodes {}
    set last_report {}
    set highlight_by_name [dict create]
    set comp_ids [lsort -integer -unique $comp_ids]
    if {[llength $comp_ids] < 2} {error "Select at least two different components"}
    if {$mode ne "pair"} {error "Only pair mode is supported"}
    if {$colors eq ""} {set colors [default_colors]}
    validate_colors $colors
    set selected [dict create]
    foreach cid $comp_ids {dict set selected $cid 1}
    set shared_started [clock milliseconds]
    set shared_nodes [shared_nodes_for_components $comp_ids]
    puts "Shared node scan: components=[llength $comp_ids], nodes=[llength $shared_nodes], elapsed=[expr {[clock milliseconds] - $shared_started}] ms."
    set last_shared_nodes $shared_nodes
    if {![llength $shared_nodes]} {
        return [dict create status no_shared message "No shared nodes" missing 0 extra 0 inconsistent 0 outputs {} mode $mode pairs 0]
    }
    set shared [dict create]
    foreach nid $shared_nodes {dict set shared $nid 1}

    set read_started [clock milliseconds]
    *createmark elems 1 "by node" {*}$shared_nodes
    array set rows_by_comp {}
    array set configs {}
    set owners [dict create]
    foreach cid [hm_getvalue elems mark=1 dataname=collector.id] \
        cfg [hm_getvalue elems mark=1 dataname=config] \
        ns [hm_getvalue elems mark=1 dataname=nodes] {
        if {![dict exists $selected $cid]} {continue}
        lappend rows_by_comp($cid) [list $cfg $ns]
        if {![info exists configs($cid)]} {set configs($cid) $cfg}
        foreach nid $ns {
            if {[dict exists $shared $nid]} {dict set owners $nid $cid 1}
        }
    }
    set read_elapsed [expr {[clock milliseconds] - $read_started}]
    set groups [pair_shared_nodes $owners]
    set faces_started [clock milliseconds]
    set faces_by_comp [dict create]
    foreach cid $comp_ids {
        if {[info exists rows_by_comp($cid)]} {
            dict set faces_by_comp $cid [source_faces $cid $configs($cid) $shared $rows_by_comp($cid)]
        } else {
            dict set faces_by_comp $cid {}
        }
    }
    set faces_elapsed [expr {[clock milliseconds] - $faces_started}]
    # For many interfaces, only visit faces touching that pair's nodes.
    # A single pair uses the face lists directly and avoids building an index.
    set face_index [dict create]
    if {[dict size $groups] > 1} {
        dict for {cid faces} $faces_by_comp {
            set comp_index [dict create]
            set index 0
            foreach row $faces {
                foreach nid [lsort -integer -unique [lindex $row 1]] {
                    if {[dict exists $shared $nid]} {dict lappend comp_index $nid $index}
                }
                incr index
            }
            dict set face_index $cid $comp_index
        }
    }
    set region_bridges [dict create]
    set classified_by_group [dict create]
    set report_faces [dict create]
    set face_count 0
    set region_count 0
    set source_counts [dict create]
    set jobs {}
    dict for {key pair_nodes} $groups {
        lappend jobs [list [split $key ,] $pair_nodes]
    }
    set classify_started [clock milliseconds]
    foreach job $jobs {
        lassign $job sources job_shared
        set group_key [pair [lindex $sources 0] [lindex $sources 1]]
        set job_faces $faces_by_comp
        if {[dict size $groups] > 1} {
            set job_faces [dict create]
            foreach source $sources {
                set hits [dict create]
                dict for {nid ignored} $job_shared {
                    if {![dict exists $face_index $source $nid]} {continue}
                    foreach index [dict get $face_index $source $nid] {dict set hits $index 1}
                }
                set nearby {}
                foreach index [lsort -integer [dict keys $hits]] {
                    lappend nearby [lindex [dict get $faces_by_comp $source] $index]
                }
                dict set job_faces $source $nearby
            }
        }
        set classified [classify_group $sources $job_shared $job_faces]
        dict set classified_by_group $group_key $classified
        if {[dict size [dict get $classified missing]] ||
            [dict size [dict get $classified extra]] ||
            [dict size [dict get $classified inconsistent]]} {
            dict set report_faces $group_key $job_faces
        }
        dict for {key value} [dict get $classified bridge_details] {
            dict set region_bridges $key $value
        }
        incr face_count [dict get $classified faces]
        incr region_count [dict get $classified regions]
        dict for {source count} [dict get $classified sources] {
            dict incr source_counts $source $count
        }
    }
    set classify_elapsed [expr {[clock milliseconds] - $classify_started}]
    if {$face_count == 0} {
        return [dict create status no_faces message "No quadratic surface faces near shared nodes" missing 0 extra 0 inconsistent 0 outputs {} mode $mode pairs [dict size $groups]]
    }
    set outputs {}
    set output_by_category [dict create missing {} extra {} inconsistent {}]
    set output_by_group [dict create]
    set report_errors [dict create]
    set pair_counts [dict create missing 0 extra 0 inconsistent 0]
    set pair_extra_keys [dict create]
    set highlight_started [clock milliseconds]
    set rc [catch {
        dict for {group_key classified} $classified_by_group {
            set group_suffix [string map {, _} $group_key]
            foreach item {{missing Miss} {extra Extra} {inconsistent Incon}} {
                lassign $item category prefix
                set edges [dict get $classified $category]
                if {[dict size $edges]} {
                    dict set report_errors $group_key $category $edges
                    dict incr pair_counts $category [dict size $edges]
                    if {$category eq "extra"} {
                        dict for {key edge} $edges {dict set pair_extra_keys $key 1}
                    }
                }
                set name [create_highlights $edges "${prefix}_${group_suffix}" [dict get $colors $category]]
                if {$name ne ""} {
                    lappend outputs $name
                    dict lappend output_by_category $category $name
                    dict set output_by_group $group_key $category $name
                }
            }
        }
    } err opts]
    if {$rc} {
        foreach name $outputs {
            catch {*createmark comps 1 $name; *deletemark comps 1}
        }
        return -options $opts $err
    }
    set highlight_elapsed [expr {[clock milliseconds] - $highlight_started}]
    puts "Check phases: read=${read_elapsed} ms, faces=${faces_elapsed} ms, classify=${classify_elapsed} ms, highlight=${highlight_elapsed} ms."
    set kept_faces [dict create]
    dict for {group categories} $report_errors {
        dict set kept_faces $group [dict get $report_faces $group]
    }
    set last_report [dict create faces $kept_faces errors $report_errors]
    return [dict create status done message "Check completed" \
        missing [dict get $pair_counts missing] extra [dict get $pair_counts extra] \
        inconsistent [dict get $pair_counts inconsistent] extra_keys [dict keys $pair_extra_keys] \
        bridge_details $region_bridges outputs $outputs \
        output_by_category $output_by_category output_by_group $output_by_group \
        faces $face_count regions $region_count sources $source_counts \
        mode $mode pairs [dict size $groups] components [llength $comp_ids] \
        shared_nodes [llength $shared_nodes]]
}

proc ::SharedEdgeContext::run {comp_ids {mode pair} {colors {}}} {
    set started [clock milliseconds]
    catch {*redrawblock 1}
    set rc [catch {run_impl $comp_ids $mode $colors} result opts]
    catch {*clearmark nodes 2}
    catch {*clearmark comps 1}
    catch {*clearmark elems 1}
    catch {*redrawblock 0}
    catch {*redraw}
    if {$rc} {return -options $opts $result}
    dict set result elapsed [expr {[clock milliseconds] - $started}]
    return $result
}

proc ::SharedEdgeContext::node_positions {node_ids} {
    if {![llength $node_ids]} {return [dict create]}
    set rc [catch {
        *createmark nodes 2 {*}[lsort -integer -unique $node_ids]
        set ids [hm_getmark nodes 2]
        set positions {}
        if {[catch {hm_getvalue nodes mark=2 dataname=coordinates} positions] ||
            [llength $ids] != [llength $positions] ||
            ([llength $positions] && [llength [lindex $positions 0]] != 3)} {
            set positions {}
            foreach nid $ids {
                lappend positions [hm_getvalue nodes id=$nid dataname=coordinates]
            }
        }
        set result [dict create]
        foreach nid $ids xyz $positions {dict set result $nid $xyz}
        set result
    } result opts]
    catch {*clearmark nodes 2}
    if {$rc} {return -options $opts $result}
    return $result
}

# A small FEM neighborhood around the selected edge, grouped by source part.
proc ::SharedEdgeContext::error_neighborhood {a b source_comps} {
    set allowed [dict create]
    foreach cid $source_comps {dict set allowed $cid 1}
    set rc [catch {
        *createmark elems 1 "by node" $a $b
        set ids [hm_getmark elems 1]
        set by_comp [dict create]
        set highlights {}
        foreach eid $ids cid [hm_getvalue elems mark=1 dataname=collector.id] \
            cfg [hm_getvalue elems mark=1 dataname=config] \
            connected [hm_getvalue elems mark=1 dataname=nodes] {
            if {[dict exists $allowed $cid]} {
                dict lappend by_comp $cid [list $eid $connected]
            } elseif {$cfg == 2 && [llength $connected] == 2 &&
                    [lsearch -exact $connected $a] >= 0 &&
                    [lsearch -exact $connected $b] >= 0} {
                lappend highlights $eid
            }
        }
        dict create sources $by_comp highlights $highlights
    } result opts]
    catch {*clearmark elems 1}
    if {$rc} {return -options $opts $result}
    return $result
}

proc ::SharedEdgeContext::dominant_axes {positions ids} {
    if {![llength $ids]} {error "No coordinates for the report projection"}
    set lo [list Inf Inf Inf]
    set hi [list -Inf -Inf -Inf]
    set count 0
    foreach nid $ids {
        if {![dict exists $positions $nid]} {continue}
        incr count
        set xyz [dict get $positions $nid]
        for {set axis 0} {$axis < 3} {incr axis} {
            set value [lindex $xyz $axis]
            if {$value < [lindex $lo $axis]} {lset lo $axis $value}
            if {$value > [lindex $hi $axis]} {lset hi $axis $value}
        }
    }
    if {!$count} {error "No coordinates for the report projection"}
    set ranking {}
    for {set axis 2} {$axis >= 0} {incr axis -1} {
        lappend ranking [list [expr {[lindex $hi $axis] - [lindex $lo $axis]}] $axis]
    }
    set ranking [lsort -decreasing -real -index 0 $ranking]
    return [lsort -integer [list [lindex [lindex $ranking 0] 1] \
        [lindex [lindex $ranking 1] 1]]]
}

# Match the dominant-axis projection used by the PowerPoint helper. Cache it
# on the report so subsequent row changes do not rescan the same surface.
proc ::SharedEdgeContext::report_axes {group} {
    variable last_report
    if {[dict exists $last_report axes $group]} {
        return [dict get $last_report axes $group]
    }
    if {![dict exists $last_report faces $group]} {error "No report surface for $group"}
    set ids [dict create]
    dict for {source rows} [dict get $last_report faces $group] {
        foreach row $rows {
            lassign $row cfg face_nodes
            foreach item [face_edges $cfg $face_nodes] {
                foreach nid [edge_nodes [lindex $item 0]] {dict set ids $nid 1}
            }
        }
    }
    set positions [node_positions [dict keys $ids]]
    set axes [dominant_axes $positions [dict keys $ids]]
    dict set last_report axes $group $axes
    return $axes
}

proc ::SharedEdgeContext::report_view {axes} {
    # The ordered axes are right/up in the PPT. Their cross product points
    # toward the viewer; depth increases toward the viewer.
    switch -- [join $axes ,] {
        0,1 {return {top 2 1}}
        1,0 {return {bottom 2 -1}}
        0,2 {return {leftside 1 -1}}
        2,0 {return {rightside 1 1}}
        1,2 {return {rear 0 1}}
        2,1 {return {front 0 -1}}
    }
    error "Unsupported report projection: $axes"
}

proc ::SharedEdgeContext::lower_part_neighborhood {details a b depth_axis depth_sign} {
    set by_comp [dict get $details sources]
    if {![dict size $by_comp]} {error "No source elements found around edge $a-$b"}
    set scoring [dict create]
    dict for {cid rows} $by_comp {
        set on_edge {}
        foreach row $rows {
            set connected [lindex $row 1]
            if {[lsearch -exact $connected $a] >= 0 &&
                [lsearch -exact $connected $b] >= 0} {lappend on_edge $row}
        }
        if {[llength $on_edge]} {
            dict set scoring $cid $on_edge
        } else {
            dict set scoring $cid $rows
        }
    }
    set ids [dict create]
    dict for {cid rows} $scoring {
        foreach row $rows {
            foreach nid [lindex $row 1] {
                if {$nid != $a && $nid != $b} {dict set ids $nid 1}
            }
        }
    }
    set positions [node_positions [dict keys $ids]]
    set lower ""
    set lower_depth Inf
    dict for {cid rows} $scoring {
        set sum 0.0
        set count 0
        foreach row $rows {
            foreach nid [lindex $row 1] {
                if {$nid == $a || $nid == $b || ![dict exists $positions $nid]} {continue}
                set sum [expr {$sum + $depth_sign * [lindex [dict get $positions $nid] $depth_axis]}]
                incr count
            }
        }
        if {!$count} {continue}
        set depth [expr {$sum / $count}]
        if {$lower eq "" || $depth < $lower_depth} {
            set lower $cid
            set lower_depth $depth
        }
    }
    if {$lower eq ""} {error "Cannot determine the lower part around edge $a-$b"}
    set element_ids [dict get $details highlights]
    foreach row [dict get $by_comp $lower] {lappend element_ids [lindex $row 0]}
    return [list $lower $element_ids]
}

# Export the last check's actual surface network and classified edges. The
# helper creates a presentation; the FEM model is only queried for coordinates.
proc ::SharedEdgeContext::export_ppt {destination colors} {
    variable last_report
    variable report_script_dir
    if {$last_report eq "" || ![dict exists $last_report errors] ||
        ![dict size [dict get $last_report errors]]} {
        error "Run Check & Highlight before exporting a report"
    }
    set helper [file join $report_script_dir export_shared_edge_ppt.py]
    if {![file isfile $helper]} {error "PowerPoint helper is missing: $helper"}
    set python38 [file normalize [file join $report_script_dir .. 00-Other_Tool python3.8.10 python.exe]]
    if {[file isfile $python38]} {
        set python [list $python38]
    } else {
        set python [auto_execok python]
    }
    if {$python eq ""} {error "Python 3.8+ is not available"}
    validate_colors $colors

    set segments [dict create]
    set nodes [dict create]
    dict for {group sources} [dict get $last_report faces] {
        dict for {source rows} $sources {
            foreach row $rows {
                lassign $row cfg face_nodes
                foreach item [face_edges $cfg $face_nodes] {
                    set key [lindex $item 0]
                    dict set segments $group $key 1
                    foreach nid [edge_nodes $key] {dict set nodes $nid 1}
                }
            }
        }
    }
    dict for {group categories} [dict get $last_report errors] {
        dict for {category edges} $categories {
            dict for {key edge} $edges {
                foreach nid [lrange $edge 0 1] {dict set nodes $nid 1}
            }
        }
    }
    if {![dict size $nodes]} {error "No surface network is available for the report"}
    set temp_base [expr {[info exists ::env(TEMP)] ? $::env(TEMP) : $report_script_dir}]
    set data_path [file join $temp_base "SharedEdgeCheck_[pid]_[clock clicks].tsv"]
    set rc [catch {
        set stream [open $data_path w]
        fconfigure $stream -encoding utf-8 -translation lf
        puts $stream "SHARED_EDGE_REPORT\t1"
        foreach category {missing extra inconsistent} {
            puts $stream [join [concat COLOR $category [hm_winfo entitycolors [dict get $colors $category]]] "\t"]
        }
        dict for {group keys} $segments {
            dict for {key ignored} $keys {
                lassign [edge_nodes $key] a b
                puts $stream [join [list SEG $group $a $b] "\t"]
            }
        }
        dict for {group categories} [dict get $last_report errors] {
            dict for {category edges} $categories {
                dict for {key edge} $edges {
                    puts $stream [join [concat ERR $group $category $edge] "\t"]
                }
            }
        }
        set positions [node_positions [dict keys $nodes]]
        dict for {group keys} $segments {
            set group_nodes [dict create]
            dict for {key ignored} $keys {
                foreach nid [edge_nodes $key] {dict set group_nodes $nid 1}
            }
            dict set last_report axes $group \
                [dominant_axes $positions [dict keys $group_nodes]]
        }
        dict for {nid xyz} $positions {
            puts $stream [join [concat NODE $nid $xyz] "\t"]
        }
        ::close $stream
        unset stream
        *clearmark nodes 2
        exec {*}$python $helper $data_path $destination 2>@1
    } result opts]
    if {[info exists stream]} {catch {::close $stream}}
    catch {*clearmark nodes 2}
    catch {file delete $data_path}
    if {$rc} {return -options $opts $result}
    return $result
}

# Tests may source the same file without opening Tk.
if {[info exists ::SharedEdgeContext::library_only] && $::SharedEdgeContext::library_only} {
    unset ::SharedEdgeContext::library_only
    return
}

# HyperMesh Classic front end for the shared-edge checker.

namespace eval ::SharedEdgeGUI {
    foreach {name default} {
        selected {} selection_text {No components selected}
        status_text {Select at least two components.} color_ids {} outputs {} shared_face_outputs {}
        output_by_category {} output_by_group {} visible_shared_nodes {} view_mask {} settings_file {}
        focused_pair {} focused_comp {}
        error_rows {} list_filter All always_on_top 0
        list_search {} list_status {Run Check & Highlight to list errors.}
    } {
        if {![info exists $name]} {set $name $default}
    }
    variable script_dir [file dirname [file normalize [info script]]]
}

proc ::SharedEdgeGUI::settings_path {} {
    variable settings_file
    variable script_dir
    if {$settings_file ne ""} {return $settings_file}
    if {[info exists ::env(APPDATA)] && $::env(APPDATA) ne ""} {
        set base $::env(APPDATA)
    } else {
        set base $script_dir
    }
    set settings_file [file join $base SharedEdgeCheck settings.cfg]
    return $settings_file
}

proc ::SharedEdgeGUI::load_settings {} {
    variable color_ids
    variable list_filter
    variable always_on_top
    set color_ids [::SharedEdgeContext::default_colors]
    set list_filter "All"
    set always_on_top 0
    set path [settings_path]
    if {![file exists $path]} {return}
    if {[catch {
        if {[file size $path] > 4096} {error "Settings file is too large"}
        set stream [open $path r]
        set data [read $stream]
        ::close $stream
        dict size $data
    }]} {return}
    if {[dict exists $data colors] &&
        ![catch {::SharedEdgeContext::validate_colors [dict get $data colors]}]} {
        set color_ids [dict merge [::SharedEdgeContext::default_colors] [dict get $data colors]]
    }
    if {[dict exists $data list_filter] &&
        [dict get $data list_filter] in {All Missing Extra Inconsistent}} {
        set list_filter [dict get $data list_filter]
    }
    if {[dict exists $data always_on_top] &&
        [dict get $data always_on_top] in {0 1}} {
        set always_on_top [dict get $data always_on_top]
    }
}

proc ::SharedEdgeGUI::save_settings {} {
    variable color_ids
    variable list_filter
    variable always_on_top
    variable status_text
    set path [settings_path]
    set temp "${path}.[pid].tmp"
    set data [dict create version 6 colors $color_ids \
        list_filter $list_filter always_on_top $always_on_top]
    if {[catch {
        file mkdir [file dirname $path]
        set stream [open $temp w]
        puts $stream $data
        ::close $stream
        file rename -force $temp $path
    } err]} {
        catch {::close $stream}
        catch {file delete $temp}
        set status_text "Could not save GUI settings: $err"
        return 0
    }
    return 1
}

proc ::SharedEdgeGUI::palette_hex {id} {
    lassign [hm_winfo entitycolors $id] r g b
    return [format "#%02x%02x%02x" $r $g $b]
}

proc ::SharedEdgeGUI::refresh_swatch {category} {
    variable color_ids
    set id [dict get $color_ids $category]
    set swatch .sharededgecheck.body.work.colors.$category.swatch
    $swatch delete all
    $swatch create rectangle 1 1 25 25 -fill [palette_hex $id] -outline "#555555"
}

proc ::SharedEdgeGUI::choose_color {category} {
    variable color_ids
    set chosen [tk_chooseColor -parent .sharededgecheck \
        -title "Choose $category color" \
        -initialcolor [palette_hex [dict get $color_ids $category]]]
    if {$chosen eq ""} {return}
    scan [string range $chosen 1 2] %x r
    scan [string range $chosen 3 4] %x g
    scan [string range $chosen 5 6] %x b
    dict set color_ids $category [::SharedEdgeContext::palette_color [list $r $g $b]]
    refresh_swatch $category
    save_settings
}

proc ::SharedEdgeGUI::apply_colors {} {
    variable output_by_category
    variable shared_face_outputs
    variable color_ids
    variable status_text
    set color_outputs $output_by_category
    if {[llength $shared_face_outputs]} {
        dict set color_outputs shared_faces $shared_face_outputs
    }
    set rc [catch {::SharedEdgeContext::recolor_highlights $color_outputs $color_ids} value]
    if {$rc} {
        set status_text "Could not apply colors."
        tk_messageBox -parent .sharededgecheck -icon error -type ok -message $value
    } else {
        set status_text "Applied colors to $value components."
    }
}

proc ::SharedEdgeGUI::export_report {} {
    variable color_ids
    variable status_text
    if {$::SharedEdgeContext::last_report eq ""} {return}
    set destination [tk_getSaveFile -parent .sharededgecheck \
        -title "Export shared-edge errors" -defaultextension .pptx \
        -initialfile SharedEdgeErrors.pptx \
        -filetypes {{"PowerPoint presentation" {.pptx}}}]
    if {$destination eq ""} {return}
    set button .sharededgecheck.body.work.actions.check.export
    $button configure -state disabled
    set status_text "Exporting PowerPoint..."
    update idletasks
    set rc [catch {::SharedEdgeContext::export_ppt $destination $color_ids} result]
    $button configure -state normal
    if {$rc} {
        set status_text "PowerPoint export failed."
        tk_messageBox -parent .sharededgecheck -icon error -type ok -message $result
    } else {
        set status_text "PowerPoint saved: [file tail $destination]"
        puts $result
    }
}

proc ::SharedEdgeGUI::prepare_error_rows {} {
    variable error_rows
    set error_rows [dict create]
    if {$::SharedEdgeContext::last_report eq ""} {return}
    set report_errors [dict get $::SharedEdgeContext::last_report errors]
    set index 0
    foreach group [lsort -dictionary [dict keys $report_errors]] {
        set source_comps [lsort -integer [split $group ,]]
        if {[llength $source_comps] != 2} {error "Invalid error pair: $group"}
        set display_names {}
        foreach cid $source_comps {
            set name ""
            catch {set name [hm_getvalue comps id=$cid dataname=name]}
            if {$name eq "" || $name eq "0"} {set name $cid}
            lappend display_names $name
        }
        set categories [dict get $report_errors $group]
        set edges {}
        set counts [dict create missing 0 extra 0 inconsistent 0]
        foreach category {missing extra inconsistent} {
            if {![dict exists $categories $category]} {continue}
            dict for {key edge} [dict get $categories $category] {
                lassign $edge a b mid
                lappend edges [dict create report_group $group category $category \
                    a $a b $b mid $mid key $key]
                dict incr counts $category
            }
        }
        if {![llength $edges]} {continue}
        incr index
        dict set error_rows "part$index" [dict create group $group display [join $display_names +] \
            sources $source_comps report_group $group \
            edges $edges counts $counts]
    }
}

proc ::SharedEdgeGUI::refresh_error_list {} {
    variable error_rows
    variable list_filter
    variable list_search
    variable list_status
    set tree .sharededgecheck.errors.list.tree
    if {![winfo exists $tree]} {return}
    set children [$tree children {}]
    if {[llength $children]} {$tree delete $children}
    set shown 0
    dict for {iid row} $error_rows {
        set counts [dict get $row counts]
        if {$list_filter ne "All" && ![dict get $counts [string tolower $list_filter]]} {continue}
        set group [dict get $row group]
        if {$list_search ne ""} {
        set searchable "$group [dict get $row display]"
            foreach edge [dict get $row edges] {
                append searchable " [dict get $edge category] [dict get $edge a]-[dict get $edge b]"
            }
            if {[string first [string tolower $list_search] [string tolower $searchable]] < 0} {continue}
        }
        $tree insert {} end -id $iid -values [list [dict get $row display] \
            [dict get $counts missing] [dict get $counts extra] \
            [dict get $counts inconsistent]]
        incr shown
    }
    set list_status "Showing $shown/[dict size $error_rows] pairs. Double-click a row."
}

proc ::SharedEdgeGUI::highlight_ids_for_row {row} {
    variable output_by_group
    set wanted [dict create]
    foreach edge [dict get $row edges] {dict set wanted [dict get $edge key] 1}
    set names {}
    set group [dict get $row report_group]
    if {[dict exists $output_by_group $group]} {
        dict for {category name} [dict get $output_by_group $group] {lappend names $name}
    }
    set ids [dict create]
    foreach name $names {
        if {[dict exists $::SharedEdgeContext::highlight_by_name $name]} {
            dict for {key eid} [dict get $::SharedEdgeContext::highlight_by_name $name] {
                if {[dict exists $wanted $key]} {dict set ids $eid 1}
            }
        }
    }
    if {[dict size $ids] == [dict size $wanted]} {return [dict keys $ids]}
    # A model edited after Check can invalidate the cached mark. Read the
    # output components when the cache does not cover every edge in this row.
    foreach name $names {
        set cid [hm_getvalue comps name=$name dataname=id]
        if {$cid eq "" || $cid eq "0"} {continue}
        *createmark elems 2 "by collector id" $cid
        foreach eid [hm_getmark elems 2] nodes [hm_getvalue elems mark=2 dataname=nodes] {
            if {[llength $nodes] != 2} {continue}
            set key [::SharedEdgeContext::pair [lindex $nodes 0] [lindex $nodes 1]]
            if {[dict exists $wanted $key]} {dict set ids $eid 1}
        }
    }
    catch {*clearmark elems 2}
    return [dict keys $ids]
}

proc ::SharedEdgeGUI::inspect_selected_error {} {
    variable error_rows
    variable view_mask
    variable list_status
    variable status_text
    variable focused_pair
    variable focused_comp
    set w .sharededgecheck
    set tree $w.errors.list.tree
    if {![winfo exists $tree]} {return}
    set iid [lindex [$tree selection] 0]
    if {$iid eq "" || ![dict exists $error_rows $iid]} {return}
    set row [dict get $error_rows $iid]
    set representative [lindex [dict get $row edges] 0]
    set a [dict get $representative a]
    set b [dict get $representative b]
    set group [dict get $row group]
    set report_group [dict get $row report_group]
    set source_comps [dict get $row sources]
    if {$view_mask ne "" && ![restore_view]} {return}
    set focused_pair ""
    set focused_comp ""
    set rc [catch {
        set axes [::SharedEdgeContext::report_axes $report_group]
        lassign [::SharedEdgeContext::report_view $axes] orientation depth_axis depth_sign
        set details [::SharedEdgeContext::error_neighborhood $a $b $source_comps]
        lassign [::SharedEdgeContext::lower_part_neighborhood \
            $details $a $b $depth_axis $depth_sign] lower_comp ignored_nearby
        set shown_comps [list $lower_comp]
        set highlights [highlight_ids_for_row $row]
        if {![llength $highlights]} {error "No highlight elements remain for parts $group"}
        set mask "SharedEdgeError_[clock clicks]"
        *saveviewmask $mask 0
        *createmark elems 1 "by collector id" [lindex $shown_comps 0]
        foreach cid [lrange $shown_comps 1 end] {
            *appendmark elems 1 "by collector id" $cid
        }
        *appendmark elems 1 "by id only" $highlights
        *createstringarray 1 "showcomps"
        *isolateonlyentitybymark 1 1 1
        *view $orientation
        if {[catch {hm_viewfit}]} {*window 0 0 0 0 0}
        *clearmark elems 1
    } err]
    if {$rc} {
        catch {*clearmark elems 1}
        if {[info exists mask]} {
            catch {*restoreviewmask $mask 0}
            catch {*removeview $mask}
        }
        set list_status "Could not inspect parts $group."
        tk_messageBox -parent $w -icon error -type ok -message $err
        return
    }
    set view_mask $mask
    set focused_pair $group
    set focused_comp $lower_comp
    set list_status "Pair $group: [llength [dict get $row edges]] errors | visible [join $shown_comps {, }]"
    set status_text "Showing full part(s) [join $shown_comps {, }] and all errors for $group."
    catch {*redraw}
}

proc ::SharedEdgeGUI::focus_selected_error {} {
    inspect_selected_error
}

proc ::SharedEdgeGUI::show_other_part {} {
    variable error_rows
    variable focused_pair
    variable focused_comp
    variable list_status
    set w .sharededgecheck
    set iid [lindex [$w.errors.list.tree selection] 0]
    if {$iid eq "" || ![dict exists $error_rows $iid]} {return}
    set row [dict get $error_rows $iid]
    set pair [dict get $row group]
    if {$pair ne $focused_pair} {
        set list_status "Double-click this pair first."
        return
    }
    set other {}
    foreach cid [dict get $row sources] {
        if {$cid != $focused_comp} {lappend other $cid}
    }
    if {[llength $other] != 1} {
        set list_status "Could not identify the other part of pair $pair."
        return
    }
    set rc [catch {
        *createmark comps 1 "by id only" [lindex $other 0]
        *showentitybymark 1 1 2
    } err]
    catch {*clearmark comps 1}
    if {$rc} {
        set list_status "Could not show the other part of pair $pair."
        tk_messageBox -parent $w -icon error -type ok -message $err
        return
    }
    set list_status "Pair $pair: both parts visible."
    catch {*redraw}
}

proc ::SharedEdgeGUI::show_shared_faces_for_selected_pair {} {
    variable error_rows
    variable view_mask
    variable list_status
    variable status_text
    variable focused_pair
    variable focused_comp
    variable shared_face_outputs
    set w .sharededgecheck
    set iid [lindex [$w.errors.list.tree selection] 0]
    if {$iid eq "" || ![dict exists $error_rows $iid]} {return}
    set row [dict get $error_rows $iid]
    set pair [dict get $row group]
    set sources [lsort -integer -unique [dict get $row sources]]
    if {[llength $sources] != 2} {
        set list_status "Could not identify the two parts in pair $pair."
        return
    }
    set list_status "Preparing shared faces for pair $pair..."
    set status_text "Showing shared faces for pair $pair..."
    update idletasks
    if {$view_mask ne "" && ![restore_view]} {return}
    set face_name ""
    set mask ""
    catch {*redrawblock 1}
    set rc [catch {
        set base_name "Interface_[join $sources _]"
        if {[hm_entityinfo exist comps $base_name -byname]} {
            set candidate_id [hm_getvalue comps name=$base_name dataname=id]
            if {$candidate_id ne "" && $candidate_id ne "0"} {
                *createmark elems 1 "by collector id" $candidate_id
                set candidate_count [hm_marklength elems 1]
                *clearmark elems 1
                if {$candidate_count > 0} {set face_name $base_name}
            }
        }
        if {$face_name eq ""} {
            set result [::SharedEdgeContext::find_shared_faces $sources ::SharedEdgeGUI::face_progress]
            set generated [dict get $result outputs]
            if {![llength $generated]} {error "No shared faces found for pair $pair."}
            set face_name [lindex $generated 0]
        }
        set face_id [hm_getvalue comps name=$face_name dataname=id]
        if {$face_id eq "" || $face_id eq "0"} {error "Could not find the shared-face component $face_name."}
        ::SharedEdgeContext::recolor_highlights [dict create shared_faces [list $face_name]] $::SharedEdgeGUI::color_ids
        *createmark elems 1 "by collector id" $face_id
        set face_count [hm_marklength elems 1]
        if {$face_count < 1} {error "Shared-face component $face_name is empty."}
        set mask "SharedFaces_[clock clicks]"
        *saveviewmask $mask 0
        *createstringarray 1 "showcomps"
        *isolateonlyentitybymark 1 1 1
        if {[catch {hm_viewfit}]} {*window 0 0 0 0 0}
        *clearmark elems 1
    } err]
    catch {*redrawblock 0}
    if {$rc} {
        catch {*clearmark elems 1}
        if {$mask ne ""} {
            catch {*restoreviewmask $mask 0}
            catch {*removeview $mask}
        }
        set list_status "Could not show shared faces for pair $pair."
        tk_messageBox -parent $w -icon error -type ok -message $err
        return
    }
    set view_mask $mask
    set shared_face_outputs [lsort -unique [concat $shared_face_outputs $face_name]]
    $w.body.work.colors.apply configure -state normal
    set focused_pair ""
    set focused_comp ""
    $w.body.work.actions.restore configure -state normal
    set list_status "Pair $pair: showing $face_count shared faces in $face_name."
    set status_text "Showing shared faces for pair $pair."
    catch {*redraw}
}

proc ::SharedEdgeGUI::popup_error_menu {x y screen_x screen_y} {
    set w .sharededgecheck
    set tree $w.errors.list.tree
    set iid [$tree identify row $x $y]
    if {$iid eq "" || ![dict exists $::SharedEdgeGUI::error_rows $iid]} {return}
    $tree selection set $iid
    set pair [dict get [dict get $::SharedEdgeGUI::error_rows $iid] group]
    $w.errors.context entryconfigure 0 -state \
        [expr {$pair eq $::SharedEdgeGUI::focused_pair ? "normal" : "disabled"}]
    $w.errors.context entryconfigure 1 -state normal
    tk_popup $w.errors.context $screen_x $screen_y
}

proc ::SharedEdgeGUI::show_error_list {} {
    set w .sharededgecheck
    if {![winfo exists $w]} {::SharedEdgeGUI::build}
    if {$::SharedEdgeContext::last_report ne "" && ![dict size $::SharedEdgeGUI::error_rows]} {
        prepare_error_rows
        refresh_error_list
    }
    wm deiconify $w
    raise $w
    focus $w.errors.filters.search
}

proc ::SharedEdgeGUI::reset_session {} {
    foreach name {selected outputs output_by_category output_by_group visible_shared_nodes} {
        set ::SharedEdgeGUI::$name {}
    }
    set ::SharedEdgeGUI::shared_face_outputs {}
    set ::SharedEdgeGUI::error_rows [dict create]
    set ::SharedEdgeGUI::selection_text "No components selected"
    set ::SharedEdgeGUI::status_text "Select at least two components."
    set ::SharedEdgeGUI::list_status "Run Check & Highlight to populate the error list."
    set ::SharedEdgeGUI::list_search ""
    set ::SharedEdgeGUI::view_mask ""
    set ::SharedEdgeGUI::focused_pair ""
    set ::SharedEdgeGUI::focused_comp ""
    set ::SharedEdgeContext::last_report {}
    set ::SharedEdgeContext::last_shared_nodes {}
    set ::SharedEdgeContext::highlight_by_name [dict create]
}

proc ::SharedEdgeGUI::apply_topmost {} {
    set w .sharededgecheck
    if {[winfo exists $w]} {
        wm attributes $w -topmost $::SharedEdgeGUI::always_on_top
    }
    save_settings
}

proc ::SharedEdgeGUI::place_initial_window {w} {
    # Place once, using the work area of the monitor under the pointer.
    # Tk's generic pointer placement does not keep the full window visible
    # near the taskbar or the edge of a multi-monitor desktop.
    update idletasks
    lassign [winfo pointerxy $w] px py
    set width [winfo reqwidth $w]
    set height [winfo reqheight $w]
    if {[catch {
        package require twapi
        set monitor [twapi::get_display_monitor_from_point $px $py -default nearest]
        set info [twapi::get_display_monitor_info $monitor]
        lassign [twapi::kl_get $info -workarea] left top right bottom
    }]} {
        set left 0
        set top 0
        set right [winfo screenwidth $w]
        set bottom [winfo screenheight $w]
    }
    set margin 24
    set x [expr {max($left + $margin,
        min($right - $width - $margin, $px - $width / 2))}]
    set y [expr {max($top + $margin,
        min($bottom - $height - $margin - 36, $py - $height / 2))}]
    wm geometry $w +$x+$y
    wm deiconify $w
}

proc ::SharedEdgeGUI::show_component_shared_nodes {scope} {
    variable selected
    variable visible_shared_nodes
    variable status_text
    if {$scope eq "selected" && [llength $selected] < 2} {
        set status_text "Select at least two components first."
        return
    }
    set started [clock milliseconds]
    catch {*redrawblock 1}
    set rc [catch {
        if {$scope eq "selected"} {
            *createmark comps 1 "by id only" {*}$selected
        } else {
            *createmark comps 1 "displayed"
        }
        set comp_count [hm_marklength comps 1]
        set nodes {}
        if {$comp_count >= 2} {
            *createmark nodes 2
            *findbetween nodes components 1 0 0 2
            set nodes [hm_getmark nodes 2]
            if {[llength $nodes]} {*nodemarkaddtempmark 2}
        }
        set find_ms [expr {[clock milliseconds] - $started}]
        set count [llength $nodes]
    } err]
    catch {*clearmark nodes 2}
    catch {*clearmark comps 1}
    catch {*redrawblock 0}
    if {$rc} {
        set status_text "Could not find shared nodes between $scope components."
        tk_messageBox -parent .sharededgecheck -icon error -type ok -message $err
        return
    }
    if {$count} {catch {*redraw}}
    if {![llength $visible_shared_nodes]} {
        set visible_shared_nodes $nodes
    } else {
        set visible_shared_nodes [lsort -integer -unique [concat $visible_shared_nodes $nodes]]
    }
    if {[llength $visible_shared_nodes]} {
        .sharededgecheck.body.work.actions.nodes.clear configure -state normal
    }
    set elapsed [expr {[clock milliseconds] - $started}]
    set status_text "Marked $count shared nodes from $scope components in ${elapsed} ms."
    puts "Shared node display: scope=$scope, components=$comp_count, nodes=$count, find=${find_ms} ms, total=${elapsed} ms."
}

proc ::SharedEdgeGUI::show_selected_shared_nodes {} {
    show_component_shared_nodes selected
}

proc ::SharedEdgeGUI::show_displayed_component_shared_nodes {} {
    show_component_shared_nodes displayed
}

proc ::SharedEdgeGUI::refresh_shared_menu {} {
    set menu .sharededgecheck.body.work.actions.nodes.find.menu
    set state [expr {[llength $::SharedEdgeGUI::selected] >= 2 ? "normal" : "disabled"}]
    $menu entryconfigure 0 -state $state
}

proc ::SharedEdgeGUI::find_shared_faces {} {
    variable selected
    variable status_text
    variable shared_face_outputs
    set w .sharededgecheck
    if {[llength $selected] < 2} {
        set status_text "Select at least two components first."
        return
    }
    set button $w.body.work.actions.faces.find
    $button configure -state disabled
    set status_text "Finding shared faces..."
    update idletasks
    set started [clock milliseconds]
    catch {*redrawblock 1}
    set rc [catch {::SharedEdgeContext::find_shared_faces $selected ::SharedEdgeGUI::face_progress} result opts]
    catch {*redrawblock 0}
    catch {*redraw}
    $button configure -state normal
    if {$rc} {
        set status_text "Could not find shared faces."
        tk_messageBox -parent $w -icon error -type ok -message $result
        return
    }
    set count [dict get $result faces]
    set names [dict get $result outputs]
    if {[llength $names]} {
        set color_rc [catch {
            ::SharedEdgeContext::recolor_highlights [dict create shared_faces $names] $::SharedEdgeGUI::color_ids
        } color_err]
        if {$color_rc} {
            set status_text "Found $count shared faces, but could not apply their color."
            tk_messageBox -parent $w -icon error -type ok -message $color_err
        }
    }
    set shared_face_outputs [lsort -unique [concat $shared_face_outputs $names]]
    if {[llength $shared_face_outputs]} {
        $w.body.work.colors.apply configure -state normal
    }
    set pairs [dict get $result pairs]
    set face_scans [dict get $result findfaces]
    set elapsed [dict get $result elapsed]
    set status_text "Found $count faces in $pairs pairs (${elapsed} ms; $face_scans face scans)."
    puts "Shared faces: faces=$count, pairs=$pairs, outputs=[join $names {, }], face_scans=$face_scans, elapsed=[expr {[clock milliseconds] - $started}] ms."
}

proc ::SharedEdgeGUI::face_progress {current total} {
    variable status_text
    set status_text "Finding shared faces... ($current/$total)"
    update idletasks
}

proc ::SharedEdgeGUI::show_visible_shared_nodes {} {
    variable visible_shared_nodes
    variable status_text
    set started [clock milliseconds]
    set rc [catch {
        set nodes [::SharedEdgeContext::visible_shared_nodes]
        set find_ms [expr {[clock milliseconds] - $started}]
        set count [::SharedEdgeContext::show_shared_node_display $nodes]
    } err]
    if {$rc} {
        set status_text "Could not show visible shared nodes."
        tk_messageBox -parent .sharededgecheck -icon error -type ok -message $err
        return
    }
    set visible_shared_nodes [lsort -integer -unique [concat $visible_shared_nodes $nodes]]
    if {[llength $visible_shared_nodes]} {
        .sharededgecheck.body.work.actions.nodes.clear configure -state normal
    }
    set elapsed [expr {[clock milliseconds] - $started}]
    set status_text "Marked $count shared nodes from displayed elements in ${elapsed} ms."
    puts "Visible shared display: nodes=$count, find=${find_ms} ms, total=${elapsed} ms."
}

proc ::SharedEdgeGUI::clear_temp_nodes {} {
    variable visible_shared_nodes
    variable status_text
    set rc [catch {::SharedEdgeContext::clear_shared_node_display $visible_shared_nodes} value]
    if {$rc} {
        tk_messageBox -parent .sharededgecheck -icon error -type ok -message $value
    } else {
        set visible_shared_nodes {}
        set status_text "Cleared temporary display for $value shared nodes."
    }
}

proc ::SharedEdgeGUI::restore_view {} {
    variable view_mask
    if {$view_mask eq ""} {return 1}
    set rc [catch {*restoreviewmask $view_mask 0} err]
    if {$rc} {
        tk_messageBox -parent .sharededgecheck -icon error -type ok -message $err
        return 0
    }
    catch {*removeview $view_mask}
    set view_mask ""
    catch {*redraw}
    return 1
}

proc ::SharedEdgeGUI::discard_view_mask {} {
    if {$::SharedEdgeGUI::view_mask eq ""} {return}
    catch {*removeview $::SharedEdgeGUI::view_mask}
    set ::SharedEdgeGUI::view_mask ""
}

proc ::SharedEdgeGUI::close {} {
    discard_view_mask
    save_settings
    catch {clear_temp_nodes}
    destroy .sharededgecheck
}

proc ::SharedEdgeGUI::select_components {} {
    variable selected
    variable selection_text
    variable status_text
    set window .sharededgecheck
    catch {clear_temp_nodes}
    wm withdraw $window
    update idletasks
    *createmark components 1
    set rc [catch {*createmarkpanel components 1 "Select 2 or more components, then Proceed"} err]
    set ids {}
    if {!$rc} {set ids [lsort -integer -unique [hm_getmark components 1]]}
    wm deiconify $window
    raise $window
    if {$rc} {set status_text "Selection cancelled: $err"; return}
    if {![llength $ids]} {set status_text "Selection cancelled."; return}
    set selected $ids
    set selection_text "[llength $ids] components selected"
    if {[llength $ids] < 2} {
        set status_text "Select at least two components."
        $window.body.work.actions.check.run configure -state disabled
        $window.body.work.actions.faces.find configure -state disabled
    } else {
        set status_text "Ready to check [llength $ids] components."
        $window.body.work.actions.check.run configure -state normal
        $window.body.work.actions.faces.find configure -state normal
    }
}

proc ::SharedEdgeGUI::run_check {} {
    variable selected
    variable color_ids
    variable outputs
    variable output_by_category
    variable output_by_group
    variable shared_face_outputs
    variable status_text
    set window .sharededgecheck
    if {[llength $selected] < 2} {return}
    if {$::SharedEdgeGUI::view_mask ne "" && ![restore_view]} {return}
    set ::SharedEdgeGUI::focused_pair ""
    set ::SharedEdgeGUI::focused_comp ""
    catch {clear_temp_nodes}
    $window.body.work.actions.check.export configure -state disabled
    set ::SharedEdgeGUI::error_rows [dict create]
    set ::SharedEdgeGUI::list_search ""
    refresh_error_list
    $window.body.work.actions.check.run configure -state disabled
    $window.body.selection.button configure -state disabled
    set status_text "Checking..."
    update idletasks
    set rc [catch {::SharedEdgeContext::run $selected pair $color_ids} result]
    $window.body.work.actions.check.run configure -state normal
    $window.body.selection.button configure -state normal
    if {$rc} {
        set status_text "Check failed."
        tk_messageBox -parent $window -icon error -type ok -message $result
        return
    }
    if {[dict get $result status] ne "done"} {
        set status_text [dict get $result message]
        return
    }
    set outputs [dict get $result outputs]
    set output_by_category [dict get $result output_by_category]
    set output_by_group [dict get $result output_by_group]
    $window.body.work.colors.apply configure -state [expr {[llength $outputs] || [llength $shared_face_outputs] ? "normal" : "disabled"}]
    $window.body.work.actions.check.export configure -state [expr {[llength $outputs] ? "normal" : "disabled"}]
    set list_started [clock milliseconds]
    if {[catch {prepare_error_rows} list_err]} {
        set ::SharedEdgeGUI::list_status "Could not refresh error list: $list_err"
    } else {
        refresh_error_list
    }
    set list_elapsed [expr {[clock milliseconds] - $list_started}]
    $window.body.work.actions.nodes.clear configure -state normal
    set status_text "Missing [dict get $result missing]   Extra [dict get $result extra]   Inconsistent [dict get $result inconsistent]   |   [dict get $result elapsed] ms"
    puts "Shared Edge Check: pairs=[dict get $result pairs], missing=[dict get $result missing], extra=[dict get $result extra], inconsistent=[dict get $result inconsistent]; [dict get $result elapsed] ms."
    puts "Error list: rows=[dict size $::SharedEdgeGUI::error_rows], elapsed=${list_elapsed} ms."
    if {[llength $outputs]} {puts "Highlight components: [join $outputs {, }]"}
}

proc ::SharedEdgeGUI::build {} {
    set w .sharededgecheck
    if {[winfo exists $w]} {
        if {[winfo exists $w.errors.list.tree] &&
            [winfo exists $w.errors.heading] &&
            ![winfo exists $w.body.selection.list] &&
            [winfo exists $w.body.header.ontop] &&
            [winfo exists $w.body.work.colors.apply] &&
            [winfo exists $w.body.work.actions.nodes.find] &&
            [winfo exists $w.body.work.actions.nodes.find.menu] &&
            [winfo exists $w.body.work.actions.faces.find] &&
            [winfo exists $w.body.work.colors.shared_faces.swatch] &&
            [$w.body.work.colors cget -text] eq "Color Management" &&
            [$w.body.work.actions.nodes.find.menu index end] == 2 &&
            [$w.errors.heading cget -text] eq "Error list" &&
            [$w.errors.list.tree heading parts -text] eq "Pair" &&
            [$w.errors.list.tree column missing -stretch] &&
            ![winfo exists $w.body.mode] &&
            ![winfo exists $w.body.work.actions.view.restore]} {
            if {[catch {refresh_error_list} list_err]} {
                set ::SharedEdgeGUI::list_status "Could not refresh error list: $list_err"
            }
            wm deiconify $w
            raise $w
            return
        }
        discard_view_mask
        destroy $w
    }
    if {[winfo exists .sharededgeerrors]} {destroy .sharededgeerrors}
    load_settings
    reset_session
    toplevel $w
    wm withdraw $w
    wm title $w "Shared Edge Check"
    wm resizable $w 1 1
    wm attributes $w -topmost $::SharedEdgeGUI::always_on_top
    frame $w.body -padx 14 -pady 12
    pack $w.body -side left -fill y

    frame $w.body.header
    checkbutton $w.body.header.ontop -text "Always on top" \
        -variable ::SharedEdgeGUI::always_on_top \
        -command ::SharedEdgeGUI::apply_topmost
    pack $w.body.header.ontop -side left
    pack $w.body.header -fill x -pady {0 8}

    frame $w.body.selection
    button $w.body.selection.button -text "Select components..." \
        -command ::SharedEdgeGUI::select_components
    label $w.body.selection.count -textvariable ::SharedEdgeGUI::selection_text -anchor w
    pack $w.body.selection.button -side left
    pack $w.body.selection.count -side left -padx {10 0}
    pack $w.body.selection -fill x

    frame $w.body.work
    labelframe $w.body.work.colors -text "Color Management" -padx 10 -pady 8 -bd 2 -relief groove
    set row 0
    foreach item {{missing Missing} {extra Extra} {inconsistent Inconsistent} {shared_faces {Shared face}}} {
        lassign $item category title
        frame $w.body.work.colors.$category
        label $w.body.work.colors.$category.label -text $title -width 14 -anchor w
        canvas $w.body.work.colors.$category.swatch -width 26 -height 26 \
            -highlightthickness 0 -borderwidth 0 -cursor hand2
        pack $w.body.work.colors.$category.label -side left
        pack $w.body.work.colors.$category.swatch -side left -padx {8 0}
        bind $w.body.work.colors.$category.swatch <Button-1> \
            [list ::SharedEdgeGUI::choose_color $category]
        grid $w.body.work.colors.$category -row $row -column 0 -sticky w -pady 5
        refresh_swatch $category
        incr row
    }
    grid columnconfigure $w.body.work.colors 0 -weight 1
    button $w.body.work.colors.apply -text "Apply" -state disabled \
        -command ::SharedEdgeGUI::apply_colors
    grid $w.body.work.colors.apply -row 4 -column 0 -sticky ew -pady {10 0}
    grid $w.body.work.colors -row 0 -column 0 -sticky ns -padx {0 12}

    frame $w.body.work.actions
    labelframe $w.body.work.actions.check -text "Check & report" -padx 8 -pady 6 -bd 2 -relief groove
    foreach spec {
        {run "Check & Highlight" ::SharedEdgeGUI::run_check}
        {export "Export errors PPT" ::SharedEdgeGUI::export_report}
    } {
        lassign $spec name title command
        button $w.body.work.actions.check.$name -text $title -width 19 \
            -state disabled -command $command
        pack $w.body.work.actions.check.$name -fill x -pady 2
    }
    pack $w.body.work.actions.check -fill x

    labelframe $w.body.work.actions.nodes -text "Shared nodes" -padx 8 -pady 6 -bd 2 -relief groove
    menubutton $w.body.work.actions.nodes.find -text "Find shared nodes..." \
        -width 19 -relief raised -indicatoron 1 \
        -menu $w.body.work.actions.nodes.find.menu
    menu $w.body.work.actions.nodes.find.menu -tearoff 0 \
        -postcommand ::SharedEdgeGUI::refresh_shared_menu
    $w.body.work.actions.nodes.find.menu add command -label "Selected components" \
        -command ::SharedEdgeGUI::show_selected_shared_nodes
    $w.body.work.actions.nodes.find.menu add command -label "Displayed components (fast)" \
        -command ::SharedEdgeGUI::show_displayed_component_shared_nodes
    $w.body.work.actions.nodes.find.menu add command -label "Displayed elements (exact)" \
        -command ::SharedEdgeGUI::show_visible_shared_nodes
    bind $w.body.work.actions.nodes.find <Button-3> {
        tk_popup .sharededgecheck.body.work.actions.nodes.find.menu %X %Y
    }
    button $w.body.work.actions.nodes.clear -text "Clear temp nodes" -width 19 \
        -state disabled -command ::SharedEdgeGUI::clear_temp_nodes
    pack $w.body.work.actions.nodes.find -fill x -pady 2
    pack $w.body.work.actions.nodes.clear -fill x -pady 2
    pack $w.body.work.actions.nodes -fill x -pady {8 0}

    labelframe $w.body.work.actions.faces -text "Shared faces" -padx 8 -pady 6 -bd 2 -relief groove
    button $w.body.work.actions.faces.find -text "Find shared faces" -width 19 \
        -state disabled -command ::SharedEdgeGUI::find_shared_faces
    pack $w.body.work.actions.faces.find -fill x -pady 2
    pack $w.body.work.actions.faces -fill x -pady {8 0}

    grid $w.body.work.actions -row 0 -column 1 -sticky nsew
    grid columnconfigure $w.body.work 1 -weight 1
    pack $w.body.work -fill x -pady {10 0}

    frame $w.body.footer
    label $w.body.footer.status -textvariable ::SharedEdgeGUI::status_text -anchor w -width 53
    button $w.body.footer.close -text "Close" -command ::SharedEdgeGUI::close
    pack $w.body.footer.status -side left -fill x -expand 1
    pack $w.body.footer.close -side right -padx {10 0}
    pack $w.body.footer -fill x -pady {12 0}

    frame $w.errors -padx 10 -pady 12 -bd 1 -relief groove
    pack $w.errors -side right -fill both -expand 1 -padx {0 10} -pady 10
    label $w.errors.heading -text "Error list" -anchor w -font {Arial 11 bold}
    pack $w.errors.heading -fill x
    frame $w.errors.filters
    ttk::combobox $w.errors.filters.type -textvariable ::SharedEdgeGUI::list_filter \
        -values {All Missing Extra Inconsistent} -state readonly -width 13
    entry $w.errors.filters.search -textvariable ::SharedEdgeGUI::list_search -width 22
    pack $w.errors.filters.type -side left
    pack $w.errors.filters.search -side left -fill x -expand 1 -padx {8 0}
    pack $w.errors.filters -fill x -pady {8 7}
    frame $w.errors.list
    ttk::treeview $w.errors.list.tree -columns {parts missing extra inconsistent} \
        -show headings -selectmode browse -height 12 \
        -yscrollcommand [list $w.errors.list.scroll set]
    scrollbar $w.errors.list.scroll -orient vertical -command [list $w.errors.list.tree yview]
    foreach spec {{parts Pair 210} {missing Miss 53} {extra Extra 53} \
        {inconsistent Incon 53}} {
        lassign $spec column title width
        $w.errors.list.tree heading $column -text $title
        $w.errors.list.tree column $column -width $width \
            -minwidth [expr {$column eq "parts" ? 170 : 50}] \
            -stretch 1 -anchor w
    }
    pack $w.errors.list.scroll -side right -fill y
    pack $w.errors.list.tree -side left -fill both -expand 1
    pack $w.errors.list -fill both -expand 1
    label $w.errors.status -textvariable ::SharedEdgeGUI::list_status -anchor w -width 52
    pack $w.errors.status -fill x -pady {8 0}
    bind $w.errors.filters.type <<ComboboxSelected>> {
        ::SharedEdgeGUI::refresh_error_list
        ::SharedEdgeGUI::save_settings
    }
    bind $w.errors.filters.search <KeyRelease> ::SharedEdgeGUI::refresh_error_list
    bind $w.errors.list.tree <Double-1> ::SharedEdgeGUI::focus_selected_error
    menu $w.errors.context -tearoff 0
    $w.errors.context add command -label "Show other part" \
        -command ::SharedEdgeGUI::show_other_part
    $w.errors.context add command -label "Show shared faces" \
        -command ::SharedEdgeGUI::show_shared_faces_for_selected_pair
    bind $w.errors.list.tree <Button-3> {
        ::SharedEdgeGUI::popup_error_menu %x %y %X %Y
    }
    if {$::SharedEdgeContext::last_report ne ""} {
        catch {prepare_error_rows}
    }
    refresh_error_list
    bind $w <Escape> {::SharedEdgeGUI::close}
    wm protocol $w WM_DELETE_WINDOW ::SharedEdgeGUI::close
    place_initial_window $w
}

::SharedEdgeGUI::build
