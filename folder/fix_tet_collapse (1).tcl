if {[info exists ::TetCollapseFix::busy] && $::TetCollapseFix::busy} {error "Cannot reload while Apply is running."}
namespace eval ::TetCollapseFix {
    variable root [file dirname [file normalize [info script]]]
    variable ids {}; variable threshold 0.1; variable layers 2
    variable busy 0; variable recoveryRequired 0
    variable status "Select elements, then Proceed."
    variable result "Not checked"; variable checked {}
    variable topmost 1; variable qualityValue "--"
    variable replaced {}
    variable input {}; variable logText {}; variable report {}
}
proc ::TetCollapseFix::log {s} {
    variable logText
    append logText "[clock format [clock seconds] -format %H:%M:%S]  $s\n"
    puts "TCF: $s"
    if {[llength [info commands winfo]] && [winfo exists .tcf.log]} {
        .tcf.log configure -state normal
        .tcf.log delete 1.0 end; .tcf.log insert end $logText
        .tcf.log configure -state disabled; .tcf.log see end
        update idletasks
    }
    if {[llength [info commands winfo]] && [winfo exists .tcf]} {
        set ::TetCollapseFix::status $s
        update idletasks
    }
}
proc ::TetCollapseFix::version {} {
    set v [hm_info -appinfo VERSION]
    if {![string match "22.*" $v]} {error "This prototype requires HyperMesh 2022 (found $v)."}
}
proc ::TetCollapseFix::elements {ids} {
    if {![llength $ids]} {return {}}
    *createmark elems 1 {*}$ids
    if {![llength [hm_getmark elems 1]]} {return {}}
    set actual [hm_getvalue elems mark=1 dataname=id]
    set out {}
    foreach id $actual c [hm_getvalue elems mark=1 dataname=config] p [hm_getvalue elems mark=1 dataname=propertyid] n [hm_getvalue elems mark=1 dataname=nodes] {
        dict set out $id [list $c $p $n]
    }
    return $out
}
proc ::TetCollapseFix::component {cid} {
    *createmark elems 1 "by collector id" $cid
    return [elements [hm_getmark elems 1]]
}
proc ::TetCollapseFix::quality {ids} {
    variable threshold
    if {![llength $ids]} {return {}}
    *createmark elems 1 {*}$ids
    return [hm_getelemcheckvalues 1 3 tetracollapse]
}
proc ::TetCollapseFix::failed {values} {
    variable threshold
    set out {}
    foreach {id value} $values {if {$value < $threshold} {lappend out $id}}
    return $out
}
proc ::TetCollapseFix::coords {ids} {
    *createmark nodes 1 {*}$ids
    set actual [hm_getvalue nodes mark=1 dataname=id]
    if {[llength $actual] != [llength $ids]} {error "An original node was deleted."}
    set out {}
    foreach id $actual x [hm_getvalue nodes mark=1 dataname=x] y [hm_getvalue nodes mark=1 dataname=y] z [hm_getvalue nodes mark=1 dataname=z] {dict set out $id [list $x $y $z]}
    return $out
}
proc ::TetCollapseFix::nodes {elems} {
    set out {}
    dict for {id row} $elems {foreach n [lindex $row 2] {dict set out $n 1}}
    return [dict keys $out]
}
proc ::TetCollapseFix::boundary {elems} {
    set faces {}
    dict for {id row} $elems {
        lassign $row cfg pid ns
        if {$cfg == 210} {set patterns {{0 1 2 4 5 6} {0 1 3 4 8 7} {0 2 3 6 9 7} {1 2 3 5 9 8}}} else {set patterns {{0 1 2} {0 1 3} {0 2 3} {1 2 3}}}
        foreach pattern $patterns {
            set face {}; foreach i $pattern {lappend face [lindex $ns $i]}
            set key [lsort -integer [lrange $face 0 2]]
            dict lappend faces $key [lsort -integer $face]
        }
    }
    set out {}
    dict for {key f} $faces {
        if {[llength $f]>2} {error "Non-manifold tetra face: $key"}
        if {[llength $f]==1} {dict set out $key [lindex $f 0]}
    }
    return $out
}
proc ::TetCollapseFix::sameDict {a b} {
    if {[dict size $a] != [dict size $b]} {return 0}
    dict for {k v} $a {if {![dict exists $b $k] || [dict get $b $k] ne $v} {return 0}}
    return 1
}
proc ::TetCollapseFix::subset {all ids} {
    set out {}; foreach id $ids {dict set out $id [dict get $all $id]}; return $out
}
proc ::TetCollapseFix::volume {elems xyz} {
    set total 0.0
    dict for {id row} $elems {
        set ns [lindex $row 2]
        lassign [dict get $xyz [lindex $ns 0]] ax ay az
        lassign [dict get $xyz [lindex $ns 1]] bx by bz
        lassign [dict get $xyz [lindex $ns 2]] cx cy cz
        lassign [dict get $xyz [lindex $ns 3]] dx dy dz
        set bx [expr {$bx-$ax}]; set by [expr {$by-$ay}]; set bz [expr {$bz-$az}]
        set cx [expr {$cx-$ax}]; set cy [expr {$cy-$ay}]; set cz [expr {$cz-$az}]
        set dx [expr {$dx-$ax}]; set dy [expr {$dy-$ay}]; set dz [expr {$dz-$az}]
        set v [expr {($bx*($cy*$dz-$cz*$dy)-$by*($cx*$dz-$cz*$dx)+$bz*($cx*$dy-$cy*$dx))/6.0}]
        if {$v<=0} {error "Non-positive corner volume at $id"}
        set total [expr {$total+$v}]
    }
    return $total
}
proc ::TetCollapseFix::plan {selection} {
    variable layers
    version
    if {![llength $selection]} {error "Select at least one element."}
    set selected [elements $selection]
    if {[dict size $selected] != [llength $selection]} {error "Selection contains missing element IDs. Select again."}
    dict for {id row} $selected {if {[lindex $row 0] ni {204 210}} {error "Element $id is not Tet4 / Tet10."}}
    set bad [failed [quality $selection]]
    if {![llength $bad]} {error "Selected elements already meet the collapse threshold."}
    set groups {}
    foreach id $bad {
        set cid [hm_getvalue elems id=$id dataname=collector.id]
        lassign [dict get $selected $id] cfg pid ns
        dict lappend groups [list $cid $cfg $pid] $id
    }
    set plans {}
    dict for {key seeds} $groups {
        lassign $key cid cfg pid
        set all [component $cid]; set eligible {}; set adjacency {}
        dict for {id row} $all {
            lassign $row c p ns
            if {$c in {204 210} && $c != $cfg} {error "Component $cid mixes Tet4 and Tet10; this prototype blocks mixed order."}
            if {$c == $cfg && $p == $pid} {
                dict set eligible $id $row
                foreach n [lrange $ns 0 3] {dict lappend adjacency $n $id}
            }
        }
        # Merge overlapping seed neighborhoods into one local transaction per group.
        set patch {}; foreach id $seeds {dict set patch $id 1}
        set frontier $seeds
        for {set k 0} {$k<$layers} {incr k} {
            set next {}
            foreach id $frontier {
                foreach n [lrange [lindex [dict get $eligible $id] 2] 0 3] {
                    foreach e [dict get $adjacency $n] {if {![dict exists $patch $e]} {dict set patch $e 1; lappend next $e}}
                }
            }
            set frontier $next
        }
        if {[dict size $patch]>5000} {error "Patch exceeds 5000 elements. Select fewer elements or fewer layers."}
        set part [subset $eligible [dict keys $patch]]
        boundary $part
        lappend plans [list $cid $cfg $pid [dict keys $patch]]
    }
    return $plans
}
proc ::TetCollapseFix::guardReferences {patch} {
    *createmark elems 1 {*}$patch
    # Include region references and all active-template data/attribute references.
    set types [hm_getcrossreferencedentitiesmark elems 1 7 2 0 0 0]
    foreach type $types {
        if {$type ni {comps components collectors}} {
            set references [hm_getmark $type 2]
            if {[llength $references]} {error "Patch is referenced by $type ([lrange $references 0 9]). Element replacement is blocked."}
        }
    }
}
proc ::TetCollapseFix::runPatch {p} {
    variable threshold
    lassign $p cid cfg pid patch
    set before [component $cid]; set old [subset $before $patch]
    guardReferences $patch
    set nodeids [nodes $old]; set xyz [coords $nodeids]; set faces [boundary $old]
    set oldVolume [volume $old $xyz]
    # Monitor all neighboring elements, including elements in other components.
    *createmark nodes 1 {*}$nodeids
    set refs [hm_getcrossreferencedentitiesmark nodes 1 7 2 0 0 0]
    set external {}
    foreach type $refs {
        if {$type in {elems elements}} {set external [elements [hm_getmark $type 2]]}
    }
    foreach id $patch {if {[dict exists $external $id]} {dict unset external $id}}
    set badBefore [llength [failed [quality $patch]]]
    *elementorder [expr {$cfg==210 ? 2 : 1}]
    *currentcollector components [hm_getvalue comps id=$cid dataname=name]
    *createmark elems 1 {*}$patch
    *clearmark elems 2
    *createstringarray 2 "tet: 1280 1.2 2 0 0.8 0 0" "pars: fix_comp_bdr=1 fix_top_bdr=0 shell_swap=0 shell_remesh=0 use_optimizer=1 skip_aflr3=1 niter=10 upd_shell=0 shell_dev=0.0,0.0 tet_clps='$threshold,[expr {min(1.0,max(0.15,$threshold+0.05))}],[expr {min(1.0,max(0.3,$threshold+0.2))}],1'"
    *tetmesh elems 1 6 elems 2 1 1 2
    set after [component $cid]; set new {}
    dict for {id row} $after {if {![dict exists $before $id]} {dict set new $id $row}}
    if {![dict size $new]} {error "Remesher did not create replacement elements."}
    dict for {id row} $before {
        if {$id in $patch} {
            if {[dict exists $after $id]} {dict set new $id [dict get $after $id]}
        } elseif {![dict exists $after $id] || [dict get $after $id] ne $row} {error "An element outside the patch changed: $id"}
    }
    dict for {id row} $new {if {[lindex $row 0] != $cfg || [lindex $row 1] != $pid} {error "Replacement order/property mismatch: $id"}}
    if {![sameDict $faces [boundary $new]]} {error "Boundary connectivity changed."}
    if {![sameDict $xyz [coords $nodeids]]} {error "Original node coordinates changed."}
    set newVolume [volume $new [coords [nodes $new]]]
    if {abs($oldVolume-$newVolume)>1e-8*abs($oldVolume)} {error "Total corner volume changed."}
    if {[dict size $external] && ![sameDict $external [elements [dict keys $external]]]} {error "Neighbor connectivity changed."}
    set bad [failed [quality [dict keys $new]]]
    if {[llength $bad] >= $badBefore} {error "No reduction in failed elements ($badBefore -> [llength $bad])."}
    # Check corners/midpoints and high-order integration points, then restore mode.
    *createmark elems 1 {*}[dict keys $new]
    set jm [hm_getelementcheckmethod jacobian_3d]
    set jr [catch {
        foreach mode {2 3} {
            *jacobian_calculate_cornerpts $mode
            foreach {id value} [hm_getelemcheckvalues 1 3 jacobian] {if {$value<=0} {error "Non-positive Jacobian at $id (mode $mode)"}}
        }
    } je]
    *jacobian_calculate_cornerpts $jm
    if {$jr} {error $je}
    log "Fixed [expr {$badBefore-[llength $bad]}] failed elements. Boundary and shared nodes unchanged."
    set updated {}
    foreach id $::TetCollapseFix::checked {if {$id ni $patch} {lappend updated $id}}
    set ::TetCollapseFix::checked [lsort -integer -unique [concat $updated [dict keys $new]]]
    return $bad
}

proc ::TetCollapseFix::remeshCore {selection} {
    variable recoveryRequired
    if {$recoveryRequired} {error "Recovery required"}
    set plans [plan $selection]
    foreach p $plans {guardReferences [lindex $p 3]}
    set saved {}; set xyz {}
    foreach p $plans {
        set cid [lindex $p 0]
        dict set saved $cid [component $cid]
        set part [subset [dict get $saved $cid] [lindex $p 3]]
        set xyz [dict merge $xyz [coords [nodes $part]]]
    }
    set oldOrder [hm_getoption element_order]
    set oldComp [hm_info currentcollector component]
    set oldName {}; if {$oldComp>0} {set oldName [hm_getvalue comps id=$oldComp dataname=name]}
    log "Processing [llength $selection] selected elements..."
    # HyperMesh's native reject/history mechanism; no backup file or model reload.
    *startnotehistorystate {Fix Tet Collapse}
    set rc [catch {
        set remaining {}
        foreach p $plans {lappend remaining {*}[runPatch $p]}
    } err]
    set erc [catch {*endnotehistorystate {Fix Tet Collapse}} eerr]
    if {$erc && !$rc} {set rc 1; set err $eerr}
    if {$rc} {
        set changed 0
        dict for {cid original} $saved {
            if {![sameDict $original [component $cid]]} {set changed 1}
        }
        if {[catch {coords [dict keys $xyz]} now] || ![sameDict $xyz $now]} {set changed 1}
        if {$changed} {
            set urc [catch {*undohistorystate 1} uerr]
            set restored [expr {!$urc}]
            dict for {cid original} $saved {
                if {![sameDict $original [component $cid]]} {set restored 0}
            }
            if {[catch {coords [dict keys $xyz]} now] || ![sameDict $xyz $now]} {set restored 0}
            if {!$restored} {
                set recoveryRequired 1
                puts "TCF recovery: $err / $uerr"
                error "Recovery required: model may have changed"
            }
        }
        log "Repair did not pass. The attempted changes were reverted or unchanged."
    }
    *setoption element_order=$oldOrder
    if {$oldName ne {}} {*currentcollector components $oldName}
    if {$rc} {error $err}
    return $remaining
}

