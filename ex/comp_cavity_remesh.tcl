# Comp Cavity Remesh V5 Auto r25.1 | HyperMesh 2022 only
if {[info exists ::CCR::busy] && $::CCR::busy} {error "Comp Cavity Remesh is busy"}
if {[info exists ::CCRAutoMesh::recoveryRequired] && $::CCRAutoMesh::recoveryRequired} {error "Recovery required. Inspect the model."}
if {[llength [info commands ::CCRDebug::active]] && [::CCRDebug::active]} {error "Finish or restore the open debug area before loading V5 Auto."}
if {[llength [info commands ::CCRFlow::active]] && [::CCRFlow::active]} {
    if {$::CCRFlow::state eq "expanded" && !$::CCRFlow::mutated} {
        set ::CCR_reload_input $::CCR::input
        set ::CCR_reload_threshold $::CCR::threshold
    } else {error "Finish or restore the current area before reloading."}
}
if {[llength [info commands ::CCRUI::savePreferences]] && [llength [info commands winfo]] && [winfo exists .ccr]} {
    ::CCRUI::savePreferences
}
foreach setting {::CCR::threshold ::CCRUI::expandLayers ::CCR::topmost} {
    catch {trace remove variable $setting write ::CCRUI::preferenceChanged}
}
namespace eval ::CCR {variable sourceFile [file normalize [info script]]}

