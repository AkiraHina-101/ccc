# Revolved solid TET4 generator, HyperMesh 2022 / Tcl 8.5.
# Loading opens the form only. Model mutation requires Create.
namespace eval ::RevolveTet {
    variable node ""
    variable axis X
    variable width 14.9
    variable nw 6
    variable wr ""
    variable radius 22.5
    variable nr 6
    variable rr ""
    variable sectors 32
    variable rbeEnabled 0
    variable rbeRing 1
    variable autoRenumber 0
    variable renumberInput ""
    variable renumberIncrement 1
    variable dof
    if {![array exists dof]} {array set dof {1 1 2 1 3 1 4 1 5 1 6 1}}
    variable status "Select center nodes, then Create."
    variable statusTone neutral
    variable busy 0
    variable topmost
    if {![info exists topmost]} {set topmost 1}
    variable highWater
    if {![info exists highWater]} {set highWater {}}
}
proc ::RevolveTet::positive {value label} {
    if {![string is double -strict $value]} {error "$label must be a positive number."}
    if {[catch {expr {double($value)>0 && double($value)<1e100}} ok] || !$ok} {
        error "$label must be finite and positive."
    }
    return [expr {double($value)}]
}
proc ::RevolveTet::levels {total count ratios label} {
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
proc ::RevolveTet::det {p q r s} {
    foreach {px py pz} $p break
    foreach {qx qy qz} $q break
    foreach {rx ry rz} $r break
    foreach {sx sy sz} $s break
    set ax [expr {$qx-$px}]; set ay [expr {$qy-$py}]; set az [expr {$qz-$pz}]
    set bx [expr {$rx-$px}]; set by [expr {$ry-$py}]; set bz [expr {$rz-$pz}]
    set cx [expr {$sx-$px}]; set cy [expr {$sy-$py}]; set cz [expr {$sz-$pz}]
    return [expr {$ax*($by*$cz-$bz*$cy)-$ay*($bx*$cz-$bz*$cx)+$az*($bx*$cy-$by*$cx)}]
}
proc ::RevolveTet::geometry {center axis width wl rl ns} {
    if {$axis ni {X Y Z}} {error "Select X, Y or Z."}
    if {![string is integer -strict $ns] || $ns<3 || $ns>720} {error "Circumference segments must be 3 to 720."}
    set nw [expr {[llength $wl]-1}]; set nr [expr {[llength $rl]-1}]
    set expected [expr {3*$nw*$ns*(2*$nr-1)}]
    if {$expected>250000} {error "Mesh exceeds 250000 TET4. Reduce layer/segment counts."}
    set disk {{0.0 0.0}}
    foreach radius [lrange $rl 1 end] {
        for {set j 0} {$j<$ns} {incr j} {
            set a [expr {2.0*acos(-1.0)*$j/$ns}]
            lappend disk [list [expr {$radius*cos($a)}] [expr {$radius*sin($a)}]]
        }
    }
    set triangles {}
    for {set j 0} {$j<$ns} {incr j} {
        set k [expr {($j+1)%$ns}]
        lappend triangles [list 0 [expr {1+$j}] [expr {1+$k}]]
        for {set ring 1} {$ring<$nr} {incr ring} {
            set a [expr {1+($ring-1)*$ns+$j}]; set b [expr {1+($ring-1)*$ns+$k}]
            set c [expr {1+$ring*$ns+$j}]; set d [expr {1+$ring*$ns+$k}]
            lappend triangles [list $a $c $d] [list $a $d $b]
        }
    }
    foreach {ox oy oz} $center break
    set points {}
    foreach w $wl {
        set axial [expr {$w-$width/2.0}]
        foreach uv $disk {
            foreach {u v} $uv break
            switch $axis {
                X {lappend points [list [expr {$ox+$axial}] [expr {$oy+$u}] [expr {$oz+$v}]]}
                Y {lappend points [list [expr {$ox+$v}] [expr {$oy+$axial}] [expr {$oz+$u}]]}
                Z {lappend points [list [expr {$ox+$u}] [expr {$oy+$v}] [expr {$oz+$axial}]]}
            }
        }
    }
    set n [llength $disk]; set tets {}
    for {set layer 0} {$layer<$nw} {incr layer} {
        set lo [expr {$layer*$n}]; set hi [expr {$lo+$n}]
        foreach triangle $triangles {
            # A global ordering makes diagonals agree across adjacent prisms.
            foreach {i j k} [lsort -integer $triangle] break
            set a [expr {$lo+$i}]; set b [expr {$lo+$j}]; set c [expr {$lo+$k}]
            set A [expr {$hi+$i}]; set B [expr {$hi+$j}]; set C [expr {$hi+$k}]
            foreach tet [list [list $a $b $c $C] [list $a $b $B $C] [list $a $A $B $C]] {
                foreach {t0 t1 t2 t3} $tet break
                set volume [det [lindex $points $t0] [lindex $points $t1] [lindex $points $t2] [lindex $points $t3]]
                if {$volume==0 || [catch {expr {abs($volume)<1e300}} finite] || !$finite} {
                    error "Degenerate mesh: check dimensions, coordinates and ratios."
                }
                if {$volume<0} {set tet [list $t1 $t0 $t2 $t3]}
                lappend tets $tet
            }
        }
    }
    return [list $points $tets]
}
proc ::RevolveTet::targetIds {input increment limit} {
    if {![string is integer -strict $increment] || $increment<1} {error "Renumber increment must be a positive integer."}
    set result {}; set seen {}
    foreach token [regexp -all -inline {\S+} [string map {, " "} $input]] {
        if {![regexp {^([0-9]+)(?:-([0-9]+))?$} $token -> first last]} {error "Use node IDs or ascending ranges, e.g. 301-307 311-317."}
        scan $first %d first
        if {$last eq ""} {set last $first} else {scan $last %d last}
        if {$first<1 || $last<$first || $last>2147483647} {error "Renumber IDs must be positive ascending ranges within the ID limit."}
        for {set id $first} {$id<=$last} {incr id $increment} {
            if {[dict exists $seen $id]} {error "Duplicate renumber target ID $id."}
            dict set seen $id 1
            if {[llength $result]<$limit} {lappend result $id}
            # Excess targets are unused; avoid expanding arbitrarily large ranges.
            if {[llength $result]>=$limit} {return $result}
        }
    }
    if {![llength $result]} {error "Enter renumber target IDs."}
    return $result
}
proc ::RevolveTet::renumberControls {} {
    variable autoRenumber
    set state [expr {$autoRenumber ? "normal" : "disabled"}]
    foreach w {.revolveTet.form.renumberIDs .revolveTet.form.renumberStep} {catch {$w configure -state $state}}
}
proc ::RevolveTet::nodeIds {input} {
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
proc ::RevolveTet::pick {} {
    variable node; variable status; variable busy
    if {$busy} {return}
    tone neutral
    if {[catch {
        *createmarkpanel nodes 1 "Select center nodes (one component per node)"
        set ids [hm_getmark nodes 1]
        if {[llength $ids]} {
            set node [join [nodeIds $ids] " "]
            set status "Selected [llength [nodeIds $node]] center node(s)."
        } else {set status "Selection unchanged."}
    } msg]} {set status $msg; tone error}
}
# Query every requested entity, in bounded batches, and join by returned ID.
proc ::RevolveTet::bulk {type ids fields} {
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
# Keep IDs monotonic for this Tcl session, including across source/hot reload.
proc ::RevolveTet::reserve {type count} {
    variable highWater
    set last [hm_entitymaxid $type]
    if {[dict exists $highWater $type]} {set last [expr {max($last,[dict get $highWater $type])}]}
    set end [expr {$last+$count}]
    if {$end>2147483647} {error "Entity ID limit reached for $type."}
    dict set highWater $type $end
    return $last
}
proc ::RevolveTet::controls {state} {
    foreach widget {.revolveTet.buttons.create .revolveTet.buttons.close .revolveTet.form.pick} {
        catch {$widget configure -state $state}
    }
}
proc ::RevolveTet::record {text} {
    catch {
        set f [open [file join $::env(TEMP) RevolveTet_runtime.log] a]
        puts $f "[clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}] $text"
        close $f
    }
}
proc ::RevolveTet::applyTopmost {} {
    variable topmost
    if {[winfo exists .revolveTet]} {wm attributes .revolveTet -topmost $topmost}
}
proc ::RevolveTet::tone {value} {
    variable statusTone
    set statusTone $value
    set color #333333
    if {$value eq "success"} {set color #16723A}
    if {$value eq "error"} {set color #B42318}
    catch {.revolveTet.status configure -foreground $color}
}
proc ::RevolveTet::ringValues {} {
    variable nr; variable rr
    set count $nr
    if {[string trim $rr] ne ""} {
        set weights [split [string trim $rr] :]
        foreach w $weights {if {[catch {positive [string trim $w] Ratio}]} {return {}}}
        set count [llength $weights]
    }
    if {![string is integer -strict $count] || $count<1 || $count>1000} {return {}}
    set values {}
    for {set i 1} {$i<=$count} {incr i} {lappend values $i}
    return $values
}
proc ::RevolveTet::syncRings {args} {
    variable busy
    if {$busy} {return}
    variable rbeRing
    set values [ringValues]
    if {[llength $values] && $rbeRing ni $values} {set rbeRing [lindex $values end]}
    catch {.revolveTet.form.rbeRing configure -values $values}
}
proc ::RevolveTet::rbeToggle {} {
    variable rbeEnabled; variable dof
    if {$rbeEnabled} {foreach d {1 2 3 4 5 6} {set dof($d) 1}}
    rbeControls
}
proc ::RevolveTet::rbeControls {} {
    variable rbeEnabled
    set state [expr {$rbeEnabled ? "normal" : "disabled"}]
    catch {.revolveTet.form.rbeRing configure -state [expr {$rbeEnabled ? "readonly" : "disabled"}]}
    foreach d {1 2 3 4 5 6} {catch {.revolveTet.form.dofs.d$d configure -state $state}}
}
proc ::RevolveTet::create {} {
    variable node; variable axis; variable width; variable nw; variable wr
    variable radius; variable nr; variable rr; variable sectors; variable status; variable busy
    variable rbeEnabled; variable rbeRing; variable dof
    variable autoRenumber; variable renumberInput; variable renumberIncrement
    if {$busy} {return}
    set busy 1; controls disabled; tone neutral
    set started [clock milliseconds]
    record "START axis=$axis"
    # Entire geometry is validated before any model write.
    if {[catch {
        set centerIds [nodeIds $node]
        set wl [levels $width $nw $wr Width]
        set rl [levels $radius $nr $rr Radius]
        set nw [expr {[llength $wl]-1}]; set nr [expr {[llength $rl]-1}]
        if {![string is integer -strict $sectors] || $sectors<3 || $sectors>720} {error "Circumference segments must be 3 to 720."}
        if {3*$nw*$sectors*(2*$nr-1)*[llength $centerIds]>250000} {error "Combined mesh exceeds 250000 TET4. Reduce nodes/layers/segments."}
        if {$rbeEnabled && (![string is integer -strict $rbeRing] || $rbeRing<1 || $rbeRing>$nr)} {
            error "RBE2 radial ring must be an integer from 1 to $nr."
        }
        set rbeDofs ""
        if {$rbeEnabled} {
            foreach d {1 2 3 4 5 6} {if {$dof($d)} {append rbeDofs $d}}
            if {$rbeDofs eq ""} {error "Select at least one RBE2 DOF."}
        }
        set centers [bulk nodes $centerIds {x y z}]
        set points {}; set tets {}; set chunks {}
        foreach centerId $centerIds {
            set center {}
            foreach field {x y z} {lappend center [dict get $centers $centerId $field]}
            foreach {localPoints localTets} [geometry $center $axis $width $wl $rl $sectors] break
            set offset [llength $points]
            set firstTet [llength $tets]
            foreach p $localPoints {lappend points $p}
            foreach tet $localTets {
                set globalTet {}
                foreach index $tet {lappend globalTet [expr {$offset+$index}]}
                lappend tets $globalTet
            }
            lappend chunks [list $centerId $firstTet [llength $localTets]]
        }
        set renumberPlan {}; set targets {}
        if {$autoRenumber} {
            set diskNodes [expr {1+$nr*$sectors}]
            set axialSlot [lsearch {X Y Z} $axis]
            set ordered {}
            for {set index 0} {$index<[llength $points]} {incr index $diskNodes} {
                lappend ordered [list [lindex [lindex $points $index] $axialSlot] $index]
            }
            set ordered [lsort -real -index 0 $ordered]
            set targets [targetIds $renumberInput $renumberIncrement [llength $ordered]]
            foreach target $targets row [lrange $ordered 0 [expr {[llength $targets]-1}]] {
                if {[hm_entityinfo exist nodes $target -byid]} {error "Renumber target node $target already exists."}
                lappend renumberPlan [list [lindex $row 1] $target]
            }
        }
    } msg]} {
        set busy 0; controls normal; set status $msg; tone error
        record "PREFLIGHT_ERROR $msg"
        tk_messageBox -parent .revolveTet -icon error -message $msg; return
    }
    set validated [clock milliseconds]
    set status "Creating [llength $tets] TET4..."; update idletasks
    set name "RevolveTet_[clock clicks]"; set cids {}; set pids {}; set ids {}; set elementIds {}; set componentRows {}; set rigidIds {}; set rigidCids {}; set newRigidCids {}
    set old ""
    catch {
        set previous [hm_info currentcollector component]
        if {[string is integer -strict $previous]} {
            if {$previous>0} {set old [hm_getvalue comps id=$previous dataname=name]}
        } else {set old $previous}
    }
    set asciiFile ""; set asciiHandle ""
    set savedOptions {}
    set stage "creating component"
    set code [catch {
        foreach {option value} {command_file_state 0 block_redraw 1} {
            if {![catch {hm_getoption $option} previousOption]} {
                if {![catch {*setoption $option=$value}]} {lappend savedOptions $option $previousOption}
            }
        }
        # Fresh IDs in every pool; the file contains no properties/materials.
        set nextComponent [reserve comps [llength $chunks]]
        if {[llength $targets]} {
            variable highWater
            set largest [lindex [lsort -integer $targets] end]
            set previousHigh 0
            if {[dict exists $highWater nodes]} {set previousHigh [dict get $highWater nodes]}
            dict set highWater nodes [expr {max($largest,[hm_entitymaxid nodes],$previousHigh)}]
        }
        set nextNode [reserve nodes [llength $points]]
        set nextElement [reserve elems [llength $tets]]
        set nextProperty [reserve props [llength $chunks]]
        set componentDone [clock milliseconds]
        set stage "preparing node block"
        set asciiFile [file join $::env(TEMP) "${name}_[pid].hmascii"]
        set asciiHandle [open $asciiFile {WRONLY CREAT EXCL}]
        fconfigure $asciiHandle -encoding ascii -translation lf -buffering full
        puts $asciiHandle {*filetype(ASCII)}
        puts $asciiHandle {*version(10.0build60)}
        foreach p $points {
            foreach {x y z} $p break
            set nid [incr nextNode]
            lappend ids $nid
            puts $asciiHandle "*node($nid,$x,$y,$z,0,0,0,0,0)"
        }
        set nodesDone [clock milliseconds]
        set stage "preparing TET4 block"
        foreach chunk $chunks {
            foreach {centerId firstTet tetCount} $chunk break
            set cid [incr nextComponent]
            set componentName "PSOLID_$cid"
            if {[hm_entityinfo exist comps $componentName -byname]} {error "Component name $componentName already exists."}
            lappend cids $cid
            puts $asciiHandle "*component($cid,\"$componentName\",0,11,0)"
            set componentElements {}
            foreach tet [lrange $tets $firstTet [expr {$firstTet+$tetCount-1}]] {
                set connectivity {}
                foreach index $tet {lappend connectivity [lindex $ids $index]}
                set eid [incr nextElement]
                lappend elementIds $eid
                lappend componentElements $eid
                puts $asciiHandle "*tetra4($eid,1,[join $connectivity ,],0)"
            }
            lappend componentRows [list $cid $componentName $componentElements]
        }
        close $asciiHandle; set asciiHandle ""
        set prepared [clock milliseconds]
        set stage "importing TET4 block"
        *createstringarray 0
        # Overwrite disabled. IDs were reserved above the current maxima.
        record "IMPORT_START components=[llength $cids] nodes=[llength $ids] tetra=[llength $elementIds]"
        *feinputwithdata2 "#hmascii/hmascii" $asciiFile 0 0 0 0 0 1 0 1 0
        set imported [clock milliseconds]
        record "IMPORT_END [expr {$imported-$prepared}]ms"
        set stage "creating PSOLID properties"
        foreach row $componentRows {
            foreach {cid componentName expectedElements} $row break
            set pid [incr nextProperty]
            set propertyName "PSOLID_$pid"
            if {[hm_entityinfo exist props $propertyName -byname]} {error "Property name $propertyName already exists."}
            lappend pids $pid
            *createentity props id=$pid cardimage=PSOLID name=$propertyName
            *setvalue comps id=$cid propertyid=$pid
            if {[hm_getvalue comps id=$cid dataname=propertyid]!=$pid ||
                [hm_getvalue props id=$pid dataname=name] ne $propertyName ||
                [hm_getvalue props id=$pid dataname=cardimage] ne "PSOLID" ||
                [hm_getvalue props id=$pid dataname=materialid]!=0} {
                error "Component -> PSOLID -> blank MID readback failed."
            }
        }
        set elementsDone [clock milliseconds]
        record "PSOLID_END count=[llength $pids]"
        set stage "reading back mesh"
        set actual {}
        foreach row $componentRows {
            foreach {cid componentName expectedElements} $row break
            if {[hm_getvalue comps id=$cid dataname=name] ne $componentName} {error "Component name readback failed."}
            *createmark elems 1 "by collector id" $cid
            set got [hm_getmark elems 1]
            if {[lsort -integer $got] ne [lsort -integer $expectedElements]} {error "Component $componentName element membership mismatch."}
            foreach eid $got {lappend actual $eid}
        }
        if {[llength $actual]!=[llength $tets]} {error "Created element count does not match."}
        set nodeRows [bulk nodes $ids {x y z}]
        set readCoordinates {}
        foreach nid $ids expectedPoint $points {
            set actualPoint {}
            foreach field {x y z} target $expectedPoint {
                set value [dict get $nodeRows $nid $field]
                if {abs($value-$target)>1e-10*max(1.0,abs($target))} {error "Node $nid coordinate readback failed."}
                lappend actualPoint $value
            }
            dict set readCoordinates $nid $actualPoint
        }
        set elementRows [bulk elems $elementIds {config node1.id node2.id node3.id node4.id}]
        foreach eid $elementIds tet $tets {
            if {[dict get $elementRows $eid config]!=204} {error "Non-TET4 detected."}
            set wanted {}; set received {}; set readPoints {}
            foreach local $tet {lappend wanted [lindex $ids $local]}
            foreach slot {1 2 3 4} {
                set nid [dict get $elementRows $eid node$slot.id]
                lappend received $nid
                if {![dict exists $readCoordinates $nid]} {error "TET4 $eid references an unexpected node."}
                lappend readPoints [dict get $readCoordinates $nid]
            }
            if {[lsort -integer $received] ne [lsort -integer $wanted]} {error "TET4 $eid connectivity readback failed."}
            if {[eval det $readPoints]<=0} {error "TET4 $eid has nonpositive volume after creation."}
        }
        if {$rbeEnabled} {
            set stage "creating RBE2 links"
            set diskNodes [expr {1+$nr*$sectors}]
            set meshNodes [expr {($nw+1)*$diskNodes}]
            set centerIndex 0
            set rigidName "COMP_NO_PROPERTIES"
            if {[hm_entityinfo exist comps $rigidName -byname]} {
                set rigidCid [hm_getvalue comps name=$rigidName dataname=id]
                if {[hm_getvalue comps id=$rigidCid dataname=propertyid]!=0} {error "COMP_NO_PROPERTIES already has a property. Remove its assignment before using RBE2."}
            } else {
                set rigidCid [expr {[reserve comps 1]+1}]
                lappend newRigidCids $rigidCid
                *createentity comps id=$rigidCid name=$rigidName
            }
            set rigidCids [list $rigidCid]
            if {[hm_getvalue comps id=$rigidCid dataname=name] ne $rigidName ||
                [hm_getvalue comps id=$rigidCid dataname=propertyid]!=0} {error "RBE2 component name/property readback failed."}
            foreach cid $cids {
                *currentcollector components $rigidName
                for {set face 0} {$face<=$nw} {incr face} {
                    set base [expr {$centerIndex*$meshNodes+$face*$diskNodes}]
                    set independent [lindex $ids $base]
                    set first [expr {$base+1+($rbeRing-1)*$sectors}]
                    set dependent [lrange $ids $first [expr {$first+$sectors-1}]]
                    eval *createmark nodes 1 $dependent
                    set previousRigid [hm_entitymaxid elems]
                    set rigidCode [catch {*rigidlink $independent 1 $rbeDofs} rigidError]
                    set eid [hm_latestentityid elems]
                    if {$eid>0 && $eid ni $elementIds && $eid ni $rigidIds} {lappend rigidIds $eid; reserve elems 0}
                    if {$rigidCode} {error $rigidError}
                    if {$eid<1 || [hm_getvalue elems id=$eid dataname=config]!=55 ||
                        [hm_getvalue elems id=$eid dataname=independentnode.id]!=$independent ||
                        [hm_getvalue elems id=$eid dataname=dofs]!=$rbeDofs ||
                        [lsort -integer [hm_getvalue elems id=$eid dataname=dependentnodes]] ne [lsort -integer $dependent]} {
                        record "RBE2_MISMATCH eid=$eid previousMax=$previousRigid independent=$independent actualIndependent=[hm_getvalue elems id=$eid dataname=independentnode.id] config=[hm_getvalue elems id=$eid dataname=config] dofs=[hm_getvalue elems id=$eid dataname=dofs] expectedDependent=$dependent actualDependent=[hm_getvalue elems id=$eid dataname=dependentnodes]"
                        error "RBE2 node/DOF readback failed on axial face $face (element $eid). See RevolveTet_runtime.log."
                    }
                }
                incr centerIndex
            }
            record "RBE2_END count=[llength $rigidIds] ring=$rbeRing"
        }
        if {[llength $renumberPlan]} {
            set stage "renumbering axial center nodes"
            foreach pair $renumberPlan {
                foreach {index target} $pair break
                set source [lindex $ids $index]
                *createmark nodes 1 $source
                set renameCode [catch {*renumber nodes 1 $target 1 0 0} renameError]
                # Track actual mutation even if an error occurs after the native write.
                if {[hm_entityinfo exist nodes $target -byid] && ![hm_entityinfo exist nodes $source -byid]} {
                    lset ids $index $target
                }
                if {$renameCode} {error $renameError}
                if {[lindex $ids $index]!=$target} {error "Node renumber failed: $source -> $target."}
            }
            set renamedRows [bulk nodes $ids {x y z}]
            foreach nid $ids point $points {
                foreach field {x y z} wanted $point {
                    if {abs([dict get $renamedRows $nid $field]-$wanted)>1e-10*max(1.0,abs($wanted))} {error "Renumber coordinate readback failed."}
                }
            }
            set renamedElements [bulk elems $elementIds {node1.id node2.id node3.id node4.id}]
            foreach eid $elementIds tet $tets {
                set expected {}; set received {}
                foreach index $tet {lappend expected [lindex $ids $index]}
                foreach slot {1 2 3 4} {lappend received [dict get $renamedElements $eid node$slot.id]}
                if {[lsort -integer $expected] ne [lsort -integer $received]} {error "Renumber TET4 connectivity readback failed."}
            }
            set n 0
            foreach row $componentRows {
                for {set face 0} {$rbeEnabled && $face<=$nw} {incr face} {
                    set eid [lindex $rigidIds $n]
                    set base [expr {($n/($nw+1))*($nw+1)*(1+$nr*$sectors)+$face*(1+$nr*$sectors)}]
                    if {[hm_getvalue elems id=$eid dataname=independentnode.id]!=[lindex $ids $base]} {error "Renumber RBE2 independent node readback failed."}
                    incr n
                }
            }
            record "RENUMBER_END count=[llength $renumberPlan] axis=$axis"
        }
        set readbackDone [clock milliseconds]
        set ::RevolveTet::lastTimings [list geometry [expr {$validated-$started}] component [expr {$componentDone-$validated}] nodes [expr {$nodesDone-$componentDone}] elements [expr {$prepared-$nodesDone}] import [expr {$imported-$prepared}] properties [expr {$elementsDone-$imported}] readback [expr {$readbackDone-$elementsDone}] total [expr {$readbackDone-$started}]]
        set ::RevolveTet::lastResult [dict create components $cids properties $pids centers $centerIds rigids $rigidIds rigidComponents $rigidCids renamedCount [llength $renumberPlan] nodes $ids]
        record "READBACK_END $::RevolveTet::lastTimings"
        tone success
        set status "Created [llength $cids] component(s), PSOLID: [llength $ids] nodes, [llength $actual] TET4, [llength $rigidIds] RBE2, [llength $renumberPlan] renumbered ([format %.2f [expr {($readbackDone-$started)/1000.0}]] s)."
    } msg]
    if {$asciiHandle ne ""} {catch {close $asciiHandle}}
    if {$asciiFile ne ""} {catch {file delete -- $asciiFile}}
    foreach {option value} $savedOptions {catch {*setoption $option=$value}}
    if {$old ne ""} {catch {*currentcollector components $old}}
    if {$code} {
        if {[string trim $msg] eq "" || [string is integer -strict $msg]} {set msg "Native command failed while $stage."}
        # Cleanup is limited to entities created by this operation.
        set cleanup {}
        if {[llength $rigidIds]} {
            if {[catch {eval *createmark elems 1 $rigidIds; *deletemark elems 1} e]} {lappend cleanup $e}
        }
        set cleanupCids [concat $cids $newRigidCids]
        if {[llength $cleanupCids]} {
            if {[catch {eval *createmark comps 1 $cleanupCids; *deletemark comps 1} e]} {lappend cleanup $e}
        }
        if {[llength $pids]} {
            if {[catch {eval *createmark props 1 $pids; *deletemark props 1} e]} {lappend cleanup $e}
        }
        if {[llength $ids]} {
            if {[catch {*clearlist nodes 1; eval *createmark nodes 1 $ids; *nodemarkcleartempmark 1} e]} {lappend cleanup $e}
        }
        tone error
        set status "Create failed: $msg"
        if {[llength $cleanup]} {append status "\nCleanup incomplete ($name): $cleanup"}
        tk_messageBox -parent .revolveTet -icon error -message $status
    }
    # Release marks owned by the operation so deleted elements are not retained
    # as the active selection before the next import. Preserve node-panel temp nodes.
    foreach type {elems comps props nodes} {catch {*clearmark $type 1}}
    catch {*clearlist nodes 1}
    record "END code=$code status=$status"
    set busy 0; controls normal
}
proc ::RevolveTet::show {} {
    package require Tk
    if {[winfo exists .revolveTet]} {destroy .revolveTet}
    toplevel .revolveTet
    wm title .revolveTet "Crankshaft Section Mesher"
    wm minsize .revolveTet 560 460
    applyTopmost
    label .revolveTet.status -textvariable ::RevolveTet::status -wraplength 520 -padx 16 -pady 12 -anchor w -justify left
    tone $::RevolveTet::statusTone
    pack .revolveTet.status -fill x
    ttk::separator .revolveTet.statusLine
    pack .revolveTet.statusLine -fill x
    ttk::frame .revolveTet.form -padding 16
    pack .revolveTet.form -fill both -expand 1
    set f .revolveTet.form
    ttk::checkbutton $f.topmost -text "Always on top" -variable ::RevolveTet::topmost -command ::RevolveTet::applyTopmost
    grid $f.topmost -row 0 -column 0 -columnspan 3 -sticky w -pady {0 8}
    ttk::label $f.nodeLabel -text "Center node IDs"
    ttk::entry $f.node -textvariable ::RevolveTet::node
    ttk::button $f.pick -text "Select nodes" -command ::RevolveTet::pick
    grid $f.nodeLabel -row 1 -column 0 -sticky w
    grid $f.node -row 1 -column 1 -sticky ew -padx 8
    grid $f.pick -row 1 -column 2
    ttk::label $f.axisLabel -text "Revolution axis"
    ttk::frame $f.axes
    foreach a {X Y Z} {
        set axisWidget $f.axes.[string tolower $a]
        ttk::radiobutton $axisWidget -text $a -value $a -variable ::RevolveTet::axis
        pack $axisWidget -side left -padx 8
    }
    grid $f.axisLabel -row 2 -column 0 -sticky w -pady 8
    grid $f.axes -row 2 -column 1 -columnspan 2 -sticky w
    ttk::separator $f.meshLine
    grid $f.meshLine -row 3 -column 0 -columnspan 3 -sticky ew -pady 10
    set row 4
    foreach {label var layerVar ratioVar} {Width width nw wr Radius radius nr rr} {
        ttk::label $f.l$var -text $label
        ttk::entry $f.e$var -textvariable ::RevolveTet::$var
        grid $f.l$var -row $row -column 0 -sticky w -pady 5
        grid $f.e$var -row $row -column 1 -columnspan 2 -sticky ew -padx 8
        incr row
        ttk::label $f.l$layerVar -text "$label layers"
        ttk::frame $f.group$layerVar
        set g $f.group$layerVar
        ttk::entry $g.layers -textvariable ::RevolveTet::$layerVar -width 6
        ttk::label $g.ratioLabel -text "Ratios"
        ttk::entry $g.ratios -textvariable ::RevolveTet::$ratioVar -width 20
        grid $g.layers -row 0 -column 0 -sticky ew
        grid $g.ratioLabel -row 0 -column 1 -padx 8
        grid $g.ratios -row 0 -column 2 -sticky ew
        grid columnconfigure $g 2 -weight 1
        grid $f.l$layerVar -row $row -column 0 -sticky w -pady 5
        grid $g -row $row -column 1 -columnspan 2 -sticky ew -padx 8
        incr row
    }
    ttk::label $f.lsectors -text "Circumference segments"
    ttk::entry $f.esectors -textvariable ::RevolveTet::sectors
    grid $f.lsectors -row $row -column 0 -sticky w -pady 5
    grid $f.esectors -row $row -column 1 -columnspan 2 -sticky ew -padx 8
    incr row
    ttk::separator $f.rbeLine
    grid $f.rbeLine -row $row -column 0 -columnspan 3 -sticky ew -pady 10
    incr row
    ttk::checkbutton $f.rbeEnabled -text "Create RBE2" -variable ::RevolveTet::rbeEnabled -command ::RevolveTet::rbeToggle
    grid $f.rbeEnabled -row $row -column 0 -columnspan 3 -sticky w -pady 4
    incr row
    ttk::label $f.rbeLabel -text "RBE2 radial ring"
    ttk::combobox $f.rbeRing -textvariable ::RevolveTet::rbeRing -state readonly
    syncRings
    grid $f.rbeLabel -row $row -column 0 -sticky w -pady 5
    grid $f.rbeRing -row $row -column 1 -columnspan 2 -sticky ew -padx 8
    incr row
    ttk::frame $f.dofs
    foreach d {1 2 3 4 5 6} {
        ttk::checkbutton $f.dofs.d$d -text "DOF $d" -variable ::RevolveTet::dof($d)
        pack $f.dofs.d$d -side left -padx 3
    }
    grid $f.dofs -row $row -column 0 -columnspan 3 -sticky w -pady 4
    rbeControls
    incr row
    ttk::separator $f.renumberLine
    grid $f.renumberLine -row $row -column 0 -columnspan 3 -sticky ew -pady 10
    incr row
    ttk::checkbutton $f.autoRenumber -text "Auto renumber axial centers" -variable ::RevolveTet::autoRenumber -command ::RevolveTet::renumberControls
    grid $f.autoRenumber -row $row -column 0 -columnspan 3 -sticky w
    incr row
    ttk::label $f.renumberLabel -text "Target node IDs"
    ttk::entry $f.renumberIDs -textvariable ::RevolveTet::renumberInput
    grid $f.renumberLabel -row $row -column 0 -sticky w -pady 5
    grid $f.renumberIDs -row $row -column 1 -columnspan 2 -sticky ew -padx 8
    incr row
    ttk::label $f.stepLabel -text "Increment"
    ttk::entry $f.renumberStep -textvariable ::RevolveTet::renumberIncrement -width 6
    grid $f.stepLabel -row $row -column 0 -sticky w -pady 5
    grid $f.renumberStep -row $row -column 1 -sticky w -padx 8
    renumberControls
    grid columnconfigure $f 1 -weight 1
    ttk::frame .revolveTet.buttons -padding {16 0 16 8}
    pack .revolveTet.buttons -fill x
    ttk::button .revolveTet.buttons.create -text Create -command ::RevolveTet::create
    ttk::button .revolveTet.buttons.close -text Close -command {destroy .revolveTet}
    pack .revolveTet.buttons.close .revolveTet.buttons.create -side right -padx 4

}
foreach var {nr rr} {
    catch {trace remove variable ::RevolveTet::$var write ::RevolveTet::syncRings}
    trace add variable ::RevolveTet::$var write ::RevolveTet::syncRings
}
if {![info exists ::RevolveTet_no_gui]} {::RevolveTet::show}