proc ::TetCollapseFix::nodeStar {n} {
    *createmark nodes 1 $n
    set types [hm_getcrossreferencedentitiesmark nodes 1 7 2 0 0 0]
    set es {}
    foreach t $types {
        set refs [hm_getmark $t 2]
        if {$t in {elems elements}} {set es $refs} elseif {$t ni {comps components collectors} && [llength $refs]} {return {}}
    }
    return [elements $es]
}
proc ::TetCollapseFix::containedNodes {nodeids star} {
    # Aggregate references are the union of individual-node references. Reject
    # the union when any moved node touches an outside element or other entity.
    *createmark nodes 1 {*}$nodeids
    set types [hm_getcrossreferencedentitiesmark nodes 1 7 2 0 0 0]
    set attached 0
    foreach type $types {
        set refs [hm_getmark $type 2]
        if {$type in {elems elements}} {
            foreach id $refs {
                if {![dict exists $star $id]} {return 0}
                set attached 1
            }
        } elseif {$type ni {comps components collectors} && [llength $refs]} {return 0}
    }
    return $attached
}
proc ::TetCollapseFix::qscore {elems xyz} {
    set worst 1.0
    dict for {id row} $elems {
        set one [dict create $id $row]
        if {[catch {volume $one $xyz} v]} {return -1}
        set ns [lindex $row 2]
        foreach pattern {{0 1 2} {0 1 3} {0 2 3} {1 2 3}} {
            lassign $pattern i j k
            lassign [dict get $xyz [lindex $ns $i]] ax ay az
            lassign [dict get $xyz [lindex $ns $j]] bx by bz
            lassign [dict get $xyz [lindex $ns $k]] cx cy cz
            set bx [expr {$bx-$ax}]; set by [expr {$by-$ay}]; set bz [expr {$bz-$az}]
            set cx [expr {$cx-$ax}]; set cy [expr {$cy-$ay}]; set cz [expr {$cz-$az}]
            set ux [expr {$by*$cz-$bz*$cy}]; set uy [expr {$bz*$cx-$bx*$cz}]; set uz [expr {$bx*$cy-$by*$cx}]
            set area [expr {0.5*sqrt($ux*$ux+$uy*$uy+$uz*$uz)}]
            if {$area<=0} {return -1}
            set q [expr {3.0*$v/pow($area,1.5)/1.24}]
            if {$q<$worst} {set worst $q}
        }
    }
    return $worst
}
proc ::TetCollapseFix::displaced {original weights delta} {
    set xyz $original
    dict for {n weight} $weights {
        set v {}; foreach a [dict get $original $n] d $delta {lappend v [expr {$a+$weight*$d}]}
        dict set xyz $n $v
    }
    return $xyz
}
proc ::TetCollapseFix::seedScore {star seed floors xyz} {
    set score -1
    dict for {id row} $star {
        set q [qscore [dict create $id $row] $xyz]
        if {$q<0} {return -1}
        if {$id==$seed} {set score $q} elseif {$q<[dict get $floors $id]-1e-9} {return -1}
    }
    return $score
}
proc ::TetCollapseFix::writeCoords {xyz} {
    dict for {n v} $xyz {lassign $v x y z; *nodemodify $n $x $y $z}
}
proc ::TetCollapseFix::repairInside {seed {extraLocked {}}} {
    variable threshold; variable recoveryRequired
    set selected [elements [list $seed]]
    if {[dict size $selected]!=1} {error "Selection contains missing IDs"}
    lassign [dict get $selected $seed] cfg pid ns
    if {$cfg ni {204 210}} {error "Element $seed is not Tet4 / Tet10."}
    if {![llength [failed [quality [list $seed]]]]} {return 1}
    set cid [hm_getvalue elems id=$seed dataname=collector.id]
    foreach corner [lrange $ns 0 3] {
        set star [nodeStar $corner]
        if {![dict size $star] || [dict size $star]>200} {continue}
        set valid 1; set weights [dict create $corner 1.0]
        dict for {id row} $star {
            lassign $row c p en
            if {$c!=$cfg || $p!=$pid || $corner ni [lrange $en 0 3]} {set valid 0; break}
            if {$cfg==210} {
                foreach pair {{0 1 4} {1 2 5} {2 0 6} {0 3 7} {1 3 8} {2 3 9}} {
                    lassign $pair a b mid
                    if {[lindex $en $a]==$corner || [lindex $en $b]==$corner} {dict set weights [lindex $en $mid] 0.5}
                }
            }
        }
        if {!$valid} {puts "INSIDE_SKIP corner=$corner reason=order_or_property"; continue}
        *createmark elems 1 {*}[dict keys $star]
        if {[lsort -integer -unique [hm_getvalue elems mark=1 dataname=collector.id]] ne [list $cid]} {continue}
        set faces [boundary $star]; set locked {}
        foreach n $extraLocked {dict set locked $n 1}
        dict for {key face} $faces {foreach n $face {dict set locked $n 1}}
        dict for {n w} $weights {
            if {[dict exists $locked $n]} {set valid 0; break}
        }
        if {$valid && ![containedNodes [dict keys $weights] $star]} {set valid 0}
        if {!$valid} {puts "INSIDE_SKIP corner=$corner reason=boundary_or_reference"; continue}
        set original [coords [nodes $star]]; set best [qscore $star $original]
        set delta {0 0 0}; set step 0
        set origin [dict get $original $corner]
        foreach n [lrange $ns 0 3] {
            set d2 0; foreach a $origin b [dict get $original $n] {set d2 [expr {$d2+($a-$b)*($a-$b)}]}
            set step [expr {max($step,sqrt($d2)*0.02)}]
        }
        set directions {}
        foreach x {-1 0 1} {foreach y {-1 0 1} {foreach z {-1 0 1} {
            if {$x || $y || $z} {lappend directions [list $x $y $z]}
        }}}
        for {set iter 0} {$iter<60 && $step>1e-6} {incr iter} {
            set found 0; set chosen $delta
            foreach dir $directions {
                set candidate {}; foreach d $delta a $dir {lappend candidate [expr {$d+$step*$a}]}
                set score [qscore $star [displaced $original $weights $candidate]]
                if {$score>$best+1e-8} {set best $score; set chosen $candidate; set found 1}
            }
            set delta $chosen
            if {!$found} {set step [expr {$step*0.5}]}
            if {$best>$threshold+0.01} {break}
        }
        puts "INSIDE_SEARCH corner=$corner best=$best delta=$delta"
        set seedFallback 0
        if {$best<$threshold+1e-5} {
            # Preserve the whole-star improvement first. If it cannot reach the
            # threshold, target the selected tetrahedron without reducing any
            # already-failing neighbor or moving a protected node.
            set seedFallback 1; set floors {}
            dict for {id row} $star {
                dict set floors $id [expr {min($threshold+0.0001,[qscore [dict create $id $row] $original])}]
            }
            set delta {0 0 0}
            set best [seedScore $star $seed $floors $original]
            set step 0
            foreach n [lrange $ns 0 3] {
                set d2 0; foreach a $origin b [dict get $original $n] {set d2 [expr {$d2+($a-$b)*($a-$b)}]}
                set step [expr {max($step,sqrt($d2)*0.02)}]
            }
            for {set iter 0} {$iter<60 && $step>1e-6} {incr iter} {
                set found 0; set chosen $delta
                foreach dir $directions {
                    set candidate {}; foreach d $delta a $dir {lappend candidate [expr {$d+$step*$a}]}
                    set score [seedScore $star $seed $floors [displaced $original $weights $candidate]]
                    if {$score>$best+1e-8} {set best $score; set chosen $candidate; set found 1}
                }
                set delta $chosen
                if {!$found} {set step [expr {$step*0.5}]}
                if {$best>$threshold+0.01} {break}
            }
            puts "INSIDE_SEED_SEARCH seed=$seed corner=$corner best=$best delta=$delta"
            if {$best<$threshold+1e-5} {continue}
        }
        set trial [displaced $original $weights $delta]
        set moved [subset $trial [dict keys $weights]]
        set oldMoved [subset $original [dict keys $weights]]
        set beforeQuality [quality [dict keys $star]]
        set beforeBad [failed $beforeQuality]
        set jm [hm_getelementcheckmethod jacobian_3d]
        set rc [catch {
            ::Tangent::moveWeighted $weights $delta
            set now [coords [dict keys $original]]
            set scale 1.0
            dict for {n point} $original {
                set scale [expr {max($scale,[::Tangent::norm [::Tangent::sub $point $origin]])}]
            }
            dict for {n point} $moved {
                # HM2022 coordinate readback rounds to approximately14 significant digits.
                set tolerance [expr {max(1e-12*$scale,1e-13*max(1.0,[::Tangent::norm $point]))}]
                if {[::Tangent::norm [::Tangent::sub [dict get $now $n] $point]]>$tolerance} {
                    error "Actual internal displacement differs: node=$n actual=[dict get $now $n] expected=$point delta=$delta scale=$scale"
                }
            }
            dict for {n v} $original {if {![dict exists $weights $n] && [dict get $now $n] ne $v} {error "Protected node moved"}}
            if {![sameDict $star [elements [dict keys $star]]]} {error "Connectivity changed"}
            set av [volume $star $now]; set bv [volume $star $original]
            if {abs($av-$bv)>1e-8*abs($bv)} {error "Volume changed"}
            if {[llength [failed [quality [list $seed]]]]} {error "Seed still failed"}
            set nowQuality [quality [dict keys $star]]
            foreach id [failed $nowQuality] {if {$id ni $beforeBad} {error "New failed neighbor"}}
            if {$seedFallback} {
                foreach id $beforeBad {
                    if {$id!=$seed && [dict get $nowQuality $id]<[dict get $beforeQuality $id]-1e-8} {error "Existing failed neighbor worsened"}
                }
            }
            *createmark elems 1 {*}[dict keys $star]
            foreach mode {2 3} {
                *jacobian_calculate_cornerpts $mode
                foreach {id q} [hm_getelemcheckvalues 1 3 jacobian] {if {$q<=0} {error "Invalid high order Jacobian"}}
            }
        } err]
        *jacobian_calculate_cornerpts $jm
        if {$rc} {
            if {[catch {writeCoords $oldMoved} re] || ![sameDict $original [coords [dict keys $original]]]} {
                set recoveryRequired 1; error "Recovery required: node restore failed"
            }
            puts "TCF inside trial rejected: $err"
            continue
        }
        set q [lindex [quality [list $seed]] 1]
        log "Element $seed: collapse [format %.4f [dict get $beforeQuality $seed]] -> [format %.4f $q]. Boundary and shared nodes unchanged."
        set ::TetCollapseFix::insideAffectedIds [dict keys $star]
        puts "INSIDE_SUCCESS seed=$seed corner=$corner moved=[dict size $weights] star=[dict size $star] delta=$delta quality=$q"
        return 1
    }
    return 0
}

proc ::TetCollapseFix::restoreCavity {star xyz types solver newIDs newNodes cid} {
    *currentcollector components [hm_getvalue comps id=$cid dataname=name]
    *createmark nodes 1 {*}[dict keys $xyz]
    set present [hm_getmark nodes 1]
    # Restore missing original nodes while replacements still hold boundary nodes.
    dict for {id point} $xyz {
        if {$id in $present} {continue}
        lassign $point x y z
        *createnode $x $y $z 0 0 0
        set fresh [hm_latestentityid nodes]
        *createmark nodes 1 $fresh
        *renumber nodes 1 $id 1 0 0
        if {[dict exists $solver nodes $id]} {
            *createmark nodes 1 $id
            *renumbersolverid nodes 1 [lindex [dict get $solver nodes $id] 0] 1 0 0 0 0 0.0
        }
    }
    # Read back recreated originals and keep them on the node mark while
    # rebuilding connectivity. Native creation must see every restored node.
    if {![sameDict $xyz [coords [dict keys $xyz]]]} {error "Recreated original coordinates mismatch"}
    set existing [elements [dict keys $star]]
    dict for {id row} $star {
        if {[dict exists $existing $id]} {continue}
        lassign $row cfg pid ns
        *createlist nodes 1 {*}$ns
        *createelement $cfg [dict get $types $id] 1 0
        set fresh [hm_latestentityid elems]
        *createmark elems 1 $fresh
        *renumber elems 1 $id 1 0 0
        *setvalue elems id=$id propertyid=$pid
        if {[dict exists $solver elems $id]} {
            *createmark elems 1 $id
            *renumbersolverid elems 1 [lindex [dict get $solver elems $id] 0] 1 0 0 0 0 0.0
        }
    }
    if {[llength $newIDs]} {*createmark elems 1 {*}$newIDs; *deletemark elems 1}
    if {[llength $newNodes]} {
        *clearlist nodes 1
        *createmark nodes 1 {*}$newNodes
        *nodemarkcleartempmark 1
        *createmark nodes 1 {*}$newNodes
        if {[llength [hm_getmark nodes 1]]} {error "Unused trial node remains"}
    }
    if {![sameDict $star [elements [dict keys $star]]] || ![sameDict $xyz [coords [dict keys $xyz]]]} {error "Cavity restore mismatch"}
    dict for {kind entries} $solver {
        dict for {id pair} $entries {if {[hm_getsolverid $kind $id -byid] ne $pair} {error "Solver ID restore mismatch"}}
    }
}

