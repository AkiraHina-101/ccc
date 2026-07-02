# =============================================================================
# nastran_control.tcl  —  Nastran Control Tool  (entry point)
#
# Usage from HyperMesh:
#   *evaltclscript("D:/Tools/nastran_control/nastran_control.tcl", 0)
#
# Usage from hmbatch / tclsh (testing):
#   source nastran_control.tcl
#
# Flow:
#   1. Source all lib modules relative to this file
#   2. Determine model path from HM
#   3. Init session folder
#   4. Scan model → overlay session labels
#   5. Load session materials → feed to UI dropdown
#   6. Open / refresh the table window
# =============================================================================

# ─── Source lib modules ──────────────────────────────────────────────────────

set ::nc_dir [file dirname [info script]]
if {$::nc_dir eq "" || $::nc_dir eq "."} {
    set ::nc_dir [pwd]
}
set ::nc_lib [file join $::nc_dir lib]

# Load user-editable path config (Python exe + vendor site-packages).
# Sourced BEFORE lib modules so PYTHONPATH is set before any subprocess spawn.
set _nc_cfg [file join $::nc_dir config.tcl]
if {[file exists $_nc_cfg]} { source $_nc_cfg }
unset -nocomplain _nc_cfg

foreach _nc_mod {
    csv_io.tcl
    session.tcl
    scan.tcl
    labels.tcl
    mutations.tcl
    csv_import.tcl
    ui_table.tcl
    ui_session_manager.tcl
} {
    set _nc_path [file join $::nc_lib $_nc_mod]
    if {![file exists $_nc_path]} {
        error "nastran_control: missing lib module: $_nc_path"
    }
    source $_nc_path
}
unset _nc_mod _nc_path

# ─── App namespace ────────────────────────────────────────────────────────────

namespace eval ::nc::app {
    variable _model_path ""
}

# -----------------------------------------------------------------------------
# Public: run
#
# Main entry point — called once when the tool launches. If the window is
# already open, focuses it and re-scans.
# -----------------------------------------------------------------------------

proc ::nc::app::run {} {
    variable _model_path

    set _model_path [_current_model_path]
    ::nc::session::set_model_context $_model_path
    set sess_src [expr {$_model_path ne "" ? $_model_path : "untitled_model"}]

    # Headless/batch path: NC_SESSION_DIR skips the Session Manager entirely.
    set env_dir [_env_session_dir]
    if {$env_dir ne ""} {
        ::nc::session::set_dir $env_dir
        set rows_by_tab [_startup_rows_for_session]
        ::nc::ui_table::open $sess_src $rows_by_tab
        _log_startup_session $rows_by_tab
        return
    }

    # No Tk (plain tclsh / hmbatch without NC_SESSION_DIR): nothing to show,
    # nothing to open — abort quietly like the old cancelled-dialog path.
    if {[llength [info commands ::toplevel]] == 0} {
        return
    }

    set choice [::nc::session_manager::show startup]
    set action [dict get $choice action]
    set dir [dict get $choice dir]
    switch -- $action {
        cancel {
            # User dismissed the launcher — do not open the tool.
            return
        }
        new {
            # create_session already made <dir> active with a fresh skeleton.
            catch {::nc::session::recent_touch $dir}
            ::nc::ui_table::open $sess_src [_empty_rows_by_tab]
            ::nc::mutations::log_add "New session created: [::nc::session::dir] | table is empty until Reload"
            return
        }
        open {
            ::nc::session::set_dir $dir
            catch {::nc::session::recent_touch $dir}
            set rows_by_tab [_startup_rows_for_session]
            ::nc::ui_table::open $sess_src $rows_by_tab
            _log_startup_session $rows_by_tab
            return
        }
    }
}

proc ::nc::app::_log_startup_session {rows_by_tab} {
    set msg "Session selected: [::nc::session::dir]"
    if {[_rows_by_tab_has_data $rows_by_tab]} {
        append msg " | cached table loaded"
    } else {
        append msg " | table is empty until Reload"
    }
    ::nc::mutations::log_add $msg
}

