# Dynamic multi-model modal dashboard for HyperView 2022.
# Browse only records paths. Nothing is imported until Import all is pressed.

namespace eval ::hv2022dash {
    variable paths; array set paths {}
    variable freqChoices; array set freqChoices {}
    variable freqLabels; array set freqLabels {}
    variable freqCombo; array set freqCombo {}
    variable modeSpecs; array set modeSpecs {}
    variable modelIds; array set modelIds {}
    variable subcaseIds; array set subcaseIds {}
    variable pageIds {}
    variable rowsFrame .hv2022dash.rows
    variable outputDir ""
    variable viewChoice iso
    variable zoomFactor 1.0
    variable status "Add OP2 rows and browse files. No model is imported until Import all is pressed."
    variable imported 0
}

proc ::hv2022dash::addRow {{path ""}} {
    variable paths; variable freqChoices; variable freqLabels; variable freqCombo; variable modeSpecs; variable rowsFrame
    variable imported; variable status
    if {$imported} {set status "Rows are locked after import. Start a fresh tool session to change the model list."; return}
    set i [expr {[array size paths] + 1}]
    set r [expr {$i - 1}]
    label $rowsFrame.l$i -text "Model $i OP2"
    entry $rowsFrame.e$i -textvariable ::hv2022dash::paths([expr {$i-1}]) -width 54
    button $rowsFrame.b$i -text "Browse..." -command [list ::hv2022dash::pickOp2 [expr {$i-1}]]
    entry $rowsFrame.m$i -textvariable ::hv2022dash::modeSpecs([expr {$i-1}]) -width 20
    ttk::combobox $rowsFrame.f$i -state readonly -textvariable ::hv2022dash::freqChoices([expr {$i-1}]) -values {} -width 37
    set paths([expr {$i-1}]) $path
    set freqChoices([expr {$i-1}]) ""
    set freqLabels([expr {$i-1}]) {}
    set freqCombo([expr {$i-1}]) $rowsFrame.f$i
    set modeSpecs([expr {$i-1}]) "1"
    bind $rowsFrame.f$i <<ComboboxSelected>> [list ::hv2022dash::frequencySelected [expr {$i-1}]]
    grid $rowsFrame.l$i -row $r -column 0 -sticky e -padx 6 -pady 3
    grid $rowsFrame.e$i -row $r -column 1 -sticky ew -padx 4 -pady 3
    grid $rowsFrame.b$i -row $r -column 2 -padx 4 -pady 3
    grid $rowsFrame.m$i -row $r -column 3 -sticky ew -padx 4 -pady 3
    grid $rowsFrame.f$i -row $r -column 4 -sticky ew -padx 4 -pady 3
}

proc ::hv2022dash::frequencySelected {i} {
    variable freqChoices; variable freqLabels; variable modeSpecs; variable status
    set index [lsearch -exact $freqLabels($i) $freqChoices($i)]
    if {$index >= 0} {
        set modeSpecs($i) [expr {$index + 1}]
        set status "Model [expr {$i+1}] selected mode [expr {$index+1}]. Edit its mode input to export multiple modes."
    }
}

proc ::hv2022dash::parseModeSpec {spec modeCount} {
    set spec [string trim $spec]
    if {$spec eq ""} {error "Enter at least one mode number."}
    set out {}
    foreach token [regexp -all -inline {\S+} $spec] {
        if {[regexp {^([0-9]+)-([0-9]+)$} $token -> first last]} {
            if {$last < $first} {error "Invalid descending mode range '$token'."}
        } elseif {[regexp {^([0-9]+)$} $token -> first]} {
            set last $first
        } else {
            error "Invalid mode token '$token'. Use values such as 1-10 15 20-25."
        }
        if {$first < 1 || $last > $modeCount} {
            error "Mode '$token' is outside the available range 1-$modeCount."
        }
        for {set n $first} {$n <= $last} {incr n} {
            set zeroBased [expr {$n - 1}]
            if {[lsearch -exact $out $zeroBased] < 0} {lappend out $zeroBased}
        }
    }
    return $out
}