proc ::TetCollapseFix::collapseCavity {seed} {
    variable threshold; variable checked; variable recoveryRequired
    set selected [elements [list $seed]]
    if {![dict size $selected]} {return 0}
    lassign [dict get $selected $seed] cfg pid ns
    set cid [hm_getvalue elems id=$seed dataname=collector.id]
    foreach center [lrange $ns 0 3] {
        set star [nodeStar $center]
        if {![dict size $star] || [dict size $star]>100} {continue}
        set valid 1; set linear {}; set corners {}; set orphanCandidates [list $center]
        dict for {id row} $star {
            lassign $row c p en
            if {$c!=$cfg || $p!=$pid || $center ni [lrange $en 0 3]} {set valid 0; break}
            dict set linear $id [list 204 $pid [lrange $en 0 3]]
            foreach n [lrange $en 0 3] {dict set corners $n 1}
            if {$cfg==210} {
                foreach pair {{0 1 4} {1 2 5} {2 0 6} {0 3 7} {1 3 8} {2 3 9}} {
                    lassign $pair a b mid
                    if {[lindex $en $a]==$center || [lindex $en $b]==$center} {lappend orphanCandidates [lindex $en $mid]}
                }
            }
        }
        if {!$valid} {continue}
        *createmark elems 1 {*}[dict keys $star]
        if {[lsort -integer -unique [hm_getvalue elems mark=1 dataname=collector.id]] ne [list $cid]} {continue}
        set shell [boundary $linear]; set locked {}
        dict for {k face} $shell {foreach n $face {dict set locked $n 1}}
        if {[dict exists $locked $center]} {continue}
        # Every node that could become unused must have no external attachment.
        foreach n [lsort -integer -unique $orphanCandidates] {
            set attached [nodeStar $n]
            if {![dict size $attached]} {set valid 0; break}
            foreach id [dict keys $attached] {if {![dict exists $star $id]} {set valid 0}}
        }
        if {!$valid || [catch {guardReferences [dict keys $star]}]} {continue}
        set xyz [coords [nodes $star]]
        set originalVolume [volume $linear $xyz]
        set best {}; set bestScore $threshold; set receiver 0
        foreach target [lsort -integer [dict keys $corners]] {
            if {$target==$center} {continue}
            set trial {}; set index 0; set duplicate {}; set valid 1
            dict for {id row} $linear {
                set en {}; foreach n [lindex $row 2] {lappend en [expr {$n==$center ? $target : $n}]}
                if {[llength [lsort -integer -unique $en]]<4} {continue}
                set key [lsort -integer $en]
                if {[dict exists $duplicate $key]} {set valid 0; break}
                dict set duplicate $key 1
                dict set trial [incr index] [list 204 $pid $en]
            }
            if {!$valid || ![dict size $trial]} {continue}
            if {[catch {volume $trial $xyz} v] || abs($v-$originalVolume)>1e-8*abs($originalVolume)} {continue}
            if {[catch {boundary $trial} faces] || ![sameDict $shell $faces]} {continue}
            set score [qscore $trial $xyz]
            if {$score>$bestScore+1e-5} {set bestScore $score; set best $trial; set receiver $target}
        }
        if {![dict size $best]} {continue}
        set before [component $cid]; set allxyz $xyz
        set fullBoundary [boundary $star]
        set elementType [hm_getvalue elems id=$seed dataname=type]
        set edgeNodes {}
        if {$cfg==210} {
            dict for {id row} $before {
                if {[lindex $row 0]!=210} {continue}
                set en [lindex $row 2]
                foreach pair {{0 1 4} {1 2 5} {2 0 6} {0 3 7} {1 3 8} {2 3 9}} {
                    lassign $pair a b mid
                    set key [lsort -integer [list [lindex $en $a] [lindex $en $b]]]
                    dict set edgeNodes $key [lindex $en $mid]
                }
            }
        }
        *createmark nodes 1 {*}[dict keys $xyz]
        set types [hm_getcrossreferencedentitiesmark nodes 1 7 2 0 0 0]
        set external {}
        foreach t $types {if {$t in {elems elements}} {set external [elements [hm_getmark $t 2]]}}
        foreach id [dict keys $star] {if {[dict exists $external $id]} {dict unset external $id}}
        set oldComp [hm_info currentcollector component]
        set oldName {}; if {$oldComp>0} {set oldName [hm_getvalue comps id=$oldComp dataname=name]}
        *currentcollector components [hm_getvalue comps id=$cid dataname=name]
        set newIDs {}; set newNodes {}; set oldTypes {}; set oldSolver {}
        foreach id [dict keys $star] {
            dict set oldTypes $id [hm_getvalue elems id=$id dataname=type]
            if {![catch {hm_getsolverid elems $id -byid} pair]} {dict set oldSolver elems $id $pair}
        }
        foreach id [dict keys $xyz] {
            if {![catch {hm_getsolverid nodes $id -byid} pair]} {dict set oldSolver nodes $id $pair}
        }
        set jm [hm_getelementcheckmethod jacobian_3d]
        *sethistoryrecord 1
        if {[hm_gethistorylimit]==0} {*sethistorylimit 20}
        *startnotehistorystate {Tet cavity collapse}
        set rc [catch {
            dict for {id row} $best {
                set en [lindex $row 2]
                if {$cfg==210} {
                    foreach pair {{0 1} {1 2} {2 0} {0 3} {1 3} {2 3}} {
                        lassign $pair a b
                        set key [lsort -integer [list [lindex $en $a] [lindex $en $b]]]
                        if {![dict exists $edgeNodes $key]} {
                            lassign $key n1 n2
                            if {![dict exists $allxyz $n1]} {set allxyz [dict merge $allxyz [coords [list $n1]]]}
                            if {![dict exists $allxyz $n2]} {set allxyz [dict merge $allxyz [coords [list $n2]]]}
                            set mid {}; foreach a [dict get $allxyz $n1] b [dict get $allxyz $n2] {lappend mid [expr {($a+$b)*0.5}]}
                            lassign $mid x y z
                            *createnode $x $y $z 0 0 0
                            set n [hm_latestentityid nodes]; lappend newNodes $n
                            dict set edgeNodes $key $n
                        }
                        lappend en [dict get $edgeNodes $key]
                    }
                }
                *createlist nodes 1 {*}$en
                *createelement $cfg $elementType 1 0
                set eid [hm_latestentityid elems]; lappend newIDs $eid
                *setvalue elems id=$eid propertyid=$pid
            }
            set new [elements $newIDs]
            if {[dict size $new] != [dict size $best]} {error "Replacement count mismatch"}
            dict for {id row} $new {if {[lindex $row 0]!=$cfg || [lindex $row 1]!=$pid} {error "Replacement type/property mismatch"}}
            if {![sameDict $fullBoundary [boundary $new]]} {error "Cavity boundary changed"}
            if {![sameDict $xyz [coords [dict keys $xyz]]]} {error "Original coordinates changed"}
            set v [volume $new [coords [nodes $new]]]
            if {abs($v-$originalVolume)>1e-8*abs($originalVolume)} {error "Cavity volume changed"}
            if {[llength [failed [quality $newIDs]]]} {error "New collapse failure"}
            *createmark elems 1 {*}$newIDs
            foreach mode {2 3} {
                *jacobian_calculate_cornerpts $mode
                foreach {id q} [hm_getelemcheckvalues 1 3 jacobian] {if {$q<=0} {error "Non-positive high order Jacobian"}}
            }
            *createmark elems 1 {*}[dict keys $star]
            *deletemark elems 1
            set after [component $cid]
            dict for {id row} $before {
                if {[dict exists $star $id]} {
                    if {[dict exists $after $id]} {error "Old cavity element remains"}
                } elseif {![dict exists $after $id] || [dict get $after $id] ne $row} {error "Outside cavity element changed"}
            }
            if {[dict size $after]!=[dict size $before]-[dict size $star]+[dict size $new]} {error "Unexpected component element count"}
            *createmark nodes 1 {*}[dict keys $xyz]
            set surviving [hm_getmark nodes 1]
            foreach n [dict keys $xyz] {
                if {$n ni $surviving && $n ni $orphanCandidates} {error "Protected original node deleted"}
            }
            if {![sameDict [subset $xyz $surviving] [coords $surviving]]} {error "Original node moved"}
            if {[dict size $external] && ![sameDict $external [elements [dict keys $external]]]} {error "External neighbor changed"}
        } err]
        *endnotehistorystate {Tet cavity collapse}
        *jacobian_calculate_cornerpts $jm
        if {$oldName ne {}} {*currentcollector components $oldName}
        if {$rc} {
            puts "TCF cavity rejected: $err"
            set urc [catch {restoreCavity $star $xyz $oldTypes $oldSolver $newIDs $newNodes $cid} uerr]
            if {$urc || ![sameDict $before [component $cid]] || ![sameDict $xyz [coords [dict keys $xyz]]]} {
                set recoveryRequired 1; error "Recovery required: cavity restore failed: $uerr"
            }
            continue
        }
        set updated {}; foreach id $checked {if {![dict exists $star $id]} {lappend updated $id}}
        set checked [lsort -integer -unique [concat $updated $newIDs]]
        foreach oldID [dict keys $star] {dict set ::TetCollapseFix::replaced $oldID $newIDs}
        puts "CAVITY_SUCCESS seed=$seed center=$center receiver=$receiver old=[dict size $star] new=[dict size $new] mids=[llength $newNodes] quality=[quality $newIDs]"
        log "Completed"
        return 1
    }
    return 0
}

proc ::TetCollapseFix::splitKey {ids w} {set key {};foreach id $ids v $w {if {$v>0} {lappend key [list $id $v]}};return [lsort -integer -index 0 $key]}
proc ::TetCollapseFix::splitPoint {en xyz w} {
 set coeff {};foreach l $w {lappend coeff [expr {$l*(2*$l-1)}]}
 foreach pair {{0 1} {1 2} {2 0} {0 3} {1 3} {2 3}} {lassign $pair a b;lappend coeff [expr {4*[lindex $w $a]*[lindex $w $b]}]}
 if {[llength $en]==4} {set coeff $w}
 set out {0 0 0}
 foreach n $en c $coeff {set v {};foreach a $out b [dict get $xyz $n] {lappend v [expr {$a+$b*$c}]};set out $v}
 return $out
}

proc ::TetCollapseFix::chooseSharedEdge {cfg pid ns xyz threshold} {
 set candidates {};set oldChoice {};set oldBest $threshold
 set pairs {{0 1 4} {1 2 5} {2 0 6} {0 3 7} {1 3 8} {2 3 9}}
 foreach pair $pairs {
  lassign $pair i j m;set a [lindex $ns $i];set b [lindex $ns $j]
  if {$cfg==210} {set point [dict get $xyz [lindex $ns $m]]} else {
   set point {};foreach u [dict get $xyz $a] v [dict get $xyz $b] {lappend point [expr {($u+$v)*.5}]}
  }
  dict set xyz -1 $point;set trial {};set k 0
  foreach end [list $a $b] {set en {};foreach n [lrange $ns 0 3] {lappend en [expr {$n==$end?-1:$n}]};dict set trial [incr k] [list 204 $pid $en]}
  set score [qscore $trial $xyz];set edge [lsort -integer [list $a $b]]
  if {$score>$threshold+1e-5} {lappend candidates [list $edge $score]}
  if {$score>$oldBest+1e-5} {set oldBest $score;set oldChoice $edge}
 }
 set cache {};set fallback {};set safe {};set safeScore -1
 foreach candidate $candidates {
  lassign $candidate edge seedScore;lassign $edge a b
  if {![dict exists $cache $a]} {dict set cache $a [nodeStar $a]}
  set star {};set valid 1
  dict for {id row} [dict get $cache $a] {if {$b in [lrange [lindex $row 2] 0 3]} {dict set star $id $row}}
  if {![dict size $star] || [dict size $star]>100} {continue}
  dict for {id row} $star {if {[lindex $row 0]!=$cfg} {set valid 0;break}}
  if {!$valid || [catch {guardReferences [dict keys $star]}]} {continue}
  if {$edge eq $oldChoice} {set fallback [list $edge $star]}
  set closed 1
  dict for {key face} [boundary $star] {if {$a in $face && $b in $face} {set closed 0;break}}
  if {!$closed} {continue}
  set starXYZ [coords [nodes $star]];set minimum 1.0
  dict for {id row} $star {
   lassign $row unused parentPid en
   set point {}
   foreach pair $pairs {
    lassign $pair i j m
    if {[lsort -integer [list [lindex $en $i] [lindex $en $j]]] ne $edge} {continue}
    if {$cfg==210} {set point [dict get $starXYZ [lindex $en $m]]} else {
     foreach u [dict get $starXYZ $a] v [dict get $starXYZ $b] {lappend point [expr {($u+$v)*.5}]}
    };break
   }
   if {![llength $point]} {set minimum -1;break}
   dict set starXYZ -1 $point;set trial {};set k 0
   foreach end [list $a $b] {set child {};foreach n [lrange $en 0 3] {lappend child [expr {$n==$end?-1:$n}]};dict set trial [incr k] [list 204 $parentPid $child]}
   set minimum [expr {min($minimum,[qscore $trial $starXYZ])}]
  }
  if {$minimum>$threshold+1e-5 && $minimum>$safeScore} {set safeScore $minimum;set safe [list $edge $star]}
 }
 if {[llength $safe]} {puts "SHARED_EDGE_WHOLE_STAR=[lindex $safe 0] $safeScore";return $safe}
 return $fallback
}

