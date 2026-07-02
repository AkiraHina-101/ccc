# =============================================================================
# ui_session_manager.tcl  —  ::nc::session_manager
#
# Professional session launcher dialog for the Nastran Control Tool.
# Shown at startup (before the main window) and from "Session Manager..."
# mid-run to switch sessions.
#
#   ::nc::session_manager::show {mode}   mode = startup | switch
#     -> dict {action open|new|cancel  dir <session_root>}
#
# open   — user picked an existing session (recent row or Browse); caller
#          loads all cached data + images into the table.
# new    — a fresh session skeleton was created via ::nc::session::create_session
#          and is already the active session; caller opens an EMPTY table.
# cancel — user dismissed the dialog; caller aborts (startup) or no-ops (switch).
#
# Reuses ::nc::ui_table::_choose_folder_dialog / _prompt_text /
# _resolve_session_root / _place_companion_window — must be sourced after
# ui_table.tcl. Pure-logic helpers (format_row, can_open) are Tk-free so the
# headless test suite can exercise them in plain tclsh.
# =============================================================================

namespace eval ::nc::session_manager {
    variable _win ""
    variable _result ""
    variable _mode startup
    variable _selected_path ""
    variable _selected_missing 1
    variable _item_paths
    array set _item_paths {}
    variable _item_missing
    array set _item_missing {}
}

# ─── Pure logic (Tk-free, headless-testable) ─────────────────────────────────

proc ::nc::session_manager::can_open {summary} {
    if {[dict exists $summary missing] && [dict get $summary missing]} {
        return 0
    }
    return 1
}

proc ::nc::session_manager::format_row {summary} {
    # -> list {name rows img last_saved} of display strings.
    set name ""
    catch {set name [dict get $summary name]}
    if {[dict exists $summary missing] && [dict get $summary missing]} {
        return [list $name "-" "-" "(missing)"]
    }
    set rows ""
    catch {set rows [dict get $summary row_count]}
    if {$rows eq ""} { set rows "0" }
    set img "-"
    catch {if {[dict get $summary has_images]} { set img "yes" }}
    set last ""
    catch {set last [dict get $summary saved_at]}
    if {$last eq ""} { set last "-" }
    return [list $name $rows $img $last]
}

# ─── Dialog ──────────────────────────────────────────────────────────────────