proc ::hv2022dash::applyView {{quiet 0}} {
    variable imported; variable viewChoice; variable zoomFactor; variable pageIds; variable paths; variable status
    if {!$imported} {
        set status "Selected view and zoom will be applied after Import all OP2s."
        return 1
    }
    if {$viewChoice ni {iso front back left right top bottom}} {
        set status "Choose one of: iso, front, back, left, right, top, bottom."
        return 0
    }
    if {![string is double -strict $zoomFactor] || $zoomFactor <= 0.0 || $zoomFactor > 10.0} {
        set status "Zoom must be a number greater than 0 and no more than 10. (1.0 = Fit)"
        return 0
    }
    set count [array size ::hv2022dash::paths]
    set code [catch {
        hwi OpenStack
        set sessionHandle session; hwi GetSessionHandle $sessionHandle
        set projectHandle project; $sessionHandle GetProjectHandle $projectHandle
        for {set i 0} {$i < $count} {incr i} {
            set pageIndex [expr {$i / 4}]
            set pageHandle page; $projectHandle GetPageHandle $pageHandle [lindex $pageIds $pageIndex]
            set windowHandle window; $pageHandle GetWindowHandle $windowHandle [expr {($i % 4) + 1}]
            set viewHandle view; $windowHandle GetViewControlHandle $viewHandle
            set clientHandle client; $windowHandle GetClientHandle $clientHandle
            $viewHandle SetOrientation $viewChoice
            $viewHandle Fit
            if {$zoomFactor != 1.0} {$viewHandle Zoom $zoomFactor}
            $clientHandle Draw
            $viewHandle ReleaseHandle; $clientHandle ReleaseHandle
            $windowHandle ReleaseHandle; $pageHandle ReleaseHandle
        }
        $projectHandle ReleaseHandle; $sessionHandle ReleaseHandle; hwi CloseStack
    } err opts]
    catch {hwi CloseStack}
    if {$code} {set status "Could not apply shared view: $err"; return 0}
    if {!$quiet} {set status "Applied $viewChoice view and zoom $zoomFactor to all $count model windows."}
    return 1
}

proc ::hv2022dash::pickOp2 {i} {
    variable paths
    set p [tk_getOpenFile -title "Choose OP2 for Model [expr {$i+1}]" -filetypes {{"OP2 results" {.op2}} {"All files" {*}}}]
    if {$p ne ""} {
        set paths($i) $p
        # Deliberately do not import or inspect the model on Browse.
    }
}

proc ::hv2022dash::pickOutput {} {
    variable outputDir
    set p [tk_chooseDirectory -title "Choose folder for animated GIFs" -mustexist false]
    if {$p ne ""} {set outputDir $p}
}

proc ::hv2022dash::inspectModel {client path} {
    set mid [$client AddModel $path]
    set modelHandle model
    $client GetModelHandle $modelHandle $mid
    $modelHandle SetResult $path
    set resultHandle result
    $modelHandle GetResultCtrlHandle $resultHandle
    set subcases [$resultHandle GetSubcaseList]
    if {![llength $subcases]} {error "No result subcases in [file tail $path]"}
    set sc [lindex $subcases 0]
    set sims [$resultHandle GetSimulationList $sc]
    set labels {}
    for {set j 0} {$j < [llength $sims]} {incr j} {
        lappend labels "$j | [$resultHandle GetSimulationLabel $sc $j]"
    }
    $resultHandle ReleaseHandle; $modelHandle ReleaseHandle
    return [list $mid $sc $labels]
}