proc ::TetCollapseFix::sharedRefine {selection} {
 variable threshold;variable checked;variable recoveryRequired
 set allowedOriginalMotion {};set selectedEdges {};set parents {};set oldTypes {};set oldSolver {};set oldCid {};set saved {}
 foreach seed $selection {
  set data [elements [list $seed]];if {![dict size $data]} {continue}
  lassign [dict get $data $seed] cfg pid ns
  if {$cfg ni {204 210}} {continue}
  set xyz [coords $ns]
  lassign [chooseSharedEdge $cfg $pid $ns $xyz $threshold] chosen star
  if {![llength $chosen] || $chosen in $selectedEdges} {continue}
  lappend selectedEdges $chosen;set parents [dict merge $parents $star]
 }
 if {![llength $selectedEdges]} {return $selection}
 set originalXYZ [coords [nodes $parents]]
 dict for {id row} $parents {
  set cid [hm_getvalue elems id=$id dataname=collector.id];dict set oldCid $id $cid
  dict set oldTypes $id [hm_getvalue elems id=$id dataname=type]
  if {![catch {hm_getsolverid elems $id -byid} pair]} {dict set oldSolver elems $id $pair}
  if {![dict exists $saved $cid]} {dict set saved $cid [component $cid]}
 }
 foreach n [dict keys $originalXYZ] {if {![catch {hm_getsolverid nodes $n -byid} pair]} {dict set oldSolver nodes $n $pair}}
 set originalChecked $checked;set oldComp [hm_info currentcollector component];set oldName {}
 if {$oldComp>0} {set oldName [hm_getvalue comps id=$oldComp dataname=name]}
 set jm [hm_getelementcheckmethod jacobian_3d]
 set pairs {{0 1 4} {1 2 5} {2 0 6} {0 3 7} {1 3 8} {2 3 9}}
 set registry {};set newIDs {};set createdNodes {};set newByComp {};set childParent {};set refined {}
 set newCoordinates {};set plannedCoordinates {}
 set rc [catch {
foreach edge $selectedEdges {
 lassign $edge a b
 set attached [::TetCollapseFix::nodeStar $a];set star {}
 dict for {id row} $attached {if {$b in [lrange [lindex $row 2] 0 3]} {dict set star $id $row}}
 set xyz [::TetCollapseFix::coords [::TetCollapseFix::nodes $star]]
 dict for {id row} $star {
  lassign $row cfg pid en
  if {$cfg ni {204 210}} {error "Unsupported order"}
  
  set cid [hm_getvalue elems id=$id dataname=collector.id];set type [hm_getvalue elems id=$id dataname=type]
  set corners [lrange $en 0 3];set bary {{1 0 0 0} {0 1 0 0} {0 0 1 0} {0 0 0 1}}
  foreach n $corners w $bary {dict set registry [splitKey $corners $w] $n}
  if {$cfg==210} {foreach pair $pairs {
   lassign $pair i j m;set w {};foreach u [lindex $bary $i] v [lindex $bary $j] {lappend w [expr {($u+$v)*.5}]}
   dict set registry [splitKey $corners $w] [lindex $en $m]
  }
  }
  set ai [lsearch -exact $corners $a];set bi [lsearch -exact $corners $b]
  set mw {};foreach u [lindex $bary $ai] v [lindex $bary $bi] {lappend mw [expr {($u+$v)*.5}]}
  *currentcollector components [hm_getvalue comps id=$cid dataname=name]
  foreach replace [list $ai $bi] {
   set child $bary;lset child $replace $mw;set positions $child
   if {$cfg==210} {foreach pair $pairs {lassign $pair i j m;set w {};foreach u [lindex $child $i] v [lindex $child $j] {lappend w [expr {($u+$v)*.5}]};lappend positions $w}
   }
   set conn {}
   foreach w $positions {
    set key [splitKey $corners $w]
    if {![dict exists $registry $key]} {
     lassign [splitPoint $en $xyz $w] x y z;*createnode $x $y $z 0 0 0
     dict set registry $key [hm_latestentityid nodes];lappend createdNodes [dict get $registry $key]
     dict set newCoordinates [dict get $registry $key] [list $x $y $z]
    }
    set n [dict get $registry $key]
    set expected [splitPoint $en $xyz $w]
    if {[dict exists $xyz $n]} {set actual [dict get $xyz $n]} else {set actual [dict get $newCoordinates $n]}
    foreach u $expected v $actual {if {abs($u-$v)>1e-8} {error "Shared quadratic interpolation mismatch"}}
    dict set plannedCoordinates $n $expected
    lappend conn $n
   }
   set childXYZ [subset [dict merge $xyz $newCoordinates] $conn]
   foreach sample {{0.25 0.25 0.25 0.25} {0.1 0.2 0.3 0.4} {0.4 0.3 0.2 0.1}} {
    set parentWeights {0 0 0 0}
    foreach cornerWeights $child factor $sample {
     set next {};foreach u $parentWeights v $cornerWeights {lappend next [expr {$u+$factor*$v}]};set parentWeights $next
    }
    set expected [splitPoint $en $xyz $parentWeights];set actual [splitPoint $conn $childXYZ $sample]
    foreach u $expected v $actual {if {abs($u-$v)>1e-8} {error "Quadratic geometry reconstruction mismatch"}}
   }
   *createlist nodes 1 {*}$conn;*createelement $cfg $type 1 0
   set eid [hm_latestentityid elems];*setvalue elems id=$eid propertyid=$pid
   lappend newIDs $eid;dict lappend newByComp $cid $eid;dict set childParent $eid $id
  }
 }
 *createmark elems 1 {*}[dict keys $star];*deletemark elems 1
}
set newIDs [dict keys [::TetCollapseFix::elements $newIDs]]

  set children [elements $newIDs]
  set childCoordinates [coords [nodes $children]]
  dict for {n actual} $childCoordinates {
   foreach u [dict get $plannedCoordinates $n] v $actual {if {abs($u-$v)>1e-8} {error "Subdivision coordinate readback mismatch"}}
  }
  if {![sameDict [boundary $parents] [boundary $children]]} {error "Refined combined boundary changed"}
  set beforeVolume [volume $parents $originalXYZ];set afterVolume [volume $children $childCoordinates]
  if {abs($afterVolume-$beforeVolume)>1e-8*abs($beforeVolume)} {error "Refined combined volume changed"}
  if {![sameDict $originalXYZ [coords [dict keys $originalXYZ]]]} {error "Original shared coordinates changed"}
  foreach mode {2 3} {
   *jacobian_calculate_cornerpts $mode;*createmark elems 1 {*}$newIDs
   foreach {id value} [hm_getelemcheckvalues 1 3 jacobian] {if {$value<=0} {error "Invalid subdivision Jacobian"}}
  }
  dict for {cid before} $saved {dict set refined $cid [component $cid]}
  set checked [lsort -integer -unique [concat $checked $newIDs]]
  set bad [failed [quality $newIDs]]
  if {[llength $bad]} {
   set snapshotNodes {}
   foreach plan [plan $bad] {
    set cid [lindex $plan 0]
    foreach id [lindex $plan 3] {
     if {[dict exists $saved $cid $id] && ![dict exists $parents $id]} {
      set row [dict get $saved $cid $id];dict set parents $id $row;dict set oldCid $id $cid
      dict set oldTypes $id [hm_getvalue elems id=$id dataname=type]
      if {![catch {hm_getsolverid elems $id -byid} pair]} {dict set oldSolver elems $id $pair}
      foreach n [lindex $row 2] {
       if {![dict exists $originalXYZ $n]} {dict set snapshotNodes $n 1}
      }
     }
    }
   }
   if {[dict size $snapshotNodes]} {set originalXYZ [dict merge $originalXYZ [coords [dict keys $snapshotNodes]]]}
   foreach n [dict keys $originalXYZ] {
    if {![dict exists $oldSolver nodes $n] && ![catch {hm_getsolverid nodes $n -byid} pair]} {dict set oldSolver nodes $n $pair}
   }
   remeshCore $bad
   set residual [failed [quality [dict keys [elements $checked]]]]
   puts "SHARED_RESIDUAL_QUALITY=[quality $residual]"
   foreach id $residual {
    if {![dict exists [elements [list $id]] $id]} {continue}
    # Lock every original region boundary, including Tet10 face midnodes.
    # Original interior nodes may move only within this witnessed region.
    set protectedInterior {};set originalRegions {}
    dict for {parent row} $parents {dict set originalRegions [dict get $oldCid $parent] $parent $row}
    dict for {cid region} $originalRegions {
     dict for {key face} [boundary $region] {foreach n $face {dict set protectedInterior $n 1}}
    }
    set repaired [repairInside $id [dict keys $protectedInterior]]
    *createmark nodes 1 {*}[dict keys $originalXYZ]
    set currentOriginal [coords [hm_getmark nodes 1]]
    dict for {n point} $originalXYZ {
     if {![dict exists $currentOriginal $n]} {
      if {[dict exists $protectedInterior $n]} {error "Original region boundary node deleted"}
      continue
     }
     if {$point ne [dict get $currentOriginal $n]} {
      if {[dict exists $protectedInterior $n]} {error "Original region boundary moved"}
      dict set allowedOriginalMotion $n 1
     }
    }
    puts "SHARED_RESIDUAL_INSIDE=$id $repaired internal_original_motion=[dict keys $allowedOriginalMotion]"
   }
  }
  set protected {};set regions {}
  dict for {id row} $parents {dict set regions [dict get $oldCid $id] $id $row}
  dict for {cid region} $regions {dict for {key face} [boundary $region] {foreach n $face {dict set protected $n 1}}}
  *createmark nodes 1 {*}[dict keys $originalXYZ];set surviving [hm_getmark nodes 1]
  foreach n [dict keys $originalXYZ] {if {$n ni $surviving && [dict exists $protected $n]} {error "Protected shared node deleted"}}
  set unchangedOriginal [subset $originalXYZ $surviving]
  foreach n [dict keys $allowedOriginalMotion] {
   if {[dict exists $protected $n]} {error "Protected original node moved"}
   if {[dict exists $unchangedOriginal $n]} {dict unset unchangedOriginal $n}
  }
  if {![sameDict $unchangedOriginal [coords [dict keys $unchangedOriginal]]]} {error "Original shared coordinates changed after refinement"}
  set checked [dict keys [elements $checked]]
  if {[llength [failed [quality $checked]]]} {error "Refined region still failed"}
 } err]
 *jacobian_calculate_cornerpts $jm
 if {$rc} {
  puts "TCF shared refinement rejected: $err"
  if {$recoveryRequired} {error "Recovery required"}
  set rr [catch {
   *createmark nodes 1 {*}[dict keys $originalXYZ]
   set presentOriginal [hm_getmark nodes 1];set actualOriginal [coords $presentOriginal];set resetOriginal {}
   dict for {n point} $actualOriginal {
    if {$point ne [dict get $originalXYZ $n]} {dict set resetOriginal $n [dict get $originalXYZ $n]}
   }
   if {[dict size $resetOriginal]} {writeCoords $resetOriginal;puts "SHARED_RESTORE_ORIGINAL_MOTION=[dict size $resetOriginal]"}
   dict for {cid before} $saved {
    set star {};set types {};set solver {};set liveNew {}
    dict for {id row} $parents {
     if {[dict get $oldCid $id]==$cid} {
      dict set star $id $row;dict set types $id [dict get $oldTypes $id]
      if {[dict exists $oldSolver elems $id]} {dict set solver elems $id [dict get $oldSolver elems $id]}
     }
    }
    set xyz [subset $originalXYZ [nodes $star]]
    foreach n [dict keys $xyz] {if {[dict exists $oldSolver nodes $n]} {dict set solver nodes $n [dict get $oldSolver nodes $n]}}
    set current [component $cid];set changed {}
    dict for {id row} $current {
     if {![dict exists $before $id]} {lappend liveNew $id} elseif {[dict exists $star $id] && $row ne [dict get $star $id]} {lappend changed $id}
    }
    if {[llength $changed]} {*createmark elems 1 {*}$changed;*deletemark elems 1}
    set trialNodes [nodes [elements $liveNew]]
    foreach n $trialNodes {if {![dict exists $originalXYZ $n]} {lappend createdNodes $n}}
    restoreCavity $star $xyz $types $solver $liveNew {} $cid
   }
   if {[llength $createdNodes]} {*createmark nodes 1 {*}$createdNodes;*nodemarkcleartempmark 1}
   dict for {cid before} $saved {if {![sameDict $before [component $cid]]} {error "Shared region restore mismatch"}}
   if {![sameDict $originalXYZ [coords [dict keys $originalXYZ]]]} {error "Shared coordinates restore mismatch"}
  } re]
  set checked $originalChecked
  if {$oldName ne {}} {*currentcollector components $oldName}
  if {$rr} {set recoveryRequired 1;error "Recovery required: shared restore failed: $re"}
  return $selection
 }
 if {$oldName ne {}} {*currentcollector components $oldName}
 set remaining {};set live [elements $selection]
 foreach id $selection {if {[dict exists $live $id] && [llength [failed [quality [list $id]]]]} {lappend remaining $id}}
 puts "SHARED_REFINE_SUCCESS edges=$selectedEdges count=[llength $checked]"
 log "Completed"
 return $remaining
}

