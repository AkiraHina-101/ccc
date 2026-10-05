namespace eval ::BoltProjectionPreview {
    variable boltComp
    variable targetComp
    variable targetMode
    variable planeNodeIds
    variable customPlane
    variable angle
    variable boltCount
    variable samples
    variable alwaysOnTop
    variable status
    if {![info exists boltComp]} {set boltComp {}}
    if {![info exists targetComp]} {set targetComp {}}
    if {![info exists targetMode]} {set targetMode component}
    if {![info exists planeNodeIds]} {set planeNodeIds {}}
    if {![info exists customPlane]} {set customPlane {}}
    if {![info exists angle]} {set angle 45}
    if {![info exists boltCount]} {set boltCount "Not scanned"}
    if {![info exists samples]} {set samples 180}
    if {![info exists alwaysOnTop]} {set alwaysOnTop 1}
    if {![info exists status]} {set status "Select bolt and flange components."}
}

proc ::BoltProjectionPreview::vadd {a b} {
    if {[llength $a] != [llength $b]} {error "Vector size mismatch."}
    set out {}
    foreach x $a y $b {lappend out [expr {$x+$y}]}
    return $out
}
proc ::BoltProjectionPreview::vsub {a b} {
    if {[llength $a] != [llength $b]} {error "Vector size mismatch."}
    set out {}
    foreach x $a y $b {lappend out [expr {$x-$y}]}
    return $out
}
proc ::BoltProjectionPreview::vscale {a s} {
    set out {}
    foreach x $a {lappend out [expr {$x*$s}]}
    return $out
}
proc ::BoltProjectionPreview::dot {a b} {set out 0.0; foreach x $a y $b {set out [expr {$out+$x*$y}]}; return $out}
proc ::BoltProjectionPreview::cross {a b} {
    lassign $a ax ay az; lassign $b bx by bz
    list [expr {$ay*$bz-$az*$by}] [expr {$az*$bx-$ax*$bz}] [expr {$ax*$by-$ay*$bx}]
}
proc ::BoltProjectionPreview::norm {a} {expr {sqrt([dot $a $a])}}
proc ::BoltProjectionPreview::unit {a} {
    set m [norm $a]
    if {$m < 1.0e-12} {error "Selected points are collinear or too close."}
    vscale $a [expr {1.0/$m}]
}
proc ::BoltProjectionPreview::circumcircle {a b c} {
    set u [vsub $b $a]
    set v [vsub $c $a]
    set w [cross $u $v]
    set ww [dot $w $w]
    if {$ww < 1.0e-20} {error "The 3 bolt points are collinear."}
    set offset [vscale [vadd [vscale [cross $v $w] [dot $u $u]] [vscale [cross $w $u] [dot $v $v]]] [expr {0.5/$ww}]]
    set center [vadd $a $offset]
    list $center [norm [vsub $a $center]] [unit $w]
}

proc ::BoltProjectionPreview::best_fit_plane {points} {
    if {[llength $points] < 3} {error "The selected component has fewer than 3 nodes."}
    set center {0.0 0.0 0.0}
    foreach p $points {set center [vadd $center $p]}
    set center [vscale $center [expr {1.0/[llength $points]}]]
    set a {{0.0 0.0 0.0} {0.0 0.0 0.0} {0.0 0.0 0.0}}
    foreach p $points {
        set d [vsub $p $center]
        for {set i 0} {$i < 3} {incr i} {
            for {set j 0} {$j < 3} {incr j} {
                lset a $i $j [expr {[lindex $a $i $j] + [lindex $d $i]*[lindex $d $j]}]
            }
        }
    }
    set v {{1.0 0.0 0.0} {0.0 1.0 0.0} {0.0 0.0 1.0}}
    for {set iter 0} {$iter < 40} {incr iter} {
        set p 0; set q 1; set largest [expr {abs([lindex $a 0 1])}]
        foreach ij {{0 2} {1 2}} {
            lassign $ij i j
            set value [expr {abs([lindex $a $i $j])}]
            if {$value > $largest} {set largest $value; set p $i; set q $j}
        }
        if {$largest < 1.0e-14} {break}
        set app [lindex $a $p $p]; set aqq [lindex $a $q $q]; set apq [lindex $a $p $q]
        set theta [expr {0.5*atan2(2.0*$apq,$aqq-$app)}]
        set c [expr {cos($theta)}]; set s [expr {sin($theta)}]
        for {set k 0} {$k < 3} {incr k} {
            if {$k == $p || $k == $q} {continue}
            set akp [lindex $a $k $p]; set akq [lindex $a $k $q]
            set newkp [expr {$c*$akp-$s*$akq}]; set newkq [expr {$s*$akp+$c*$akq}]
            lset a $k $p $newkp; lset a $p $k $newkp
            lset a $k $q $newkq; lset a $q $k $newkq
        }
        lset a $p $p [expr {$c*$c*$app-2.0*$s*$c*$apq+$s*$s*$aqq}]
        lset a $q $q [expr {$s*$s*$app+2.0*$s*$c*$apq+$c*$c*$aqq}]
        lset a $p $q 0.0; lset a $q $p 0.0
        for {set k 0} {$k < 3} {incr k} {
            set vkp [lindex $v $k $p]; set vkq [lindex $v $k $q]
            lset v $k $p [expr {$c*$vkp-$s*$vkq}]
            lset v $k $q [expr {$s*$vkp+$c*$vkq}]
        }
    }
    set eigs [list [lindex $a 0 0] [lindex $a 1 1] [lindex $a 2 2]]
    set minIndex [lsearch -exact $eigs [lindex [lsort -real $eigs] 0]]
    set normal [unit [list [lindex $v 0 $minIndex] [lindex $v 1 $minIndex] [lindex $v 2 $minIndex]]]
    if {[lindex [lsort -real $eigs] 1] < 1.0e-12} {error "The component nodes do not define a plane."}
    list $center $normal
}