proc ::hv2022dash::importAll {} {
    variable paths; variable freqLabels; variable freqChoices; variable freqCombo; variable status; variable imported; variable modelIds; variable subcaseIds; variable pageIds; variable rowsFrame
    if {[array size paths] < 4} {set status "Select at least four OP2 files before importing. Browse does not load them."; return}
    if {$imported} {set status "These models are already imported. Start a fresh tool session to load a different list."; return}
    set count [array size paths]
    for {set i 0} {$i < $count} {incr i} {
        if {![info exists paths($i)] || $paths($i) eq "" || ![file isfile $paths($i)]} {
            set status "Choose a valid OP2 for every row before Import all. Nothing was imported."; return
        }
    }
    set status "Importing $count OP2 model(s) into one HyperView session..."; update
    set code [catch {
        hwi OpenStack
        set sessHandle sess; hwi GetSessionHandle $sessHandle
        set projectHandle project; $sessHandle GetProjectHandle $projectHandle
        set pageId [$projectHandle AddPage]
        set pageIds [list $pageId]
        set pageHandle page; $projectHandle GetPageHandle $pageHandle $pageId
        $pageHandle SetLayout 9
        $pageHandle ReleaseHandle
        $projectHandle SetActivePage $pageId
        set rowModels {}; set rowSubs {}; set rowPages {}
        for {set i 0} {$i < $count} {incr i} {
            set pageIndex [expr {$i / 4}]
            if {$pageIndex == 0} {$projectHandle GetPageHandle $pageHandle $pageId} else {
                if {![info exists pageMap($pageIndex)]} {
                    set pageMap($pageIndex) [$projectHandle AddPage]
                    lappend pageIds $pageMap($pageIndex)
                }
                $projectHandle GetPageHandle $pageHandle $pageMap($pageIndex)
                $pageHandle SetLayout 9
            }
            set winIndex [expr {($i % 4) + 1}]
            $pageHandle SetActiveWindow $winIndex
            set windowHandle win; $pageHandle GetWindowHandle $windowHandle $winIndex
            $windowHandle SetClientType Animation
            set clientHandle client; $windowHandle GetClientHandle $clientHandle
            set loaded [::hv2022dash::inspectModel $clientHandle $paths($i)]
            lassign $loaded mid sc labels
            lappend rowModels $mid; lappend rowSubs $sc; lappend rowPages [expr {$pageIndex == 0 ? $pageId : $pageMap($pageIndex)}]
            set modelIds($i) $mid; set subcaseIds($i) $sc
            lappend labelsByRow $labels
            set modelHandle model; $clientHandle GetModelHandle $modelHandle $mid
            $modelHandle SetLabel "M[expr {$i+1}]"
            set resultHandle result; $modelHandle GetResultCtrlHandle $resultHandle
            $resultHandle SetCurrentSubcase $sc
            set contourHandle contour; $resultHandle GetContourCtrlHandle $contourHandle
            $contourHandle SetDataType "Displacement"; $contourHandle SetDataComponent node "Mag"; $contourHandle SetEnableState true
            set legendHandle legend; $contourHandle GetLegendHandle $legendHandle
            $clientHandle SetDisplayOptions "contour" true; $clientHandle SetDisplayOptions "legend" true
            # Keep the legend compact in a 2x2 layout. The title is generated
            # by HyperView from the active result definition.
            $legendHandle SetPosition "lower left"
            $legendHandle SetMinMaxVisibility false
            set renderHandle render; $clientHandle GetRenderOptionsHandle $renderHandle
            $renderHandle SetForegroundColor 0; $renderHandle SetBackgroundColor 1
            set noteId [$clientHandle AddNote]
            set noteHandle note; $clientHandle GetNoteHandle $noteHandle $noteId
            $noteHandle SetText "Model [expr {$i+1}]\n[file tail $paths($i)]"
            $noteHandle SetTextColor 0 0 0; $noteHandle SetPosition 0.87 0.26; $noteHandle SetBackgroundColor 255 255 255; $noteHandle SetTransparency true
            $clientHandle Draw
            $noteHandle ReleaseHandle; $renderHandle ReleaseHandle; $legendHandle ReleaseHandle; $contourHandle ReleaseHandle
            $resultHandle ReleaseHandle; $modelHandle ReleaseHandle; $clientHandle ReleaseHandle
            $windowHandle ReleaseHandle; $pageHandle ReleaseHandle
        }
        $projectHandle ReleaseHandle; $sessHandle ReleaseHandle; hwi CloseStack
    } err opts]
    catch {hwi CloseStack}
    if {$code} {set status "Import failed: $err"; return}
    # Modes are assigned to matching GUI rows only after the explicit import action.
    for {set i 0} {$i < $count} {incr i} {
        set freqLabels($i) [lindex $labelsByRow $i]
        $freqCombo($i) configure -values $freqLabels($i)
        if {[llength $freqLabels($i)]} {set freqChoices($i) [lindex $freqLabels($i) 0]}
    }
    set imported 1
    set count [array size paths]
    for {set i 1} {$i <= $count} {incr i} {
        $rowsFrame.e$i configure -state disabled
        $rowsFrame.b$i configure -state disabled
    }
    .hv2022dash.actions.add configure -state disabled
    .hv2022dash.actions.import configure -state disabled
    if {![::hv2022dash::applyView 1]} {return}
    set status "Imported $count model(s) on [expr {($count+3)/4}] page(s). Choose a frequency or enter mode ranges per row, then Export GIFs."
}