proc ::TetCollapseFix::basicFlipPatch {parents children} {
    variable recoveryRequired;variable checked
    set old [elements $parents]
    if {[dict size $old]!=[llength $parents]} {error "Missing parent"}
    lassign [dict get $old [lindex $parents 0]] cfg pid unused
    *createmark elems 1 {*}$parents
    set cids [lsort -unique -integer [hm_getvalue elems mark=1 dataname=collector.id]]
    if {[llength $cids]!=1} {error "Mixed components"}
    set cid [lindex $cids 0]
    dict for {id row} $old {if {[lrange $row 0 1] ne [list $cfg $pid]} {error "Mixed order/property"}}
    guardReferences $parents
    if {![llength [failed [quality $parents]]]} {return 0}
    set before [component $cid];set xyz [coords [nodes $old]]
    set fullBoundary [boundary $old];set oldVolume [volume $old $xyz]
    set edges {};set protected {}
    dict for {key face} $fullBoundary {foreach n $face {dict set protected $n 1}}
    dict for {id row} $old {
        if {$cfg!=210} {continue}
        set en [lindex $row 2]
        foreach pair {{0 1 4} {1 2 5} {2 0 6} {0 3 7} {1 3 8} {2 3 9}} {
            lassign $pair a b m
            set edge [lsort -integer [list [lindex $en $a] [lindex $en $b]]]
            set mid [lindex $en $m]
            if {[dict exists $edges $edge] && [dict get $edges $edge]!=$mid} {error "Inconsistent quadratic edge"}
            dict set edges $edge $mid
        }
    }
    set used {};foreach en $children {
        foreach n $en {dict set used $n 1}
        foreach pair {{0 1} {1 2} {2 0} {0 3} {1 3} {2 3}} {
            lassign $pair a b
            set edge [lsort -integer [list [lindex $en $a] [lindex $en $b]]]
            if {[dict exists $edges $edge]} {dict set used [dict get $edges $edge] 1}
        }
    }
    dict for {n point} $xyz {
        if {![dict exists $used $n] && ![containedNodes [list $n] $old]} {error "Removed node has outside references"}
    }
    *createmark nodes 1 {*}[dict keys $xyz]
    set refs [hm_getcrossreferencedentitiesmark nodes 1 7 2 0 0 0];set external {}
    foreach type $refs {if {$type in {elems elements}} {set external [elements [hm_getmark $type 2]]}}
    foreach id $parents {if {[dict exists $external $id]} {dict unset external $id}}
    set types {};set solver {}
    foreach id $parents {
        dict set types $id [hm_getvalue elems id=$id dataname=type]
        if {![catch {hm_getsolverid elems $id -byid} pair]} {dict set solver elems $id $pair}
    }
    foreach n [dict keys $xyz] {if {![catch {hm_getsolverid nodes $n -byid} pair]} {dict set solver nodes $n $pair}}
    if {[llength [lsort -unique [dict values $types]]]!=1} {error "Mixed solver element types"}
    set current [hm_info currentcollector component];set currentName {}
    if {$current>0} {set currentName [hm_getvalue comps id=$current dataname=name]}
    set jm [hm_getelementcheckmethod jacobian_3d]
    set newIDs {};set newNodes {};set expectedConn {}
    *currentcollector components [hm_getvalue comps id=$cid dataname=name]
    set rc [catch {
        foreach corners $children {
            set en $corners
            if {$cfg==210} {
                foreach pair {{0 1} {1 2} {2 0} {0 3} {1 3} {2 3}} {
                    lassign $pair a b
                    set edge [lsort -integer [list [lindex $corners $a] [lindex $corners $b]]]
                    if {![dict exists $edges $edge]} {
                        lassign $edge n1 n2
                        set point {};foreach x [dict get $xyz $n1] y [dict get $xyz $n2] {lappend point [expr {($x+$y)*0.5}]}
                        lassign $point x y z;*createnode $x $y $z 0 0 0
                        set mid [hm_latestentityid nodes];dict set edges $edge $mid;lappend newNodes $mid
                    }
                    lappend en [dict get $edges $edge]
                }
            }
            *createlist nodes 1 {*}$en
            *createelement $cfg [dict get $types [lindex $parents 0]] 1 0
            set id [hm_latestentityid elems];lappend newIDs $id;dict set expectedConn $id $en;*setvalue elems id=$id propertyid=$pid
        }
        set new [elements $newIDs]
        if {![sameDict $fullBoundary [boundary $new]]} {error "Boundary changed"}
        dict for {id row} $new {if {[lrange $row 0 1] ne [list $cfg $pid]} {error "Order/property changed"}}
        dict for {id row} $new {if {[lrange [lindex $row 2] 0 end] ne [dict get $expectedConn $id]} {error "Native node ordering changed"}}
        set v [volume $new [coords [nodes $new]]]
        if {abs($v-$oldVolume)>1e-8*abs($oldVolume)} {error "Volume changed"}
        if {[llength [failed [quality $newIDs]]]} {error "New failed element"}
        *createmark elems 1 {*}$newIDs
        foreach mode {2 3} {
            *jacobian_calculate_cornerpts $mode
            foreach {id q} [hm_getelemcheckvalues 1 3 jacobian] {if {$q<=0} {error "Invalid Jacobian"}}
        }
        *createmark elems 1 {*}$parents;*deletemark elems 1
        if {[info exists ::env(FLIP_INJECT)]} {
            if {[dict size [elements $parents]]} {error "Old parent remains before injection"}
            incr ::TetCollapseFix::flipInjectedDeletes
            error "Injected post-delete failure"
        }
        set after [component $cid]
        dict for {id row} $before {
            if {$id in $parents} {if {[dict exists $after $id]} {error "Old parent retained"}} elseif {![dict exists $after $id] || [dict get $after $id] ne $row} {error "Outside connectivity changed"}
        }
        if {[dict size $after]!=[dict size $before]-[llength $parents]+[llength $children]} {error "Unexpected element count"}
        *createmark nodes 1 {*}[dict keys $xyz];set surviving [hm_getmark nodes 1]
        dict for {n point} $xyz {if {$n ni $surviving && [dict exists $protected $n]} {error "Boundary node deleted"}}
        if {![sameDict [subset $xyz $surviving] [coords $surviving]]} {error "Original node moved"}
        if {[dict size $external] && ![sameDict $external [elements [dict keys $external]]]} {error "External connectivity changed"}
    } reason]
    *jacobian_calculate_cornerpts $jm
    if {$currentName ne {}} {*currentcollector components $currentName}
    if {$rc} {
        set restore [catch {restoreCavity $old $xyz $types $solver $newIDs $newNodes $cid} restoreReason]
        if {$currentName ne {}} {*currentcollector components $currentName}
        if {$restore || ![sameDict $before [component $cid]] || ![sameDict $xyz [coords [dict keys $xyz]]]} {set recoveryRequired 1;error "Flip restore failed: $restoreReason"}
        puts "FLIP_REJECT=$reason"
        return 0
    }
    set updated {}
    foreach id $checked {if {$id ni $parents} {lappend updated $id}}
    set checked [lsort -unique -integer [concat $updated $newIDs]]
    foreach id $parents {dict set ::TetCollapseFix::replaced $id $newIDs}
    puts "FLIP_SUCCESS=$parents $newIDs [quality $newIDs]"
    return 1
}
proc ::TetCollapseFix::edgeRepairFlip {seed} {
    variable recoveryRequired
    if {![llength [failed [quality [list $seed]]]]} {return 1}
    foreach plan [flipPlans $seed] {
        lassign $plan score parents children
        set rc [catch {flipPatch $parents $children} result]
        if {$rc} {
            if {$recoveryRequired} {error $result}
            puts "FLIP_SKIP=$seed $result"
            continue
        }
        if {$result} {log "Completed";return 1}
    }
    return 0
}

proc ::TetCollapseFix::basicFlipPlans {seed} {
    variable threshold
    set one [elements [list $seed]]
    if {![dict exists $one $seed]} {return {}}
    lassign [dict get $one $seed] cfg pid ns
    set cid [hm_getvalue elems id=$seed dataname=collector.id]
    *createmark nodes 1 {*}[lrange $ns 0 3]
    set refs [hm_getcrossreferencedentitiesmark nodes 1 7 2 0 0 0]
    set ids {}
    foreach type $refs {if {$type in {elems elements}} {set ids [hm_getmark $type 2]}}
    set adjacent [elements $ids]
    set cids [hm_getvalue elems mark=1 dataname=collector.id]
    set eligible {};set faces {};set edges {}
    foreach id [dict keys $adjacent] part $cids {
        set row [dict get $adjacent $id]
        if {$part!=$cid || [lrange $row 0 1] ne [list $cfg $pid]} {continue}
        dict set eligible $id $row
        set en [lindex $row 2]
        foreach pattern {{0 1 2} {0 1 3} {0 2 3} {1 2 3}} {
            set key {};foreach i $pattern {lappend key [lindex $en $i]}
            dict lappend faces [lsort -integer $key] $id
        }
        foreach pair {{0 1} {0 2} {0 3} {1 2} {1 3} {2 3}} {
            lassign $pair a b;dict lappend edges [lsort -integer [list [lindex $en $a] [lindex $en $b]]] $id
        }
    }
    if {[dict size $eligible]>500} {return {}}
    set xyz [coords [nodes $eligible]];set proposals {}
    dict for {face parents} $faces {
        if {[llength $parents]!=2 || $seed ni $parents} {continue}
        set tips {}
        foreach p $parents {foreach n [lrange [lindex [dict get $eligible $p] 2] 0 3] {if {$n ni $face} {lappend tips $n}}}
        if {[llength [lsort -unique -integer $tips]]!=2} {continue}
        lassign $tips a b
        set diagonal [lsort -integer $tips]
        if {[dict exists $edges $diagonal]} {continue}
        set occupied 0
        dict for {id row} $adjacent {
            set en [lindex $row 2]
            if {$a in $en && $b in $en} {set occupied 1;break}
        }
        if {$occupied} {continue}
        lassign $face i j k
        lappend proposals [list $parents [list [list $a $b $i $j] [list $a $b $j $k] [list $a $b $k $i]]]
    }
    dict for {edge parents} $edges {
        if {[llength $parents]!=3 || $seed ni $parents} {continue}
        set ring {}
        foreach p $parents {foreach n [lrange [lindex [dict get $eligible $p] 2] 0 3] {if {$n ni $edge} {dict set ring $n 1}}}
        if {[dict size $ring]!=3} {continue}
        set ring [lsort -integer [dict keys $ring]]
        if {[dict exists $faces $ring]} {continue}
        set occupied 0
        dict for {id row} $adjacent {
            if {[lindex $row 0] ni {204 210}} {continue}
            set en [lrange [lindex $row 2] 0 3];set contains 1
            foreach n $ring {if {$n ni $en} {set contains 0;break}}
            if {$contains} {set occupied 1;break}
        }
        if {$occupied} {continue}
        lassign $ring i j k;lassign $edge a b
        lappend proposals [list $parents [list [list $a $i $j $k] [list $b $i $j $k]]]
    }
    dict for {edge parents} $edges {
        if {[llength $parents]!=4 || $seed ni $parents} {continue}
        set neighbors {};set valid 1
        foreach p $parents {
            set ring {}
            foreach n [lrange [lindex [dict get $eligible $p] 2] 0 3] {if {$n ni $edge} {lappend ring $n}}
            if {[llength $ring]!=2} {set valid 0;break}
            lassign $ring a b;dict lappend neighbors $a $b;dict lappend neighbors $b $a
        }
        if {!$valid || [dict size $neighbors]!=4} {continue}
        dict for {n linked} $neighbors {
            set linked [lsort -unique -integer $linked]
            if {[llength $linked]!=2} {set valid 0;break}
            dict set neighbors $n $linked
        }
        if {!$valid} {continue}
        set first [lindex [lsort -integer [dict keys $neighbors]] 0]
        set order [list $first [lindex [dict get $neighbors $first] 0]]
        while {[llength $order]<4} {
            set previous [lindex $order end-1];set current [lindex $order end];set next {}
            foreach n [dict get $neighbors $current] {if {$n!=$previous} {lappend next $n}}
            if {[llength $next]!=1 || [lindex $next 0] in $order} {set valid 0;break}
            lappend order [lindex $next 0]
        }
        if {!$valid || $first ni [dict get $neighbors [lindex $order end]]} {continue}
        lassign $order i j k l;lassign $edge a b
        foreach choice [list [list $i $k $j $l] [list $j $l $i $k]] {
            lassign $choice x y u v
            if {[dict exists $edges [lsort -integer [list $x $y]]]} {continue}
            set occupied 0
            dict for {id row} $adjacent {set en [lindex $row 2];if {$x in $en && $y in $en} {set occupied 1;break}}
            if {$occupied} {continue}
            lappend proposals [list $parents [list [list $x $y $a $u] [list $x $y $u $b] [list $x $y $b $v] [list $x $y $v $a]]]
        }
    }
    set plans {}
    foreach proposal $proposals {
        lassign $proposal parents children
        set old {}
        foreach p $parents {
            set corners [lrange [lindex [dict get $eligible $p] 2] 0 3]
            dict set old $p [list 204 $pid $corners]
        }
        set trial {};set oriented {};set count 0;set valid 1
        foreach en $children {
            set row [dict create 1 [list 204 $pid $en]]
            if {[catch {volume $row $xyz}]} {set en [list [lindex $en 1] [lindex $en 0] [lindex $en 2] [lindex $en 3]]}
            dict set trial [incr count] [list 204 $pid $en];lappend oriented $en
        }
        if {[catch {volume $old $xyz} ov] || [catch {volume $trial $xyz} nv] || abs($ov-$nv)>1e-8*abs($ov)} {continue}
        if {[catch {boundary $old} of] || [catch {boundary $trial} nf] || ![sameDict $of $nf]} {continue}
        set score [qscore $trial $xyz]
        if {$score>$threshold+0.0001} {lappend plans [list $score $parents $oriented]}
    }
    return [lsort -real -decreasing -index 0 $plans]
}