# -----------------------------------------------------------------------------
# Public: scan
#
# Called by the [Scan] button inside the table window.
# Re-reads HM state, merges session labels, repopulates the table.
# -----------------------------------------------------------------------------

proc ::nc::app::scan {} {
    variable _model_path

    set mp [_current_model_path]
    if {$mp eq ""} { set mp $_model_path }
    set _model_path $mp
    ::nc::session::set_model_context $mp

    set rows [_scan_and_merge]
    set mat_rows [_load_and_feed_mats]

    ::nc::ui_table::populate_all [_build_tab_rows $rows]
    if {[llength $rows] > 0} {
        catch {::nc::ui_table::set_session_dirty 1}
    }
    if {[llength $rows] == 0} {
        ::nc::mutations::log_add "SCAN: no components found — open or import a model first."
    } else {
        ::nc::mutations::log_add "Re-scan: [llength $rows] component(s)."
    }
}

# ─── Wire [Scan] button to real scan proc ────────────────────────────────────
#
# ui_table.tcl defines _on_scan as a placeholder; redefine it here after
# all procs are declared so the button calls the real implementation.
#
proc ::nc::ui_table::_on_scan {} {
    ::nc::app::scan
}

# ─── Private helpers ─────────────────────────────────────────────────────────

proc ::nc::app::_current_model_path {} {
    # Best-effort current model file path, used ONLY to name the session folder.
    # Returns "" when nothing is available — callers fall back to a generic name
    # and still scan, since the scan does not need a file path.
    #
    # hm_info modelfile returns the saved .hm path (empty until the model is
    # saved). We accept any non-empty string and do NOT gate on [file exists],
    # because the path is only used for naming, not for reading the model.
    set mp ""
    catch {set mp [hm_info modelfile]}
    set mp [string trim $mp]
    if {$mp ne ""} { return $mp }

    # Fallback: env variable (useful for hmbatch testing)
    if {[info exists ::env(NC_MODEL_PATH)]} {
        return [string trim $::env(NC_MODEL_PATH)]
    }
    return ""
}

proc ::nc::app::_empty_rows_by_tab {} {
    return [dict create general {} component {} properties {} materials {}]
}

proc ::nc::app::_rows_by_tab_has_data {rows_by_tab} {
    foreach tab {general component properties materials} {
        if {[dict exists $rows_by_tab $tab] && [llength [dict get $rows_by_tab $tab]] > 0} {
            return 1
        }
    }
    return 0
}

proc ::nc::app::_session_internal_subfolder_names {} {
    return {edits cache thumb_cache Component_Images}
}

proc ::nc::app::_resolve_session_root {path} {
    # A picked file/folder may live inside one of the session's own internal
    # subfolders (e.g. <session>/edits/matprop_general.csv, which is where the
    # visible per-tab CSVs actually live). Walk up past any such known
    # internal subfolder names so the tool uses the real session root, not
    # a subfolder of it.
    set dir $path
    if {![file isdirectory $dir]} { set dir [file dirname $dir] }
    set internal [_session_internal_subfolder_names]
    while {[file tail $dir] in $internal} {
        set parent [file dirname $dir]
        if {$parent eq $dir} { break }
        set dir $parent
    }
    return $dir
}

proc ::nc::app::_env_session_dir {} {
    if {[info exists ::env(NC_SESSION_DIR)]} {
        set dir [string trim $::env(NC_SESSION_DIR)]
        if {$dir ne ""} { return [_resolve_session_root $dir] }
    }
    return ""
}