proc ::hv2022dash::exportGifs {} {
    variable paths; variable freqLabels; variable modeSpecs; variable outputDir; variable status; variable imported; variable modelIds; variable subcaseIds; variable pageIds; variable viewChoice; variable zoomFactor
    if {!$imported} {set status "Import all selected OP2 files before exporting."; return}
    if {$outputDir eq ""} {set status "Choose an output folder first."; return}
    if {![file isdirectory $outputDir]} {file mkdir $outputDir}
    set count [array size paths]
    array set selectedModes {}
    set captureCount 0
    for {set i 0} {$i < $count} {incr i} {
        if {[catch {::hv2022dash::parseModeSpec $modeSpecs($i) [llength $freqLabels($i)]} modes]} {
            set status "Model [expr {$i+1}] mode input: $modes"; return
        }
        set selectedModes($i) $modes
        incr captureCount [llength $modes]
    }
    if {$captureCount == 0} {set status "Enter at least one mode number."; return}
    if {![::hv2022dash::applyView 1]} {return}
    set code [catch {
        hwi OpenStack
        set sessHandle sess; hwi GetSessionHandle $sessHandle
        set projectHandle project; $sessHandle GetProjectHandle $projectHandle
        set log [open [file join $outputDir hyperview_gif_export.log] w]
        fconfigure $log -translation lf
        puts $log "HyperView Tcl [info patchlevel]"
        for {set i 0} {$i < $count} {incr i} {
            set pageIndex [expr {$i / 4}]
            set pid [lindex $pageIds $pageIndex]
            $projectHandle SetActivePage $pid
            set pageHandle page; $projectHandle GetPageHandle $pageHandle $pid
            set wi [expr {($i % 4) + 1}]
            $pageHandle SetActiveWindow $wi
            set windowHandle win; $pageHandle GetWindowHandle $windowHandle $wi
            set clientHandle client; $windowHandle GetClientHandle $clientHandle
            set mid $modelIds($i)
            set modelHandle model; $clientHandle GetModelHandle $modelHandle $mid
            set resultHandle result; $modelHandle GetResultCtrlHandle $resultHandle
            set sc $subcaseIds($i)
            $resultHandle SetCurrentSubcase $sc
            foreach idx $selectedModes($i) {
                set selected [lindex $freqLabels($i) $idx]
                set modeNumber [expr {$idx + 1}]
                $resultHandle SetCurrentSimulation $idx
                set contourHandle contour; $resultHandle GetContourCtrlHandle $contourHandle
                set legendHandle legend; $contourHandle GetLegendHandle $legendHandle
                set modeLabel [string trim [string range $selected [expr {[string first "|" $selected] + 1}] end]]
                $legendHandle SetPosition "lower left"
                $legendHandle SetMinMaxVisibility false
                $legendHandle ReleaseHandle; $contourHandle ReleaseHandle
                $pageHandle SetAnimationMode modal
                set animatorHandle animator; $pageHandle GetAnimatorHandle $animatorHandle
                $animatorHandle SetAnimationMode modal
                $animatorHandle SetIncrementBy angle
                $animatorHandle SetIncrement 30
                $animatorHandle SetNumberOfFrames 12
                $animatorHandle SetCurrentFrame 0
                $clientHandle Draw; update
                set safe [string map {" " "_" ":" "_" "/" "_" "\\" "_" "=" "_" "," "_"} $modeLabel]
                set gif [file join $outputDir "Model_[format %03d [expr {$i+1}]]_${viewChoice}_Mode_[format %03d $modeNumber]_${safe}.gif"]
                set captureWindow [expr {$wi - 1}]
                set rc [$sessHandle CaptureAnimationByWindow $captureWindow gif $gif 0 0 1 1 percent 100 100]
                if {$rc != 0 || ![file exists $gif] || [file size $gif] == 0} {error "GIF capture failed for Model [expr {$i+1}], mode $modeNumber (return=$rc)."}
                puts $log "model=[expr {$i+1}] file=$paths($i) mode=$selected view=$viewChoice zoom=$zoomFactor gif=$gif bytes=[file size $gif]"
                $animatorHandle ReleaseHandle
            }
            $resultHandle ReleaseHandle; $modelHandle ReleaseHandle; $clientHandle ReleaseHandle; $windowHandle ReleaseHandle; $pageHandle ReleaseHandle
        }
        close $log
        catch {$projectHandle ReleaseHandle}; catch {$sessHandle ReleaseHandle}; hwi CloseStack
    } err opts]
    catch {hwi CloseStack}
    if {$code} {set status "GIF export failed: $err"} else {set status "Created $captureCount animated GIF file(s) for $count model(s), view $viewChoice, under $outputDir"}
}