proc ::BoltProjectionPreview::plane_from_three {a b c} {
    set normal [unit [cross [vsub $b $a] [vsub $c $a]]]
    list $a $normal
}

proc ::BoltProjectionPreview::project_circle {circle plane count angle} {
    lassign $circle center radius axis
    lassign $plane planePoint planeNormal
    if {![string is double -strict $angle] || $angle <= 0.0 || $angle > 90.0} {error "Projection angle must be greater than 0 and no more than 90 degrees."}
    set radialScale [expr {1.0/tan($angle*acos(-1.0)/180.0)}]
    if {$count < 24} {set count 24}
    set side [dot $axis [vsub $planePoint $center]]
    if {abs($side) < 1.0e-10} {error "Flange plane is not on either side of the bolt circle."}
    if {$side < 0} {set axis [vscale $axis -1.0]}
    set ref {1.0 0.0 0.0}
    if {abs([dot $ref $axis]) > 0.9} {set ref {0.0 1.0 0.0}}
    set u [unit [vsub $ref [vscale $axis [dot $ref $axis]]]]
    set v [unit [cross $axis $u]]
    set result {}
    for {set i 0} {$i < $count} {incr i} {
        set angle [expr {2.0*acos(-1.0)*$i/$count}]
        set radial [vadd [vscale $u [expr {cos($angle)}]] [vscale $v [expr {sin($angle)}]]]
        set source [vadd $center [vscale $radial $radius]]
        set direction [vadd $axis [vscale $radial $radialScale]]
        set denom [dot $planeNormal $direction]
        if {abs($denom) < 1.0e-10} {error "A projection ray is parallel to the flange plane."}
        set t [expr {[dot $planeNormal [vsub $planePoint $source]]/$denom}]
        if {$t <= 0} {error "Projection ray reaches the flange plane behind the bolt."}
        lappend result [vadd $source [vscale $direction $t]]
    }
    return $result
}

proc ::BoltProjectionPreview::select_bolt_component {} {
    variable boltComp; variable boltCount; variable status
    *createmarkpanel comps 1 "Select component containing bolts"
    set ids [lsort -integer -unique [hm_getmark comps 1]]
    *clearmark comps 1
    if {[llength $ids] != 1} {set status "Select exactly 1 bolt component."; return}
    set boltComp [lindex $ids 0]
    set name [hm_getvalue comps id=$boltComp dataname=name]
    set boltCount "Not scanned"
    .boltProjection.body.left.bolt.source configure -text "$name ($boltComp)"
    set status "Bolt component selected: $name."
}

proc ::BoltProjectionPreview::select_target_component {} {
    variable targetComp; variable status
    *createmarkpanel comps 1 "Select flange shared-face component"
    set ids [lsort -integer -unique [hm_getmark comps 1]]
    *clearmark comps 1
    if {[llength $ids] != 1} {set status "Select exactly 1 flange component."; return}
    set targetComp [lindex $ids 0]
    set name [hm_getvalue comps id=$targetComp dataname=name]
    .boltProjection.body.left.target.component.name configure -text "$name ($targetComp)"
    set status "Flange component selected: $name."
}