proc ::nc::app::_startup_rows_for_session {} {
    set empty [_empty_rows_by_tab]
    set dir ""
    catch {set dir [::nc::session::dir]}
    if {$dir eq ""} { return $empty }
    set trust_status missing
    set trust_reason ""
    catch {
        set trust [::nc::session::table_session_trust_status $dir]
        set trust_status [dict get $trust status]
        set trust_reason [dict get $trust reason]
    }
    set offline 0
    if {$trust_status ne "ok"} {
        if {$trust_reason ne ""} {
            catch {::nc::mutations::log_add "Session cache trust: $trust_reason"}
        }
        set offline 1
    }
    if {[catch {set result [::nc::session::load_table_session $dir]}]} {
        return $empty
    }
    set cached [dict get $result rows_by_tab]
    foreach tab {general component properties materials} {
        if {![dict exists $cached $tab]} { return $empty }
    }
    if {![_rows_by_tab_has_data $cached]} {
        set synth [_synthesize_rows_from_images $dir]
        if {$synth ne ""} {
            catch {_load_and_feed_mats}
            catch {::nc::mutations::log_add "Loaded [llength [dict get $synth component]] component(s) from Component_Images/ (no cached CSV data)"}
            return $synth
        }
        return $empty
    }
    set cached [_resolve_image_paths_in_rows_by_tab $cached $dir]
    set cached [_sync_label_columns_in_rows_by_tab $cached]
    catch {_load_and_feed_mats}
    if {$offline} {
        catch {::nc::mutations::log_add "Loaded cached session offline (no FEM required)"}
    }
    return $cached
}

proc ::nc::app::_sync_label_columns_in_rows_by_tab {rows_by_tab} {
    # If user hand-edits the CSV `label` column, sync `comp_user_name` from it
    # so the displayed "Component Label" reflects the edit. Same for
    # prop_user_name/prop_name and mat_user_name/material_label.
    foreach tab {general component} {
        if {![dict exists $rows_by_tab $tab]} continue
        set new {}
        foreach row [dict get $rows_by_tab $tab] {
            set row [_sync_label_pair $row comp_user_name label]
            set row [_sync_label_pair $row prop_user_name prop_name]
            set row [_sync_label_pair $row mat_user_name material_label]
            lappend new $row
        }
        dict set rows_by_tab $tab $new
    }
    foreach tab {properties} {
        if {![dict exists $rows_by_tab $tab]} continue
        set new {}
        foreach row [dict get $rows_by_tab $tab] {
            set row [_sync_label_pair $row prop_user_name prop_name]
            lappend new $row
        }
        dict set rows_by_tab $tab $new
    }
    foreach tab {materials} {
        if {![dict exists $rows_by_tab $tab]} continue
        set new {}
        foreach row [dict get $rows_by_tab $tab] {
            set row [_sync_label_pair $row mat_user_name material_label]
            lappend new $row
        }
        dict set rows_by_tab $tab $new
    }
    return $rows_by_tab
}

proc ::nc::app::_sync_label_pair {row user_key alt_key} {
    set uv ""; set av ""
    catch {set uv [dict get $row $user_key]}
    catch {set av [dict get $row $alt_key]}
    if {$av ne "" && $av ne $uv} {
        dict set row $user_key $av
    } elseif {$uv ne "" && $av eq ""} {
        dict set row $alt_key $uv
    }
    return $row
}

proc ::nc::app::_synthesize_rows_from_images {session_dir} {
    set img_dir [file join $session_dir Component_Images]
    if {![file isdirectory $img_dir]} { return "" }
    set entries {}
    foreach f [glob -nocomplain -directory $img_dir *] {
        if {![file isfile $f]} continue
        set ext [string tolower [file extension $f]]
        if {$ext ni {.png .jpg .jpeg .bmp .gif}} continue
        set stem [file rootname [file tail $f]]
        if {![string is integer -strict $stem]} continue
        lappend entries [list $stem $f]
    }
    if {[llength $entries] == 0} { return "" }
    set entries [lsort -integer -index 0 $entries]
    set comp_rows {}
    foreach e $entries {
        set cid [lindex $e 0]
        set path [lindex $e 1]
        lappend comp_rows [dict create \
            case_type 1 \
            comp_id $cid \
            comp_name "" \
            hm_comp_name "" \
            comp_user_name "" \
            label "" \
            prop_card "" \
            prop_id "" \
            prop_name "" \
            prop_user_name "" \
            mat_id "" \
            mat_name "" \
            mat_user_name "" \
            material_label "" \
            mass_total "" \
            note "" \
            image_path $path \
            _dirty_fields {} \
            _pending_fields {} \
            _pending_values {}]
    }
    return [dict create \
        general    $comp_rows \
        component  $comp_rows \
        properties {} \
        materials  {}]
}