proc ::hv2022dash::show {} {
    variable rowsFrame; variable status; variable outputDir; variable viewChoice; variable zoomFactor
    if {[winfo exists .hv2022dash]} {destroy .hv2022dash}
    toplevel .hv2022dash
    wm title .hv2022dash "HyperView 2022 - Modal GIF Dashboard"
    wm minsize .hv2022dash 1450 0
    set r 0
    label .hv2022dash.title -text "Dynamic modal model importer and GIF exporter" -font {Arial 14 bold}
    grid .hv2022dash.title -row $r -column 0 -columnspan 5 -sticky w -padx 12 -pady 10; incr r
    label .hv2022dash.h1 -text "Model"; label .hv2022dash.h2 -text "OP2 path (Browse does not import)"; label .hv2022dash.h3 -text "Browse"; label .hv2022dash.h4 -text "Modes to export (e.g. 1-10 15 20-25)"; label .hv2022dash.h5 -text "Frequency list (after import)"
    foreach {w c} {.hv2022dash.h1 0 .hv2022dash.h2 1 .hv2022dash.h3 2 .hv2022dash.h4 3 .hv2022dash.h5 4} {grid $w -row $r -column $c -sticky w -padx 5}
    incr r
    frame .hv2022dash.rows
    set rowsFrame .hv2022dash.rows
    grid $rowsFrame -row $r -column 0 -columnspan 5 -sticky ew -padx 8
    incr r
    grid columnconfigure .hv2022dash 1 -weight 1
    grid columnconfigure .hv2022dash 3 -weight 1
    grid columnconfigure .hv2022dash 4 -weight 1
    grid columnconfigure $rowsFrame 1 -weight 1
    grid columnconfigure $rowsFrame 3 -weight 1
    grid columnconfigure $rowsFrame 4 -weight 1
    label .hv2022dash.viewlabel -text "View for all models"
    ttk::combobox .hv2022dash.view -state readonly -textvariable ::hv2022dash::viewChoice -values {iso front back left right top bottom} -width 12
    label .hv2022dash.zoomlabel -text "Zoom multiplier (1.0 = Fit)"
    entry .hv2022dash.zoom -textvariable ::hv2022dash::zoomFactor -width 8
    button .hv2022dash.applyview -text "Apply view to all models" -command ::hv2022dash::applyView
    grid .hv2022dash.viewlabel -row $r -column 0 -sticky e -padx 6 -pady 5
    grid .hv2022dash.view -row $r -column 1 -sticky w -padx 4 -pady 5
    grid .hv2022dash.zoomlabel -row $r -column 2 -sticky e -padx 6 -pady 5
    grid .hv2022dash.zoom -row $r -column 3 -sticky w -padx 4 -pady 5
    grid .hv2022dash.applyview -row $r -column 4 -padx 6 -pady 5; incr r
    frame .hv2022dash.actions
    button .hv2022dash.actions.add -text "Add model row" -command ::hv2022dash::addRow
    button .hv2022dash.actions.import -text "Import all OP2s" -command ::hv2022dash::importAll
    pack .hv2022dash.actions.add .hv2022dash.actions.import -side left -padx 6
    grid .hv2022dash.actions -row $r -column 0 -columnspan 5 -sticky w -padx 8 -pady 8; incr r
    label .hv2022dash.ol -text "GIF folder"
    entry .hv2022dash.oe -textvariable ::hv2022dash::outputDir -width 76
    button .hv2022dash.ob -text "Browse..." -command ::hv2022dash::pickOutput
    button .hv2022dash.export -text "Export animated GIFs" -command ::hv2022dash::exportGifs
    grid .hv2022dash.ol -row $r -column 0 -sticky e -padx 6 -pady 5
    grid .hv2022dash.oe -row $r -column 1 -columnspan 2 -sticky ew -padx 4 -pady 5
    grid .hv2022dash.ob -row $r -column 3 -padx 4 -pady 5
    grid .hv2022dash.export -row $r -column 4 -padx 6 -pady 5; incr r
    label .hv2022dash.status -textvariable ::hv2022dash::status -anchor w -wraplength 1000
    grid .hv2022dash.status -row $r -column 0 -columnspan 5 -sticky ew -padx 12 -pady 8
    ::hv2022dash::addRow; ::hv2022dash::addRow; ::hv2022dash::addRow; ::hv2022dash::addRow
    update idletasks
    wm geometry .hv2022dash "[winfo reqwidth .hv2022dash]x[winfo reqheight .hv2022dash]"
}

::hv2022dash::show