proc ::nc::session_manager::show {{mode startup}} {
    variable _win
    variable _result
    variable _mode
    variable _selected_path
    variable _selected_missing

    set _mode $mode
    set _result [dict create action cancel dir ""]
    set _selected_path ""
    set _selected_missing 1

    set w .nc_session_mgr
    catch {destroy $w}
    toplevel $w
    set _win $w
    if {$mode eq "switch"} {
        wm title $w "Nastran Control - Switch Session"
    } else {
        wm title $w "Nastran Control - Session Manager"
    }
    catch {wm minsize $w 560 360}
    wm protocol $w WM_DELETE_WINDOW {::nc::session_manager::_finish cancel ""}

    label $w.head -text "Recent Sessions" -anchor w -font {Arial 10 bold}
    pack $w.head -side top -fill x -padx 10 -pady {10 4}

    set lf [frame $w.listframe -bd 1 -relief sunken -background white]
    pack $lf -side top -fill both -expand 1 -padx 10 -pady 2
    catch {package require Ttk}
    set tv [ttk::treeview $lf.tree -columns {rows img saved path} \
        -show {tree headings} -selectmode browse \
        -yscrollcommand [list $lf.sy set]]
    scrollbar $lf.sy -orient v -command [list $tv yview]
    pack $lf.sy -side right -fill y
    pack $tv -side left -fill both -expand 1
    $tv heading #0 -text "Name"
    $tv heading rows -text "Rows"
    $tv heading img -text "Img"
    $tv heading saved -text "Last Saved"
    $tv heading path -text "Path"
    $tv column #0 -width 150 -stretch 0
    $tv column rows -width 50 -anchor e -stretch 0
    $tv column img -width 40 -anchor center -stretch 0
    $tv column saved -width 130 -stretch 0
    $tv column path -width 240 -stretch 1
    catch {$tv tag configure nc_missing -foreground #999999}
    bind $tv <<TreeviewSelect>> {::nc::session_manager::_on_select}
    bind $tv <Double-Button-1> {::nc::session_manager::_on_open}
    bind $tv <Return> {::nc::session_manager::_on_open; break}
    bind $tv <Button-3> {::nc::session_manager::_on_right_click %x %y %X %Y}
    bind $tv <MouseWheel> {%W yview scroll [expr {-(%D/120)}] units}

    label $w.selected -text "Selected: (none)" -anchor w -foreground #555555
    pack $w.selected -side top -fill x -padx 10 -pady {4 0}

    set bf [frame $w.buttons]
    pack $bf -side top -fill x -padx 10 -pady {6 10}
    button $bf.new -text "New Session..." -command {::nc::session_manager::_on_new}
    button $bf.browse -text "Browse..." -command {::nc::session_manager::_on_browse}
    set cancel_text [expr {$mode eq "switch" ? "Close" : "Cancel"}]
    button $bf.cancel -text $cancel_text -command {::nc::session_manager::_finish cancel ""}
    button $bf.open -text "Open" -width 8 -state disabled \
        -command {::nc::session_manager::_on_open}
    pack $bf.new -side left
    pack $bf.browse -side left -padx {6 0}
    pack $bf.cancel -side right
    pack $bf.open -side right -padx {0 6}

    _refresh_list
    catch {::nc::ui_table::_place_companion_window $w 660 440}
    _center_if_unplaced $w 660 440
    catch {focus $tv}
    catch {grab $w}
    tkwait window $w
    catch {grab release $w}
    set _win ""
    return $_result
}

proc ::nc::session_manager::_center_if_unplaced {w width height} {
    # Startup mode has no parent window; center on screen.
    catch {
        if {![winfo exists $w]} { return }
        set parent ""
        catch {set parent $::nc::ui_table::_win}
        if {$parent ne "" && [winfo exists $parent]} { return }
        set sw [winfo screenwidth $w]
        set sh [winfo screenheight $w]
        set x [expr {($sw - $width) / 2}]
        set y [expr {($sh - $height) / 3}]
        if {$x < 0} { set x 0 }
        if {$y < 0} { set y 0 }
        wm geometry $w "${width}x${height}+${x}+${y}"
    }
}

proc ::nc::session_manager::_tree {} {
    variable _win
    if {$_win eq "" || ![winfo exists $_win.listframe.tree]} { return "" }
    return $_win.listframe.tree
}

proc ::nc::session_manager::_refresh_list {} {
    variable _item_paths
    variable _item_missing
    variable _selected_path
    variable _selected_missing
    set tv [_tree]
    if {$tv eq ""} { return }
    catch {$tv delete [$tv children {}]}
    array unset _item_paths
    array set _item_paths {}
    array unset _item_missing
    array set _item_missing {}
    set _selected_path ""
    set _selected_missing 1
    _update_selection_ui
    set entries {}
    catch {set entries [::nc::session::recent_list]}
    foreach e $entries {
        set path [dict get $e path]
        set summary ""
        if {[catch {set summary [::nc::session::session_summary $path]}]} {
            set summary [dict create name [file tail $path] saved_at "" \
                row_count "" has_images 0 missing 1]
        }
        set disp [format_row $summary]
        set tags {}
        if {![can_open $summary]} { lappend tags nc_missing }
        set id [$tv insert {} end -text [lindex $disp 0] \
            -values [list [lindex $disp 1] [lindex $disp 2] [lindex $disp 3] $path] \
            -tags $tags]
        set _item_paths($id) $path
        set _item_missing($id) [expr {![can_open $summary]}]
    }
}

proc ::nc::session_manager::_update_selection_ui {} {
    variable _win
    variable _selected_path
    variable _selected_missing
    if {$_win eq "" || ![winfo exists $_win]} { return }
    if {[winfo exists $_win.selected]} {
        if {$_selected_path eq ""} {
            $_win.selected configure -text "Selected: (none)"
        } elseif {$_selected_missing} {
            $_win.selected configure -text "Selected: $_selected_path (missing on disk)"
        } else {
            $_win.selected configure -text "Selected: $_selected_path"
        }
    }
    if {[winfo exists $_win.buttons.open]} {
        if {$_selected_path ne "" && !$_selected_missing} {
            $_win.buttons.open configure -state normal
        } else {
            $_win.buttons.open configure -state disabled
        }
    }
}

proc ::nc::session_manager::_on_select {} {
    variable _item_paths
    variable _item_missing
    variable _selected_path
    variable _selected_missing
    set tv [_tree]
    if {$tv eq ""} { return }
    set sel [$tv selection]
    if {[llength $sel] == 0} {
        set _selected_path ""
        set _selected_missing 1
    } else {
        set id [lindex $sel 0]
        set _selected_path ""
        set _selected_missing 1
        if {[info exists _item_paths($id)]} {
            set _selected_path $_item_paths($id)
            set _selected_missing $_item_missing($id)
        }
    }
    _update_selection_ui
}

proc ::nc::session_manager::_on_open {} {
    variable _selected_path
    variable _selected_missing
    if {$_selected_path eq "" || $_selected_missing} { return }
    set root $_selected_path
    catch {set root [::nc::ui_table::_resolve_session_root $_selected_path]}
    _finish open $root
}

proc ::nc::session_manager::_on_browse {} {
    variable _win
    set initial ""
    catch {set initial [file normalize [::nc::session::_sessions_root]]}
    if {$initial eq "" || ![file isdirectory $initial]} { set initial [pwd] }
    set picked ""
    catch {set picked [::nc::ui_table::_choose_folder_dialog "Open Session Folder" $initial]}
    catch {grab $_win}
    if {$picked eq ""} { return }
    set root $picked
    catch {set root [::nc::ui_table::_resolve_session_root $picked]}
    _finish open $root
}

proc ::nc::session_manager::_on_new {} {
    variable _win
    set initial ""
    catch {set initial [file normalize [::nc::session::_sessions_root]]}
    catch {file mkdir $initial}
    if {$initial eq "" || ![file isdirectory $initial]} { set initial [pwd] }
    set parent ""
    catch {set parent [::nc::ui_table::_choose_folder_dialog \
        "Choose Parent Folder for New Session" $initial]}
    catch {grab $_win}
    if {$parent eq ""} { return }
    set name ""
    catch {set name [::nc::ui_table::_prompt_text "New Session" "Session name:" ""]}
    catch {grab $_win}
    set name [string trim $name]
    if {$name eq ""} { return }
    if {[catch {set dest [::nc::session::create_session $parent $name]} err]} {
        catch {tk_messageBox -parent $_win -title "New Session" -icon error -type ok \
            -message "Could not create session:\n$err"}
        return
    }
    _finish new $dest
}

proc ::nc::session_manager::_on_right_click {x y rootx rooty} {
    variable _win
    variable _item_paths
    set tv [_tree]
    if {$tv eq ""} { return }
    set id [$tv identify item $x $y]
    if {$id eq "" || ![info exists _item_paths($id)]} { return }
    catch {$tv selection set $id}
    set path $_item_paths($id)
    set m $_win.recentmenu
    catch {destroy $m}
    menu $m -tearoff 0
    $m add command -label "Remove from list" \
        -command [list ::nc::session_manager::_on_remove_recent $path]
    catch {tk_popup $m $rootx $rooty}
}

proc ::nc::session_manager::_on_remove_recent {path} {
    catch {::nc::session::recent_remove $path}
    _refresh_list
}

proc ::nc::session_manager::_finish {action dir} {
    variable _result
    variable _win
    set _result [dict create action $action dir $dir]
    catch {destroy $_win}
}