namespace eval ::LargeEdge {}
proc ::LargeEdge::signedVolume {ns xyz} {
    lassign $ns a b c d
    set origin [dict get $xyz $a]
    return [expr {[::Tangent::dot [::Tangent::sub [dict get $xyz $b] $origin] [::Tangent::cross [::Tangent::sub [dict get $xyz $c] $origin] [::Tangent::sub [dict get $xyz $d] $origin]]]/6.0}]
}
proc ::LargeEdge::orientedBoundary {rows xyz} {
    set signs {}
    dict for {id row} $rows {
        set ns [lrange [lindex $row 2] 0 3]
        if {[signedVolume $ns $xyz]<=0} {error "Non-positive oriented parent/child volume"}
        foreach pattern {{0 2 1} {0 1 3} {1 2 3} {2 0 3}} {
            set face {};foreach i $pattern {lappend face [lindex $ns $i]}
            set inversions 0
            for {set i 0} {$i<3} {incr i} {
                for {set j [expr {$i+1}]} {$j<3} {incr j} {
                    if {[lindex $face $i]>[lindex $face $j]} {incr inversions}
                }
            }
            dict lappend signs [lsort -integer $face] [expr {$inversions%2 ? -1 : 1}]
        }
    }
    set boundary {}
    dict for {face values} $signs {
        if {[llength $values]>2} {error "Non-manifold oriented face"}
        if {[llength $values]==2} {
            if {[lindex $values 0]+[lindex $values 1]!=0} {error "Internal face orientations agree"}
        } else {dict set boundary $face [lindex $values 0]}
    }
    return $boundary
}
proc ::LargeEdge::ring {edge parents rows} {
    set linked {};set count [llength $parents]
    foreach p $parents {
        set pair {}
        foreach n [lrange [lindex [dict get $rows $p] 2] 0 3] {if {$n ni $edge} {lappend pair $n}}
        if {[llength $pair]!=2} {return {}}
        lassign $pair a b;dict lappend linked $a $b;dict lappend linked $b $a
    }
    if {[dict size $linked]!=$count} {return {}}
    dict for {n next} $linked {
        set next [lsort -unique -integer $next]
        if {[llength $next]!=2} {return {}}
        dict set linked $n $next
    }
    set first [lindex [lsort -integer [dict keys $linked]] 0]
    set order [list $first [lindex [dict get $linked $first] 0]]
    while {[llength $order]<$count} {
        set previous [lindex $order end-1];set current [lindex $order end];set next {}
        foreach n [dict get $linked $current] {if {$n!=$previous} {lappend next $n}}
        if {[llength $next]!=1 || [lindex $next 0] in $order} {return {}}
        lappend order [lindex $next 0]
    }
    if {$first ni [dict get $linked [lindex $order end]]} {return {}}
    return $order
}
proc ::LargeEdge::outsideOccupied {map key parents} {
    if {![dict exists $map $key]} {return 0}
    foreach id [dict get $map $key] {if {$id ni $parents} {return 1}}
    return 0
}
proc ::LargeEdge::triangulate {edge ring parents old xyz edges faces} {
    set count [llength $ring];lassign $edge a b
    set first [signedVolume [list $a $b [lindex $ring 0] [lindex $ring 1]] $xyz]
    set sign [expr {$first>0 ? 1 : -1}]
    for {set i 0} {$i<$count} {incr i} {
        if {[signedVolume [list $a $b [lindex $ring $i] [lindex $ring [expr {($i+1)%$count}]]] $xyz]*$sign<=0} {return {}}
    }
    set dp {}
    for {set i 0} {$i<$count-1} {incr i} {dict set dp [list $i [expr {$i+1}]] [list 1.0 {}]}
    for {set span 2} {$span<$count} {incr span} {
        for {set i 0} {$i<$count-$span} {incr i} {
            set j [expr {$i+$span}];set best [list -1 {}]
            set x [lindex $ring $i];set z [lindex $ring $j]
            if {!($i==0 && $j==$count-1) && [outsideOccupied $edges [lsort -integer [list $x $z]] $parents]} {
                dict set dp [list $i $j] $best;continue
            }
            for {set k [expr {$i+1}]} {$k<$j} {incr k} {
                lassign [dict get $dp [list $i $k]] left leftChildren
                lassign [dict get $dp [list $k $j]] right rightChildren
                if {min($left,$right)<=$::TetCollapseFix::threshold+0.0001} {continue}
                set y [lindex $ring $k]
                if {[outsideOccupied $faces [lsort -integer [list $x $y $z]] $parents]} {continue}
                set one [list $a $x $y $z];set two [list $b $x $z $y]
                if {[signedVolume $one $xyz]*$sign<=0 || [signedVolume $two $xyz]*$sign<=0} {continue}
                if {$sign<0} {
                    set one [list $x $a $y $z];set two [list $x $b $z $y]
                }
                set trial [dict create 1 [list 204 0 $one] 2 [list 204 0 $two]]
                set score [expr {min($left,$right,[::TetCollapseFix::qscore $trial $xyz])}]
                if {$score>[lindex $best 0]} {set best [list $score [concat $leftChildren $rightChildren [list $one $two]]]}
            }
            dict set dp [list $i $j] $best
        }
    }
    lassign [dict get $dp [list 0 [expr {$count-1}]]] score children
    if {$score<=$::TetCollapseFix::threshold+0.0001} {return {}}
    set trial {};set id 0
    foreach ns $children {dict set trial [incr id] [list 204 0 $ns]}
    if {![::TetCollapseFix::sameDict [orientedBoundary $old $xyz] [orientedBoundary $trial $xyz]]} {return {}}
    set ov [::TetCollapseFix::volume $old $xyz];set nv [::TetCollapseFix::volume $trial $xyz]
    if {abs($ov-$nv)>1e-8*abs($ov)} {return {}}
    return [list $score $parents $children]
}
proc ::LargeEdge::attached {nodeids} {
    *createmark nodes 1 {*}$nodeids
    set types [hm_getcrossreferencedentitiesmark nodes 1 7 2 0 0 0]
    foreach type $types {if {$type in {elems elements}} {return [::TetCollapseFix::elements [hm_getmark $type 2]]}}
    return {}
}
proc ::LargeEdge::plans {seed} {
    set one [::TetCollapseFix::elements [list $seed]]
    if {![dict exists $one $seed]} {return {}}
    lassign [dict get $one $seed] cfg pid ns
    set cid [hm_getvalue elems id=$seed dataname=collector.id]
    set adjacent [attached [lrange $ns 0 3]]
    set cids [hm_getvalue elems mark=1 dataname=collector.id]
    set eligible {};set edges {}
    foreach id [dict keys $adjacent] part $cids {
        set row [dict get $adjacent $id]
        if {$part!=$cid || [lrange $row 0 1] ne [list $cfg $pid]} {continue}
        dict set eligible $id $row
        set en [lindex $row 2]
        foreach pair {{0 1} {0 2} {0 3} {1 2} {1 3} {2 3}} {
            lassign $pair a b
            dict lappend edges [lsort -integer [list [lindex $en $a] [lindex $en $b]]] $id
        }
    }
    if {[dict size $eligible]>500} {return {}}
    set infos {};set vertices {}
    dict for {edge parents} $edges {
        if {$seed ni $parents || [llength $parents]<5 || [llength $parents]>10} {continue}
        set ring [ring $edge $parents $eligible]
        if {![llength $ring]} {continue}
        lappend infos [list $edge $parents $ring]
        foreach n $ring {dict set vertices $n 1}
    }
    if {![llength $infos]} {return {}}
    # Query every ring vertex, including vertices absent from the selected tet.
    set full [attached [dict keys $vertices]]
    set occupiedEdges {};set occupiedFaces {}
    dict for {id row} $full {
        set present {}
        foreach n [lindex $row 2] {if {[dict exists $vertices $n]} {lappend present $n}}
        set present [lsort -unique -integer $present];set count [llength $present]
        for {set i 0} {$i<$count} {incr i} {
            for {set j [expr {$i+1}]} {$j<$count} {incr j} {
                dict lappend occupiedEdges [list [lindex $present $i] [lindex $present $j]] $id
                for {set k [expr {$j+1}]} {$k<$count} {incr k} {
                    dict lappend occupiedFaces [list [lindex $present $i] [lindex $present $j] [lindex $present $k]] $id
                }
            }
        }
    }
    set xyz [::TetCollapseFix::coords [::TetCollapseFix::nodes $eligible]];set plans {}
    foreach info $infos {
        lassign $info edge parents ring
        set old [::TetCollapseFix::subset $eligible $parents]
        if {[catch {triangulate $edge $ring $parents $old $xyz $occupiedEdges $occupiedFaces} plan]} {continue}
        if {[llength $plan]} {lappend plans $plan}
    }
    return [lsort -real -decreasing -index 0 $plans]
}


proc ::TetCollapseFix::flipPlans {seed} {
    set plans [basicFlipPlans $seed]
    if {[catch {::LargeEdge::plans $seed} larger]} {puts "LARGE_EDGE_SKIP=$larger";set larger {}}
    return [lsort -real -decreasing -index 0 [concat $plans $larger]]
}
proc ::TetCollapseFix::flipPatch {parents children} {
    set old [elements $parents];set xyz [coords [nodes $old]]
    set trial {};set id 0
    foreach ns $children {dict set trial [incr id] [list 204 0 $ns]}
    if {![sameDict [::LargeEdge::orientedBoundary $old $xyz] [::LargeEdge::orientedBoundary $trial $xyz]]} {
        error "Oriented cavity boundary differs"
    }
    return [basicFlipPatch $parents $children]
}

namespace eval ::FixedCavity {}
proc ::FixedCavity::faces {ns} {
    set out {}
    foreach p {{0 2 1} {0 1 3} {1 2 3} {2 0 3}} {
        set f {};foreach i $p {lappend f [lindex $ns $i]}
        set parity 0
        for {set i 0} {$i<3} {incr i} {for {set j [expr {$i+1}]} {$j<3} {incr j} {if {[lindex $f $i]>[lindex $f $j]} {incr parity}}}
        dict set out [lsort -integer $f] [expr {$parity%2 ? -1 : 1}]
    }
    return $out
}
proc ::FixedCavity::add {id frontier counts selected} {
    variable candidates;variable shell
    if {$id in $selected} {return {}}
    lassign [lindex $candidates $id] quality ns volume fs
    dict for {face sign} $fs {
        set count 0;if {[dict exists $counts $face]} {set count [dict get $counts $face]}
        set limit [expr {[dict exists $shell $face] ? 1 : 2}]
        if {$count>=$limit} {return {}}
        dict set counts $face [expr {$count+1}]
        if {[dict exists $frontier $face]} {
            if {[dict get $frontier $face]!=$sign} {return {}}
            dict unset frontier $face
        } else {dict set frontier $face [expr {-$sign}]}
    }
    return [list $frontier $counts]
}
proc ::FixedCavity::compatible {id frontier counts selected} {
    variable candidates;variable shell
    if {$id in $selected} {return 0}
    dict for {face sign} [lindex [lindex $candidates $id] 3] {
        set count 0;if {[dict exists $counts $face]} {set count [dict get $counts $face]}
        set limit [expr {[dict exists $shell $face] ? 1 : 2}]
        if {$count >= $limit} {return 0}
        if {[dict exists $frontier $face] && [dict get $frontier $face] != $sign} {return 0}
    }
    return 1
}
proc ::FixedCavity::search {frontier counts selected volume} {
    variable steps;variable deadline;variable faceIndex;variable candidates;variable targetVolume;variable exhausted
    incr steps
    if {$steps>50000 || [clock milliseconds]>$deadline} {set exhausted 1;return {}}
    if {![dict size $frontier]} {
        if {abs($volume-$targetVolume)<=1e-8*abs($targetVolume)} {return $selected}
        return {}
    }
    if {$volume>$targetVolume*(1+1e-8)} {return {}}
    set best {};set fewest 1000000
    dict for {face sign} $frontier {
        set choices {};set key [list $face $sign]
        if {![dict exists $faceIndex $key]} {faceIDs $face $sign}
        if {$exhausted} {return {}}
        if {[dict exists $faceIndex $key]} {
            foreach id [dict get $faceIndex $key] {
                if {[compatible $id $frontier $counts $selected]} {lappend choices $id}
            }
        }
        if {![llength $choices]} {return {}}
        if {[llength $choices]<$fewest} {set best $choices;set fewest [llength $choices]}
        if {$fewest==1} {break}
    }
    foreach id $best {
        lassign [add $id $frontier $counts $selected] nf nc
        set result [search $nf $nc [concat $selected [list $id]] [expr {$volume+[lindex [lindex $candidates $id] 2]}]]
        if {[llength $result]} {return $result}
        if {$exhausted} {return {}}
    }
    return {}
}

proc ::FixedCavity::faceFeasible {face sign corners xyz} {
    foreach apex $corners {
        if {$apex in $face} {continue}
        set ns [concat $face [list $apex]]
        set v [::LargeEdge::signedVolume $ns $xyz]
        if {$v==0 || ($v>0 ? -1 : 1)!=$sign} {continue}
        if {$v<0} {set ns [list [lindex $ns 1] [lindex $ns 0] [lindex $ns 2] [lindex $ns 3]]}
        if {[::TetCollapseFix::qscore [dict create 1 [list 204 0 $ns]] $xyz]>$::TetCollapseFix::threshold+.0001} {return 1}
    }
    return 0
}

proc ::FixedCavity::candidateID {key} {
    variable candidateCache;variable candidates;variable candidateXYZ
    variable edgeBlocks;variable faceBlocks;variable shell
    if {[dict exists $candidateCache $key]} {return [dict get $candidateCache $key]}
    dict set candidateCache $key -1
    set ns $key;set v [::LargeEdge::signedVolume $ns $candidateXYZ]
    if {$v==0} {return -1}
    if {$v<0} {set ns [list [lindex $ns 1] [lindex $ns 0] [lindex $ns 2] [lindex $ns 3]];set v [expr {-$v}]}
    foreach pair {{0 1} {0 2} {0 3} {1 2} {1 3} {2 3}} {
        lassign $pair i j
        if {[dict exists $edgeBlocks [lsort -integer [list [lindex $ns $i] [lindex $ns $j]]]]} {return -1}
    }
    set fs [faces $ns]
    dict for {face sign} $fs {
        if {[dict exists $faceBlocks $face]} {return -1}
        if {[dict exists $shell $face] && [dict get $shell $face]!=$sign} {return -1}
    }
    set q [::TetCollapseFix::qscore [dict create 1 [list 204 0 $ns]] $candidateXYZ]
    if {$q<=$::TetCollapseFix::threshold+.0001} {return -1}
    set id [llength $candidates];lappend candidates [list $q $ns $v $fs]
    dict set candidateCache $key $id
    return $id
}
proc ::FixedCavity::faceIDs {face sign} {
    variable faceIndex;variable cornerPool;variable candidates;variable exhausted;variable deadline
    set key [list $face $sign]
    if {[dict exists $faceIndex $key]} {return [dict get $faceIndex $key]}
    set choices {}
    foreach apex $cornerPool {
        if {$apex in $face} {continue}
        if {[clock milliseconds]>$deadline} {set exhausted 1;break}
        set id [candidateID [lsort -integer [concat $face [list $apex]]]]
        if {$id<0} {continue}
        set candidate [lindex $candidates $id]
        if {[dict get [lindex $candidate 3] $face]==$sign} {lappend choices [list [lindex $candidate 0] $id]}
    }
    set ids {};foreach choice [lsort -real -decreasing -index 0 $choices] {lappend ids [lindex $choice 1]}
    dict set faceIndex $key $ids
    return $ids
}
proc ::FixedCavity::solve {old xyz {milliseconds 5000} {blockedEdges {}} {blockedFaces {}}} {
    variable candidates;variable shell;variable faceIndex;variable targetVolume
    variable steps;variable deadline;variable exhausted;variable candidateCache;variable candidateXYZ
    variable edgeBlocks;variable faceBlocks;variable cornerPool
    set steps 0;set exhausted 0;set deadline [expr {[clock milliseconds]+$milliseconds}]
    set shell [::LargeEdge::orientedBoundary $old $xyz]
    set targetVolume [::TetCollapseFix::volume $old $xyz]
    set corners {}
    dict for {id row} $old {foreach n [lrange [lindex $row 2] 0 3] {dict set corners $n 1}}
    set cornerPool [lsort -integer [dict keys $corners]]
    if {[llength $cornerPool]>24} {error "Prototype corner limit exceeded"}
    set candidates {};set faceIndex {};set candidateCache {};set candidateXYZ $xyz
    set edgeBlocks $blockedEdges;set faceBlocks $blockedFaces
    dict for {face sign} $shell {
        set ids [faceIDs $face $sign]
        if {$exhausted || ![llength $ids]} {
            return [dict create children {} quality 1.0 steps 0 exhausted $exhausted candidates [llength $candidates]]
        }
    }
    set selected [search $shell {} {} 0.0]
    set children {};set quality 1.0
    foreach id $selected {lassign [lindex $candidates $id] q ns v fs;lappend children $ns;set quality [expr {min($quality,$q)}]}
    return [dict create children $children quality $quality steps $steps exhausted $exhausted candidates [llength $candidates]]
}

