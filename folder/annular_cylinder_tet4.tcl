namespace eval ::AnnularCylinder {
    variable node ""
    variable axis X
    variable width 14.9
    variable nw 6
    variable wr ""
    variable diameter 45.0
    variable sectors 32
    variable autoRenumber 0
    variable startId ""
    variable increment 1
    variable nodesPerSection 8
    variable specialBearingIndex ""
    variable specialStartId 40001
    variable lastBearingNodeRings {}
    variable status "Select center nodes, then Create."
    variable statusTone neutral
    variable busy 0
    variable topmost
    if {![info exists topmost]} {set topmost 1}
    variable highWater
    if {![info exists highWater]} {set highWater {}}
}
proc ::AnnularCylinder::positive {value label} {
    if {![string is double -strict $value]} {error "$label must be a positive number."}
    if {[catch {expr {double($value)>0 && double($value)<1e100}} ok] || !$ok} {
        error "$label must be finite and positive."
    }
    return [expr {double($value)}]
}
proc ::AnnularCylinder::levels {total count ratios label} {
    set total [positive $total $label]
    set ratios [string trim $ratios]
    if {$ratios ne ""} {
        set weights [split $ratios :]
        set count [llength $weights]
    } else {
        if {![string is integer -strict $count] || $count<1 || $count>1000} {
            error "$label layers must be an integer from 1 to 1000."
        }
        set weights [lrepeat $count 1.0]
    }
    if {$count>1000} {error "$label has too many layers."}
    set sum 0.0
    foreach w $weights {set sum [expr {$sum+[positive [string trim $w] "$label ratio"]}]}
    set result {0.0}; set acc 0.0
    foreach w $weights {
        set acc [expr {$acc+double([string trim $w])}]
        lappend result [expr {$total*($acc/$sum)}]
    }
    return $result
}
proc ::AnnularCylinder::geometry {center axis width wl diameter ns} {
    if {$axis ni {X Y Z}} {error "Select X, Y or Z."}
    if {![string is integer -strict $ns] || $ns<3 || $ns>720} {error "Circumference segments must be 3 to 720."}
    set radius [expr {[positive $diameter Diameter]/2.0}]
    set nw [expr {[llength $wl]-1}]
    set expected [expr {2*$nw*$ns}]
    if {$expected>250000} {error "Mesh exceeds 250000 TRIA3. Reduce axial layers/segments."}
    foreach {ox oy oz} $center break
    set points {}
    foreach w $wl {
        set axial [expr {$w-$width/2.0}]
        for {set j 0} {$j<$ns} {incr j} {
            set a [expr {2.0*acos(-1.0)*$j/$ns}]
            set u [expr {$radius*cos($a)}]; set v [expr {$radius*sin($a)}]
            switch $axis {
                X {lappend points [list [expr {$ox+$axial}] [expr {$oy+$u}] [expr {$oz+$v}]]}
                Y {lappend points [list [expr {$ox+$v}] [expr {$oy+$axial}] [expr {$oz+$u}]]}
                Z {lappend points [list [expr {$ox+$u}] [expr {$oy+$v}] [expr {$oz+$axial}]]}
            }
        }
    }
    set trias {}
    for {set layer 0} {$layer<$nw} {incr layer} {
        set lo [expr {$layer*$ns}]; set hi [expr {$lo+$ns}]
        for {set j 0} {$j<$ns} {incr j} {
            set k [expr {($j+1)%$ns}]
            set a [expr {$lo+$j}]; set b [expr {$lo+$k}]
            set A [expr {$hi+$j}]; set B [expr {$hi+$k}]
            lappend trias [list $a $b $A] [list $b $B $A]
        }
    }
    foreach tria $trias {
        foreach {a b c} $tria break
        set facing [triaNormalDotRadial [lindex $points $a] [lindex $points $b] [lindex $points $c] $center $axis]
        if {$facing<=0} {error "Degenerate or inward-facing TRIA3; check dimensions and axis."}
    }
    return [list $points $trias]
}
proc ::AnnularCylinder::triaNormalDotRadial {p q r center axis} {
    foreach {px py pz} $p break; foreach {qx qy qz} $q break; foreach {rx ry rz} $r break
    set ux [expr {$qx-$px}]; set uy [expr {$qy-$py}]; set uz [expr {$qz-$pz}]
    set vx [expr {$rx-$px}]; set vy [expr {$ry-$py}]; set vz [expr {$rz-$pz}]
    set nx [expr {$uy*$vz-$uz*$vy}]; set ny [expr {$uz*$vx-$ux*$vz}]; set nz [expr {$ux*$vy-$uy*$vx}]
    foreach {cx cy cz} $center break
    set mx [expr {($px+$qx+$rx)/3.0-$cx}]; set my [expr {($py+$qy+$ry)/3.0-$cy}]; set mz [expr {($pz+$qz+$rz)/3.0-$cz}]
    switch $axis {
        X {return [expr {$ny*$my+$nz*$mz}]}
        Y {return [expr {$nx*$mx+$nz*$mz}]}
        Z {return [expr {$nx*$mx+$ny*$my}]}
    }
}
proc ::AnnularCylinder::targetIds {start count step} {
    if {![string is integer -strict $count] || $count<0} {error "Renumber node count cannot be negative."}
    if {![string is integer -strict $step] || $step<1} {error "Increment must be a positive integer."}
    if {$count==0} {return {}}
    if {![string is integer -strict $start] || $start<1} {error "Start ID must be a positive integer."}
    if {$start+($count-1)*$step>2147483647} {error "Generated target IDs exceed the node ID limit."}
    set result {}
    for {set i 0} {$i<$count} {incr i} {lappend result [expr {$start+$i*$step}]}
    return $result
}
proc ::AnnularCylinder::bearingRingOrder {axis sectors nodesPerSection} {
    if {![string is integer -strict $nodesPerSection] || $nodesPerSection<1 || $nodesPerSection>$sectors} {
        error "Nodes per section must be an integer from 1 to the segment count."
    }
    if {$sectors%$nodesPerSection!=0} {
        error "Circumference segments must be divisible by Nodes per section."
    }
    switch $axis {
        X {set start [expr {$sectors/4}]; set step 1}
        Y {set start 0; set step 1}
        Z {set start [expr {$sectors/4}]; set step -1}
        default {error "Select X, Y or Z."}
    }
    set result {}
    set spacing [expr {$sectors/$nodesPerSection}]
    for {set n 0} {$n<$nodesPerSection} {incr n} {lappend result [expr {($start+$step*$n*$spacing+$sectors)%$sectors}]}
    return $result
}
proc ::AnnularCylinder::showBearingNodeIds {} {
    variable lastBearingNodeRings; variable status
    if {![llength $lastBearingNodeRings]} {
        set status "Create a bearing mesh first; there are no bearing node IDs to show."
        tone error
        return
    }
    set ids {}
    foreach rings $lastBearingNodeRings {foreach ring $rings {foreach id $ring {lappend ids $id}}}
    if {[catch {
        *numbersclear
        *clearmark nodes 1
        eval *createmark nodes 1 $ids
        *numbersmark nodes 1 1
        hm_highlightmark nodes 1 highlight
    } msg]} {
        set status "Could not display bearing node IDs: $msg"
        tone error
        return
    }
    set lines {}; set bearing 0
    foreach rings $lastBearingNodeRings {
        incr bearing
        set layer 0
        foreach ring $rings {
            incr layer
            lappend lines "Bearing $bearing / ring $layer: [join $ring {, }]"
        }
    }
    set status "Displayed [llength $ids] bearing node IDs across [llength $lastBearingNodeRings] bearing(s)."
    tone success
    tk_messageBox -parent .annularCylinder -title "Bearing node IDs" -message [join $lines "\n"]
}
proc ::AnnularCylinder::renumberControls {} {
    variable autoRenumber
    set state [expr {$autoRenumber ? "normal" : "disabled"}]
    foreach w {.annularCylinder.form.nodesPerSection .annularCylinder.form.startId .annularCylinder.form.increment .annularCylinder.form.specialStart} {catch {$w configure -state $state}}
    catch {.annularCylinder.form.specialBearing configure -state [expr {$autoRenumber ? "readonly" : "disabled"}]}
}
proc ::AnnularCylinder::updateBearingOrders {name1 name2 op} {
    variable node; variable specialBearingIndex
    set values {}
    if {![catch {set ids [nodeIds $node]}]} {
        for {set i 1} {$i<=[llength $ids]} {incr i} {lappend values $i}
    }
    if {$specialBearingIndex ne "" && (![string is integer -strict $specialBearingIndex] || $specialBearingIndex<1 || $specialBearingIndex>[llength $values])} {
        set specialBearingIndex ""
    }
    catch {.annularCylinder.form.specialBearing configure -values $values}
}
proc ::AnnularCylinder::nodeIds {input} {
    set ids {}; set seen {}
    foreach token [regexp -all -inline {\S+} [string map {, " "} $input]] {
        if {![regexp {^[0-9]+$} $token]} {error "Node IDs must be positive integers, separated by spaces or commas."}
        scan $token %d id
        if {$id<1} {error "Node IDs must be positive integers."}
        if {![dict exists $seen $id]} {dict set seen $id 1; lappend ids $id}
    }
    if {![llength $ids]} {error "Enter/select at least one center node."}
    return $ids
}
proc ::AnnularCylinder::sortCenterIds {ids centers axis} {
    set rows {}
    foreach id $ids {
        set x [dict get $centers $id x]; set y [dict get $centers $id y]; set z [dict get $centers $id z]
        switch $axis {
            X {set row [list $x $y $z $id]}
            Y {set row [list $y $x $z $id]}
            Z {set row [list $z $x $y $id]}
            default {error "Select X, Y or Z before sorting center nodes."}
        }
        lappend rows $row
    }
    set sorted [lsort -command ::AnnularCylinder::compareCenterRows $rows]
    set result {}
    foreach row $sorted {lappend result [lindex $row 3]}
    return $result
}
proc ::AnnularCylinder::compareCenterRows {a b} {
    foreach va [lrange $a 0 2] vb [lrange $b 0 2] {
        if {double($va)<double($vb)} {return -1}
        if {double($va)>double($vb)} {return 1}
    }
    set idA [lindex $a 3]; set idB [lindex $b 3]
    if {$idA<$idB} {return -1}
    if {$idA>$idB} {return 1}
    return 0
}
proc ::AnnularCylinder::pick {} {
    variable node; variable axis; variable status; variable busy
    if {$busy} {return}
    tone neutral
    if {[catch {
        *createmarkpanel nodes 1 "Select center node(s)"
        set ids [hm_getmark nodes 1]
        if {[llength $ids]} {
            set picked [nodeIds $ids]
            set centers [bulk nodes $picked {x y z}]
            set picked [sortCenterIds $picked $centers $axis]
            set node [join $picked " "]
            set status "Selected [llength $picked] center node(s), sorted by $axis coordinate."
        } else {set status "Selection unchanged."}
    } msg]} {set status $msg; tone error}
}
proc ::AnnularCylinder::bulk {type ids fields} {
    set rows {}
    for {set offset 0} {$offset<[llength $ids]} {incr offset 1024} {
        set chunk [lrange $ids $offset [expr {$offset+1023}]]
        set returned [hm_getvalue $type user_ids=$chunk dataname=id]
        if {[lsort -integer $returned] ne [lsort -integer $chunk]} {error "Bulk $type ID readback mismatch."}
        foreach field $fields {
            set values [hm_getvalue $type user_ids=$chunk dataname=$field]
            if {[llength $values]!=[llength $returned]} {error "Bulk $type $field length mismatch."}
            foreach id $returned value $values {dict set rows $id $field $value}
        }
    }
    return $rows
}
proc ::AnnularCylinder::reserve {type count} {
    variable highWater
    set last [hm_entitymaxid $type]
    if {[dict exists $highWater $type]} {set last [expr {max($last,[dict get $highWater $type])}]}
    set end [expr {$last+$count}]
    if {$end>2147483647} {error "Entity ID limit reached for $type."}
    dict set highWater $type $end
    return $last
}
proc ::AnnularCylinder::controls {state} {
    foreach widget {.annularCylinder.buttons.create .annularCylinder.buttons.close .annularCylinder.form.pick} {catch {$widget configure -state $state}}
}
proc ::AnnularCylinder::applyTopmost {} {
    variable topmost
    if {[winfo exists .annularCylinder]} {wm attributes .annularCylinder -topmost $topmost}
}
proc ::AnnularCylinder::tone {value} {
    variable statusTone
    set statusTone $value; set color #333333
    if {$value eq "success"} {set color #16723A}
    if {$value eq "error"} {set color #B42318}
    catch {.annularCylinder.status configure -foreground $color}
}
proc ::AnnularCylinder::create {} {
    variable node; variable axis; variable width; variable nw; variable wr
    variable diameter; variable sectors; variable status; variable busy
    variable autoRenumber; variable startId; variable increment; variable nodesPerSection; variable specialBearingIndex; variable specialStartId
    if {$busy} {return}
    set busy 1; controls disabled; tone neutral; set started [clock milliseconds]
    if {[catch {
        set centerIds [nodeIds $node]
        set wl [levels $width $nw $wr Width]
        set diameter [positive $diameter Diameter]
        set nw [expr {[llength $wl]-1}]
        if {![string is integer -strict $sectors] || $sectors<3 || $sectors>720} {error "Circumference segments must be 3 to 720."}
        if {2*$nw*$sectors*[llength $centerIds]>250000} {error "Combined mesh exceeds 250000 TRIA3. Reduce nodes/axial layers/segments."}
        set centers [bulk nodes $centerIds {x y z}]
        set centerIds [sortCenterIds $centerIds $centers $axis]
        set node [join $centerIds " "]
        set points {}; set trias {}; set chunks {}; set triaCenters {}
        foreach centerId $centerIds {
            set center {}; foreach field {x y z} {lappend center [dict get $centers $centerId $field]}
            foreach {localPoints localTrias} [geometry $center $axis $width $wl $diameter $sectors] break
            set offset [llength $points]; set firstTria [llength $trias]
            foreach p $localPoints {lappend points $p}
            foreach tria $localTrias {
                set globalTria {}; foreach index $tria {lappend globalTria [expr {$offset+$index}]}
                lappend trias $globalTria; lappend triaCenters $center
            }
            lappend chunks [list $centerId $firstTria [llength $localTrias]]
        }
        set renumberPlan {}; set targets {}
        set ringOrder [bearingRingOrder $axis $sectors $nodesPerSection]
        set ringNodes $sectors
        set planes [llength $wl]
        set orderedRings {}
        set bearingOffset 0
        foreach chunk $chunks {
            set pointOffset [expr {$bearingOffset*$planes*$ringNodes}]
            set bearingRings {}
            for {set plane 0} {$plane<$planes} {incr plane} {
                set ringIndexes {}
                foreach sector $ringOrder {
                    set index [expr {$pointOffset+$plane*$ringNodes+$sector}]
                    lappend ringIndexes $index
                }
                lappend bearingRings $ringIndexes
            }
            lappend orderedRings $bearingRings
            incr bearingOffset
        }
        if {$autoRenumber} {
            if {![string is integer -strict $increment] || $increment<1} {error "Increment must be a positive integer."}
            set specialIndex -1
            if {[string trim $specialBearingIndex] ne ""} {
                if {![string is integer -strict $specialBearingIndex] || $specialBearingIndex<1 || $specialBearingIndex>[llength $centerIds]} {
                    error "Special bearing order must be between 1 and [llength $centerIds]."
                }
                set specialIndex [expr {$specialBearingIndex-1}]
                set specialCount [expr {2*$nodesPerSection}]
                if {![string is integer -strict $specialStartId] || $specialStartId<1 || $specialStartId+$specialCount-1>2147483647} {
                    error "Special start ID must have room for [expr {2*$nodesPerSection}] consecutive IDs."
                }
            }
            set required [expr {[llength $centerIds]*$planes*$nodesPerSection}]
            set mainCount [expr {$required-($specialIndex>=0 ? 2*$nodesPerSection : 0)}]
            if {$mainCount<0} {error "The special bearing requires at least two axial sections."}
            if {$mainCount>0 && (![string is integer -strict $startId] || $startId<1)} {error "Start ID must be a positive integer."}
            set mainTargets [targetIds $startId $mainCount $increment]
            set mainCursor 0; set specialCursor 0; set usedTargets {}; set bearingIndex 0
            foreach bearingRings $orderedRings {
                set planeIndex 0
                foreach ringIndexes $bearingRings {
                    set isSpecialEnd [expr {$bearingIndex==$specialIndex && ($planeIndex==0 || $planeIndex==[llength $bearingRings]-1)}]
                    if {$isSpecialEnd} {
                        set targetRingStart [expr {$specialStartId+$specialCursor}]
                        set ringTargets [targetIds $targetRingStart $nodesPerSection 1]
                        incr specialCursor $nodesPerSection
                    } else {
                        set ringTargets [lrange $mainTargets $mainCursor [expr {$mainCursor+$nodesPerSection-1}]]
                        incr mainCursor $nodesPerSection
                    }
                    foreach row $ringIndexes target $ringTargets {
                        if {[dict exists $usedTargets $target]} {error "Renumber target ID $target is assigned more than once."}
                        dict set usedTargets $target 1
                        if {[hm_entityinfo exist nodes $target -byid]} {error "Renumber target node $target already exists."}
                        lappend renumberPlan [list $row $target]
                    }
                    incr planeIndex
                }
                incr bearingIndex
            }
            if {$mainCursor!=$mainCount || ($specialIndex>=0 && $specialCursor!=2*$nodesPerSection)} {error "Internal renumber plan length mismatch."}
            set targets [dict keys $usedTargets]
        }
    } msg]} {
        set busy 0; controls normal; set status $msg; tone error
        tk_messageBox -parent .annularCylinder -icon error -message $msg; return
    }
    set name "CylinderTria3_[clock clicks]"; set cids {}; set pids {}; set ids {}; set elementIds {}; set componentRows {}
    set old ""
    catch {set previous [hm_info currentcollector component]; if {[string is integer -strict $previous]} {if {$previous>0} {set old [hm_getvalue comps id=$previous dataname=name]}} else {set old $previous}}
    set asciiFile ""; set asciiHandle ""; set savedOptions {}; set stage "creating component"
    set code [catch {
        foreach {option value} {command_file_state 0 block_redraw 1} {if {![catch {hm_getoption $option} previousOption]} {if {![catch {*setoption $option=$value}]} {lappend savedOptions $option $previousOption}}}
        set nextComponent [reserve comps [llength $chunks]]
        if {[llength $targets]} {variable highWater; set largest [lindex [lsort -integer $targets] end]; set previousHigh 0; if {[dict exists $highWater nodes]} {set previousHigh [dict get $highWater nodes]}; dict set highWater nodes [expr {max($largest,[hm_entitymaxid nodes],$previousHigh)}]}
        set nextNode [reserve nodes [llength $points]]; set nextElement [reserve elems [llength $trias]]; set nextProperty [reserve props [llength $chunks]]
        foreach target $targets {if {$target>$nextNode && $target<=$nextNode+[llength $points]} {error "Renumber target node $target overlaps a generated node ID."}}
        set asciiFile [file join $::env(TEMP) "${name}_[pid].hmascii"]; set asciiHandle [open $asciiFile {WRONLY CREAT EXCL}]
        fconfigure $asciiHandle -encoding ascii -translation lf -buffering full
        puts $asciiHandle {*filetype(ASCII)}
        puts $asciiHandle {*version(10.0build60)}
        puts $asciiHandle {BEGIN NODES}
        foreach p $points {
            foreach {x y z} $p break
            set nid [incr nextNode]; lappend ids $nid
            puts $asciiHandle "*node($nid,$x,$y,$z,0,0,0,0,0)"
        }
        puts $asciiHandle {END NODES}
        puts $asciiHandle {BEGIN COMPONENTS}
        foreach chunk $chunks {
            foreach {centerId firstTria triaCount} $chunk break
            set cid [incr nextComponent]; set componentName "TRIA3_$cid"
            if {[hm_entityinfo exist comps $componentName -byname]} {error "Component name $componentName already exists."}
            lappend cids $cid
            puts $asciiHandle "*component($cid,\"$componentName\",0,11,0)"
            set componentElements {}
            foreach tria [lrange $trias $firstTria [expr {$firstTria+$triaCount-1}]] {
                set connectivity {}
                foreach index $tria {lappend connectivity [lindex $ids $index]}
                set eid [incr nextElement]; lappend elementIds $eid; lappend componentElements $eid
                puts $asciiHandle "*tria3($eid,1,[join $connectivity ,],0)"
            }
            lappend componentRows [list $cid $componentName $componentElements]
        }
        puts $asciiHandle {END COMPONENTS}
        puts $asciiHandle {END DATA}
        close $asciiHandle; set asciiHandle ""; *createstringarray 0
        *feinputwithdata2 "#hmascii/hmascii" $asciiFile 0 0 0 0 0 1 0 1 0
        set stage "creating PSHELL properties"
        foreach row $componentRows {
            foreach {cid componentName expectedElements} $row break; set pid [incr nextProperty]; set propertyName "PSHELL_$pid"
            if {[hm_entityinfo exist props $propertyName -byname]} {error "Property name $propertyName already exists."}
            lappend pids $pid; *createentity props id=$pid cardimage=PSHELL name=$propertyName; *setvalue comps id=$cid propertyid=$pid
            if {[hm_getvalue comps id=$cid dataname=propertyid]!=$pid || [hm_getvalue props id=$pid dataname=name] ne $propertyName || [hm_getvalue props id=$pid dataname=cardimage] ne "PSHELL" || [hm_getvalue props id=$pid dataname=materialid]!=0} {error "Component -> PSHELL -> blank MID readback failed."}
        }
        set actual {}
        foreach row $componentRows {
            foreach {cid componentName expectedElements} $row break
            if {[hm_getvalue comps id=$cid dataname=name] ne $componentName} {error "Component name readback failed."}
            *createmark elems 1 "by collector id" $cid; set got [hm_getmark elems 1]
            if {[lsort -integer $got] ne [lsort -integer $expectedElements]} {error "Component $componentName element membership mismatch."}
            foreach eid $got {lappend actual $eid}
        }
        if {[llength $actual]!=[llength $trias]} {error "Created element count does not match."}
        set nodeRows [bulk nodes $ids {x y z}]; set readCoordinates {}
        foreach nid $ids expectedPoint $points {
            set actualPoint {}; foreach field {x y z} target $expectedPoint {set value [dict get $nodeRows $nid $field]; if {abs($value-$target)>1e-10*max(1.0,abs($target))} {error "Node $nid coordinate readback failed."}; lappend actualPoint $value}; dict set readCoordinates $nid $actualPoint
        }
        set elementRows [bulk elems $elementIds {config node1.id node2.id node3.id}]
        foreach eid $elementIds tria $trias center $triaCenters {
            if {[dict get $elementRows $eid config]!=103} {error "Non-TRIA3 detected."}
            set wanted {}; set received {}; set readPoints {}; foreach local $tria {lappend wanted [lindex $ids $local]}
            foreach slot {1 2 3} {set nid [dict get $elementRows $eid node$slot.id]; lappend received $nid; if {![dict exists $readCoordinates $nid]} {error "TRIA3 references unexpected node."}; lappend readPoints [dict get $readCoordinates $nid]}
            if {[lsort -integer $received] ne [lsort -integer $wanted]} {error "TRIA3 $eid connectivity readback failed."}
            if {[triaNormalDotRadial {*}$readPoints $center $axis]<=0} {error "TRIA3 $eid has nonpositive area or inward normal."}
        }
        if {[llength $renumberPlan]} {
            set stage "renumbering bearing nodes"
            foreach pair $renumberPlan {foreach {index target} $pair break; set source [lindex $ids $index]; *createmark nodes 1 $source; set renameCode [catch {*renumber nodes 1 $target 1 0 0} renameError]; if {[hm_entityinfo exist nodes $target -byid] && ![hm_entityinfo exist nodes $source -byid]} {lset ids $index $target}; if {$renameCode} {error $renameError}; if {[lindex $ids $index]!=$target} {error "Node renumber failed: $source -> $target."}}
            set renamedRows [bulk nodes $ids {x y z}]
            foreach nid $ids point $points {foreach field {x y z} wanted $point {if {abs([dict get $renamedRows $nid $field]-$wanted)>1e-10*max(1.0,abs($wanted))} {error "Renumber coordinate readback failed."}}}
            set renamedElements [bulk elems $elementIds {node1.id node2.id node3.id}]
            foreach eid $elementIds tria $trias {
                set expected {}; set received {}
                foreach index $tria {lappend expected [lindex $ids $index]}
                foreach slot {1 2 3} {lappend received [dict get $renamedElements $eid node$slot.id]}
                if {[lsort -integer $expected] ne [lsort -integer $received]} {error "Renumber TRIA3 connectivity readback failed."}
            }
        }
        set finalRings {}
        foreach bearingRings $orderedRings {
            set actualRings {}
            foreach indexes $bearingRings {
                set actualRing {}
                foreach index $indexes {lappend actualRing [lindex $ids $index]}
                lappend actualRings $actualRing
            }
            lappend finalRings $actualRings
        }
        set ::AnnularCylinder::lastBearingNodeRings $finalRings
        set ::AnnularCylinder::lastResult [dict create components $cids properties $pids centers $centerIds renamedCount [llength $renumberPlan] nodes $ids elements $elementIds rings $finalRings]
        tone success
        set status "Created [llength $cids] component(s), PSHELL: [llength $ids] nodes, [llength $actual] TRIA3, [llength $renumberPlan] renumbered ([format %.2f [expr {([clock milliseconds]-$started)/1000.0}]] s)."
    } msg]
    if {$asciiHandle ne ""} {catch {close $asciiHandle}}; if {$asciiFile ne ""} {catch {file delete -- $asciiFile}}
    foreach {option value} $savedOptions {catch {*setoption $option=$value}}; if {$old ne ""} {catch {*currentcollector components $old}}
    if {$code} {
        if {[string trim $msg] eq "" || [string is integer -strict $msg]} {set msg "Native command failed while $stage."}
        set cleanup {}; if {[llength $cids] && [catch {eval *createmark comps 1 $cids; *deletemark comps 1} e]} {lappend cleanup $e}
        if {[llength $pids] && [catch {eval *createmark props 1 $pids; *deletemark props 1} e]} {lappend cleanup $e}
        if {[llength $ids] && [catch {*clearlist nodes 1; eval *createmark nodes 1 $ids; *nodemarkcleartempmark 1} e]} {lappend cleanup $e}
        tone error; set status "Create failed: $msg"; if {[llength $cleanup]} {append status "\nCleanup incomplete ($name): $cleanup"}
        tk_messageBox -parent .annularCylinder -icon error -message $status
    }
    foreach type {elems comps props nodes} {catch {*clearmark $type 1}}; catch {*clearlist nodes 1}
    set busy 0; controls normal
}
proc ::AnnularCylinder::show {} {
    package require Tk
    if {[winfo exists .annularCylinder]} {destroy .annularCylinder}
    toplevel .annularCylinder; wm title .annularCylinder "Cylinder TRIA3 Mesher"; applyTopmost
    label .annularCylinder.status -textvariable ::AnnularCylinder::status -wraplength 570 -padx 14 -pady 9 -anchor w -justify left; tone $::AnnularCylinder::statusTone; pack .annularCylinder.status -fill x
    ttk::separator .annularCylinder.statusLine; pack .annularCylinder.statusLine -fill x
    ttk::frame .annularCylinder.form -padding {14 9}; pack .annularCylinder.form -fill both -expand 1; set f .annularCylinder.form
    ttk::checkbutton $f.topmost -text "Always on top" -variable ::AnnularCylinder::topmost -command ::AnnularCylinder::applyTopmost
    grid $f.topmost -row 0 -column 0 -columnspan 4 -sticky w -pady {0 5}
    ttk::label $f.nodeLabel -text "Center node IDs"; ttk::entry $f.node -textvariable ::AnnularCylinder::node
    ttk::button $f.pick -text "Select center" -command ::AnnularCylinder::pick
    grid $f.nodeLabel -row 1 -column 0 -sticky w -pady 4; grid $f.node -row 1 -column 1 -columnspan 2 -sticky ew -padx 8
    grid $f.pick -row 1 -column 3 -sticky e -padx {2 0}
    ttk::label $f.axisLabel -text "Cylinder axis"; ttk::frame $f.axes
    foreach a {X Y Z} {set w $f.axes.[string tolower $a]; ttk::radiobutton $w -text $a -value $a -variable ::AnnularCylinder::axis; pack $w -side left -padx 8}
    grid $f.axisLabel -row 2 -column 0 -sticky w -pady 4; grid $f.axes -row 2 -column 1 -columnspan 3 -sticky w
    ttk::separator $f.meshLine; grid $f.meshLine -row 3 -column 0 -columnspan 4 -sticky ew -pady 7
    ttk::label $f.widthLabel -text "Width"; ttk::entry $f.width -textvariable ::AnnularCylinder::width -width 14
    ttk::label $f.layersLabel -text "Layers"; ttk::entry $f.layers -textvariable ::AnnularCylinder::nw -width 8
    grid $f.widthLabel -row 4 -column 0 -sticky w -pady 4; grid $f.width -row 4 -column 1 -sticky ew -padx 8
    grid $f.layersLabel -row 4 -column 2 -sticky w -padx {6 0}; grid $f.layers -row 4 -column 3 -sticky ew -padx {8 0}
    ttk::label $f.ratiosLabel -text "Layer ratios"; ttk::entry $f.ratios -textvariable ::AnnularCylinder::wr -width 14
    grid $f.ratiosLabel -row 5 -column 0 -sticky w -pady 4; grid $f.ratios -row 5 -column 1 -sticky ew -padx 8
    ttk::label $f.diameterLabel -text "Diameter"; ttk::entry $f.diameter -textvariable ::AnnularCylinder::diameter -width 14
    ttk::label $f.segmentsLabel -text "Segments"; ttk::entry $f.segments -textvariable ::AnnularCylinder::sectors -width 8
    grid $f.diameterLabel -row 6 -column 0 -sticky w -pady 4; grid $f.diameter -row 6 -column 1 -sticky ew -padx 8
    grid $f.segmentsLabel -row 6 -column 2 -sticky w -padx {6 0}; grid $f.segments -row 6 -column 3 -sticky ew -padx {8 0}
    ttk::separator $f.renumberLine; grid $f.renumberLine -row 7 -column 0 -columnspan 4 -sticky ew -pady 7
    ttk::checkbutton $f.autoRenumber -text "Renumber bearing nodes" -variable ::AnnularCylinder::autoRenumber -command ::AnnularCylinder::renumberControls
    ttk::label $f.nodesPerSectionLabel -text "Nodes/section"; ttk::entry $f.nodesPerSection -textvariable ::AnnularCylinder::nodesPerSection -width 8
    grid $f.autoRenumber -row 8 -column 0 -columnspan 2 -sticky w -pady 2
    grid $f.nodesPerSectionLabel -row 8 -column 2 -sticky w -padx {6 0}; grid $f.nodesPerSection -row 8 -column 3 -sticky ew -padx {8 0}
    ttk::label $f.startLabel -text "Start ID"; ttk::entry $f.startId -textvariable ::AnnularCylinder::startId -width 14
    ttk::label $f.incrementLabel -text "Increment"; ttk::entry $f.increment -textvariable ::AnnularCylinder::increment -width 8
    grid $f.startLabel -row 9 -column 0 -sticky w -pady 4; grid $f.startId -row 9 -column 1 -sticky ew -padx 8
    grid $f.incrementLabel -row 9 -column 2 -sticky w -padx {6 0}; grid $f.increment -row 9 -column 3 -sticky ew -padx {8 0}
    ttk::label $f.specialBearingLabel -text "Bearing order"; ttk::combobox $f.specialBearing -textvariable ::AnnularCylinder::specialBearingIndex -state readonly -width 14
    ttk::label $f.specialStartLabel -text "Special start ID"; ttk::entry $f.specialStart -textvariable ::AnnularCylinder::specialStartId -width 12
    grid $f.specialBearingLabel -row 10 -column 0 -sticky w -pady 4; grid $f.specialBearing -row 10 -column 1 -sticky ew -padx 8
    grid $f.specialStartLabel -row 10 -column 2 -sticky w -padx {6 0}; grid $f.specialStart -row 10 -column 3 -sticky ew -padx {8 0}; updateBearingOrders node {} write; renumberControls
    grid columnconfigure $f 0 -minsize 128; grid columnconfigure $f 1 -minsize 145; grid columnconfigure $f 2 -minsize 115; grid columnconfigure $f 3 -minsize 92
    ttk::frame .annularCylinder.buttons -padding {14 0 14 9}; pack .annularCylinder.buttons -fill x
    ttk::button .annularCylinder.buttons.create -text Create -command ::AnnularCylinder::create
    ttk::button .annularCylinder.buttons.showIds -text "Show bearing node IDs" -command ::AnnularCylinder::showBearingNodeIds
    ttk::button .annularCylinder.buttons.close -text Close -command {destroy .annularCylinder}
    pack .annularCylinder.buttons.close -side right -padx {4 0}
    pack .annularCylinder.buttons.showIds .annularCylinder.buttons.create -side right -padx 4
    update idletasks
    set windowWidth [winfo reqwidth .annularCylinder]
    set windowHeight [winfo reqheight .annularCylinder]
    wm geometry .annularCylinder ${windowWidth}x${windowHeight}
    wm minsize .annularCylinder $windowWidth $windowHeight
    wm maxsize .annularCylinder $windowWidth $windowHeight
    wm resizable .annularCylinder 0 0
    update idletasks
    set x [expr {([winfo screenwidth .annularCylinder]-[winfo width .annularCylinder])/2}]
    set y [expr {([winfo screenheight .annularCylinder]-[winfo height .annularCylinder])/2}]
    wm geometry .annularCylinder +$x+$y
}
catch {trace remove variable ::AnnularCylinder::node write ::AnnularCylinder::updateBearingOrders}
trace add variable ::AnnularCylinder::node write ::AnnularCylinder::updateBearingOrders
if {![info exists ::AnnularCylinder_no_gui]} {::AnnularCylinder::show}