proc ::BoltProjectionPreview::select_plane_nodes {} {
    variable planeNodeIds; variable customPlane; variable status
    *createmarkpanel nodes 1 "Select exactly 3 nodes to define flange plane"
    set ids [hm_getmark nodes 1]
    *clearmark nodes 1
    if {[llength $ids] != 3} {set status "Select exactly 3 nodes to define the plane."; return}
    set coords [get_coordinates $ids]
    set points {}; foreach id $ids {lappend points [dict get $coords $id]}
    if {[catch {set plane [plane_from_three {*}$points]} err]} {set status $err; return}
    set planeNodeIds $ids
    set customPlane $plane
    .boltProjection.body.left.target.nodes configure -text "Nodes: [join $ids {, }]"
    set status "Plane defined from nodes [join $ids {, }]."
}

proc ::BoltProjectionPreview::set_target_mode {} {
    variable targetMode
    if {$targetMode eq "component"} {
        .boltProjection.body.left.target.component.select configure -state normal
        .boltProjection.body.left.target.plane.select configure -state disabled
    } else {
        .boltProjection.body.left.target.component.select configure -state disabled
        .boltProjection.body.left.target.plane.select configure -state normal
    }
}

proc ::BoltProjectionPreview::apply_topmost {} {
    variable alwaysOnTop
    wm attributes .boltProjection -topmost $alwaysOnTop
}

proc ::BoltProjectionPreview::get_coordinates {ids} {
    if {![llength $ids]} {error "No nodes selected."}
    set result [dict create]
    for {set offset 0} {$offset < [llength $ids]} {incr offset 1024} {
        set chunk [lrange $ids $offset [expr {$offset+1023}]]
        *createmark nodes 1 {*}$chunk
        set actual [hm_getmark nodes 1]
        if {[llength $actual] != [llength $chunk]} {
            *clearmark nodes 1
            error "Some selected nodes no longer exist."
        }
        set xs [hm_getvalue nodes mark=1 dataname=x]
        set ys [hm_getvalue nodes mark=1 dataname=y]
        set zs [hm_getvalue nodes mark=1 dataname=z]
        *clearmark nodes 1
        foreach id $actual x $xs y $ys z $zs {dict set result $id [list $x $y $z]}
    }
    return $result
}

proc ::BoltProjectionPreview::find_root {parentVar id} {
    upvar 1 $parentVar parents
    set root $id
    while {[dict get $parents $root] ne $root} {set root [dict get $parents $root]}
    set current $id
    while {[dict get $parents $current] ne $current} {
        set next [dict get $parents $current]
        dict set parents $current $root
        set current $next
    }
    return $root
}

proc ::BoltProjectionPreview::join_elements {parentVar rankVar left right} {
    upvar 1 $parentVar parents $rankVar ranks
    set rootA [find_root parents $left]
    set rootB [find_root parents $right]
    if {$rootA eq $rootB} {return}
    set rankA [dict get $ranks $rootA]
    set rankB [dict get $ranks $rootB]
    if {$rankA < $rankB} {
        dict set parents $rootA $rootB
    } elseif {$rankA > $rankB} {
        dict set parents $rootB $rootA
    } else {
        dict set parents $rootB $rootA
        dict incr ranks $rootA
    }
}

proc ::BoltProjectionPreview::connected_bolt_meshes {cid} {
    *createmark elems 1 "by collector id" $cid
    set elemIds [hm_getmark elems 1]
    *clearmark elems 1
    if {![llength $elemIds]} {error "The selected bolt component contains no elements."}
    set parents [dict create]
    set ranks [dict create]
    set nodeOwner [dict create]
    set connectivity [dict create]
    foreach eid $elemIds {dict set parents $eid $eid; dict set ranks $eid 0}
    for {set offset 0} {$offset < [llength $elemIds]} {incr offset 1024} {
        set chunk [lrange $elemIds $offset [expr {$offset+1023}]]
        set conns [hm_getvalue elems user_ids=$chunk dataname=nodes]
        if {[llength $conns] != [llength $chunk]} {error "Could not read all bolt element connectivities."}
        foreach eid $chunk nodes $conns {
            dict set connectivity $eid $nodes
            foreach nid $nodes {
                if {[dict exists $nodeOwner $nid]} {
                    join_elements parents ranks $eid [dict get $nodeOwner $nid]
                } else {
                    dict set nodeOwner $nid $eid
                }
            }
        }
    }
    set groups [dict create]
    set allNodes [dict create]
    foreach eid $elemIds {
        set root [find_root parents $eid]
        dict lappend groups $root $eid
        foreach nid [dict get $connectivity $eid] {dict set allNodes $nid 1}
    }
    set coords [get_coordinates [lsort -integer [dict keys $allNodes]]]
    set groupNodes [dict create]
    dict for {root members} $groups {
        set nodes [dict create]
        foreach eid $members {foreach nid [dict get $connectivity $eid] {dict set nodes $nid 1}}
        dict set groupNodes $root [dict keys $nodes]
    }
    list $groupNodes $coords
}