proc ::FixedCavity::plans {seed} {
    set one [::TetCollapseFix::elements [list $seed]]
    if {![dict exists $one $seed]} {return {}}
    set cfg [lindex [dict get $one $seed] 0];set pid [lindex [dict get $one $seed] 1]
    set cid [hm_getvalue elems id=$seed dataname=collector.id]
    set patch $one;set plans {}
    for {set layer 1} {$layer<=4} {incr layer} {
        set corners {}
        dict for {id row} $patch {foreach n [lrange [lindex $row 2] 0 3] {dict set corners $n 1}}
        if {$layer==1} {
            set full [::LargeEdge::attached [dict keys $corners]]
            set cids [hm_getvalue elems mark=1 dataname=collector.id]
        } else {
            set full $cachedFull;set cids $cachedCids
        }
        set eligible {};set faceAdj {}
        foreach id [dict keys $full] part $cids {
            set row [dict get $full $id]
            if {$part!=$cid || [lrange $row 0 1] ne [list $cfg $pid]} {continue}
            dict set eligible $id $row
            dict for {face sign} [faces [lrange [lindex $row 2] 0 3]] {dict lappend faceAdj $face $id}
        }
        set expanded $patch
        dict for {id row} $patch {
            dict for {face sign} [faces [lrange [lindex $row 2] 0 3]] {
                if {[dict exists $faceAdj $face]} {foreach e [dict get $faceAdj $face] {dict set expanded $e [dict get $eligible $e]}}
            }
        }
        set patch $expanded;set corners {};set oldEdges {}
        dict for {id row} $patch {
            set ns [lrange [lindex $row 2] 0 3]
            foreach n $ns {dict set corners $n 1}
            foreach pair {{0 1} {0 2} {0 3} {1 2} {1 3} {2 3}} {
                lassign $pair i j;dict set oldEdges [lsort -integer [list [lindex $ns $i] [lindex $ns $j]]] 1
            }
        }
        if {[dict size $corners]>24 || [dict size $patch]>75} {break}
        set xyz [::TetCollapseFix::coords [::TetCollapseFix::nodes $patch]]
        set shell [::LargeEdge::orientedBoundary $patch $xyz]
        # Full references at every candidate corner protect neighboring parts.
        set outside [::LargeEdge::attached [dict keys $corners]]
        set blockedEdges {};set blockedFaces {}
        dict for {id row} $outside {
            if {[dict exists $patch $id]} {continue}
            set present {}
            foreach n [lindex $row 2] {if {[dict exists $corners $n]} {lappend present $n}}
            set present [lsort -integer -unique $present];set count [llength $present]
            for {set i 0} {$i<$count} {incr i} {for {set j [expr {$i+1}]} {$j<$count} {incr j} {
                set edge [list [lindex $present $i] [lindex $present $j]]
                if {![dict exists $oldEdges $edge]} {dict set blockedEdges $edge 1}
                for {set k [expr {$j+1}]} {$k<$count} {incr k} {
                    set face [list [lindex $present $i] [lindex $present $j] [lindex $present $k]]
                    if {![dict exists $shell $face]} {dict set blockedFaces $face 1}
                }
            }}
        }
        set result [solve $patch $xyz 1500 $blockedEdges $blockedFaces]
        if {[llength [dict get $result children]]} {
            lappend plans [list [dict get $result quality] [dict keys $patch] [dict get $result children]]
            break
        }
        if {$layer<4} {
            # No mesh changes occur in this function. The outside query at
            # current corners exactly supplies the next layer's initial rows.
            set cachedFull $outside
            set cachedCids [hm_getvalue elems mark=1 dataname=collector.id]
        }
    }
    return $plans
}


proc ::TetCollapseFix::repairFlip {seed} {
    if {[edgeRepairFlip $seed]} {return 1}
    if {[catch {::FixedCavity::plans $seed} plans]} {puts "FIXED_CAVITY_SKIP=$seed $plans";return 0}
    foreach plan $plans {
        lassign $plan score parents children
        set rc [catch {flipPatch $parents $children} result]
        if {$::TetCollapseFix::recoveryRequired} {error "Recovery required"}
        if {!$rc && $result} {puts "FIXED_CAVITY_SUCCESS=$seed [llength $parents] [llength $children]";return 1}
    }
    return 0
}

namespace eval ::Tangent {}
proc ::Tangent::sub {a b} {set out {};foreach x $a y $b {lappend out [expr {$x-$y}]};return $out}
proc ::Tangent::dot {a b} {set v 0;foreach x $a y $b {set v [expr {$v+$x*$y}]};return $v}
proc ::Tangent::cross {a b} {lassign $a x y z;lassign $b u v w;return [list [expr {$y*$w-$z*$v}] [expr {$z*$u-$x*$w}] [expr {$x*$v-$y*$u}]]}
proc ::Tangent::norm {a} {return [expr {sqrt([dot $a $a])}]}
proc ::Tangent::checkFans {star groups xyz corner weights delta scale} {
    set ::Tangent::lastNormals {};set ::Tangent::lastIntervals {}
    set origin [dict get $xyz $corner];set tolerance [expr {1e-9*$scale}]
    dict for {group members} $groups {
        set part [::TetCollapseFix::subset $star $members];set clusters {}
        set edgeMids {}
        dict for {id row} $part {
            if {[lindex $row 0]!=210} {continue}
            set en [lindex $row 2]
            foreach pair {{0 1 4} {1 2 5} {2 0 6} {0 3 7} {1 3 8} {2 3 9}} {
                lassign $pair a b m
                set edge [lsort -integer [list [lindex $en $a] [lindex $en $b]]]
                set mid [lindex $en $m]
                if {[dict exists $edgeMids $edge] && [dict get $edgeMids $edge]!=$mid} {error "Inconsistent quadratic edge"}
                dict set edgeMids $edge $mid
            }
        }
        dict for {key face} [::TetCollapseFix::boundary $part] {
            # boundary() returns sorted node IDs; use its separate corner key.
            set face $key
            if {[dict size $edgeMids]} {
                foreach pair {{0 1} {1 2} {2 0}} {
                    lassign $pair a b
                    set edge [lsort -integer [list [lindex $key $a] [lindex $key $b]]]
                    lappend face [dict get $edgeMids $edge]
                }
            }
            if {$corner ni $key} {
                foreach n $face {if {[dict exists $weights $n]} {error "Moved node lies on an opposite boundary face"}}
                continue
            }
            set a [dict get $xyz [lindex $face 0]];set b [dict get $xyz [lindex $face 1]];set c [dict get $xyz [lindex $face 2]]
            set normal [cross [sub $b $a] [sub $c $a]];set length [norm $normal]
            if {$length<=1e-14*$scale*$scale} {error "Degenerate surface triangle"}
            set unit {};foreach value $normal {lappend unit [expr {$value/$length}]}
            lappend ::Tangent::lastNormals $unit
            foreach n $face {if {abs([dot [sub [dict get $xyz $n] $origin] $unit])>$tolerance} {error "Curved boundary fan"}}
            if {abs([dot $delta $unit])>$tolerance} {error "Motion leaves original surface plane"}
            set index -1;set i 0
            foreach cluster $clusters {if {[norm [cross $unit [lindex $cluster 0]]]<1e-10} {set index $i;break};incr i}
            if {$index<0} {lappend clusters [list $unit [list $face]]} else {
                set cluster [lindex $clusters $index];lset cluster 1 [concat [lindex $cluster 1] [list $face]];lset clusters $index $cluster
            }
        }
        foreach cluster $clusters {
            set counts {};set mids {}
            foreach face [lindex $cluster 1] {
                foreach pair {{0 1 3} {1 2 4} {2 0 5}} {
                    lassign $pair a b m;set edge [lsort -integer [list [lindex $face $a] [lindex $face $b]]]
                    dict incr counts $edge
                    if {[llength $face]>3} {dict set mids $edge [lindex $face $m]}
                }
            }
            set endpoints {};set featureMids {}
            dict for {edge count} $counts {
                if {$count>2} {error "Non-manifold planar fan"}
                if {$count!=1} {continue}
                if {$corner in $edge} {
                    foreach n $edge {if {$n!=$corner} {lappend endpoints $n}}
                    if {[dict exists $mids $edge]} {lappend featureMids [dict get $mids $edge]}
                } else {
                    foreach n $edge {if {[dict exists $weights $n]} {error "Fan perimeter moved"}}
                    if {[dict exists $mids $edge] && [dict exists $weights [dict get $mids $edge]]} {error "Quadratic fan perimeter moved"}
                }
            }
            if {![llength $endpoints]} {continue}
            if {[llength $endpoints]!=2} {error "Geometric surface junction is locked"}
            set a [dict get $xyz [lindex $endpoints 0]];set b [dict get $xyz [lindex $endpoints 1]]
            set axis [sub $b $a];set length [norm $axis]
            if {$length<=1e-12*$scale} {error "Degenerate feature line"}
            set extra [cross [lindex $cluster 0] $axis];set extraLength [norm $extra];set extraUnit {}
            foreach value $extra {lappend extraUnit [expr {$value/$extraLength}]}
            lappend ::Tangent::lastNormals $extraUnit
            lappend ::Tangent::lastIntervals [list $a $b]
            set points [list $origin];foreach n $featureMids {lappend points [dict get $xyz $n]}
            foreach point $points {
                if {[norm [cross [sub $point $a] $axis]]>$tolerance*$length} {error "Curved or bent perimeter is locked"}
            }
            if {[norm [cross $delta $axis]]>$tolerance*$length} {error "Motion changes original feature line"}
            set next {};foreach x $origin d $delta {lappend next [expr {$x+$d}]}
            foreach point [list $origin $next] {if {[dot [sub $point $a] [sub $point $b]]>$tolerance*$scale} {error "Feature node leaves fixed interval"}}
        }
    }
    return 1
}
proc ::Tangent::prepare {seed corner} {
    set star [::TetCollapseFix::nodeStar $corner]
    if {![dict exists $star $seed] || [dict size $star]>200} {error "Invalid shared-node star"}
    set cfg [lindex [dict get $star $seed] 0];set weights [dict create $corner 1.0]
    dict for {id row} $star {
        lassign $row c pid en
        if {$c!=$cfg || $corner ni [lrange $en 0 3]} {error "Mixed order or corner role"}
        if {$cfg==210} {
            foreach pair {{0 1 4} {1 2 5} {2 0 6} {0 3 7} {1 3 8} {2 3 9}} {
                lassign $pair a b mid
                if {[lindex $en $a]==$corner || [lindex $en $b]==$corner} {dict set weights [lindex $en $mid] .5}
            }
        }
    }
    if {![::TetCollapseFix::containedNodes [dict keys $weights] $star]} {error "Moved nodes have outside references"}
    set ::Tangent::lastWeights $weights
    set xyz [::TetCollapseFix::coords [::TetCollapseFix::nodes $star]];set groups {}
    *createmark elems 1 {*}[dict keys $star];set cids [hm_getvalue elems mark=1 dataname=collector.id]
    foreach id [dict keys $star] cid $cids {dict lappend groups [list $cid [lindex [dict get $star $id] 1]] $id}
    set scale 0
    dict for {id row} $star {foreach n [lrange [lindex $row 2] 0 3] {set scale [expr {max($scale,[norm [sub [dict get $xyz $n] [dict get $xyz $corner]]])}]}}
    checkFans $star $groups $xyz $corner $weights {0 0 0} $scale
    return [dict create star $star xyz $xyz weights $weights groups $groups scale $scale normals $::Tangent::lastNormals intervals $::Tangent::lastIntervals]
}
# Experimental native translation in one group per corner/midpoint weight.
# Rejection still restores absolute original coordinates using writeCoords.
proc ::Tangent::moveWeighted {weights delta} {
    set length [norm $delta]
    if {$length==0} {return}
    lassign $delta x y z
    *createvector 1 $x $y $z
    set groups {}
    dict for {n weight} $weights {dict lappend groups $weight $n}
    dict for {weight ids} $groups {
        *createmark nodes 1 {*}$ids
        *translatemark nodes 1 1 [expr {$length*$weight}]
    }
}
proc ::Tangent::trial {seed corner delta {prepared {}}} {
    if {$prepared eq {}} {set prepared [prepare $seed $corner]}
    foreach key {star xyz weights groups scale} {set $key [dict get $prepared $key]}
    set ::Tangent::lastWeights $weights
    if {![::TetCollapseFix::sameDict $star [::TetCollapseFix::elements [dict keys $star]]] || ![::TetCollapseFix::sameDict $xyz [::TetCollapseFix::coords [dict keys $xyz]]]} {error "Model changed during tangent search"}
    checkFans $star $groups $xyz $corner $weights $delta $scale
    set candidate [::TetCollapseFix::displaced $xyz $weights $delta]
    set q [::TetCollapseFix::qscore [dict create $seed [dict get $star $seed]] $candidate]
    if {$q<$::TetCollapseFix::threshold+0.0001} {error "Predicted seed collapse remains low"}
    set beforeQ [::TetCollapseFix::quality [dict keys $star]]
    set oldBad [::TetCollapseFix::failed $beforeQ]
    set jm [hm_getelementcheckmethod jacobian_3d]
    set rc [catch {
        ::Tangent::moveWeighted $weights $delta
        if {[info exists ::env(TANGENT_INJECT)]} {incr ::Tangent::injectedWrites;error "Injected post-move failure"}
        set now [::TetCollapseFix::coords [dict keys $xyz]]
        dict for {n weight} $weights {if {[norm [sub [dict get $now $n] [dict get $candidate $n]]]>1e-12*$scale} {error "Actual displacement differs from the geometry-checked trial"}}
        dict for {n point} $xyz {if {![dict exists $weights $n] && [dict get $now $n] ne $point} {error "Protected original coordinate changed"}}
        if {![::TetCollapseFix::sameDict $star [::TetCollapseFix::elements [dict keys $star]]]} {error "Connectivity changed"}
        checkFans $star $groups $now $corner $weights {0 0 0} $scale
        dict for {group members} $groups {
            set part [::TetCollapseFix::subset $star $members]
            set ov [::TetCollapseFix::volume $part $xyz];set nv [::TetCollapseFix::volume $part $now]
            if {abs($ov-$nv)>1e-8*abs($ov)} {error "Component/property volume changed"}
        }
        set nowQ [::TetCollapseFix::quality [dict keys $star]]
        if {[llength [::TetCollapseFix::failed [::TetCollapseFix::quality [list $seed]]]]} {error "Seed still failed"}
        foreach id [::TetCollapseFix::failed $nowQ] {if {$id ni $oldBad} {error "New failed neighbor"}}
        foreach id $oldBad {if {$id!=$seed && [dict get $nowQ $id]<[dict get $beforeQ $id]-1e-8} {error "Existing failed neighbor worsened"}}
        *createmark elems 1 {*}[dict keys $star]
        foreach mode {2 3} {*jacobian_calculate_cornerpts $mode;foreach {id q} [hm_getelemcheckvalues 1 3 jacobian] {if {$q<=0} {error "Invalid high-order Jacobian"}}}
    } reason]
    *jacobian_calculate_cornerpts $jm
    if {$rc} {
        set restore [catch {::TetCollapseFix::writeCoords [::TetCollapseFix::subset $xyz [dict keys $weights]]} restoreReason]
        if {$restore || ![::TetCollapseFix::sameDict $xyz [::TetCollapseFix::coords [dict keys $xyz]]]} {set ::TetCollapseFix::recoveryRequired 1;error "Shared-node restore failed"}
        puts "TANGENT_REJECT=$reason";return 0
    }
    puts "TANGENT_SUCCESS=$seed $corner [dict keys $groups] [::TetCollapseFix::quality [list $seed]]"
    return 1
}
proc ::Tangent::basis {normals} {
    set orthogonal {}
    foreach normal $normals {
        set vector $normal
        foreach axis $orthogonal {
            set projection [dot $vector $axis];set next {}
            foreach x $vector a $axis {lappend next [expr {$x-$projection*$a}]};set vector $next
        }
        set length [norm $vector]
        if {$length>1e-8} {set unit {};foreach value $vector {lappend unit [expr {$value/$length}]};lappend orthogonal $unit}
    }
    if {[llength $orthogonal]==1} {
        set normal [lindex $orthogonal 0];set least 2;set choice {1 0 0}
        foreach axis {{1 0 0} {0 1 0} {0 0 1}} {
            set value [expr {abs([dot $normal $axis])}]
            if {$value<$least} {set least $value;set choice $axis}
        }
        set vector [cross $normal $choice];set length [norm $vector];set first {}
        foreach value $vector {lappend first [expr {$value/$length}]}
        return [list $first [cross $normal $first]]
    }
    if {[llength $orthogonal]==2} {
        set vector [cross [lindex $orthogonal 0] [lindex $orthogonal 1]];set length [norm $vector];set unit {}
        foreach value $vector {lappend unit [expr {$value/$length}]};return [list $unit]
    }
    return {}
}
proc ::Tangent::allowed {prepared corner delta} {
    set scale [dict get $prepared scale];set tolerance [expr {1e-9*$scale}]
    foreach normal [dict get $prepared normals] {if {abs([dot $normal $delta])>$tolerance} {return 0}}
    set origin [dict get $prepared xyz $corner];set point {}
    foreach x $origin d $delta {lappend point [expr {$x+$d}]}
    foreach interval [dict get $prepared intervals] {
        lassign $interval a b
        if {[dot [sub $point $a] [sub $point $b]]>$tolerance*$scale} {return 0}
    }
    return 1
}
proc ::Tangent::repair {seed} {
    set selected [::TetCollapseFix::elements [list $seed]]
    if {![dict exists $selected $seed]} {return 0}
    if {![llength [::TetCollapseFix::failed [::TetCollapseFix::quality [list $seed]]]]} {return 1}
    set threshold $::TetCollapseFix::threshold
    foreach corner [lrange [lindex [dict get $selected $seed] 2] 0 3] {
        if {[catch {prepare $seed $corner} prepared]} {puts "TANGENT_SKIP=$corner $prepared";continue}
        set axes [basis [dict get $prepared normals]]
        if {![llength $axes]} {continue}
        set directions {}
        if {[llength $axes]==1} {set choices {{-1} {1}}} else {set choices {{-1 -1} {-1 0} {-1 1} {0 -1} {0 1} {1 -1} {1 0} {1 1}}}
        foreach choice $choices {
            set vector {0 0 0}
            foreach coefficient $choice axis $axes {
                set next {};foreach x $vector a $axis {lappend next [expr {$x+$coefficient*$a}]};set vector $next
            }
            lappend directions $vector
        }
        set star [dict get $prepared star];set xyz [dict get $prepared xyz];set weights [dict get $prepared weights];set floors {}
        dict for {id row} $star {dict set floors $id [expr {min($threshold+0.0001,[::TetCollapseFix::qscore [dict create $id $row] $xyz])}]}
        set delta {0 0 0};set best [::TetCollapseFix::seedScore $star $seed $floors $xyz];set step [expr {.02*[dict get $prepared scale]}]
        for {set iteration 0} {$iteration<60 && $step>1e-6} {incr iteration} {
            set found 0;set chosen $delta
            foreach direction $directions {
                set candidate {};foreach x $delta d $direction {lappend candidate [expr {$x+$step*$d}]}
                if {![allowed $prepared $corner $candidate]} {continue}
                set score [::TetCollapseFix::seedScore $star $seed $floors [::TetCollapseFix::displaced $xyz $weights $candidate]]
                if {$score>$best+1e-8} {set best $score;set chosen $candidate;set found 1}
            }
            set delta $chosen
            if {!$found} {set step [expr {$step*.5}]}
            if {$best>$threshold+.01} {break}
        }
        puts "TANGENT_SEARCH=$seed $corner $best $delta"
        if {$best<$threshold+.0001} {continue}
        if {[trial $seed $corner $delta $prepared]} {
            set ::Tangent::affectedIds [dict keys $star]
            return 1
        }
    }
    return 0
}