proc ::nc::app::_resolve_image_paths_in_rows_by_tab {rows_by_tab session_dir} {
    set img_dir [file join $session_dir Component_Images]
    set has_img_dir [file isdirectory $img_dir]
    set by_cid [dict create]
    if {$has_img_dir} {
        foreach f [glob -nocomplain -directory $img_dir *] {
            if {![file isfile $f]} continue
            set ext [string tolower [file extension $f]]
            if {$ext ni {.png .jpg .jpeg .bmp .gif}} continue
            set stem [file rootname [file tail $f]]
            if {[string is integer -strict $stem]} { dict set by_cid $stem $f }
        }
    }
    foreach tab {general component} {
        if {![dict exists $rows_by_tab $tab]} continue
        set new {}
        foreach row [dict get $rows_by_tab $tab] {
            set p ""
            catch {set p [dict get $row image_path]}
            set need_scan 0
            if {$p eq ""} {
                set need_scan 1
            } elseif {![file exists $p] && $has_img_dir} {
                set cand [file join $img_dir [file tail $p]]
                if {[file exists $cand]} {
                    dict set row image_path $cand
                } else {
                    set need_scan 1
                }
            }
            if {$need_scan} {
                set cid ""
                catch {set cid [dict get $row comp_id]}
                if {$cid ne "" && [dict exists $by_cid $cid]} {
                    dict set row image_path [dict get $by_cid $cid]
                }
            }
            lappend new $row
        }
        dict set rows_by_tab $tab $new
    }
    return $rows_by_tab
}

proc ::nc::app::_scan_and_merge {} {
    set rows {}
    catch {
        set rows [::nc::scan::scan_model]
        set rows [::nc::session::merge_labels $rows]
    }
    return $rows
}

proc ::nc::app::_load_and_feed_mats {} {
    set mat_rows {}
    catch {set mat_rows [::nc::session::load_materials]}
    ::nc::ui_table::set_mat_rows $mat_rows
    return $mat_rows
}

# -----------------------------------------------------------------------------
# Build the 4 per-tab row lists from the component scan.
#   general / component : the component rows as-is.
#   properties          : derived — one row per distinct prop_id + usage count.
#   materials           : derived — one row per distinct mat_id + usage count.
# Phase A derives Property/Material from the component scan (no new HM calls);
# Phase B replaces these with full ::nc::scan::scan_properties/scan_materials.
# -----------------------------------------------------------------------------

proc ::nc::app::_build_tab_rows {comp_rows} {
    set comp_rows [_decorate_component_rows $comp_rows]
    return [dict create \
        general    $comp_rows \
        component  $comp_rows \
        properties [_derive_properties $comp_rows] \
        materials  [_derive_materials  $comp_rows]]
}

proc ::nc::app::_load_cached_table_or_build {comp_rows} {
    set built [_build_tab_rows $comp_rows]
    set dir ""
    catch {set dir [::nc::session::dir]}
    if {$dir eq ""} { return $built }
    set trust_status missing
    set trust_reason ""
    catch {
        set trust [::nc::session::table_session_trust_status $dir]
        set trust_status [dict get $trust status]
        set trust_reason [dict get $trust reason]
    }
    if {$trust_status ne "ok"} {
        if {$trust_reason ne ""} {
            catch {::nc::mutations::log_add "Session cache ignored: $trust_reason"}
        }
        return $built
    }
    if {[catch {set result [::nc::session::load_table_session $dir]}]} {
        return $built
    }
    set cached [dict get $result rows_by_tab]
    foreach tab {general component properties materials} {
        if {![dict exists $cached $tab]} { return $built }
    }
    if {[llength [dict get $cached component]] == 0 && [llength [dict get $cached general]] == 0} {
        return $built
    }
    return $cached
}