proc ::BoltProjectionPreview::principal_axis {points} {
    if {[llength $points] < 6} {error "Bolt body has too few mesh nodes."}
    set center {0.0 0.0 0.0}
    foreach point $points {set center [vadd $center $point]}
    set center [vscale $center [expr {1.0/[llength $points]}]]
    set matrix {{0.0 0.0 0.0} {0.0 0.0 0.0} {0.0 0.0 0.0}}
    foreach point $points {
        set delta [vsub $point $center]
        for {set i 0} {$i < 3} {incr i} {
            for {set j 0} {$j < 3} {incr j} {
                lset matrix $i $j [expr {[lindex $matrix $i $j]+[lindex $delta $i]*[lindex $delta $j]}]
            }
        }
    }
    set vectors {{1.0 0.0 0.0} {0.0 1.0 0.0} {0.0 0.0 1.0}}
    for {set iter 0} {$iter < 40} {incr iter} {
        set p 0; set q 1; set largest [expr {abs([lindex $matrix 0 1])}]
        foreach pair {{0 2} {1 2}} {
            lassign $pair i j
            set value [expr {abs([lindex $matrix $i $j])}]
            if {$value > $largest} {set largest $value; set p $i; set q $j}
        }
        if {$largest < 1.0e-14} {break}
        set app [lindex $matrix $p $p]; set aqq [lindex $matrix $q $q]; set apq [lindex $matrix $p $q]
        set theta [expr {0.5*atan2(2.0*$apq,$aqq-$app)}]
        set c [expr {cos($theta)}]; set s [expr {sin($theta)}]
        for {set k 0} {$k < 3} {incr k} {
            if {$k == $p || $k == $q} {continue}
            set mkp [lindex $matrix $k $p]; set mkq [lindex $matrix $k $q]
            set newP [expr {$c*$mkp-$s*$mkq}]; set newQ [expr {$s*$mkp+$c*$mkq}]
            lset matrix $k $p $newP; lset matrix $p $k $newP
            lset matrix $k $q $newQ; lset matrix $q $k $newQ
        }
        lset matrix $p $p [expr {$c*$c*$app-2.0*$s*$c*$apq+$s*$s*$aqq}]
        lset matrix $q $q [expr {$s*$s*$app+2.0*$s*$c*$apq+$c*$c*$aqq}]
        lset matrix $p $q 0.0; lset matrix $q $p 0.0
        for {set k 0} {$k < 3} {incr k} {
            set vkp [lindex $vectors $k $p]; set vkq [lindex $vectors $k $q]
            lset vectors $k $p [expr {$c*$vkp-$s*$vkq}]
            lset vectors $k $q [expr {$s*$vkp+$c*$vkq}]
        }
    }
    set eigenvalues [list [lindex $matrix 0 0] [lindex $matrix 1 1] [lindex $matrix 2 2]]
    set index [lsearch -exact $eigenvalues [lindex [lsort -real $eigenvalues] 2]]
    set axis [unit [list [lindex $vectors 0 $index] [lindex $vectors 1 $index] [lindex $vectors 2 $index]]]
    list $center $axis
}