proc ::TetCollapseFix::applyCore {selection} {
    variable recoveryRequired
    version
    if {$recoveryRequired} {error "Recovery required"}
    validateThreshold
    if {![llength $selection]} {error "Select at least one element."}
    set chosen [elements $selection]
    if {[dict size $chosen] != [llength $selection]} {error "Selection contains missing element IDs. Select again."}
    dict for {id row} $chosen {if {[lindex $row 0] ni {204 210}} {error "Element $id is not Tet4 / Tet10."}}
    set ::TetCollapseFix::replaced {}
    set left {}; set solved 0
    log "Processing [llength $selection] selected elements..."
    foreach id $selection {
        if {[dict exists $::TetCollapseFix::replaced $id]} {incr solved; continue}
        if {[repairInside $id] || [::Tangent::repair $id] || [collapseCavity $id] || [repairFlip $id]} {incr solved} else {lappend left $id}
    }
    if {![llength $left]} {return {}}
    set rc [catch {remeshCore $left} remaining]
    if {$rc && !$recoveryRequired} {
        set remaining [sharedRefine $left]
        set rc 0
    }
    if {$rc} {
        if {$recoveryRequired || !$solved} {error $remaining}
        puts "TCF remesh detail: $remaining"
        log "[llength $left] elements could not be repaired."
        return $left
    }
    return $remaining
}


proc ::TetCollapseFix::validateThreshold {} {
    variable threshold
    if {![string is double -strict $threshold] || [catch {expr {$threshold>0 && $threshold<1}} ok] || !$ok} {
        error "Invalid collapse threshold"
    }
}
proc ::TetCollapseFix::setBusy {value} {
    variable busy; set busy $value
    if {![winfo exists .tcf]} {return}
    foreach w {.tcf.select .tcf.apply .tcf.ids .tcf.threshold} {
        $w configure -state [expr {$value ? "disabled" : "normal"}]
    }
    update idletasks
}
proc ::TetCollapseFix::readInput {} {
    variable input
    validateThreshold
    set ids {}
    foreach s [split [string map {, " " ; " " \n " " \t " "} $input] " "] {
        if {$s eq {}} {continue}
        if {![string is integer -strict $s] || $s<=0} {error "Invalid element ID"}
        lappend ids $s
    }
    return [lsort -integer -unique $ids]
}
proc ::TetCollapseFix::friendly {err} {
    switch -glob -- $err {
        "Select at least*" {return "Select at least one element."}
        "Invalid collapse threshold*" {return "Tet Collapse must be a number greater than 0 and less than 1."}
        "Invalid element ID*" {return "Enter numeric IDs separated by spaces or commas."}
        "Selection contains*" {return "Some element IDs no longer exist. Select again."}
        "Selected elements already*" {return "Selected elements already meet the entered threshold."}
        "*not Tet4*" {return "Select Tet4 or Tet10 elements only."}
        "Component *mixes*" {return "Mixed Tet4/Tet10 components are not supported yet."}
        "Patch exceeds*" {return "The repair area is too large. Select fewer elements."}
        "Patch is referenced*" {return "These elements are used by a set, load or other connection. Replacement is blocked."}
        "No reduction*" {return "No improvement"}
        "Recovery required*" {return "Undo could not be confirmed. Stop and inspect the model before saving."}
        "This prototype requires*" {return "This tool requires HyperMesh 2022."}
        default {return "No improvement"}
    }
}
proc ::TetCollapseFix::select {} {
    variable input; variable status; variable result
    if {$::TetCollapseFix::busy} {return}
    setBusy 1
    pin
    set rc [catch {*createmarkpanel elems 1 "Select Tet4 / Tet10 elements"; set picked [hm_getmark elems 1]} err]
    setBusy 0
    pin
    if {$rc} {set status [friendly $err]; puts "TCF: $err"; return}
    set input $picked; set result "Not checked"
    resetStats
    set checked $picked; set ::TetCollapseFix::checked $picked
    if {[llength $picked] && [catch {readback} detail]} {set ::TetCollapseFix::qualityValue "Unavailable"; puts "TCF readback: $detail"}
    set status "[llength $picked] elements selected. Click Proceed."
}
proc ::TetCollapseFix::pin {} {
    variable topmost
    if {[winfo exists .tcf]} {wm attributes .tcf -topmost $topmost}
}
proc ::TetCollapseFix::resetStats {} {
    variable qualityValue; set qualityValue "--"
}
proc ::TetCollapseFix::readback {} {
    variable checked; variable threshold; variable result; variable recoveryRequired
    if {$recoveryRequired} {set result "Verification failed"; set ::TetCollapseFix::qualityValue "Unverified"; return}
    set actual [dict keys [elements [lsort -integer -unique $checked]]]
    if {![llength $actual]} {set result "No elements checked"; set ::TetCollapseFix::qualityValue "--"; return}
    set values [quality $actual]; set minimum 1.0
    foreach {id q} $values {if {$q<$minimum} {set minimum $q}}
    set ::TetCollapseFix::qualityValue [format %.6f $minimum]
    set result "Min: [format %.6f $minimum] | Below $threshold: [llength [failed $values]] / [llength $actual]"
}
proc ::TetCollapseFix::action {{which apply}} {
    variable busy; variable status; variable input; variable logText; variable checked; variable result
    if {$busy} {return}
    set logText {}; set result "Checking..."; set checked {}; resetStats
    set status "Processing..."; setBusy 1
    set selection {}; set valid 0
    set rc [catch {
        set selection [readInput]; set valid 1; set checked $selection
        set input [applyCore $selection]
        if {[llength $input]} {
            set status "No improvement"
        } else {set status "Completed"}
    } err]
    if {$rc} {puts "TCF detail: $err"; set status [friendly $err]}
    if {$valid && [llength $selection]} {
        if {$rc} {set checked [lsort -integer -unique [concat $checked $selection]]}
        if {[catch {readback} detail]} {set result "Check unavailable"; set ::TetCollapseFix::qualityValue "Unavailable"; puts "TCF readback: $detail"}
    } else {set result "Not checked"}
    setBusy 0
}
proc ::TetCollapseFix::close {} {variable busy; if {!$busy} {destroy .tcf}}


proc ::TetCollapseFix::show {} {
    package require Tk
    if {[winfo exists .tcf]} {destroy .tcf}
    toplevel .tcf; wm title .tcf "Tet Collapse | HM2022"
    wm geometry .tcf 540x185; wm minsize .tcf 540 185
    wm protocol .tcf WM_DELETE_WINDOW ::TetCollapseFix::close
    ttk::label .tcf.idlabel -text "Elements"
    ttk::entry .tcf.ids -textvariable ::TetCollapseFix::input
    ttk::button .tcf.select -text "Select..." -width 14 -command ::TetCollapseFix::select
    ttk::label .tcf.tlabel -text "Tet Collapse <"
    ttk::entry .tcf.threshold -textvariable ::TetCollapseFix::threshold
    ttk::button .tcf.apply -text "Proceed" -width 14 -command ::TetCollapseFix::action
    ttk::checkbutton .tcf.ontop -text "Always on top" -variable ::TetCollapseFix::topmost -command ::TetCollapseFix::pin
    ttk::label .tcf.qlabel -text "Tet Collapse"
    ttk::entry .tcf.quality -textvariable ::TetCollapseFix::qualityValue -state readonly
    ttk::label .tcf.status -textvariable ::TetCollapseFix::status -wraplength 512 -anchor nw -justify left
    grid .tcf.idlabel -row 0 -column 0 -sticky w -padx {12 8} -pady {12 3}
    grid .tcf.ids -row 0 -column 1 -sticky nsew -padx {0 8} -pady {12 3}
    grid .tcf.select -row 0 -column 2 -sticky nsew -padx {0 12} -pady {12 3}
    grid .tcf.tlabel -row 1 -column 0 -sticky w -padx {12 8} -pady 3
    grid .tcf.threshold -row 1 -column 1 -sticky nsew -padx {0 8} -pady 3
    grid .tcf.apply -row 1 -column 2 -sticky nsew -padx {0 12} -pady 3
    grid .tcf.ontop -row 2 -column 2 -sticky w -padx {0 12} -pady 2
    grid .tcf.qlabel -row 3 -column 0 -sticky w -padx {12 8} -pady 3
    grid .tcf.quality -row 3 -column 1 -columnspan 2 -sticky ew -padx {0 12} -pady 3
    grid .tcf.status -row 4 -column 0 -columnspan 3 -sticky nw -padx 12 -pady {7 8}
    grid columnconfigure .tcf 1 -weight 1
    pin
}
if {![info exists ::TetCollapseFix_no_gui] || !$::TetCollapseFix_no_gui} {::TetCollapseFix::show}