proc ::nc::app::_decorate_component_rows {comp_rows} {
    set out {}
    foreach row $comp_rows {
        set comp_name [expr {[dict exists $row comp_name] ? [dict get $row comp_name] : ""}]
        set label [expr {[dict exists $row label] && [dict get $row label] ne "" ? [dict get $row label] : $comp_name}]
        dict set row hm_comp_name $comp_name
        dict set row comp_user_name $label
        dict set row prop_user_name [expr {[dict exists $row prop_name] ? [dict get $row prop_name] : ""}]
        dict set row mat_user_name [expr {[dict exists $row material_label] && [dict get $row material_label] ne "" ? [dict get $row material_label] : [dict get $row mat_name]}]
        if {![dict exists $row mass_total_raw]} { dict set row mass_total_raw "" }
        if {![dict exists $row mass_total]} { dict set row mass_total "" }
        if {![dict exists $row image_path]} { dict set row image_path "" }
        if {![dict exists $row note]} { dict set row note "" }
        lappend out $row
    }
    return $out
}

proc ::nc::app::calculate_component_masses {} {
    set comp_ids [::nc::ui_table::get_component_ids]
    if {[llength $comp_ids] == 0} {
        ::nc::ui_table::set_status "No components available for mass calculation." warn
        return
    }
    if {[llength [info commands hm_getmass]] == 0} {
        ::nc::ui_table::set_status "hm_getmass is not available in this session." warn
        return
    }
    set mass_by_comp [dict create]
    set count 0
    foreach cid $comp_ids {
        set mass_values [_component_mass_values $cid]
        if {[lindex $mass_values 0] eq "" && [lindex $mass_values 1] eq "" && [lindex $mass_values 2] eq ""} {
            continue
        }
        dict set mass_by_comp $cid [lindex $mass_values 0]
        incr count
    }
    ::nc::ui_table::set_component_mass_values $mass_by_comp
    ::nc::ui_table::set_status "Calculated mass for $count component(s)." ok
}

proc ::nc::app::_component_mass_values {comp_id} {
    set total ""
    set structural ""
    set nonstructural ""
    if {$comp_id eq ""} {
        return [list $total $structural $nonstructural]
    }
    if {[llength [info commands hm_getmass]] == 0} {
        return [list $total $structural $nonstructural]
    }
    set ok [catch {
        *createmark comps 1 "by id" $comp_id
        set massvaluelist [hm_getmass comps 1 0 0]
        set total [lindex $massvaluelist 0]
        set structural [lindex $massvaluelist 3]
        set nonstructural [lindex $massvaluelist 4]
    }]
    catch {*clearmark comps 1}
    if {$ok} {
        return [list "" "" ""]
    }
    return [list $total $structural $nonstructural]
}