proc ::BoltProjectionPreview::bolt_end_circle {nodeIds coords plane} {
    if {[llength $nodeIds] < 6} {error "mesh island is too small to be a bolt."}
    set points {}
    foreach nid $nodeIds {lappend points [dict get $coords $nid]}
    lassign [principal_axis $points] center axis
    lassign $plane planePoint planeNormal
    set axialCenter [dot $center $axis]
    set low 1.0e100; set high -1.0e100
    foreach point $points {
        set axial [dot $point $axis]
        if {$axial < $low} {set low $axial}
        if {$axial > $high} {set high $axial}
    }
    set span [expr {$high-$low}]
    if {$span < 1.0e-8} {error "mesh island does not have a clear bolt axis."}
    set lowCenter [vadd $center [vscale $axis [expr {$low-$axialCenter}]]]
    set highCenter [vadd $center [vscale $axis [expr {$high-$axialCenter}]]]
    set lowGap [expr {abs([dot $planeNormal [vsub $lowCenter $planePoint]])}]
    set highGap [expr {abs([dot $planeNormal [vsub $highCenter $planePoint]])}]
    set endValue [expr {$lowGap <= $highGap ? $low : $high}]
    set tolerance [expr {max(1.0e-7,$span*0.015)}]
    set ref {1.0 0.0 0.0}
    if {abs([dot $ref $axis]) > 0.9} {set ref {0.0 1.0 0.0}}
    set u [unit [vsub $ref [vscale $axis [dot $ref $axis]]]]
    set v [unit [cross $axis $u]]
    set faceCenter [vadd $center [vscale $axis [expr {$endValue-$axialCenter}]]]
    set radialNodes {}
    set maxRadius 0.0
    foreach nid $nodeIds {
        set point [dict get $coords $nid]
        set axial [dot $point $axis]
        if {abs($axial-$endValue) > $tolerance} {continue}
        set delta [vsub $point $faceCenter]
        set x [dot $delta $u]; set y [dot $delta $v]
        set radius [expr {sqrt($x*$x+$y*$y)}]
        if {$radius > $maxRadius} {set maxRadius $radius}
        lappend radialNodes [list $nid $point $radius $x $y]
    }
    if {$maxRadius < 1.0e-8 || [llength $radialNodes] < 3} {error "could not find a circular bolt end face."}
    set bins [dict create]
    set twoPi [expr {2.0*acos(-1.0)}]
    foreach item $radialNodes {
        lassign $item nid point radius x y
        if {$radius < 0.78*$maxRadius} {continue}
        set theta [expr {atan2($y,$x)}]
        if {$theta < 0} {set theta [expr {$theta+$twoPi}]}
        set bin [expr {int(floor(12.0*$theta/$twoPi))}]
        if {![dict exists $bins $bin] || $radius > [lindex [dict get $bins $bin] 2]} {dict set bins $bin $item}
    }
    set perimeter [dict values $bins]
    if {[llength $perimeter] < 3} {error "not enough perimeter nodes on the bolt end face."}
    set bestArea 0.0; set selected {}
    for {set i 0} {$i < [llength $perimeter]-2} {incr i} {
        for {set j [expr {$i+1}]} {$j < [llength $perimeter]-1} {incr j} {
            for {set k [expr {$j+1}]} {$k < [llength $perimeter]} {incr k} {
                set a [lindex [lindex $perimeter $i] 1]
                set b [lindex [lindex $perimeter $j] 1]
                set c [lindex [lindex $perimeter $k] 1]
                set area [norm [cross [vsub $b $a] [vsub $c $a]]]
                if {$area > $bestArea} {set bestArea $area; set selected [list $a $b $c]}
            }
        }
    }
    if {$bestArea < $maxRadius*$maxRadius*0.5} {error "bolt end perimeter nodes are nearly collinear."}
    set circle [circumcircle {*}$selected]
    if {[lindex $circle 1] < 0.6*$maxRadius || [lindex $circle 1] > 1.8*$maxRadius} {error "bolt end nodes do not form a stable circle."}
    return $circle
}

proc ::BoltProjectionPreview::component_plane {cid} {
    *createmark elems 1 "by collector id" $cid
    set elemIds [hm_getmark elems 1]
    *clearmark elems 1
    if {![llength $elemIds]} {error "The selected component contains no elements."}
    set nodeSet [dict create]
    for {set offset 0} {$offset < [llength $elemIds]} {incr offset 1024} {
        set chunk [lrange $elemIds $offset [expr {$offset+1023}]]
        foreach nodes [hm_getvalue elems user_ids=$chunk dataname=nodes] {
            foreach nid $nodes {dict set nodeSet $nid 1}
        }
    }
    set nodeIds [lsort -integer [dict keys $nodeSet]]
    *createmark nodes 1 {*}$nodeIds
    set existing [hm_getmark nodes 1]
    *clearmark nodes 1
    set coords [get_coordinates $existing]
    best_fit_plane [dict values $coords]
}