namespace eval ::CCRAutoMesh {variable threshold 0.1;variable recoveryRequired 0}
namespace eval ::CCRAutoVolume {}
namespace eval ::CCRAutoAudit {}
namespace eval ::CCRAutoMapping {}
namespace eval ::CCRAutoImport {}
proc ::CCRAutoMesh::version {} {
    set v [hm_info -appinfo VERSION]
    if {![string match "22.*" $v]} {error "This prototype requires HyperMesh 2022 (found $v)."}
}
proc ::CCRAutoMesh::elements ids {
    if {![llength $ids]} {return {}}
    *createmark elems 1 {*}$ids
    return [markedElements]
}
proc ::CCRAutoMesh::markedElements {} {
    if {![llength [hm_getmark elems 1]]} {return {}}
    set actual [hm_getvalue elems mark=1 dataname=id]
    set out {}
    foreach id $actual c [hm_getvalue elems mark=1 dataname=config] p [hm_getvalue elems mark=1 dataname=propertyid] n [hm_getvalue elems mark=1 dataname=nodes] {
        dict set out $id [list $c $p $n]
    }
    return $out
}
proc ::CCRAutoMesh::component cid {
    *createmark elems 1 "by collector id" $cid
    return [markedElements]
}
proc ::CCRAutoMesh::quality ids {
    variable threshold
    if {![llength $ids]} {return {}}
    *createmark elems 1 {*}$ids
    return [hm_getelemcheckvalues 1 3 tetracollapse]
}
proc ::CCRAutoMesh::failed values {
    variable threshold
    set out {}
    foreach {id value} $values {if {$value < $threshold} {lappend out $id}}
    return $out
}
proc ::CCRAutoMesh::coords ids {
    if {![llength $ids]} {return {}}
    *createmark nodes 1 {*}$ids
    set actual [hm_getvalue nodes mark=1 dataname=id]
    if {[llength $actual] != [llength $ids]} {error "An original node was deleted."}
    set out {}
    foreach id $actual x [hm_getvalue nodes mark=1 dataname=x] y [hm_getvalue nodes mark=1 dataname=y] z [hm_getvalue nodes mark=1 dataname=z] {dict set out $id [list $x $y $z]}
    return $out
}
proc ::CCRAutoMesh::nodes elems {
    set out {}
    dict for {id row} $elems {foreach n [lindex $row 2] {dict set out $n 1}}
    return [dict keys $out]
}
proc ::CCRAutoMesh::boundary elems {
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
proc ::CCRAutoMesh::sameDict {a b} {
    if {[dict size $a] != [dict size $b]} {return 0}
    dict for {k v} $a {if {![dict exists $b $k] || [dict get $b $k] ne $v} {return 0}}
    return 1
}
proc ::CCRAutoMesh::subset {all ids} {
    set out {}; foreach id $ids {dict set out $id [dict get $all $id]}; return $out
}
proc ::CCRAutoMesh::volume {elems xyz} {
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
proc ::CCRAutoMesh::guardReferences patch {
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
proc ::CCRAutoMesh::containedNodes {nodeids star} {
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
proc ::CCRAutoMesh::restoreCavity {star xyz types solver newIDs newNodes cid} {
    *currentcollector components [hm_getvalue comps id=$cid dataname=name]
    *createmark nodes 1 {*}[dict keys $xyz]
    set present {};foreach id [hm_getmark nodes 1] {dict set present $id 1}
    set nodeMap {}
    dict for {id point} $xyz {
        if {[dict exists $present $id]} {dict set nodeMap $id $id;continue}
        lassign $point x y z;*createnode $x $y $z 0 0 0
        dict set nodeMap $id [hm_latestentityid nodes]
    }
    if {[llength $newIDs]} {*createmark elems 1 {*}$newIDs;*deletemark elems 1}
    set existing [elements [dict keys $star]];set restored {}
    dict for {id row} $star {
        if {[dict exists $existing $id]} {lappend restored $id;continue}
        lassign $row cfg pid ns
        set actualNodes {};foreach node $ns {lappend actualNodes [dict get $nodeMap $node]}
        *createlist nodes 1 {*}$actualNodes;*createelement $cfg [dict get $types $id] 1 0
        lappend restored [hm_latestentityid elems]
    }
    *createmark elements 1 {*}$restored
    *movemark elements 1 [hm_getvalue comps id=$cid dataname=name]
    return $restored
}
proc ::CCRAutoMesh::validateThreshold {} {
    variable threshold
    if {![string is double -strict $threshold] || [catch {expr {$threshold>0 && $threshold<1}} ok] || !$ok} {
        error "Invalid collapse threshold"
    }
}
proc ::CCRAutoVolume::jacobian {en xyz bary} {
    variable derivativeCache; variable sampleKeys
    set key [list [llength $en] $bary]
    if {[dict exists $derivativeCache $key]} {
        set derivatives [dict get $derivativeCache $key]
    } else {
    set gradients {{-1 -1 -1} {1 0 0} {0 1 0} {0 0 1}}
    set derivatives {}
    foreach l $bary g $gradients {
        set d {};foreach v $g {lappend d [expr {(4*$l-1)*$v}]};lappend derivatives $d
    }
    foreach pair {{0 1} {1 2} {2 0} {0 3} {1 3} {2 3}} {
        lassign $pair i j;set d {}
        foreach u [lindex $gradients $i] v [lindex $gradients $j] {lappend d [expr {4*([lindex $bary $j]*$u+[lindex $bary $i]*$v)}]}
        lappend derivatives $d
    }
    if {[llength $en]==4} {set derivatives $gradients}
        if {[dict exists $sampleKeys $key]} {dict set derivativeCache $key $derivatives}
    }
    set columns {}
    foreach k {0 1 2} {
        set column {0 0 0}
        foreach n $en d $derivatives {
            set updated {};foreach a $column b [dict get $xyz $n] {lappend updated [expr {$a+$b*[lindex $d $k]}]};set column $updated
        }
        lappend columns $column
    }
    lassign [lindex $columns 0] a b c
    lassign [lindex $columns 1] d e f
    lassign [lindex $columns 2] g h i
    return [expr {$a*($e*$i-$f*$h)-$b*($d*$i-$f*$g)+$c*($d*$h-$e*$g)}]
}
proc ::CCRAutoVolume::rule {} {
    set result [list [list -.8 {.25 .25 .25 .25}]]
    foreach i {0 1 2 3} {set bary [lrepeat 4 [expr {1./6}]];lset bary $i .5;lappend result [list .45 $bary]}
    return $result
}
proc ::CCRAutoVolume::volume {rows xyz} {
    set total 0.
    dict for {id row} $rows {
        lassign $row cfg pid en
        if {$cfg ni {204 210} || [llength $en] != [expr {$cfg==210?10:4}]} {error "Unsupported tetrahedron connectivity"}
        set value 0.
        foreach sample [rule] {lassign $sample weight bary;set value [expr {$value+$weight*[jacobian $en $xyz $bary]/6.}]}
        if {$value<=0} {error "Non-positive signed isoparametric volume"}
        set total [expr {$total+$value}]
    }
    return $total
}
proc ::CCRAutoAudit::attributes ids {
 set result {}
 foreach id $ids {
  set values {};set maximum [hm_attributeindexmax elements $id -byid]
  for {set i 1} {$i<=$maximum} {incr i} {
   set identifier [hm_attributeindexidentifier elements $id $i -byid]
   dict set values $identifier [list [hm_attributeindexvalue elements $id $i -byid] [hm_attributeindextype elements $id $i -byid] [hm_attributeindexstatus elements $id $i -byid] [hm_attributeindexsolver elements $id $i -byid]]
  }
  dict set result $id [dict create solver_id {} type [hm_getvalue elems id=$id dataname=type] component [hm_getvalue elems id=$id dataname=collector.id] attributes $values]
 }
 return $result
}
proc ::CCRAutoAudit::globalFailures {} {
 *createmark elems 1 all
 return [::CCRAutoMesh::failed [hm_getelemcheckvalues 1 3 tetracollapse]]
}
proc ::CCRAutoAudit::globalInvalidJacobian {} {
 set method [hm_getelementcheckmethod jacobian_3d];set result {}
 set rc [catch {
  foreach mode {2 3} {
   *jacobian_calculate_cornerpts $mode;*createmark elems 1 all
   foreach {id value} [hm_getelemcheckvalues 1 3 jacobian] {if {$value<=0} {dict set result [list $mode $id] $value}}
  }
 } reason]
 *jacobian_calculate_cornerpts $method
 if {$rc} {error $reason}
 return $result
}
proc ::CCRAutoAudit::optionalIdentity {id} {
    if {![catch {hm_getsolverid elems $id -byid} pair]} {return $pair}
    if {[string first "pool name not found" $pair]>=0} {return {}}
    error "Element $id solver lookup failed: $pair"
}
proc ::CCRAutoAudit::guardReplaceable {ids} {
    set metadata [attributes $ids]
    if {[dict size $metadata]!=[llength $ids]} {error "Incomplete element metadata"}
    dict for {id entry} $metadata {
        set pair [dict get $entry solver_id]
        if {[llength $pair]} {
            if {[llength $pair]!=2 || [lindex $pair 0]!=$id || [lindex $pair 1] ne "structural_idpool"} {error "Unsupported solver identity at element $id"}
        }
        dict for {identifier tuple} [dict get $entry attributes] {
            if {$identifier==8181 && [lindex $tuple 1]==14 && [lindex $tuple 0] eq $id} {continue}
            error "Unsupported element attribute $identifier at element $id"
        }
    }
    return $metadata
}
proc ::CCRAutoAudit::jacobian ids {
 if {![llength $ids]} {return {}}
 set method [hm_getelementcheckmethod jacobian_3d];set result {}
 set rc [catch {
  foreach mode {2 3} {
   *jacobian_calculate_cornerpts $mode;*createmark elems 1 {*}$ids
   foreach {id value} [hm_getelemcheckvalues 1 3 jacobian] {dict set result [list $mode $id] $value}
  }
 } reason]
 *jacobian_calculate_cornerpts $method
 if {$rc} {error $reason}
 return $result
}
proc ::CCRAutoAudit::jacobianSubset {snapshot ids} {
 set result {}
 foreach mode {2 3} {
  foreach id $ids {
   set key [list $mode $id]
   if {![dict exists $snapshot $key]} {error "Incomplete Jacobian snapshot for $id mode $mode"}
   dict set result $key [dict get $snapshot $key]
  }
 }
 return $result
}
proc ::CCRAutoMapping::guardLiveReferences {input plan} {
 set rows [dict get $input elements]
 if {![::CCRAutoMesh::sameDict $rows [::CCRAutoMesh::elements [dict keys $rows]]]} {error "Host patch differs from worker input"}
 set xyz [dict get $input coordinates]
 if {![::CCRAutoMesh::sameDict $xyz [::CCRAutoMesh::coords [dict keys $xyz]]]} {error "Host coordinates differ from worker input"}
 set changed [dict get $plan changed_original_nodes]
 if {[llength $changed] && ![::CCRAutoMesh::containedNodes $changed $rows]} {error "Changed original nodes have external or unsupported references"}
 return 1
}
proc ::CCRAutoMapping::plan {input result hostMaximum} {
 if {![string is integer -strict $hostMaximum] || $hostMaximum<0} {error "Invalid host maximum node ID"}
 set oldXYZ [dict get $input coordinates];set resultXYZ [dict get $result coordinates]
 set oldRows [dict get $input elements];set rows [dict get $result elements]
 set expectedConfig [dict get $input config];set expectedProperty [dict get $input property]
 if {$expectedConfig ni {204 210}} {error "Unsupported worker element configuration"}
 dict for {id row} $rows {
  lassign $row cfg pid ns
  if {[llength $row]!=3 || $cfg!=$expectedConfig || $pid!=$expectedProperty || [llength $ns]!=($cfg==210?10:4)} {error "Worker row order/property/connectivity size mismatch: $id"}
 }
 dict for {id point} $resultXYZ {
  if {[llength $point]!=3} {error "Worker coordinate length mismatch: $id"}
  foreach value $point {
   if {![string is double -strict $value] || [catch {expr {abs($value)<Inf}} finite] || !$finite} {error "Invalid worker coordinate: $id"}
  }
 }
 foreach id [dict keys $oldXYZ] {if {$id>$hostMaximum} {error "Host maximum excludes an original node"}}
 set boundaryNodes {}
 dict for {key face} [::CCRAutoMesh::boundary $oldRows] {foreach n $face {dict set boundaryNodes $n 1}}
 dict for {n unused} $boundaryNodes {
  if {![dict exists $resultXYZ $n] || [dict get $resultXYZ $n] ne [dict get $oldXYZ $n]} {error "Protected original node changed or missing: $n"}
 }
 set mapping {};set freshXYZ {};set retainedXYZ {};set next $hostMaximum
 foreach id [lsort -integer [dict keys $resultXYZ]] {
  if {[dict exists $oldXYZ $id]} {dict set mapping $id $id;dict set retainedXYZ $id [dict get $resultXYZ $id]} else {
   incr next;dict set mapping $id $next;dict set freshXYZ $next [dict get $resultXYZ $id]
  }
 }
 set mappedRows {}
 dict for {id row} $rows {
  lassign $row cfg pid ns;set mapped {}
  foreach n $ns {
   if {![dict exists $mapping $n]} {error "Connectivity references missing worker coordinate: $n"}
   lappend mapped [dict get $mapping $n]
  }
  if {[llength [lsort -unique $mapped]]!=[llength $mapped]} {error "Repeated node in mapped element: $id"}
  dict set mappedRows $id [list $cfg $pid $mapped]
 }
 if {![::CCRAutoMesh::sameDict [::CCRAutoMesh::boundary $oldRows] [::CCRAutoMesh::boundary $mappedRows]]} {error "Mapped interface differs"}
 set removed {}
 foreach n [dict keys $oldXYZ] {if {![dict exists $resultXYZ $n]} {lappend removed $n}}
 set changed $removed
 dict for {n point} $retainedXYZ {if {$point ne [dict get $oldXYZ $n]} {lappend changed $n}}
 return [dict create node_map $mapping new_coordinates $freshXYZ retained_coordinates $retainedXYZ elements $mappedRows removed_original_nodes $removed changed_original_nodes [lsort -unique -integer $changed] next_node_id $next]
}
proc ::CCRAutoImport::run {input result {forceReject 0}} {
    if {![string is boolean -strict $forceReject]} {error "Invalid force-rejection flag"}
    ::CCRAutoMesh::version
    ::CCRAutoMesh::validateThreshold
    if {$::CCRAutoMesh::recoveryRequired} {error "Recovery required"}
set plan [::CCRAutoMapping::plan $input $result [hm_entitymaxid nodes]]
::CCRAutoMapping::guardLiveReferences $input $plan
set cid [dict get $input cid];set originalRows [dict get $input elements];set originalXYZ [dict get $input coordinates]
set compRows [::CCRAutoMesh::component $cid];set compXYZ [::CCRAutoMesh::coords [::CCRAutoMesh::nodes $compRows]]
set originalQuality [::CCRAutoMesh::quality [dict keys $compRows]]
set originalJacobian [::CCRAutoAudit::jacobian [dict keys $compRows]]
set originalAttributes [::CCRAutoAudit::attributes [dict keys $originalRows]]
set originalComponentPid [hm_getvalue comps id=$cid dataname=propertyid]
set outsideRows $compRows
foreach id [dict keys $originalRows] {dict unset outsideRows $id}
if {[lsort -integer [dict keys $originalQuality]] ne [lsort -integer [dict keys $compRows]]} {error "Incomplete component quality snapshot"}
set outsideQuality [::CCRAutoMesh::subset $originalQuality [dict keys $outsideRows]]
set outsideJacobian [::CCRAutoAudit::jacobianSubset $originalJacobian [dict keys $outsideRows]]
set originalBadCount [llength [::CCRAutoMesh::failed [::CCRAutoMesh::subset $originalQuality [dict keys $originalRows]]]]
if {!$originalBadCount} {return [dict create accepted 0 reason "Already meets threshold" changed 0]}
set keepResult [expr {!$forceReject}]
set globalBad [::CCRAutoAudit::globalFailures]
set globalInvalid [::CCRAutoAudit::globalInvalidJacobian]
dict for {id metadata} $originalAttributes {
 set attrs [dict get $metadata attributes];set sid [dict get $metadata solver_id]
 dict for {identifier tuple} $attrs {
  if {$identifier==8181 && [lindex $tuple 1]==14 && [lindex $tuple 0] eq [lindex $sid 0] && [lindex $sid 1] eq "structural_idpool"} {continue}
  error "Worker attribute transfer not implemented for element $id attribute $identifier"
 }
}
set types {};set solver {};set commonType {}
dict for {id row} $originalRows {
 set type [hm_getvalue elems id=$id dataname=type];dict set types $id $type
 if {$commonType eq {}} {set commonType $type} elseif {$type!=$commonType} {error "Mixed element types not yet supported by worker import test"}
 dict set solver elems $id [::CCRAutoAudit::optionalIdentity $id]
}
dict for {n point} [dict get $plan retained_coordinates] {if {$point ne [dict get $originalXYZ $n]} {error "Moved-original import not yet implemented"}}
*currentcollector components [hm_getvalue comps id=$cid dataname=name]
set newNodes {};set newElements {}
set accepted 0
puts "WORKER_HOST_IMPORT_START original=[dict size $originalRows] planned=[dict size [dict get $plan elements]] new_nodes=[dict size [dict get $plan new_coordinates]]"
flush stdout
set rc [catch {
 set nodeStart [clock milliseconds];set renumbered 0
 dict for {id point} [dict get $plan new_coordinates] {
  lassign $point x y z;*createnode $x $y $z 0 0 0
  set fresh [hm_latestentityid nodes];lappend newNodes $fresh
  if {$fresh!=$id} {*createmark nodes 1 $fresh;*renumber nodes 1 $id 1 0 0;incr renumbered}
  lset newNodes end $id
 }
 puts "WORKER_HOST_NODE_CREATE_MS=[expr {[clock milliseconds]-$nodeStart}] renumbered=$renumbered"
 flush stdout
 *createmark elems 1 {*}[dict keys $originalRows];*deletemark elems 1
 set expected {}
 set elementStart [clock milliseconds]
 dict for {workerId row} [dict get $plan elements] {
  lassign $row cfg pid ns;*createlist nodes 1 {*}$ns;*createelement $cfg $commonType 1 0
  set fresh [hm_latestentityid elems];lappend newElements $fresh
  dict set expected $fresh $row
 }
 # Homogeneous packet checked below; assign once after creating all replacements.
 set pid [dict get $input property]
 dict for {id row} $expected {if {[lindex $row 1]!=$pid} {error "Mixed replacement properties"}}
 *createmark elems 1 {*}$newElements
 *setvalue elems mark=1 propertyid=$pid
 puts "WORKER_HOST_ELEMENT_CREATE_MS=[expr {[clock milliseconds]-$elementStart}]"
 flush stdout
 if {![::CCRAutoMesh::sameDict $expected [::CCRAutoMesh::elements $newElements]]} {error "Imported connectivity/property mismatch"}
 if {![::CCRAutoMesh::sameDict [::CCRAutoMesh::boundary $originalRows] [::CCRAutoMesh::boundary $expected]]} {error "Imported boundary mismatch"}
 set plannedXYZ [dict merge [dict get $plan retained_coordinates] [dict get $plan new_coordinates]]
 if {![::CCRAutoMesh::sameDict $plannedXYZ [::CCRAutoMesh::coords [dict keys $plannedXYZ]]]} {error "Imported coordinates mismatch"}
 set oldVolume [::CCRAutoVolume::volume $originalRows $originalXYZ]
 set newVolume [::CCRAutoVolume::volume $expected $plannedXYZ]
 if {abs($oldVolume-$newVolume)>1e-8*max(1.0,abs($oldVolume))} {error "Imported signed volume mismatch"}
 puts "WORKER_HOST_IMPORT_CREATED=[llength $newElements] [llength $newNodes]"
 if {!$keepResult} {error "Injected post-import rejection"}
 set importedQuality [::CCRAutoMesh::quality $newElements]
 set importedBadCount [llength [::CCRAutoMesh::failed $importedQuality]]
 if {$importedBadCount>=$originalBadCount} {error "No improvement"}
 dict for {key value} [::CCRAutoAudit::jacobian $newElements] {if {$value<=0} {error "Imported Jacobian failure"}}
 if {![::CCRAutoMesh::sameDict $outsideRows [::CCRAutoMesh::elements [dict keys $outsideRows]]]} {error "Outside connectivity/property differs"}
 if {![::CCRAutoMesh::sameDict $outsideQuality [::CCRAutoMesh::quality [dict keys $outsideRows]]]} {error "Outside quality differs"}
 if {![::CCRAutoMesh::sameDict $outsideJacobian [::CCRAutoAudit::jacobian [dict keys $outsideRows]]]} {error "Outside Jacobian differs"}
 set expectedBad {}
 foreach id $globalBad {if {![dict exists $originalRows $id]} {lappend expectedBad $id}}
 set expectedBad [concat $expectedBad [::CCRAutoMesh::failed $importedQuality]]
 if {[lsort -integer $expectedBad] ne [lsort -integer [::CCRAutoAudit::globalFailures]]} {error "Global failed set differs outside import"}
 if {![::CCRAutoMesh::sameDict $globalInvalid [::CCRAutoAudit::globalInvalidJacobian]]} {error "Global invalid Jacobian differs"}
 set liveRows [::CCRAutoMesh::component $cid];set liveXYZ [::CCRAutoMesh::coords [::CCRAutoMesh::nodes $liveRows]]
 set liveQuality [::CCRAutoMesh::quality [dict keys $liveRows]];set liveJacobian [::CCRAutoAudit::jacobian [dict keys $liveRows]]
 puts "WORKER_HOST_GLOBAL_FAILURES=[llength $globalBad] [llength $expectedBad]"
 puts "WORKER_HOST_IMPORT_QUALITY=$originalBadCount $importedBadCount"
 if {[hm_getvalue comps id=$cid dataname=propertyid] ne $originalComponentPid} {error "Component property mismatch"}
 set newMetadata [::CCRAutoAudit::guardReplaceable $newElements]
 set seenSolver {}
 dict for {id metadata} $newMetadata {
  if {[dict get $metadata component]!=$cid || [dict get $metadata type]!=$commonType} {error "Replacement component/type mismatch"}
  set pair [dict get $metadata solver_id]
  if {[dict exists $seenSolver $pair]} {error "Duplicate replacement solver ID"}
  dict set seenSolver $pair 1
 }
 set accepted 1
} reason]
puts "WORKER_HOST_IMPORT_TRIAL_RC=$rc reason=$reason"
flush stdout
if {$accepted && !$rc} {return [dict create accepted 1 new_elements $newElements new_nodes $newNodes original_elements [dict keys $originalRows] failures_before $originalBadCount failures_after $importedBadCount global_before [llength $globalBad] global_after [llength $expectedBad]]}
set restoreRc [catch {
set restoreStart [clock milliseconds]
if {[catch {::CCRAutoMesh::restoreCavity $originalRows $originalXYZ $types $solver $newElements $newNodes $cid} restoreReason]} {set ::CCRAutoMesh::recoveryRequired 1;error "Recovery required: $restoreReason"}
puts "WORKER_HOST_RESTORE_MS=[expr {[clock milliseconds]-$restoreStart}]"
if {![::CCRAutoMesh::sameDict $compRows [::CCRAutoMesh::component $cid]] || ![::CCRAutoMesh::sameDict $compXYZ [::CCRAutoMesh::coords [dict keys $compXYZ]]]} {error "Component restore mismatch"}
if {![::CCRAutoMesh::sameDict $originalQuality [::CCRAutoMesh::quality [dict keys $compRows]]]} {error "Quality restore mismatch"}
if {![::CCRAutoMesh::sameDict $originalJacobian [::CCRAutoAudit::jacobian [dict keys $compRows]]]} {error "Jacobian restore mismatch"}
if {![::CCRAutoMesh::sameDict $originalAttributes [::CCRAutoAudit::attributes [dict keys $originalRows]]]} {error "Attributes restore mismatch"}
if {[hm_getvalue comps id=$cid dataname=propertyid] ne $originalComponentPid} {error "Component property restore mismatch"}
puts WORKER_HOST_RESTORE_JACOBIAN_ATTRIBUTES_VERIFIED
if {[lsort -integer $globalBad] ne [lsort -integer [::CCRAutoAudit::globalFailures]] || ![::CCRAutoMesh::sameDict $globalInvalid [::CCRAutoAudit::globalInvalidJacobian]]} {error "Global restore quality/Jacobian mismatch"}
puts WORKER_HOST_RESTORE_GLOBAL_QUALITY_JACOBIAN_VERIFIED

} restoreAuditReason]
if {$restoreRc} {set ::CCRAutoMesh::recoveryRequired 1;error "Recovery required: $restoreAuditReason"}
if {!$forceReject} {return [dict create accepted 0 reason $reason restored 1]}
if {$reason ne "Injected post-import rejection"} {error "Restored after unexpected import failure: $reason"}
if {[llength $newElements]!=[dict size [dict get $plan elements]]} {error "Forced restore did not cover full import"}
return [dict create accepted 0 reason $reason restored 1 original_elements [dict keys $originalRows]]

}
namespace eval ::CCRAutoVolume {variable derivativeCache {};variable sampleKeys {}}
foreach count {4 10} {foreach sample [::CCRAutoVolume::rule] {dict set ::CCRAutoVolume::sampleKeys [list $count [lindex $sample 1]] 1}}


# Fresh fixed-shell engine. This procedure runs only in an empty HM2022 worker.
namespace eval ::CCRAutoShell {}
proc ::CCRAutoShell::canonicalFace {ns} {
    set corners [lsort -integer [lrange $ns 0 2]]
    if {[llength $ns]==3} {return $corners}
    if {[llength $ns]!=6} {error "Unsupported shell face"}
    set edges {}
    foreach pair {{0 1 3} {1 2 4} {0 2 5}} {
        lassign $pair a b m
        dict set edges [lsort -integer [list [lindex $ns $a] [lindex $ns $b]]] [lindex $ns $m]
    }
    set ordered {}
    foreach edge [lsort -dictionary [dict keys $edges]] {lappend ordered $edge [dict get $edges $edge]}
    return [list $corners $ordered]
}
proc ::CCRAutoShell::boundary {rows} {
    set faces {}
    dict for {id row} $rows {
        lassign $row cfg pid ns
        if {$cfg==204} {set patterns {{0 1 2} {0 1 3} {0 2 3} {1 2 3}}} elseif {$cfg==210} {
            set patterns {{0 1 2 4 5 6} {0 1 3 4 8 7} {0 2 3 6 9 7} {1 2 3 5 9 8}}
        } else {error "Select Tet4 or Tet10 elements only"}
        foreach pattern $patterns {
            set face {};foreach i $pattern {lappend face [lindex $ns $i]}
            set key [lsort -integer [lrange $face 0 2]]
            dict lappend faces $key [canonicalFace $face]
        }
    }
    set boundary {}
    dict for {key entries} $faces {
        if {[llength $entries]>2} {error "Non-manifold cavity"}
        if {[llength $entries]==2 && [lindex $entries 0] ne [lindex $entries 1]} {error "Nonconforming quadratic internal face"}
        if {[llength $entries]==1} {dict set boundary $key [lindex $entries 0]}
    }
    return $boundary
}
proc ::CCRAutoShell::shellBoundary {rows} {
    set result {}
    dict for {id row} $rows {
        lassign $row cfg pid ns
        if {$cfg ni {103 106} || [llength $ns]!=($cfg==106?6:3)} {error "Find faces produced an unsupported shell"}
        set key [lsort -integer [lrange $ns 0 2]]
        if {[dict exists $result $key]} {error "Duplicate temporary face"}
        dict set result $key [canonicalFace $ns]
    }
    return $result
}

namespace eval ::CCR {
    variable busy 0;variable input {};variable threshold 0.1;variable topmost 1
    variable qualityValue --;variable status "Select elements, then Proceed."
    variable checked {};variable replaced {};variable report {};variable forceReject 0
}
proc ::CCR::message {text} {
    set ::CCR::status $text
    puts "Comp Cavity Remesh: $text"
    if {[llength [info commands update]]} {update idletasks}
}
proc ::CCR::validate {} {
    variable threshold
    if {![string is double -strict $threshold] || [catch {expr {$threshold>0 && $threshold<1 && abs($threshold)<Inf}} ok] || !$ok} {error "Enter a Tet Collapse threshold between 0 and 1."}
    set ::CCRAutoMesh::threshold $threshold
}
proc ::CCR::parseIds {} {
    variable input
    set ids {}
    foreach token [split [string map {, " " ; " " \n " " \t " "} $input] " "] {
        if {$token eq {}} {continue}
        if {![string is integer -strict $token] || $token<=0} {error "Enter numeric element IDs separated by spaces or commas."}
        lappend ids $token
    }
    return [lsort -integer -unique $ids]
}
proc ::CCR::index {rows} {
    set adjacency {}
    dict for {id row} $rows {
        set ns [lindex $row 2]
        foreach pattern {{0 1 2} {0 1 3} {0 2 3} {1 2 3}} {
            set face {};foreach i $pattern {lappend face [lindex $ns $i]}
            dict lappend adjacency [lsort -integer $face] $id
        }
    }
    return $adjacency
}

proc ::CCR::regions {rows adjacency seeds layers {limit 0}} {
    set seen {};set result {}
    foreach start [lsort -integer $seeds] {
        if {[dict exists $seen $start]} {continue}
        set queue [list $start];dict set seen $start 1
        for {set i 0} {$i<[llength $queue]} {incr i} {
            set ns [lindex [dict get $rows [lindex $queue $i]] 2]
            foreach pattern {{0 1 2} {0 1 3} {0 2 3} {1 2 3}} {
                set face {};foreach j $pattern {lappend face [lindex $ns $j]}
                foreach neighbor [dict get $adjacency [lsort -integer $face]] {
                    if {![dict exists $seen $neighbor]} {dict set seen $neighbor 1;lappend queue $neighbor}
                }
            }
        }
        lappend result [lsort -integer $queue]
    }
    return $result
}
namespace eval ::CCRFlow {}
proc ::CCRFlow::focus {cid} {
    if {[info exists ::CCRUI::debugMode] && $::CCRUI::debugMode} {return}
    *createmark comps 1 "by id only" $cid
    *createstringarray 2 "elements_on" "geometry_on"
    *isolateonlyentitybymark 1 1 2
}
proc ::CCR::plans {selection layers cacheName} {
    upvar 1 $cacheName cache
    set rows [::CCRAutoMesh::elements $selection]
    if {[dict size $rows]!=[llength $selection]} {error "Some element IDs no longer exist. Select again."}
    *createmark elems 1 {*}$selection
    set groups {}
    foreach id [hm_getvalue elems mark=1 dataname=id] cid [hm_getvalue elems mark=1 dataname=collector.id] {
        set row [dict get $rows $id]
        lassign $row cfg pid ns
        if {$cfg ni {204 210}} {error "Select Tet4 or Tet10 elements only."}
        if {$pid<=0} {error "Elements need an assigned property."}
        dict lappend groups [list $cid $cfg $pid] $id
    }
    set cache $rows;set rejected {};set plans {};set groupIndex 0;set groupCount [dict size $groups]
    dict for {key seeds} $groups {
        incr groupIndex
        lassign $key cid cfg pid
        ::CCRFlow::focus $cid
        # Expand natively from the selected IDs, never from all displayed cells.
        # Filter every ring before using it as the next input, so shared nodes
        # cannot carry the expansion through another component/property/order.
        set kept $seeds;set frontier $seeds
        set partition [::CCRAutoMesh::subset $rows $seeds]
        for {set depth 0} {$depth<$layers && [llength $frontier]} {incr depth} {
            ::CCRFlow::note "Group $groupIndex/$groupCount | Component $cid | Expand layer [expr {$depth+1}]/$layers | [llength $frontier] new solids"
            *createmark elems 1 {*}$frontier
            *clearmark elems 2
            *findmark elems 1 1 1 elems 0 2
            set unseen {}
            foreach id [hm_getmark elems 2] {
                if {![dict exists $partition $id] && ![dict exists $rejected $key $id]} {lappend unseen $id}
            }
            set frontier {};set matching {};set fresh {};set otherComp 0;set otherProperty 0;set otherOrder 0
            if {[llength $unseen]} {
                *createmark elems 1 {*}$unseen
                set candidateIds [hm_getvalue elems mark=1 dataname=id]
                set candidateCids [hm_getvalue elems mark=1 dataname=collector.id]
                if {[llength $candidateIds]!=[llength $candidateCids]} {error "Incomplete adjacent-element query."}
                foreach id $candidateIds candidateCid $candidateCids {
                    if {$candidateCid!=$cid} {dict set rejected $key $id 1;incr otherComp;continue}
                    lappend matching $id
                    if {![dict exists $cache $id]} {lappend fresh $id}
                }
                if {[llength $fresh]} {set cache [dict merge $cache [::CCRAutoMesh::elements $fresh]]}
                foreach id $matching {
                    if {![dict exists $cache $id]} {error "Adjacent element $id is missing."}
                    set row [dict get $cache $id]
                    if {[lindex $row 0]!=$cfg} {dict set rejected $key $id 1;incr otherOrder;continue}
                    if {[lindex $row 1]!=$pid} {dict set rejected $key $id 1;incr otherProperty;continue}
                    dict set partition $id $row;lappend frontier $id
                }
            }
            ::CCRFlow::note "Layer [expr {$depth+1}]: added [llength $frontier]; total [dict size $partition]. Excluded: $otherComp other component, $otherProperty other property, $otherOrder other type."
            set kept [dict keys $partition]
        }
        ::CCRFlow::focus $cid
        # Only filtered elements of this component/property/order reach the patch.
        lappend plans [list $cid $cfg $pid $partition]
    }
    set merged {}
    foreach plan $plans {
        lassign $plan cid cfg pid rows
        set key [list $cid $cfg $pid]
        if {![dict exists $merged $key]} {dict set merged $key {}}
        dict set merged $key [dict merge [dict get $merged $key] $rows]
    }
    set grouped {}
    dict for {key rows} $merged {
        lappend grouped [concat $key [list $rows]]
    }
    set covered {}
    foreach plan $grouped {dict for {id row} [lindex $plan 3] {dict set covered $id 1}}
    set missing {};foreach id $selection {if {![dict exists $covered $id]} {lappend missing $id}}
    if {[llength $missing]} {error "Expansion missed selected elements: $missing. No solids were deleted."}
    return $grouped
}
proc ::CCR::signature {cid cfg pid rows xyz threshold} {
    set r {};foreach id [lsort -integer [dict keys $rows]] {lappend r $id [dict get $rows $id]}
    set p {};foreach id [lsort -integer [dict keys $xyz]] {lappend p $id [dict get $xyz $id]}
    return [list $cid $cfg $pid $threshold $r $p]
}

# Internal continuous transaction. No model files are saved by this tool.
namespace eval ::CCRFlow {variable detailedChecks 0;variable state idle;variable journal {};variable log {};variable mutated 0}
proc ::CCRFlow::active {} {expr {$::CCRFlow::state ni {idle committed restored}}}
proc ::CCRFlow::progressText {text} {
    variable journal
    if {[active] && [dict exists $journal areaIndex] && [dict exists $journal areaTotal]} {
        return "Area [dict get $journal areaIndex]/[dict get $journal areaTotal] | Component [dict get $journal cid] | $text"
    }
    return $text
}
proc ::CCRFlow::note {text} {
    set text [progressText $text]
    variable log
    lappend log "[clock format [clock seconds] -format %H:%M:%S]  $text"
    ::CCR::message $text
    if {[llength [info commands ::CCRUI::logRefresh]]} {::CCRUI::logRefresh}
}
proc ::CCRFlow::ids {kind} {*createmark $kind 1 all;return [hm_getmark $kind 1]}
proc ::CCRFlow::difference {now before} {
    set known {};foreach id $before {dict set known $id 1}
    set result {};foreach id $now {if {![dict exists $known $id]} {lappend result $id}}
    return $result
}
proc ::CCRFlow::require {allowed} {
    if {$::CCRFlow::state ni $allowed} {error "Finish the preceding step first."}
    if {$::CCRAutoMesh::recoveryRequired} {error "Recovery required. Inspect the model."}
    ::CCRAutoMesh::version
}
proc ::CCRFlow::original {} {
    require {expanded}
    variable journal
    set rows [dict get $journal rows];set ids [dict keys $rows];set cid [dict get $journal cid]
    ::CCRAutoMesh::guardReferences $ids
    if {$::CCRFlow::detailedChecks} {
        set attrs [::CCRAutoAudit::guardReplaceable $ids]
    } else {
        set attrs {}
        *createmark elems 1 {*}$ids
        set originalTypes [hm_getvalue elems mark=1 dataname=type]
        set originalIds [hm_getvalue elems mark=1 dataname=id]
        foreach id $originalIds elementType $originalTypes {
            dict set attrs $id [dict create type $elementType component $cid solver_id {}]
        }
    }
    dict for {id meta} $attrs {if {[dict get $meta component]!=$cid} {error "Original component assignment changed. Expand again."}}
    set types {};set solver {}
    dict for {id meta} $attrs {dict set types $id [dict get $meta type];if {[llength [dict get $meta solver_id]]==2} {dict set solver elems $id [dict get $meta solver_id]}}
    set xyz [::CCRAutoMesh::coords [::CCRAutoMesh::nodes $rows]]
    set comp {};set outside {}
    if {$::CCRFlow::detailedChecks} {
        set comp [::CCRAutoMesh::component $cid];set outside $comp
        foreach id $ids {dict unset outside $id}
    }
    set q [::CCRAutoMesh::quality $ids]
    if {![llength [::CCRAutoMesh::failed $q]]} {error "This area already meets the threshold. Expand another area."}
    set compXYZ [::CCRAutoMesh::coords [::CCRAutoMesh::nodes $comp]]
    foreach {key value} [list xyz $xyz boundary {} volume [expr {$::CCRFlow::detailedChecks?[::CCRAutoVolume::volume $rows $xyz]:0.0}] types $types solver $solver attributes $attrs outside $outside compXYZ $compXYZ quality $q componentPid [hm_getvalue comps id=$cid dataname=propertyid] oldOrder [hm_getoption element_order] oldCollector [hm_info currentcollector component]] {dict set journal $key $value}
    set ::CCRFlow::state checked
    note "Area prepared: [dict size $rows] solids, [llength [::CCRAutoMesh::failed $q]] below threshold. Original data is held in memory for Restore original."
}
proc ::CCRFlow::unchanged {} {return}
proc ::CCRFlow::find {} {
    require {checked};variable journal
    *createmark comps 1 "^faces"
    if {[llength [hm_getmark comps 1]]} {error "An existing ^faces component is not owned by this tool. Rename it before Find faces."}
    set cid [dict get $journal cid];set rows [dict get $journal rows]
    set originals [dict keys $rows];set first [lindex [lsort -integer $originals] 0]
    ::CCRFlow::focus $cid
    hm_entityrecorder comps on
    set ::CCRFlow::mutated 1
    set rc [catch {*createmark elements 1 {*}$originals;*findfaces elements 1} detail]
    set recorderRC [catch {hm_entityrecorder comps off;set createdComps [hm_entityrecorder comps ids]} recorderError]
    if {$recorderRC} {error "Component recorder: $recorderError"}
    dict set journal temporaryComps $createdComps
    set faceRows {};set faceComps {}
    *createmark comps 1 "^faces"
    foreach faceCid [hm_getmark comps 1] {
        if {$faceCid in $createdComps} {
            lappend faceComps $faceCid
            set faceRows [dict merge $faceRows [::CCRAutoMesh::component $faceCid]]
        }
    }
    dict set journal faces [dict keys $faceRows];dict set journal faceComps $faceComps
    if {$rc} {error $detail}
    if {![dict size $faceRows]} {error "Find faces produced no faces."}
    set labels {}
    foreach faceCid $faceComps {
        set name "CCR_Faces_C${cid}_E${first}_[clock clicks]"
        *setvalue comps id=$faceCid name=$name
        lappend labels $name
    }
    # Build owner tags from existing connectivity; no per-element HM calls.
    set parents {}
    dict for {id row} $rows {
        set ns [lindex $row 2]
        foreach pattern {{0 1 2} {0 1 3} {0 2 3} {1 2 3}} {
            set face {};foreach i $pattern {lappend face [lindex $ns $i]}
            dict lappend parents [lsort -integer $face] $id
        }
    }
    set owners {}
    dict for {faceId row} $faceRows {
        set key [lsort -integer [lrange [lindex $row 2] 0 2]]
        if {![dict exists $parents $key] || [llength [dict get $parents $key]]!=1} {
            error "Face $faceId cannot be linked to one original solid. Solids have not been deleted."
        }
        dict set owners $faceId [dict create component $cid solid [lindex [dict get $parents $key] 0]]
    }
    dict set journal faceOwners $owners;dict set journal faceNames $labels
    dict set journal faceOriginalSolids $originals
    set ::CCRFlow::state faces
    note "Found [dict size $faceRows] faces in [join $labels {, }]. Each face is tagged with its original solid ID in memory."
}
proc ::CCRFlow::delete {} {
    require {faces};unchanged
    variable journal
    if {$::CCRFlow::detailedChecks && ![::CCRAutoMesh::sameDict [dict get $journal attributes] [::CCRAutoAudit::guardReplaceable [dict keys [dict get $journal rows]]]]} {error "Original solid metadata changed. Restore or expand again."}
    set ::CCRFlow::state deleted
    *createmark elems 1 {*}[dict keys [dict get $journal rows]];*deletemark elems 1
    if {[dict size [::CCRAutoMesh::elements [dict keys [dict get $journal rows]]]]} {error "Not all selected solids were deleted. Use Rebuild original."}
    set ::CCR::qualityValue --
    note "Deleted [dict size [dict get $journal rows]] original solids. Temporary faces remain to enclose the empty area."
}
namespace eval ::CCRUI {}
proc ::CCRFlow::meshNative {} {
    require {deleted};variable journal
    set start [clock milliseconds]
    *currentcollector components [hm_getvalue comps id=[dict get $journal cid] dataname=name]
    set order [expr {[dict get $journal config]==210?2:1}]
    *elementorder $order
    *createmark elements 2 {*}[dict get $journal faces]
    set threshold [dict get $journal threshold]
    set options [expr {$order==2?1059:35}]
    *createstringarray 2 "pars: upd_shell fix_comp_bdr el2comp=1 tet_clps='$threshold,1.000000,0' max_size='0,0,1.79769e+308'" "tet: $options 1.3 -1 0 0.8 0 0 1"
    hm_entityrecorder comps on
    hm_entityrecorder nodes on
    hm_entityrecorder elems on
    set prepareMs [expr {[clock milliseconds]-$start}]
    set nativeStart [clock milliseconds]
    set rc [catch {*tetmesh elements 2 1 elements 0 -1 1 2} detail]
    dict set journal nativeMeshMs [expr {[clock milliseconds]-$nativeStart}]
    set collectStart [clock milliseconds]
    set compRC [catch {hm_entityrecorder comps off;set meshComps [hm_entityrecorder comps ids]} compError]
    if {!$compRC} {dict set journal temporaryComps [lsort -integer -unique [concat [dict get $journal temporaryComps] $meshComps]]}
    set elemRC [catch {hm_entityrecorder elems off;set recordedElements [hm_entityrecorder elems ids]} elemError]
    set nodeRC [catch {hm_entityrecorder nodes off;set recordedNodes [hm_entityrecorder nodes ids]} nodeError]
    if {!$elemRC} {dict set journal new $recordedElements;dict set journal recordedElements $recordedElements}
    if {!$nodeRC} {dict set journal newNodes $recordedNodes}
    *elementorder [dict get $journal oldOrder]
    dict set journal prepareMeshMs $prepareMs
    dict set journal recorderMs [expr {[clock milliseconds]-$collectStart}]
    if {$compRC} {error "Component recorder: $compError"}
    if {$elemRC} {error "Element recorder: $elemError"}
    if {$nodeRC} {error "Node recorder: $nodeError"}
    if {$rc} {error $detail}
    set ::CCRFlow::state native_meshed
    note "Native Tetmesh: [format %.3f [expr {[dict get $journal nativeMeshMs]/1000.0}]] s. Next: Collect solids."
}
proc ::CCRFlow::collectSolids {} {
    require {native_meshed};variable journal
    set start [clock milliseconds]
    set generated {}
    dict for {id row} [::CCRAutoMesh::elements [dict get $journal recordedElements]] {
        if {[lindex $row 0] in {204 210}} {dict set generated $id $row}
    }
    if {![dict size $generated]} {error "Tetmesh produced no solids."}
    dict for {id row} $generated {if {[lindex $row 0]!=[dict get $journal config]} {error "Tetmesh produced a different Tet order."}}
    dict set journal new [dict keys $generated];dict set journal result $generated
    set ::CCRFlow::state meshed;set ::CCR::checked [dict keys $generated]
    note "Collected [dict size $generated] solids in [format %.3f [expr {([clock milliseconds]-$start)/1000.0}]] s."
}
proc ::CCRFlow::mesh {} {meshNative;collectSolids}
namespace eval ::CCRUI {variable stepBaseColors {}}
proc ::CCRUI::markStep {action phase} {
    if {$action eq "quality"} {set action checkquality}
    if {![llength [info commands winfo]] || ![winfo exists .ccr.$action]} {return}
    # Native Tk buttons retain background colors when disabled, unlike some ttk themes.
    dict for {name color} $::CCRUI::stepBaseColors {
        if {[winfo exists .ccr.$name]} {.ccr.$name configure -background $color -activebackground $color}
    }
    switch -- $phase {
        running {set color #FFD166}
        done {set color #A9D8F5}
        error {set color #F3ADAD}
    }
    .ccr.$action configure -background $color -activebackground $color
    update idletasks
}
proc ::CCRUI::step {action} {
    if {$::CCR::busy || $::CCRAutoMesh::recoveryRequired} {return}
    markStep $action running
    busy 1;set start [clock milliseconds];set oldMode $::CCRUI::debugMode;set ::CCRUI::debugMode 1
    set rc [catch {
        switch -- $action {
            prepare {
                ::CCR::validate
                if {$::CCRFlow::state in {idle restored committed}} {
                    if {[::CCR::parseIds] ne $::CCRUI::manualSelection || ![llength $::CCRUI::manualPlans]} {error "Click Expand layers first."}
                    if {[llength $::CCRUI::manualPlans]!=1} {error "Step buttons need one component/property/Tet order. Proceed handles multiple groups."}
                    lassign [lindex $::CCRUI::manualPlans 0] cid cfg pid rows
                    set ::CCRFlow::journal [dict create cid $cid config $cfg property $pid rows $rows layers $::CCRUI::manualLayers threshold $::CCR::threshold faces {} new {} newNodes {} temporaryComps {}]
                    dict set ::CCRFlow::journal areaIndex 1
                    dict set ::CCRFlow::journal areaTotal 1
                    dict set ::CCRFlow::journal areaStarted [clock milliseconds]
                    set ::CCRFlow::state expanded;set ::CCRFlow::mutated 0
                    set ::CCRUI::manualPlans {}
                }
                debugCommand "Prepare: hm_getvalue; hm_getelemcheckvalues"
                ::CCRFlow::original;set result "Prepared [dict size [dict get $::CCRFlow::journal rows]] solids"
            }
            find {
                debugCommand "Find faces: *createmark elements 1 (patch); *findfaces elems 1"
                ::CCRFlow::find;debugView [concat [dict keys [dict get $::CCRFlow::journal rows]] [dict get $::CCRFlow::journal faces]]
                set result "Found [llength [dict get $::CCRFlow::journal faces]] faces"
            }
            delete {
                debugCommand "Delete solids: *createmark elements 1 (original); *deletemark elems 1"
                ::CCRFlow::delete;debugView [dict get $::CCRFlow::journal faces]
                set result "Original solids deleted"
            }
            mesh {
                debugCommand "Tetmesh: *createstringarray (record parameters); *createmark elements 2 (faces); *tetmesh elements 2 1 elements 0 -1 1 2"
                ::CCRFlow::meshNative
                set j $::CCRFlow::journal
                set result "Tetmesh [format %.3f [expr {[dict get $j nativeMeshMs]/1000.0}]] s; setup [format %.3f [expr {[dict get $j prepareMeshMs]/1000.0}]] s; recorder [format %.3f [expr {[dict get $j recorderMs]/1000.0}]] s"
            }
            collect {
                debugCommand "Collect solids: hm_getvalue on recorded new elements"
                ::CCRFlow::collectSolids;set result "Collected [llength [dict get $::CCRFlow::journal new]] solids"
            }
            assign {
                debugCommand "Move solids: *createmark elements 1 (new solids); *movemark elements 1 [list [hm_getvalue comps id=[dict get $::CCRFlow::journal cid] dataname=name]]"
                ::CCRFlow::returnSolids;set result "Solids moved to original component"
            }
            hide {
                if {$::CCRFlow::state ni {native_meshed meshed returned}} {error "Run Tetmesh first."}
                debugCommand "Hide owned faces: *createmark components 3 (temporary face comp IDs); *createstringarray 2 elements_on geometry_off; *hideentitybymark 3 1 2"
                *createmark components 3 {*}[dict get $::CCRFlow::journal faceComps]
                *createstringarray 2 "elements_on" "geometry_off"
                *hideentitybymark 3 1 2
                set result "Faces hidden; solids remain"
            }
            cleanup {
                debugCommand "Remove faces: *deletemark elems 1 (faces); *deletemark comps 1 (empty temporary comps)"
                ::CCRFlow::remove;set result "Temporary faces removed"
            }
            quality {
                debugCommand "Quality: hm_getelemcheckvalues 1 3 tetracollapse"
                set improved [::CCRFlow::check]
                set result "Tet Collapse $::CCR::qualityValue; [llength [::CCRAutoMesh::failed [dict get $::CCRFlow::journal resultQuality]]] below threshold"
                if {!$improved} {set result "No improvement; mesh kept. $result"}
            }
        }
    } detail]
    if {$rc} {
        set result "Stopped: $detail"
        # Wrong button ordering is rejected without undoing a valid open area.
        if {$::CCRFlow::mutated && $::CCRFlow::state ni {checked faces deleted native_meshed meshed returned cleaned}} {
            append result " Inspect the model."
        }
    }
    markStep $action [expr {$rc?"error":"done"}]
    set ::CCRUI::debugMode $oldMode
    debugCommand "$result | Total [format %.3f [expr {([clock milliseconds]-$start)/1000.0}]] s"
    busy 0;pin
}
proc ::CCRUI::stepButtons {} {
    if {![winfo exists .ccr.prepare]} {return}
    set state $::CCRFlow::state
    foreach {name allowed} {
        prepare {idle restored committed expanded}
        find {checked}
        delete {faces}
        mesh {deleted}
        collect {native_meshed}
        assign {meshed}
        hide {native_meshed meshed returned}
        cleanup {returned}
        checkquality {cleaned}
    } {
        set enabled [expr {!$::CCR::busy && !$::CCRAutoMesh::recoveryRequired && $state in $allowed}]
        if {$name eq "prepare" && $state in {idle restored committed} && ![llength $::CCRUI::manualPlans]} {set enabled 0}
        .ccr.$name configure -state [expr {$enabled?"normal":"disabled"}]
    }
}

proc ::CCRFlow::returnSolids {} {
    require {meshed};variable journal
    set new [dict get $journal new];set cid [dict get $journal cid]
    set name [hm_getvalue comps id=$cid dataname=name]
    *createmark elements 1 {*}$new
    *movemark elements 1 $name
    *createmark elements 1 {*}$new
    set actual [hm_getvalue elems mark=1 dataname=id]
    if {[llength $actual]!=[llength $new]} {error "Solid move is incomplete."}
    set result [dict get $journal result]
    foreach id $actual actualCid [hm_getvalue elems mark=1 dataname=collector.id] actualPid [hm_getvalue elems mark=1 dataname=propertyid] {
        if {$actualCid!=$cid} {error "Solid move failed. Use Rebuild original."}
        set row [dict get $result $id];lset row 1 $actualPid;dict set result $id $row
    }
    dict set journal result $result;set ::CCRFlow::state returned
    note "Moved [llength $new] solids to $name (component $cid)."
}
proc ::CCRFlow::cleanup {} {
    variable journal
    set faces [dict get $journal faces]
    if {[llength $faces]} {*createmark elems 1 {*}$faces;*deletemark elems 1;dict set journal faces {}}
    foreach cid [dict get $journal temporaryComps] {
        *createmark comps 1 $cid
        if {![llength [hm_getmark comps 1]]} {continue}
        *createmark elems 1 "by collector id" $cid
        if {[llength [hm_getmark elems 1]]} {error "A temporary component still contains elements. Restore original first."}
        *createmark comps 1 $cid;*deletemark comps 1
    }
    dict set journal temporaryComps {}
}
proc ::CCRFlow::remove {} {
    require {returned};unchanged
    cleanup;set ::CCRFlow::state cleaned
    note "Removed the temporary faces and empty temporary components. The new solids remain. Next: update Tet Collapse."
}
proc ::CCRFlow::settings {} {
    variable journal
    *elementorder [dict get $journal oldOrder]
    set cid [dict get $journal oldCollector]
    if {$cid>0} {*currentcollector components [hm_getvalue comps id=$cid dataname=name]}
}
proc ::CCRFlow::check {} {
    require {cleaned};unchanged
    variable journal
    note "Updating Tet Collapse for [llength [dict get $journal new]] new solids..."
    set qualityStart [clock milliseconds]
    set rows [dict get $journal result];set q [::CCRAutoMesh::quality [dict keys $rows]]
    note "Tet Collapse measured in [format %.2f [expr {([clock milliseconds]-$qualityStart)/1000.0}]] s."
    set before [llength [::CCRAutoMesh::failed [dict get $journal quality]]];set after [llength [::CCRAutoMesh::failed $q]]
    settings;set ::CCRFlow::state committed;set ::CCRFlow::mutated 0
    dict set journal resultQuality $q
    set ::CCR::checked [dict keys $rows];set ::CCR::input [::CCRAutoMesh::failed $q]
    set minimum 1.0
    foreach {id value} $q {if {$value<$minimum} {set minimum $value}}
    set ::CCR::qualityValue [format %.6f $minimum]
    set improved [expr {$after<$before && !$::CCR::forceReject}]
    if {!$improved} {note "No improvement. New mesh kept: $after solids remain below threshold."} elseif {$::CCRFlow::detailedChecks} {
        note "Result kept: $before below threshold became $after. Detailed debug checks passed."
    } else {note "Result kept: $before below threshold became $after. Original component checked. Tet Collapse updated."}
    return $improved
}
proc ::CCRFlow::restore {} {
    variable journal
    if {![active]} {return}
    if {!$::CCRFlow::mutated} {set ::CCRFlow::state restored;note "Prepared area released; original solids remain.";return}
    set restored [::CCRAutoMesh::restoreCavity [dict get $journal rows] [dict get $journal xyz] [dict get $journal types] {} [dict get $journal new] [dict get $journal newNodes] [dict get $journal cid]]
    dict set journal new {};dict set journal newNodes {}
    cleanup;settings
    set ::CCRFlow::state restored;set ::CCRFlow::mutated 0
    set ::CCR::checked $restored;set ::CCR::input $restored;::CCRUI::refresh
    note "Original connectivity rebuilt: [llength $restored] solids. New IDs assigned; no renumber."
}

proc ::CCRFlow::apply {selection} {
    ::CCRAutoMesh::version;::CCR::validate
    if {$::CCRAutoMesh::recoveryRequired} {error "Recovery required. Inspect the model."}
    if {![llength $selection]} {error "Select at least one element."}
    set rows [::CCRAutoMesh::elements $selection]
    if {[dict size $rows]!=[llength $selection]} {error "Some selected elements no longer exist."}
    dict for {id row} $rows {if {[lindex $row 0] ni {204 210}} {error "Select Tet4 or Tet10 solids only."}}
    set allQuality [::CCRAutoMesh::quality $selection]
    set pending [::CCRAutoMesh::failed $allQuality];set initial [llength $pending]
    set commits 0;set checked $selection;set ::CCR::replaced {};set ::CCR::report {}
    set start [clock milliseconds];set cache {};set queue {}
    if {[llength $pending]} {
        foreach plan [::CCR::plans $pending 2 cache] {lappend queue [list 2 $plan]}
    }
    for {set index 0} {$index<[llength $queue]} {incr index} {
        lassign [lindex $queue $index] layers plan
        lassign $plan cid cfg pid patch
        set areaStart [clock milliseconds]
        set ::CCRFlow::journal [dict create cid $cid config $cfg property $pid rows $patch layers $layers threshold $::CCR::threshold faces {} new {} newNodes {} temporaryComps {}]
        dict set ::CCRFlow::journal areaIndex [expr {$index+1}]
        dict set ::CCRFlow::journal areaTotal [llength $queue]
        dict set ::CCRFlow::journal areaStarted [clock milliseconds]
        set ::CCRFlow::state expanded;set ::CCRFlow::mutated 0
        set rc [catch {original;find;delete;mesh;returnSolids;remove;set improved [check]} reason]
        if {$rc} {
            note "ERROR: $reason. Processing stopped; no automatic restore."
            error $reason
            note "Area stopped: $reason"
            set retry {};foreach id $pending {if {[dict exists $patch $id]} {lappend retry $id}}
        } else {
            if {$improved} {incr commits}
            foreach id [dict keys $patch] {
                dict set ::CCR::replaced $id 1
                if {[dict exists $allQuality $id]} {dict unset allQuality $id}
            }
            set retained {};foreach id $checked {if {![dict exists $patch $id]} {lappend retained $id}}
            set checked [concat $retained [dict get $::CCRFlow::journal new]]
            set allQuality [dict merge $allQuality [dict get $::CCRFlow::journal resultQuality]]
            set retry [::CCRAutoMesh::failed [dict get $::CCRFlow::journal resultQuality]]
            note "Area completed in [format %.2f [expr {([clock milliseconds]-$areaStart)/1000.0}]] s."
        }
        set pending [::CCRAutoMesh::failed $allQuality]
        if {$layers==2 && [llength $retry]} {
            if {[catch {::CCR::plans $retry 3 cache} retryPlans]} {note "Additional expansion skipped: $retryPlans"} else {
                # Any queued area touching a replacement must be rebuilt from current IDs.
                set rest {};for {set j [expr {$index+1}]} {$j<[llength $queue]} {incr j} {lappend rest [lindex $queue $j]}
                set queue [lrange $queue 0 $index]
                foreach nextPlan $retryPlans {lappend queue [list 3 $nextPlan]}
                foreach item $rest {
                    lassign $item nextLayers nextPlan
                    set nextSeeds {};foreach id $pending {if {[dict exists [lindex $nextPlan 3] $id]} {lappend nextSeeds $id}}
                    if {[llength $nextSeeds]} {foreach rebuilt [::CCR::plans $nextSeeds $nextLayers cache] {lappend queue [list $nextLayers $rebuilt]}}
                }
            }
        }
    }
    set ::CCR::checked $checked;set ::CCR::input $pending
    set minimum 1.0;foreach {id value} $allQuality {if {$value<$minimum} {set minimum $value}}
    set ::CCR::qualityValue [format %.6f $minimum]
    note "Finished in [format %.2f [expr {([clock milliseconds]-$start)/1000.0}]] s. $commits areas improved; [llength $pending] solids remain below threshold."
    return [dict create accepted_areas $commits remaining $pending remaining_failures [llength $pending] initial_failures $initial]
}

proc ::CCR::apply {selection} {return [::CCRFlow::apply $selection]}

if {[llength [info commands ::CCRFlow::runContinuous]]} {rename ::CCRFlow::runContinuous {}}
rename ::CCRFlow::apply ::CCRFlow::runContinuous
proc ::CCRFlow::apply {selection} {
    set previous $::CCRFlow::detailedChecks
    set ::CCRFlow::detailedChecks 0
    set redraw [hm_getoption block_redraw]
    *setoption block_redraw=1
    set rc [catch {::CCRFlow::runContinuous $selection} result options]
    set restoreRC [catch {*setoption block_redraw=$redraw} restoreError]
    if {$restoreRC && !$rc} {error "Redraw setting restore failed: $restoreError"}
    set ::CCRFlow::detailedChecks $previous
    if {$rc} {return -options $options $result}
    return $result
}

namespace eval ::CCRUI {variable window .ccr}
namespace eval ::CCRUI {variable savedGeometry {}}
proc ::CCRUI::preferencePath {} {
    if {[info exists ::env(APPDATA)]} {set base $::env(APPDATA)} else {set base [file normalize ~]}
    return [file join $base CompCavityRemesh preferences.dict]
}
proc ::CCRUI::loadPreferences {} {
    set path [preferencePath]
    if {![file exists $path]} {return}
    set channel {}
    set rc [catch {set channel [open $path r];set data [read $channel];dict size $data}]
    if {$channel ne {}} {catch {::close $channel}}
    if {$rc} {return}
    if {[dict exists $data threshold]} {
        set v [dict get $data threshold]
        if {[string is double -strict $v] && ![catch {expr {$v>0 && $v<1}} valid] && $valid} {set ::CCR::threshold $v}
    }
    if {[dict exists $data layers]} {
        set v [dict get $data layers]
        if {[string is integer -strict $v] && $v>=0} {set ::CCRUI::expandLayers $v}
    }
    if {[dict exists $data topmost] && [dict get $data topmost] in {0 1}} {set ::CCR::topmost [dict get $data topmost]}
    if {[dict exists $data geometry] && [regexp {^[0-9]+x[0-9]+[+-][0-9]+[+-][0-9]+$} [dict get $data geometry]]} {set ::CCRUI::savedGeometry [dict get $data geometry]}
}
proc ::CCRUI::savePreferences {} {
    if {![winfo exists .ccr]} {return}
    set threshold $::CCR::threshold;set layers $::CCRUI::expandLayers
    if {![string is double -strict $threshold] || [catch {expr {$threshold>0 && $threshold<1}} valid] || !$valid} {return}
    if {![string is integer -strict $layers] || $layers<0} {return}
    set data [dict create schema 1 threshold $::CCR::threshold layers $::CCRUI::expandLayers topmost $::CCR::topmost geometry [wm geometry .ccr]]
    set channel {}
    set rc [catch {
        set path [preferencePath];file mkdir [file dirname $path]
        set channel [::open $path w]
        puts $channel $data
        flush $channel
        ::close $channel;set channel {}
    } detail]
    if {$channel ne {}} {catch {::close $channel}}
    if {$rc} {puts "Comp Cavity Remesh: Cannot save preferences: $detail";set ::CCR::status "Cannot save settings: $detail"}
}
proc ::CCRUI::preferenceChanged {args} {
    if {![llength [info commands winfo]] || ![winfo exists .ccr]} {return}
    # Persist each completed valid edit, without needing a Close event.
    savePreferences
}
proc ::CCRUI::watchPreferences {} {
    foreach setting {::CCR::threshold ::CCRUI::expandLayers ::CCR::topmost} {
        catch {trace remove variable $setting write ::CCRUI::preferenceChanged}
        trace add variable $setting write ::CCRUI::preferenceChanged
    }
}
proc ::CCRUI::reset {} {
    if {$::CCR::busy} {return}
    if {$::CCRAutoMesh::recoveryRequired || ([::CCRFlow::active] && $::CCRFlow::mutated)} {
        debugCommand "Reset unavailable: finish the current area or use Rebuild original first."
        return
    }
    set ::CCRFlow::state idle;set ::CCRFlow::journal {};set ::CCRFlow::mutated 0
    set ::CCRUI::manualPlans {};set ::CCRUI::manualSelection {};set ::CCRUI::manualLayers 0
    set ::CCRUI::foundTet {};set ::CCRUI::foundCount 0
    set ::CCR::input {};set ::CCR::checked {};set ::CCR::replaced {};set ::CCR::report {}
    set ::CCR::qualityValue --;set ::CCRFlow::log {}
    dict for {name color} $::CCRUI::stepBaseColors {
        if {[winfo exists .ccr.$name]} {.ccr.$name configure -background $color -activebackground $color}
    }
    savePreferences;busy 0
    debugCommand "Reset complete. Settings and current mesh kept. Select elements or click Find displayed."
}
proc ::CCRUI::pin {} {if {[winfo exists .ccr]} {wm attributes .ccr -topmost $::CCR::topmost}}
proc ::CCRUI::busy {value} {
    set ::CCR::busy $value
    if {![winfo exists .ccr]} {return}
    foreach name {ids threshold layers select proceed finddisplayed} {.ccr.$name configure -state [expr {$value || [::CCRFlow::active]?"disabled":"normal"}]}
    if {[winfo exists .ccr.debug]} {
        .ccr.debug configure -state [expr {$value || $::CCRAutoMesh::recoveryRequired?"disabled":"normal"}]
        .ccr.restore configure -state [expr {$value || $::CCRAutoMesh::recoveryRequired || ![::CCRFlow::active]?"disabled":"normal"}]
    }
    if {[winfo exists .ccr.expand]} {.ccr.expand configure -state [expr {$value || [::CCRFlow::active] || $::CCRAutoMesh::recoveryRequired?"disabled":"normal"}]}
    stepButtons
    if {[winfo exists .ccr.reset]} {.ccr.reset configure -state [expr {$value || $::CCRAutoMesh::recoveryRequired || ([::CCRFlow::active] && $::CCRFlow::mutated)?"disabled":"normal"}]}
    if {[winfo exists .ccr.showfound]} {.ccr.showfound configure -state [expr {$value || [::CCRFlow::active] || $::CCRAutoMesh::recoveryRequired || ![llength $::CCRUI::foundTet]?"disabled":"normal"}]}
    if {[winfo exists .ccr.restore]} {.ccr.restore configure -state [expr {$value || ![::CCRFlow::active] || $::CCRAutoMesh::recoveryRequired?"disabled":"normal"}]}
    logRefresh
    update idletasks
}
proc ::CCRUI::refresh {} {
    if {$::CCRAutoMesh::recoveryRequired} {set ::CCR::qualityValue Unverified;return}
    *createmark elems 1 {*}[lsort -integer -unique $::CCR::checked]
    set ids [hm_getmark elems 1]
    if {![llength $ids]} {set ::CCR::qualityValue --;return}
    set minimum 1.0
    foreach {id value} [::CCRAutoMesh::quality $ids] {if {$value<$minimum} {set minimum $value}}
    set ::CCR::qualityValue [format %.6f $minimum]
}
namespace eval ::CCRUI {variable foundTet {};variable foundCount 0}
proc ::CCRUI::findDisplayed {} {
    if {$::CCR::busy || [::CCRFlow::active] || $::CCRAutoMesh::recoveryRequired} {return}
    busy 1;set start [clock milliseconds]
    set ::CCRUI::foundTet {};set ::CCRUI::foundCount 0
    set rc [catch {
        ::CCRAutoMesh::version;::CCR::validate
        debugCommand "Find displayed: *createmark elems 1 displayed; filter Tet4/Tet10; measure Tet Collapse < $::CCR::threshold"
        *createmark elems 1 "displayed"
        set displayed [hm_getvalue elems mark=1 dataname=id]
        set configs [hm_getvalue elems mark=1 dataname=config]
        if {[llength $displayed]!=[llength $configs]} {error "Incomplete displayed-element query."}
        set tetra {}
        foreach id $displayed cfg $configs {if {$cfg in {204 210}} {lappend tetra $id}}
        set values [::CCRAutoMesh::quality $tetra]
        set found [::CCRAutoMesh::failed $values]
        set ::CCRUI::foundTet $found;set ::CCRUI::foundCount [llength $found]
        set ::CCRUI::manualPlans {};set ::CCRUI::manualSelection {};set ::CCRUI::manualLayers 0
        set ::CCR::input $found;set ::CCR::checked $found
        set minimum 1.0
        foreach {id value} $values {if {$value<$minimum} {set minimum $value}}
        set ::CCR::qualityValue [expr {[llength $found]?[format %.6f $minimum]:"--"}]
        set result "Found [llength $found] below $::CCR::threshold among [llength $tetra] displayed Tet4/Tet10 elements. Click Show found only to hide the others."
    } detail]
    if {$rc} {set result "Stopped: $detail"}
    debugCommand "$result | [format %.2f [expr {([clock milliseconds]-$start)/1000.0}]] s"
    busy 0;pin
}
proc ::CCRUI::showFound {} {
    if {$::CCR::busy || [::CCRFlow::active] || $::CCRAutoMesh::recoveryRequired} {return}
    if {![llength $::CCRUI::foundTet]} {debugCommand "No search results. Click Find displayed first.";return}
    busy 1;set start [clock milliseconds]
    set rc [catch {
        *createmark elems 1 {*}$::CCRUI::foundTet
        set existing [hm_getmark elems 1]
        if {[llength $existing]!=[llength $::CCRUI::foundTet]} {error "Search results changed. Click Find displayed again."}
        debugCommand "Show found only: *maskall; *unmaskentitymark elems 1 0"
        *maskall
        *createmark elems 1 {*}$existing
        *unmaskentitymark elems 1 0
        set result "Showing [llength $existing] found elements only."
    } detail]
    if {$rc} {set result "Stopped: $detail"}
    debugCommand "$result | [format %.2f [expr {([clock milliseconds]-$start)/1000.0}]] s"
    busy 0;pin
}
proc ::CCRUI::select {} {
    if {$::CCR::busy} {return}
    busy 1;pin
    set rc [catch {
        ::CCRAutoMesh::version
        *createmarkpanel elems 1 "Select Tet4 / Tet10 elements"
        set picked [hm_getmark elems 1]
        set ::CCRUI::manualPlans {};set ::CCRUI::manualSelection {};set ::CCRUI::manualLayers 0
        set ::CCR::input $picked;set ::CCR::checked $picked
        refresh
        ::CCR::message "[llength $picked] elements selected. Click Proceed to repair."
    } detail]
    busy 0;pin
    if {$rc} {::CCR::message $detail}
}
namespace eval ::CCRUI {variable manualPlans {};variable manualSelection {};variable manualLayers 0;variable expandLayers 2}
proc ::CCRUI::layerCount {} {
    set count [string trim $::CCRUI::expandLayers]
    if {![string is integer -strict $count] || $count < 0} {error "Layers must be a whole number of 0 or greater."}
    return $count
}
proc ::CCRUI::expandOne {} {
    if {$::CCR::busy || $::CCRAutoMesh::recoveryRequired || [::CCRFlow::active]} {return}
    busy 1;set start [clock milliseconds];set previousMode $::CCRUI::debugMode
    set ::CCRUI::debugMode 1
    set rc [catch {
        ::CCR::validate;set layers [layerCount];set selected [::CCR::parseIds]
        if {![llength $selected]} {error "Select at least one element."}
        if {$selected ne $::CCRUI::manualSelection} {
            set ::CCRUI::manualPlans {};set ::CCRUI::manualLayers 0
        }
        set seeds $selected
        if {[llength $::CCRUI::manualPlans]} {
            set seeds {};foreach plan $::CCRUI::manualPlans {set seeds [concat $seeds [dict keys [lindex $plan 3]]]}
        }
        debugCommand "Expand $layers layers: *findmark elems 1 1 0 elems 0 2 (once per layer)"
        set cache {};set next [::CCR::plans $seeds $layers cache]
        set visible {};foreach plan $next {set visible [concat $visible [dict keys [lindex $plan 3]]]}
        set ::CCRUI::manualPlans $next;set ::CCRUI::manualSelection $selected
        incr ::CCRUI::manualLayers $layers
        set ::CCR::checked $visible;debugView $visible;refresh
        set result "Layers: $::CCRUI::manualLayers; [llength $visible] solids shown. Proceed uses this area."
    } detail]
    set ::CCRUI::debugMode $previousMode
    if {$rc} {set result "Stopped: $detail"}
    debugCommand "$result ([format %.2f [expr {([clock milliseconds]-$start)/1000.0}]] s)"
    busy 0;pin
}
proc ::CCRUI::applyPrepared {} {
    set checked {};set commits 0;set initial 0;set allQuality {};set groupIndex 0;set groupCount [llength $::CCRUI::manualPlans]
    debugCommand "Remesh queue: $groupCount areas. Each area uses its own temporary faces."
    set redraw [hm_getoption block_redraw];set previousMode $::CCRUI::debugMode
    *setoption block_redraw=1
    # Preserve patch-only display while using the prepared area.
    set ::CCRUI::debugMode 1
    set rc [catch {
        foreach plan $::CCRUI::manualPlans {
            incr groupIndex
            lassign $plan cid cfg pid rows
            debugCommand "Group $groupIndex/$groupCount | Component $cid | [dict size $rows] solids"
            set originalIDs [dict keys $rows]
            *createmark elems 1 {*}$originalIDs
            if {[llength [hm_getmark elems 1]]!=[llength $originalIDs]} {error "Prepared elements changed. Select again and expand."}
            set ::CCRFlow::journal [dict create cid $cid config $cfg property $pid rows $rows layers $::CCRUI::manualLayers threshold $::CCR::threshold faces {} new {} newNodes {} temporaryComps {}]
            dict set ::CCRFlow::journal areaIndex $groupIndex
            dict set ::CCRFlow::journal areaTotal $groupCount
            dict set ::CCRFlow::journal areaStarted [clock milliseconds]
            set ::CCRFlow::state expanded;set ::CCRFlow::mutated 0
            debugCommand "Proceed: *findfaces -> *deletemark -> *tetmesh -> *movemark -> cleanup -> Tet Collapse"
            set areaRC [catch {
                ::CCRFlow::original
                incr initial [llength [::CCRAutoMesh::failed [dict get $::CCRFlow::journal quality]]]
                ::CCRFlow::find;::CCRFlow::delete;::CCRFlow::mesh
                ::CCRFlow::returnSolids;::CCRFlow::remove
                if {[::CCRFlow::check]} {incr commits}
            } areaError]
            if {$areaRC} {
                debugCommand "ERROR: $areaError. Processing stopped; no automatic restore."
                error $areaError
                set checked [concat $checked $originalIDs]
                debugCommand "Area stopped: $areaError"
            } else {
                set checked [concat $checked [dict get $::CCRFlow::journal new]]
                set allQuality [dict merge $allQuality [dict get $::CCRFlow::journal resultQuality]]
            }
        }
        set ::CCR::checked $checked;debugView $checked
        set remaining [::CCRAutoMesh::failed $allQuality]
        set minimum 1.0
        foreach {id value} $allQuality {if {$value<$minimum} {set minimum $value}}
        set ::CCR::qualityValue [expr {[dict size $allQuality]?[format %.6f $minimum]:"--"}]
        set result [dict create accepted_areas $commits remaining $remaining remaining_failures [llength $remaining] initial_failures $initial]
    } detail options]
    set ::CCRUI::debugMode $previousMode
    set restoreRC [catch {*setoption block_redraw=$redraw} restoreError]
    set ::CCRUI::manualPlans {};set ::CCRUI::manualSelection {};set ::CCRUI::manualLayers 0
    if {$rc} {return -options $options $detail}
    if {$restoreRC} {error "Redraw setting restore failed: $restoreError"}
    return $result
}

proc ::CCRUI::proceed {} {
    if {$::CCR::busy || [::CCRFlow::active]} {return}
    set ::CCRUI::foundTet {};set ::CCRUI::foundCount 0
    busy 1
    set rc [catch {
        ::CCR::validate
        set ids [::CCR::parseIds]
        set ::CCR::checked $ids
        if {[llength $::CCRUI::manualPlans] && $ids eq $::CCRUI::manualSelection} {
            set result [applyPrepared]
        } else {
            set ::CCRUI::manualPlans {};set ::CCRUI::manualLayers 0
            set layers [layerCount]
            debugCommand "Prepare $layers layers within each original component."
            set cache {};set ::CCRUI::manualPlans [::CCR::plans $ids $layers cache]
            set ::CCRUI::manualSelection $ids;set ::CCRUI::manualLayers $layers
            set result [applyPrepared]
        }
        set left [dict get $result remaining_failures];set areas [dict get $result accepted_areas]
        set ::CCR::input [dict get $result remaining]
        if {$areas && !$left} {::CCR::message "Completed. No elements below the threshold in the checked areas."} elseif {$areas} {
            ::CCR::message "$areas areas improved. $left elements remain below the threshold."
        } elseif {[dict get $result initial_failures]==0} {::CCR::message "Selected elements already meet the threshold."} else {::CCR::message "No improvement"}
    } detail]
    if {$rc} {::CCR::message $detail;puts "CCR: $detail"}
    if {$rc && [catch {refresh} detail]} {set ::CCR::qualityValue Unavailable;puts "CCR quality: $detail"}
    busy 0;pin
}
proc ::CCRUI::close {} {
    if {$::CCR::busy} {return}
    if {[::CCRFlow::active]} {::CCR::message "Finish Debug next step or click Rebuild original before closing.";return}
    savePreferences
    destroy .ccr
}
namespace eval ::CCRUI {variable renderedLog 0}
proc ::CCRUI::logRefresh {} {
    if {![llength [info commands winfo]] || ![winfo exists .ccr.log]} {return}
    set count [llength $::CCRFlow::log]
    .ccr.log configure -state normal
    if {$::CCRUI::renderedLog>$count} {.ccr.log delete 1.0 end;set ::CCRUI::renderedLog 0}
    if {$count>$::CCRUI::renderedLog} {
        .ccr.log insert end "[join [lrange $::CCRFlow::log $::CCRUI::renderedLog end] \n]\n"
        set ::CCRUI::renderedLog $count
        .ccr.log see end
    }
    .ccr.log configure -state disabled
    update idletasks
}
proc ::CCRUI::resize {widget width} {
    if {$widget eq ".ccr"} {.ccr.status configure -wraplength [expr {max(100,$width-20)}]}
}
proc ::CCRUI::show {} {
    ::CCRAutoMesh::version
    package require Tk
    if {[winfo exists .ccr]} {destroy .ccr}
    loadPreferences
    watchPreferences
    set ::CCRUI::renderedLog 0
    toplevel .ccr;wm title .ccr "Comp Cavity Remesh V5 Auto r25.1 | HM2022"
    wm minsize .ccr 510 0;wm resizable .ccr 1 0
    wm protocol .ccr WM_DELETE_WINDOW ::CCRUI::close
    ttk::label .ccr.idlabel -text Elements
    ttk::entry .ccr.ids -textvariable ::CCR::input
    ttk::button .ccr.select -text "Select..." -width 14 -command ::CCRUI::select
    ttk::label .ccr.tlabel -text "Tet Collapse <"
    ttk::entry .ccr.threshold -textvariable ::CCR::threshold
    ttk::button .ccr.proceed -text Proceed -width 14 -command ::CCRUI::proceed
    ttk::label .ccr.qlabel -text "Tet Collapse"
    ttk::entry .ccr.quality -textvariable ::CCR::qualityValue -state readonly
    ttk::checkbutton .ccr.ontop -text "Always on top" -variable ::CCR::topmost -command ::CCRUI::pin
    ttk::label .ccr.status -textvariable ::CCR::status -anchor nw -justify left -wraplength 490
    ttk::button .ccr.expand -text "Expand layers" -width 14 -command ::CCRUI::expandOne
    ttk::entry .ccr.layers -textvariable ::CCRUI::expandLayers
    button .ccr.restore -disabledforeground #303030 -text "Rebuild original" -state disabled -command ::CCRUI::debugRestore
    foreach {name label} {prepare Prepare find {Find faces} delete {Delete solids} mesh Tetmesh collect {Collect solids} assign {Move solids} hide {Hide faces} cleanup {Remove faces} checkquality {Check quality}} {
        button .ccr.$name -disabledforeground #303030 -text $label -command [list ::CCRUI::step [expr {$name eq "checkquality"?"quality":$name}]]
    }
    set ::CCRUI::stepBaseColors {}
    foreach name {prepare find delete mesh collect assign hide cleanup checkquality restore} {
        dict set ::CCRUI::stepBaseColors $name [.ccr.$name cget -background]
    }
    ttk::button .ccr.reset -text Reset -width 14 -command ::CCRUI::reset
    ttk::button .ccr.finddisplayed -text "Find displayed" -width 14 -command ::CCRUI::findDisplayed
    ttk::button .ccr.showfound -text "Show found only" -width 14 -state disabled -command ::CCRUI::showFound
    text .ccr.log -height 4 -width 66 -wrap word -state disabled -font TkDefaultFont
    ttk::scrollbar .ccr.scroll -orient vertical -command {.ccr.log yview}
    .ccr.log configure -yscrollcommand {.ccr.scroll set}
    ttk::labelframe .ccr.search -text "Selection and search" -padding 4
    ttk::labelframe .ccr.repair -text "Remesh" -padding 4
    ttk::labelframe .ccr.steps -text "Step by step" -padding 4
    ttk::labelframe .ccr.feedback -text "Progress" -padding 4
    foreach group {search repair} {
        grid columnconfigure .ccr.$group 0 -minsize 112
        grid columnconfigure .ccr.$group 1 -weight 1
        grid columnconfigure .ccr.$group 2 -minsize 132
    }
    ttk::label .ccr.foundlabel -text Found
    ttk::entry .ccr.foundvalue -textvariable ::CCRUI::foundCount -state readonly
    ttk::label .ccr.layerslabel -text Layers
    set row 0
    foreach names {{idlabel ids select} {tlabel threshold finddisplayed} {foundlabel foundvalue showfound}} {
        set col 0
        foreach name $names {
            grid .ccr.$name -in .ccr.search -row $row -column $col -sticky ew -padx 3 -pady 2
            incr col
        }
        incr row
    }
    set row 0
    foreach names {{layerslabel layers expand} {qlabel quality proceed}} {
        set col 0
        foreach name $names {
            grid .ccr.$name -in .ccr.repair -row $row -column $col -sticky ew -padx 3 -pady 2
            incr col
        }
        incr row
    }
    set row 0;set col 0
    foreach name {prepare find delete mesh collect assign hide cleanup checkquality} {
        grid .ccr.$name -in .ccr.steps -row $row -column $col -sticky ew -padx 3 -pady 2
        incr col
        if {$col==3} {set col 0;incr row}
    }
    foreach col {0 1 2} {grid columnconfigure .ccr.steps $col -weight 1 -uniform actions}
    grid .ccr.restore -in .ccr.steps -row 3 -column 1 -columnspan 2 -sticky ew -padx 3 -pady 2
    grid .ccr.log -in .ccr.feedback -row 0 -column 0 -sticky nsew
    grid .ccr.scroll -in .ccr.feedback -row 0 -column 1 -sticky ns
    grid columnconfigure .ccr.feedback 0 -weight 1
    foreach row {0 1 2 3} group {search repair steps feedback} {
        grid .ccr.$group -row $row -column 0 -columnspan 2 -sticky ew -padx 8 -pady 3
    }
    grid .ccr.reset -row 4 -column 1 -sticky e -padx 10 -pady 2
    grid .ccr.ontop -row 4 -column 0 -sticky w -padx 10 -pady 2
    grid .ccr.status -row 5 -column 0 -columnspan 2 -sticky ew -padx 10 -pady {2 6}
    grid columnconfigure .ccr 0 -weight 1
    # Widgets are children of .ccr and grid-managed inside sibling group frames.
    # Keep them above those frames; otherwise later-created frames cover them.
    foreach name {idlabel ids select tlabel threshold finddisplayed foundlabel foundvalue showfound layerslabel layers expand qlabel quality proceed prepare find delete mesh collect assign hide cleanup checkquality restore log scroll} {
        raise .ccr.$name
    }
    stepButtons
    # Let the new single-page layout determine its height; keep saved width/position.
    if {[regexp {^([0-9]+)x[0-9]+([+-][0-9]+[+-][0-9]+)$} $::CCRUI::savedGeometry -> width position]} {
        update idletasks
        wm geometry .ccr "${width}x[winfo reqheight .ccr]${position}"
    }
    bind .ccr.idlabel <Button-1> {focus .ccr.ids}
    bind .ccr.tlabel <Button-1> {focus .ccr.threshold}
    bind .ccr <Configure> {::CCRUI::resize %W %w}
    bind .ccr <Escape> ::CCRUI::close
    logRefresh;pin;focus .ccr.ids
}
namespace eval ::CCRUI {variable debugMode 0}
proc ::CCRUI::debugCommand {text} {
    set text [::CCRFlow::progressText $text]
    lappend ::CCRFlow::log "[clock format [clock seconds] -format %H:%M:%S]  $text"
    ::CCR::message $text;logRefresh
}
proc ::CCRUI::debugView {ids} {
    *maskall
    if {[llength $ids]} {
        *createmark elems 1 {*}$ids
        *unmaskentitymark elems 1 0
    }
}
proc ::CCRUI::debugNext {} {
    if {$::CCR::busy || $::CCRAutoMesh::recoveryRequired} {return}
    set ::CCRFlow::detailedChecks 0;set ::CCRUI::debugMode 1
    busy 1;set start [clock milliseconds]
    set rc [catch {
        switch -- $::CCRFlow::state {
            idle - committed - restored {
                ::CCRAutoMesh::version;::CCR::validate
                set selected [::CCR::parseIds]
                if {![llength $selected]} {error "Select at least one element."}
                debugCommand "1. Expand: *createmark; *findmark elems 1 1 0 elems 0 2 (2 layers)"
                set cache {};set plans [::CCR::plans $selected 2 cache]
                if {[llength $plans]!=1} {error "Debug requires one component, property and Tet order."}
                lassign [lindex $plans 0] cid cfg pid rows
                set ::CCRFlow::journal [dict create cid $cid config $cfg property $pid rows $rows layers 2 threshold $::CCR::threshold faces {} new {} newNodes {} temporaryComps {}]
                set ::CCRFlow::state expanded;set ::CCRFlow::mutated 0
                set ::CCR::checked [dict keys $rows];refresh
                debugView [dict keys $rows]
                set result "Selected covered: [llength $selected]/[llength $selected]; patch [dict size $rows] solids; comp $cid"
            }
            expanded - checked {
                if {$::CCRFlow::state eq "expanded"} {
                    debugCommand "2. Prepare: hm_getvalue; hm_getelemcheckvalues"
                    ::CCRFlow::original
                }
                debugCommand "2. Faces: *createmark elems 1 (patch); *findfaces elems 1"
                ::CCRFlow::find
                debugView [concat [dict keys [dict get $::CCRFlow::journal rows]] [dict get $::CCRFlow::journal faces]]
                set result "[llength [dict get $::CCRFlow::journal faces]] faces shown"
            }
            faces {
                debugCommand "3. Delete: *createmark elems 1 (original solids); *deletemark elems 1"
                ::CCRFlow::delete;debugView [dict get $::CCRFlow::journal faces]
                set result "Original solids deleted; faces shown"
            }
            deleted - meshed {
                if {$::CCRFlow::state eq "deleted"} {
                    debugCommand "4. Mesh: *currentcollector; *elementorder; *createstringarray; hm_entityrecorder; *tetmesh elems 1 1 elems 0 -1 1 2"
                    ::CCRFlow::mesh
                }
                debugCommand "4. Move solids: *createmark elements 1 (new solids); *movemark elements 1 (original component)"
                ::CCRFlow::returnSolids
                debugView [concat [dict get $::CCRFlow::journal new] [dict get $::CCRFlow::journal faces]]
                set result "[llength [dict get $::CCRFlow::journal new]] new solids shown"
            }
            returned {
                debugCommand "5. Cleanup: *deletemark elems 1 (faces); *deletemark comps 1 (empty temporary comps)"
                ::CCRFlow::remove;debugView [dict get $::CCRFlow::journal new]
                set result "Temporary faces removed"
            }
            cleaned {
                debugCommand "6. Quality: *createmark elems 1 (new solids); hm_getelemcheckvalues 1 3 tetracollapse"
                set improved [::CCRFlow::check]
                set count [llength [::CCRAutoMesh::failed [dict get $::CCRFlow::journal resultQuality]]]
                set result "Tet Collapse: $::CCR::qualityValue; $count below threshold"
                if {!$improved} {set result "No improvement; mesh kept. $result"}
            }
            default {error "Unknown state. Use Rebuild original."}
        }
    } detail]
    if {$rc} {
        set result "Stopped: $detail"
        append result " Processing stopped; no automatic restore."
    }
    set ::CCRUI::debugMode 0
    debugCommand "$result ([format %.2f [expr {([clock milliseconds]-$start)/1000.0}]] s)"
    busy 0;pin
}
proc ::CCRUI::debugRestore {} {
    if {$::CCR::busy || $::CCRAutoMesh::recoveryRequired} {return}
    markStep restore running;busy 1
    set rc [catch {::CCRFlow::restore} detail]
    if {$rc} {::CCRFlow::note "Stopped: $detail"}
    markStep restore [expr {$rc?"error":"done"}]
    busy 0;pin
}

proc ::CCRFlow::runStep {action} {
    set commands [dict create original {Read original connectivity/coordinates: hm_getvalue} find {*findfaces; name owned temporary face components} delete {*deletemark: original solids} meshNative {*tetmesh elements 2 1 elements 0 -1 1 2} collectSolids {hm_getvalue: recorded new solids} returnSolids {*movemark: original component} remove {*deletemark: temporary faces/components} check {hm_getelemcheckvalues: Tet Collapse} restore {Rebuild original connectivity with new IDs; no renumber}]
    variable journal
    set steps [dict create original 1 find 2 delete 3 meshNative 4 collectSolids 5 returnSolids 6 remove 7 check 8]
    set stage $action
    if {[dict exists $steps $action]} {set stage "Step [dict get $steps $action]/8 $action"}
    set context [progressText {}]
    set counts ""
    if {[dict exists $journal rows]} {append counts " | [dict size [dict get $journal rows]] original solids"}
    if {[dict exists $journal faces]} {append counts " | [llength [dict get $journal faces]] temporary faces"}
    note "START $stage$counts: [dict get $commands $action]"
    set start [clock milliseconds]
    set rc [catch {::CCRFlow::raw_$action} result options]
    set elapsed [format %.3f [expr {([clock milliseconds]-$start)/1000.0}]]
    if {$rc} {note "ERROR $action: $result | $elapsed s";return -options $options $result}
    # check commits the area, so preserve its context for the completion line.
    if {$action eq "check" && [dict exists $journal areaIndex]} {
        set areaSeconds [format %.2f [expr {([clock milliseconds]-[dict get $journal areaStarted])/1000.0}]]
        note "${context}DONE $stage | $elapsed s | Area finished in $areaSeconds s"
    } else {note "DONE $stage | $elapsed s"}
    return $result
}
foreach action {original find delete meshNative collectSolids returnSolids remove check restore} {
    if {[llength [info commands ::CCRFlow::raw_$action]]} {rename ::CCRFlow::raw_$action {}}
    rename ::CCRFlow::$action ::CCRFlow::raw_$action
    proc ::CCRFlow::$action {} [list ::CCRFlow::runStep $action]
}

if {[info exists ::CCR_reload_input]} {
    set ::CCR::input $::CCR_reload_input
    set ::CCR::threshold $::CCR_reload_threshold
    unset ::CCR_reload_input ::CCR_reload_threshold
}
if {[info exists ::CCR_batch_mode] && $::CCR_batch_mode} {unset ::CCR_batch_mode} else {::CCRUI::show}