proc ::nc::app::capture_component_images {dir comp_ids {progress_cb ""} {cancel_cb ""}} {
    set image_map [dict create]
    if {[llength $comp_ids] == 0} { return $image_map }
    if {$dir eq ""} {
        catch {set dir [::nc::session::dir]}
    }
    if {$dir eq ""} { set dir [pwd] }
    set img_dir [file join $dir Component_Images]
    if {![file isdirectory $img_dir]} { file mkdir $img_dir }
    set image_size 768
    set image_quality 95
    set have_hwi [expr {[llength [info commands hwi]] > 0}]
    if {!$have_hwi && [llength [info commands *jpegfilenamed]] == 0} {
        error "HyperMesh graphics capture API is not available."
    }
    set total [llength $comp_ids]
    set idx 0
    set rc [catch {
        if {$have_hwi} {
            catch {hwi CloseStack}
            hwi OpenStack
            hwi GetSessionHandle sess1
        }
        set saved_view "NC_Capture_View_[clock clicks]"
        set saved_view_ok [expr {![catch {*saveviewmask $saved_view 0}]}]
        foreach comp_id $comp_ids {
            if {$comp_id eq ""} { continue }
            incr idx
            if {$cancel_cb ne "" && [uplevel #0 $cancel_cb]} {
                dict set image_map _cancelled 1
                dict set image_map _remaining_comp_ids [lrange $comp_ids [expr {$idx - 1}] end]
                break
            }
            catch {
                *createmark comps 1 $comp_id
                *createmark component 2 comp_id = $comp_id
                *createstringarray 2 "elements_on" "geometry_on"
                *isolateonlyentitybymark 2 1 2
                *view "iso1"
                *window 0 0 0 0 0
            }
            set png_path [file join $img_dir "$comp_id.png"]
            set jpg_path [file join $img_dir "$comp_id.jpg"]
            catch {file delete -force -- $png_path}
            catch {file delete -force -- $jpg_path}
            if {$have_hwi && ![catch {sess1 CaptureScreenToSize png "$png_path" $image_size $image_size $image_quality}] && [file exists $png_path]} {
                dict set image_map $comp_id $png_path
            } elseif {![catch {*jpegfilenamed $jpg_path}] && [file exists $jpg_path]} {
                dict set image_map $comp_id $jpg_path
            }
            if {$progress_cb ne ""} {
                catch {uplevel #0 $progress_cb [list $idx $total $comp_id]}
            }
        }
        if {$progress_cb ne ""} {
            catch {uplevel #0 $progress_cb [list restore $total ""]}
        }
        catch {
            *createmark comps 1 "all"
            *showentity comps 1
        }
        if {$saved_view_ok} {
            catch {*restoreviewmask $saved_view 0}
            catch {*removeview $saved_view}
        }
        if {$have_hwi} { catch {hwi CloseStack} }
        if {$progress_cb ne ""} {
            catch {uplevel #0 $progress_cb [list restore_done $total ""]}
        }
    } err opts]
    if {$rc} {
        catch {
            *createmark comps 1 "all"
            *showentity comps 1
        }
        if {[info exists saved_view_ok] && $saved_view_ok} {
            catch {*restoreviewmask $saved_view 0}
            catch {*removeview $saved_view}
        }
        if {$have_hwi} { catch {hwi CloseStack} }
        return -options $opts $err
    }
    return $image_map
}

proc ::nc::app::_derive_properties {comp_rows} {
    set byp [dict create]
    set prop_fields {T NSM Z1 Z2}
    set order {}
    set seen_card [dict create]
    foreach row $comp_rows {
        set pid [dict get $row prop_id]
        if {$pid eq "" || $pid <= 0} continue
        set card [dict get $row prop_card]
        if {$card ne ""} { dict set seen_card $card 1 }
        if {![dict exists $byp $pid]} {
            set d [dict create \
                prop_id     $pid \
                prop_card   $card \
                prop_name   [dict get $row prop_name] \
                prop_user_name [dict get $row prop_user_name] \
                mat_id      [dict get $row mat_id] \
                mat_card    [dict get $row mat_card] \
                mat_name    [dict get $row mat_name] \
                mat_user_name [dict get $row mat_user_name] \
                usage_count 0 \
                note ""]
            foreach field $prop_fields {
                if {[dict exists $row $field]} {
                    dict set d $field [dict get $row $field]
                }
            }
            set d [_add_preview_property_fields $d]
            dict set byp $pid $d
            lappend order $pid
        }
        set d [dict get $byp $pid]
        dict set d usage_count [expr {[dict get $d usage_count] + 1}]
        dict set byp $pid $d
    }
    set out {}
    foreach pid $order { lappend out [dict get $byp $pid] }
    foreach sample_card {PSHELL PSOLID PBUSH} {
        if {![dict exists $seen_card $sample_card]} {
            lappend out [_preview_property_sample $sample_card [expr {900000 + [llength $out] + 1}]]
        }
    }
    return $out
}

proc ::nc::app::_derive_materials {comp_rows} {
    set bym [dict create]
    set seen_prop [dict create]   ;# mat_id -> dict of prop_id already counted
    set mat_fields {E G NU RHO A TREF GE ST SC SS}
    set order {}
    foreach row $comp_rows {
        set mid [dict get $row mat_id]
        if {$mid eq "" || $mid <= 0} continue
        set pid [dict get $row prop_id]
        if {![dict exists $bym $mid]} {
            set d [dict create \
                mat_id      $mid \
                mat_name    [dict get $row mat_name] \
                mat_user_name [dict get $row mat_user_name] \
                mat_card    [dict get $row mat_card] \
                usage_count 0 \
                note ""]
            foreach field $mat_fields {
                if {[dict exists $row $field]} {
                    dict set d $field [dict get $row $field]
                }
            }
            set d [_add_preview_material_fields $d]
            dict set bym $mid $d
            dict set seen_prop $mid [dict create]
            lappend order $mid
        }
        # Count distinct properties using this material.
        if {$pid ne "" && $pid > 0} {
            set sp [dict get $seen_prop $mid]
            if {![dict exists $sp $pid]} {
                dict set sp $pid 1
                dict set seen_prop $mid $sp
                set d [dict get $bym $mid]
                dict set d usage_count [expr {[dict get $d usage_count] + 1}]
                dict set bym $mid $d
            }
        }
    }
    set out {}
    foreach mid $order { lappend out [dict get $bym $mid] }
    if {[llength $out] == 0} {
        lappend out [_preview_material_sample 910001 Steel_preview]
        lappend out [_preview_material_sample 910002 Rubber_preview]
    }
    return $out
}

proc ::nc::app::_add_preview_property_fields {row} {
    set pid [dict get $row prop_id]
    set card [string toupper [dict get $row prop_card]]
    if {$card eq ""} { set card PSHELL; dict set row prop_card $card }
    set base [expr {($pid % 9) + 1}]
    foreach {k v} [list \
        T [format %.3f [expr {0.8 + ($base * 0.1)}]] \
        NSM 0 \
        Z1 "" \
        Z2 "" \
        E 210000 \
        G 80769 \
        NU 0.30 \
        RHO 7.85e-9 \
        A "" \
        TREF 20 \
        ST "" \
        SC "" \
        SS ""] {
        if {![dict exists $row $k] || [dict get $row $k] eq ""} { dict set row $k $v }
    }
    foreach k {K1 K2 K3 K4 K5 K6 B1 B2 B3 B4 B5 B6 GE1 GE2 GE3 GE4 GE5 GE6 M1 M2 M3 M4 M5 M6} {
        if {![dict exists $row $k]} { dict set row $k "" }
    }
    if {$card eq "PBUSH"} {
        foreach k {K1 K2 K3 K4 K5 K6} { dict set row $k [expr {1000 * $base}] }
        foreach k {B1 B2 B3 B4 B5 B6} { dict set row $k [expr {10 * $base}] }
        foreach k {GE1 GE2 GE3 GE4 GE5 GE6} { dict set row $k 0.02 }
        foreach k {M1 M2 M3 M4 M5 M6} { dict set row $k "" }
    }
    return $row
}

proc ::nc::app::_preview_property_sample {card pid} {
    set row [dict create \
        prop_card $card \
        prop_id $pid \
        prop_name "${card}_preview" \
        prop_user_name "${card}_preview" \
        mat_card MAT1 \
        mat_id 910001 \
        mat_name Steel_preview \
        mat_user_name Steel_preview \
        usage_count 0 \
        note "Preview sample row - no HM entity"]
    return [_add_preview_property_fields $row]
}

proc ::nc::app::_add_preview_material_fields {row} {
    foreach {k v} {
        E 210000
        G 80769
        NU 0.30
        RHO 7.85e-9
        A ""
        TREF 20
        GE 0.0
        ST ""
        SC ""
        SS ""
    } {
        if {![dict exists $row $k] || [dict get $row $k] eq ""} { dict set row $k $v }
    }
    if {![dict exists $row mat_card] || [dict get $row mat_card] eq ""} { dict set row mat_card MAT1 }
    if {![dict exists $row mat_user_name] || [dict get $row mat_user_name] eq ""} {
        dict set row mat_user_name [dict get $row mat_name]
    }
    return $row
}

proc ::nc::app::_preview_material_sample {mid label} {
    set row [dict create \
        mat_card MAT1 \
        mat_id $mid \
        mat_user_name $label \
        mat_name $label \
        usage_count 0 \
        note "Preview sample row - no HM entity"]
    return [_add_preview_material_fields $row]
}

proc ::nc::app::_save_session_if_new {rows} {
    # Only write comps.csv on first run (file absent) to avoid clobbering labels
    set comps_path [file join [::nc::session::dir] comps.csv]
    if {![file exists $comps_path]} {
        catch {::nc::session::save_comps $rows}
    }
}

# ─── Launch ──────────────────────────────────────────────────────────────────

::nc::app::run