proc ::BoltProjectionPreview::draw {} {
    variable boltComp; variable targetComp; variable targetMode; variable customPlane
    variable planeNodeIds; variable angle; variable samples; variable status; variable boltCount
    if {$boltComp eq ""} {error "Select the component containing bolts first."}
    if {$targetMode eq "component" && $targetComp eq ""} {error "Select the flange component first."}
    if {$targetMode eq "plane" && [llength $planeNodeIds] != 3} {error "Define the flange plane with 3 nodes first."}
    if {![string is double -strict $angle] || $angle <= 0.0 || $angle > 90.0} {error "Enter an angle greater than 0 and no more than 90 degrees."}
    set status "Finding separate bolt meshes..."
    update idletasks
    if {$targetMode eq "component"} {set plane [component_plane $targetComp]} else {set plane $customPlane}
    lassign [connected_bolt_meshes $boltComp] groups coords
    set circles {}; set failures {}
    dict for {root nodeIds} $groups {
        if {[catch {set circle [bolt_end_circle $nodeIds $coords $plane]} err]} {
            lappend failures $err
        } else {
            lappend circles $circle
        }
    }
    if {![llength $circles]} {
        set boltCount "0 valid"
        .boltProjection.body.output.heading configure -text "Created rings: 0"
        error "Could not detect bolt end circles in the selected component."
    }
    set curves {}
    foreach circle $circles {lappend curves [project_circle $circle $plane $samples $angle]}
    create_native_lines $curves
    set boltCount "[llength $circles] found"
    .boltProjection.body.output.tree delete [.boltProjection.body.output.tree children {}]
    set index 0
    foreach curve $curves {
        incr index
        set center {0.0 0.0 0.0}
        foreach point $curve {set center [vadd $center $point]}
        set center [vscale $center [expr {1.0/[llength $curve]}]]
        set radius 0.0
        foreach point $curve {set radius [expr {$radius+[norm [vsub $point $center]]}]}
        set radius [expr {$radius/[llength $curve]}]
        .boltProjection.body.output.tree insert {} end -values [list "Ring $index" \
            [format "%.3f, %.3f, %.3f" {*}$center] [format "%.3f" $radius]]
    }
    .boltProjection.body.output.heading configure -text "Created rings: $boltCount"
    if {[llength $failures]} {
        set status "Created [llength $circles] rings; skipped [llength $failures] mesh islands that did not match a bolt end."
    } else {
        set status "Created [llength $circles] persistent 3D rings at ${angle} degrees. Delete them manually in the model when no longer needed."
    }
}

proc ::BoltProjectionPreview::unique_output_name {} {
    set base "BoltProjectionRings_[pid]_[clock clicks]"
    set name $base
    set suffix 1
    while {![catch {hm_getvalue comps name=$name dataname=id} id] && $id ne "" && $id ne "0"} {
        set name "${base}_$suffix"
        incr suffix
    }
    return $name
}

proc ::BoltProjectionPreview::red_color_id {} {
    set target {255 0 0}
    set best 1
    set bestDistance 1.0e100
    set index 0
    foreach swatch [hm_winfo entitycolors] {
        if {[llength $swatch] >= 3} {
            lassign $swatch r g b
            set dr [expr {$r-[lindex $target 0]}]
            set dg [expr {$g-[lindex $target 1]}]
            set db [expr {$b-[lindex $target 2]}]
            set distance [expr {$dr*$dr+$dg*$dg+$db*$db}]
            if {$distance < $bestDistance} {set bestDistance $distance; set best [expr {$index+1}]}
        }
        incr index
    }
    return $best
}

proc ::BoltProjectionPreview::create_native_lines {curves} {
    set previousId [hm_info currentcollector comp]
    set previousName ""
    if {$previousId ne "" && $previousId ne "0"} {
        catch {set previousName [hm_getvalue comps id=$previousId dataname=name]}
    }
    set name [unique_output_name]
    set color [red_color_id]
    *collectorcreateonly comps $name "" $color
    set cid [hm_getvalue comps name=$name dataname=id]
    set rc [catch {
        *currentcollector comps $name
        foreach points $curves {
            set values {}
            foreach point $points {foreach value $point {lappend values $value}}
            set count [llength $values]
            *createdoublearray $count {*}$values
            *linecreatefromcoords 10 150 5 179 1 $count
        }
        *createmark lines 1 "by collector id" $cid
        set lineIds [hm_getmark lines 1]
        *clearmark lines 1
        if {[llength $lineIds] != [llength $curves]} {error "Preview line creation returned [llength $lineIds] lines instead of [llength $curves]."}
    } err opts]
    if {$previousName ne ""} {catch {*currentcollector comps $previousName}}
    if {$rc} {return -options $opts "$err (partial output, if any, was left in component $name)"}
    hm_redraw
}

proc ::BoltProjectionPreview::reset_inputs {} {
    variable boltComp; variable targetComp; variable planeNodeIds; variable customPlane
    variable boltCount; variable status
    set boltComp {}; set targetComp {}; set planeNodeIds {}; set customPlane {}; set boltCount "Not scanned"
    .boltProjection.body.left.bolt.source configure -text "No component selected"
    .boltProjection.body.left.target.component.name configure -text "No component selected"
    .boltProjection.body.left.target.nodes configure -text "No plane defined"
    .boltProjection.body.output.tree delete [.boltProjection.body.output.tree children {}]
    .boltProjection.body.output.heading configure -text "Created rings remain in the model"
    set status "Inputs reset; created line groups remain in the model."
}

proc ::BoltProjectionPreview::clear_old_previews {} {
    if {[winfo exists .boltProjectionOverlay]} {destroy .boltProjectionOverlay}
    if {[info exists ::BoltProjectionPreview::previewNodes] && [llength $::BoltProjectionPreview::previewNodes]} {
        catch {*createmark nodes 1 {*}$::BoltProjectionPreview::previewNodes}
        catch {hm_clearshape nodes mark=1 shape=sphere}
        catch {*clearmark nodes 1}
        set ::BoltProjectionPreview::previewNodes {}
    }
}

proc ::BoltProjectionPreview::close {} {destroy .boltProjection}

proc ::BoltProjectionPreview::show {} {
    variable angle; variable boltCount; variable status; variable boltComp; variable targetComp
    variable targetMode; variable planeNodeIds; variable customPlane; variable alwaysOnTop
    if {[winfo exists .boltProjection]} {
        destroy .boltProjection
        set boltComp {}; set targetComp {}; set planeNodeIds {}; set customPlane {}; set boltCount "Not scanned"
    }
    set status "Select bolt and flange targets."
    toplevel .boltProjection
    wm withdraw .boltProjection
    wm title .boltProjection "Bolt to Flange Projection Preview"
    wm resizable .boltProjection 0 0
    wm attributes .boltProjection -topmost $alwaysOnTop
    frame .boltProjection.body -padx 12 -pady 10
    pack .boltProjection.body -fill both -expand 1
    frame .boltProjection.body.left -width 410
    pack .boltProjection.body.left -side left -fill y
    checkbutton .boltProjection.body.left.ontop -text "Always on top" -variable ::BoltProjectionPreview::alwaysOnTop -command ::BoltProjectionPreview::apply_topmost
    pack .boltProjection.body.left.ontop -anchor w -pady {0 7}
    labelframe .boltProjection.body.left.bolt -text "Bolt source" -padx 8 -pady 6 -bd 2 -relief groove
    grid columnconfigure .boltProjection.body.left.bolt 1 -weight 1
    button .boltProjection.body.left.bolt.select -text "Select component..." -command ::BoltProjectionPreview::select_bolt_component -width 19
    label .boltProjection.body.left.bolt.source -text "No component selected" -anchor w
    grid .boltProjection.body.left.bolt.select -row 0 -column 0 -sticky ew -padx {0 8} -pady 3
    grid .boltProjection.body.left.bolt.source -row 0 -column 1 -sticky ew -pady 3
    pack .boltProjection.body.left.bolt -fill x
    labelframe .boltProjection.body.left.target -text "Flange target" -padx 8 -pady 6 -bd 2 -relief groove
    grid columnconfigure .boltProjection.body.left.target 1 -weight 1
    frame .boltProjection.body.left.target.mode
    radiobutton .boltProjection.body.left.target.mode.component -text "Component" -variable ::BoltProjectionPreview::targetMode -value component -command ::BoltProjectionPreview::set_target_mode
    radiobutton .boltProjection.body.left.target.mode.plane -text "Defined plane" -variable ::BoltProjectionPreview::targetMode -value plane -command ::BoltProjectionPreview::set_target_mode
    pack .boltProjection.body.left.target.mode.component .boltProjection.body.left.target.mode.plane -side left -padx {0 12}
    grid .boltProjection.body.left.target.mode -row 0 -column 0 -columnspan 2 -sticky w -pady {0 5}
    button .boltProjection.body.left.target.component.select -text "Select component..." -command ::BoltProjectionPreview::select_target_component -width 19
    label .boltProjection.body.left.target.component.name -text "No component selected" -anchor w
    grid .boltProjection.body.left.target.component.select -row 1 -column 0 -sticky ew -padx {0 8} -pady 3
    grid .boltProjection.body.left.target.component.name -row 1 -column 1 -sticky ew -pady 3
    button .boltProjection.body.left.target.plane.select -text "Define plane (3 nodes)..." -command ::BoltProjectionPreview::select_plane_nodes -width 19
    label .boltProjection.body.left.target.nodes -text "No plane defined" -anchor w
    grid .boltProjection.body.left.target.plane.select -row 2 -column 0 -sticky ew -padx {0 8} -pady 3
    grid .boltProjection.body.left.target.nodes -row 2 -column 1 -sticky ew -pady 3
    pack .boltProjection.body.left.target -fill x -pady {8 0}
    labelframe .boltProjection.body.left.projection -text "Projection" -padx 8 -pady 6 -bd 2 -relief groove
    grid columnconfigure .boltProjection.body.left.projection 1 -weight 1
    label .boltProjection.body.left.projection.angleLabel -text "Angle from bolt face" -anchor w
    entry .boltProjection.body.left.projection.angle -textvariable ::BoltProjectionPreview::angle -width 9 -justify right
    label .boltProjection.body.left.projection.angleUnit -text "deg  (90 = normal to flange)" -anchor w
    grid .boltProjection.body.left.projection.angleLabel -row 0 -column 0 -sticky w -padx {0 8} -pady 3
    grid .boltProjection.body.left.projection.angle -row 0 -column 1 -sticky w -pady 3
    grid .boltProjection.body.left.projection.angleUnit -row 0 -column 2 -sticky w -padx {8 0} -pady 3
    pack .boltProjection.body.left.projection -fill x -pady {8 0}
    frame .boltProjection.body.left.actions
    button .boltProjection.body.left.actions.create -text "Create rings" -command {if {[catch {::BoltProjectionPreview::draw} e]} {set ::BoltProjectionPreview::status $e}}
    button .boltProjection.body.left.actions.reset -text "Reset inputs" -command ::BoltProjectionPreview::reset_inputs
    pack .boltProjection.body.left.actions.create .boltProjection.body.left.actions.reset -side left -padx {0 6} -pady 8
    pack .boltProjection.body.left.actions -anchor e -fill x
    frame .boltProjection.body.output -padx 10 -pady 8 -bd 1 -relief groove
    pack .boltProjection.body.output -side right -fill both -expand 1 -padx {12 0}
    label .boltProjection.body.output.heading -text "Created rings remain in the model" -anchor w -font {Arial 11 bold}
    pack .boltProjection.body.output.heading -fill x
    ttk::treeview .boltProjection.body.output.tree -columns {ring center radius} -show headings -height 10
    foreach spec {{ring Ring 75} {center {Center X, Y, Z} 190} {radius Radius 70}} {
        lassign $spec column title width
        .boltProjection.body.output.tree heading $column -text $title
        .boltProjection.body.output.tree column $column -width $width -minwidth [expr {$width-10}] -stretch [expr {$column eq "center"}] -anchor w
    }
    pack .boltProjection.body.output.tree -fill both -expand 1 -pady {7 0}
    label .boltProjection.body.output.note -text "Lines remain in the model after closing this tool." -anchor w
    pack .boltProjection.body.output.note -fill x -pady {7 0}
    frame .boltProjection.footer -padx 12 -pady {0 9}
    label .boltProjection.footer.status -textvariable ::BoltProjectionPreview::status -anchor w -width 64
    button .boltProjection.footer.close -text "Close" -command ::BoltProjectionPreview::close
    pack .boltProjection.footer.status -side left -fill x -expand 1
    pack .boltProjection.footer.close -side right -padx {10 0}
    pack .boltProjection.footer -fill x
    set_target_mode
    wm protocol .boltProjection WM_DELETE_WINDOW ::BoltProjectionPreview::close
    update idletasks
    set width [winfo reqwidth .boltProjection]
    set height [winfo reqheight .boltProjection]
    set x [expr {max(0,([winfo screenwidth .boltProjection]-$width)/2)}]
    set y [expr {max(0,([winfo screenheight .boltProjection]-$height)/2)}]
    wm geometry .boltProjection +$x+$y
    wm deiconify .boltProjection
}

::BoltProjectionPreview::clear_old_previews
::BoltProjectionPreview::show
