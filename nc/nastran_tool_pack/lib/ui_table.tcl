# =============================================================================
# ui_table.tcl  --  ::nc::ui_table
#
# Refined compact preview UI for Nastran Control.
#
# Preview safety rule: this module must not call model-changing HM commands.
# Edits, assignment, create/duplicate/delete/apply/isolate are staged in memory.
# Capture may call graphics/display commands through nastran_control.tcl only.
# =============================================================================

# xlsx_io provides ::nc::xlsx::python_ok / convert_multi_to_xlsx /
# convert_xlsx_to_multi_csv — the xlsx-authoritative Save/Load path
# (session.tcl) and this UI layer's library snapshot + sheet-aware Import
# both use it directly. Idempotent - re-sourcing rebinds the same procs.
if {[info commands ::nc::xlsx::python_ok] eq ""} {
    catch {source [file join [file dirname [info script]] xlsx_io.tcl]}
}

namespace eval ::nc::ui_table {
    variable _win ""
    variable _hm_window_rect {}
    variable _root ""
    variable _tbl ""
    variable _log_w ""
    variable _status_lbl ""
    variable _session_lbl ""
    variable _tabbar ""
    variable _control_frame ""
    variable _tablebar ""
    variable _search_frame ""
    variable _search_group ""
    variable _pick_frame ""
    variable _display_frame ""
    variable _action_frame ""
    variable _io_frame ""
    variable _edit_frame ""
    variable _label_frame ""
    variable _review_frame ""
    variable _orientation_frame ""
    variable _current_named_view ""
    variable _display_auto_fit 1
    variable _hidden_comp_ids {}
    array set _icon_cache {}
    variable _library_frame ""
    variable _view_frame ""
    variable _prop_view_frame ""
    variable _pbush_frame ""
    variable _assign_frame ""
    variable _tableframe ""
    variable _status_frame ""
    variable _log_frame ""
    variable _log_grip ""
    variable _log_resize_start_y 0
    variable _log_resize_start_height 4
    variable _mat_cb ""
    variable _context_menu ""
    variable _tab_context_menu ""

    variable _tab component
    variable _rows {}
    variable _sort_col 0
    variable _sort_dir incr
    variable _mat_rows {}
    variable _mat_label ""
    variable _library_columns {}
    variable _library_match_last_type_col ""
    variable _library_match_last_label_col ""
    variable _library_match_last_fields {}
    # Match dialog v2 (two independent tables, no Match/Fill checkboxes -
    # a pair's presence in the Match list or Fill list IS its role). Each
    # entry is {lib_col target_field}; target_field is a material field key
    # (E/NU/RHO/mat_user_name/mat_label/...). Remembered per session so
    # reopening the dialog resumes the user's last picks instead of
    # starting blank.
    variable _library_match_last_match_pairs {}
    variable _library_match_last_fill_pairs {}
    variable _mass_unit "kg"
    variable _session_path ""
    variable _session_dirty 0
    variable _autosave_after_id ""
    variable _autosave_delay_ms 3000
    variable _autosave_enabled 1
    # Manual-save model: edits update the table in memory but are NEVER written
    # to disk automatically. Only the "Save Session" button writes. This keeps
    # the last saved state on disk intact so the user can Discard bad edits by
    # closing without saving. _autosave_timed gates the periodic auto-write;
    # left 0 so no timer ever fires. (_autosave_enabled stays as the separate
    # "is this session bound/savable" flag used by the save-policy checks.)
    variable _autosave_timed 0
    variable _autosave_suspend 0
    variable _autosave_running 0
    variable _autosave_warned_fail 0
    variable _last_saved_hhmmss ""
    variable _search_text ""
    variable _search_mode "All Labels"
    variable _property_view ALL
    variable _worklist_active 0
    variable _worklist_labels {}
    variable _worklist_ids {}
    # Raw worklist entries (IDs and labels mixed), deduped, in the exact
    # order they were typed/pasted - used to sort the filtered display so
    # results follow worklist order instead of the table's native row
    # order. _worklist_ids/_worklist_labels above stay split for matching.
    variable _worklist_items {}
    # Which column to match worklist entries against. "" (default) keeps
    # the original behavior of checking both the tab's ID column and its
    # label column at once. Any other value is a column key from
    # _cols_for_tab - lets the user filter on ANY column (Property Label,
    # HM Comp. Name, Prop Card, a material property, etc.), just not the
    # Image column since there's no meaningful text to type/match there.
    variable _worklist_col ""
    # Dialog-only scratch state: currently-shown combobox label, and the
    # label->key lookup built for whatever tab the dialog was opened on.
    variable _worklist_col_pick ""
    variable _worklist_dialog_label_to_key {}
    variable _worklist_dialog_active_col ""
    variable _worklist_memory
    array set _worklist_memory {}
    # Set by _material_id_for_label when a typed/picked Mat Type label
    # matches more than one Materials-tab row - callers that would
    # otherwise stomp the status bar with a generic "Pending ..." message
    # right after check this and surface it instead, so the ambiguity
    # warning isn't silently swallowed.
    variable _last_mat_ambiguous_msg ""
    variable _known_comp_ids_seeded 0
    variable _known_comp_ids_baseline {}
    variable _recent_new_comp_ids {}
    variable _edit_orig ""
    variable _edit_col -1
    variable _editing_cell ""
    variable _edit_widget ""
    variable _edit_var ""
    variable _combo_cell ""
    variable _combo_var ""
    variable _combo_widget ""
    variable _label_win ""
    variable _label_filter ""
    variable _label_target_key "comp_user_name"
    variable _label_target_cell ""
    variable _label_list ""
    variable _label_status ""
    variable _label_auto_next_table 1
    variable _label_auto_next_palette 1
    variable _label_bank
    variable _label_display_map {}
    variable _label_disabled_map {}
    variable _import_preview_plan ""
    variable _import_preview_win ""
    variable _header_press_col -1
    variable _header_dragging 0
    variable _header_hover_col -1
    variable _header_drop_slot -1
    variable _header_press_x 0
    variable _header_press_y 0
    variable _header_drag_threshold 6
    variable _header_resize_col -1
    variable _header_resize_start_x 0
    variable _header_resize_start_width 0
    variable _header_resize_edge_px 7
    variable _header_widgets {}
    variable _header_indicator ""
    variable _last_csv_dir ""
    variable _show_toolbar 1
    variable _show_data_toolbar 1
    variable _show_edit_toolbar 1
    variable _show_review_toolbar 1
    variable _show_view_toolbar 1
    variable _show_context_filter 1
    variable _show_status_log 1
    variable _show_images_col 1
    variable _show_notes_col 1
    variable _show_mat_params_col 0
    variable _compact_rows 1
    variable _alternate_rows 1
    variable _ui_font_size 9
    variable _image_thumb_px 96
    variable _image_widgets {}
    variable _image_photos
    variable _image_seq 0
    variable _image_photo_cache
    variable _image_render_signature ""
    variable _always_on_top_strict 0
    variable _highlight_active_gray_ids {}
    variable _findcomp_transparent_ids {}
    # Generic "last view action" bookkeeping shared by Isolate/Find Comp/
    # Highlight/Show-Hide so a single Invert button can flip whichever of
    # them ran most recently, instead of only ever undoing Highlight.
    # _last_view_target = the ids that action put in the "foreground"
    # state (shown/opaque/normal-colored/shown-after-toggle); _last_view_other
    # = the rest of the then-displayed universe, left in the "background"
    # state (hidden/transparent/greyed/hidden-after-toggle).
    variable _last_view_action ""
    variable _last_view_target {}
    variable _last_view_other {}
    variable _capture_cancelled 0
    variable _capture_resume_comp_ids {}
    variable _toolbar_wrap_after ""
    variable _toolbar_wrapping 0
    variable _main_geometry_after_id ""

    variable tableData
    variable _tab_btns
    variable _tab_rows
    variable _tab_sort_col
    variable _tab_sort_dir
    variable _col_order
    # Default-hidden on Component now that it absorbed the (removed) General
    # tab's extra columns - still toggleable via the header right-click menu,
    # just not cluttering the default view.
    variable _hidden_cols
    array set _hidden_cols {component {hm_comp_name comp_id prop_name prop_user_name}}
    # Per-tab column widths (dict of column key -> char width), set by
    # Autofit (single column or "Fit Columns") or manual drag-resize.
    # _rebuild_table_columns (runs on every tab switch) reads from here
    # first, falling back to the column definition's default width - so a
    # fitted/resized width survives switching tabs instead of resetting.
    variable _col_width
    array set _col_width {}
    variable _column_visible_var
    variable _header_btn_to_col
    variable _prop_view_btns
    variable _pbush_line_vars
}

# =============================================================================
# Schema
# =============================================================================

proc ::nc::ui_table::_tab_defs {} {
    return {
        {general "General"}
        {component "Component"}
        {properties "Property"}
        {materials "Material"}
        {library "Material Library"}
    }
}

# General is no longer a user-facing tab (Component absorbed its extra
# columns, toggleable via the header right-click menu) but is kept as an
# internal data mirror of Component - _sync_component_fields and the CSV
# round-trip still rely on it existing, so _tab_defs itself is untouched;
# only the tab BAR uses this filtered list.
proc ::nc::ui_table::_visible_tab_defs {} {
    set out {}
    foreach pair [_tab_defs] {
        if {[lindex $pair 0] eq "general"} continue
        lappend out $pair
    }
    return $out
}

proc ::nc::ui_table::_pbush_line_fields {line} {
    switch -- $line {
        K {return {K1 K2 K3 K4 K5 K6}}
        B {return {B1 B2 B3 B4 B5 B6}}
        GE {return {GE1 GE2 GE3 GE4 GE5 GE6}}
        M {return {M1 M2 M3 M4 M5 M6}}
    }
    return {}
}

proc ::nc::ui_table::_filter_display_cols {cols {tab ""}} {
    variable _show_images_col
    variable _show_notes_col
    variable _show_mat_params_col
    set out {}
    foreach col_def $cols {
        set key [lindex $col_def 0]
        if {!$_show_images_col && $key eq "image_path"} { continue }
        if {!$_show_notes_col && $key eq "note"} { continue }
        # The basic material params (E/G/NU/RHO/A/TREF) were added to the
        # Component tab's column list so a comp's material properties are
        # visible without switching to the Materials tab - gated behind
        # their own toggle since that's 6 extra columns nobody wants on by
        # default. Properties/Materials tabs already show these same keys
        # unconditionally (their own _export_all_possible_cols/_cols_for_tab
        # filtering doesn't route through this toggle), so only gate them
        # for general/component.
        if {!$_show_mat_params_col && $tab in {general component} \
                && $key in {E G NU RHO A TREF}} { continue }
        lappend out $col_def
    }
    return $out
}

proc ::nc::ui_table::_filter_hidden_cols {tab cols} {
    variable _hidden_cols
    if {![info exists _hidden_cols($tab)] || [llength $_hidden_cols($tab)] == 0} {
        return $cols
    }
    set out {}
    foreach col_def $cols {
        set key [lindex $col_def 0]
        if {[lsearch -exact $_hidden_cols($tab) $key] >= 0} { continue }
        lappend out $col_def
    }
    if {[llength $out] == 0 && [llength $cols] > 0} {
        lappend out [lindex $cols 0]
    }
    return $out
}

proc ::nc::ui_table::_apply_column_order {tab cols} {
    variable _col_order
    if {![info exists _col_order($tab)] || [llength $_col_order($tab)] == 0} {
        return $cols
    }
    array set by_key {}
    set available {}
    foreach col_def $cols {
        set key [lindex $col_def 0]
        set by_key($key) $col_def
        lappend available $key
    }
    set ordered {}
    foreach key $_col_order($tab) {
        if {[info exists by_key($key)]} {
            lappend ordered $by_key($key)
            unset by_key($key)
        }
    }
    foreach key $available {
        if {[info exists by_key($key)]} {
            lappend ordered $by_key($key)
        }
    }
    return $ordered
}

# The full, filter-independent set of columns a tab can ever have - the
# single source of truth shared by the on-screen table (_cols_for_tab, which
# slices it down by Property View/PBUSH-line/Show-Images/Show-Notes/hidden
# columns) and Export (_write_tab_csv), which must NOT be at the mercy of
# whatever on-screen filter happens to be active when Export is clicked.
proc ::nc::ui_table::_export_all_possible_cols {tab} {
    switch -- $tab {
        general {
            return {
                {image_path "Image" 10}
                {comp_type "COMP. Type" 12}
                {comp_user_name "COMP. Name" 18}
                {hm_comp_name "HM Comp. Name" 18}
                {comp_id "Comp ID" 8}
                {prop_name "Property Name" 16}
                {prop_user_name "Property Label" 16}
                {prop_id "Prop ID" 8}
                {prop_card "Prop Card" 10}
                {mat_user_name "MAT. Type" 16}
                {mat_id "MAT ID" 8}
                {note "Note" 24}
            }
        }
        component {
            return {
                {image_path "Image" 10}
                {comp_type "COMP. Type" 12}
                {comp_user_name "COMP. Name" 20}
                {hm_comp_name "HM Comp. Name" 18}
                {comp_id "Comp ID" 8}
                {prop_name "Property Name" 16}
                {prop_user_name "Property Label" 16}
                {prop_card "Prop Card" 10}
                {prop_id "Prop ID" 8}
                {mat_id "MAT ID" 8}
                {mat_user_name "MAT. Type" 18}
                {mat_label "MAT. Label" 18}
                {E "E" 12}
                {G "G" 12}
                {NU "NU" 8}
                {RHO "RHO" 12}
                {A "A" 8}
                {TREF "TREF" 8}
                {mass_total "Mass" 12}
                {note "Note" 26}
            }
        }
        properties {
            set cols {
                {prop_card "Prop Card" 10}
                {prop_id "Prop ID" 8}
                {mat_card "Mat Card" 10}
                {mat_id "Mat ID" 8}
                {T "T" 10}
                {NSM "NSM" 10}
                {Z1 "Z1" 10}
                {Z2 "Z2" 10}
                {E "E" 12}
                {G "G" 12}
                {NU "NU" 8}
                {RHO "RHO" 12}
                {A "A" 8}
                {TREF "TREF" 8}
                {ST "ST" 8}
                {SC "SC" 8}
                {SS "SS" 8}
            }
            foreach line {K B GE M} {
                foreach field [_pbush_line_fields $line] {
                    lappend cols [list $field $field 8]
                }
            }
            lappend cols {note "Note" 24}
            return $cols
        }
        materials {
            return {
                {mat_card "Mat Card" 10}
                {mat_id "Mat ID" 8}
                {mat_user_name "MAT. Type" 18}
                {mat_label "MAT. Label" 18}
                {mat_name "HM MAT. Name" 18}
                {E "E" 12}
                {G "G" 12}
                {NU "NU" 8}
                {RHO "RHO" 12}
                {A "A" 8}
                {TREF "TREF" 8}
                {GE "GE" 8}
                {ST "ST" 8}
                {SC "SC" 8}
                {SS "SS" 8}
                {note "Note" 24}
            }
        }
        library {
            variable _library_columns
            set cols {}
            foreach col $_library_columns { lappend cols [list $col $col 14] }
            return $cols
        }
    }
    return {}
}

proc ::nc::ui_table::_cols_for_tab {tab {include_hidden 0}} {
    variable _property_view
    variable _pbush_line_vars

    set cols [_export_all_possible_cols $tab]
    if {$tab eq "properties"} {
        set keep {prop_card prop_id mat_card mat_id note}
        if {$_property_view in {ALL PSHELL}} { lappend keep T NSM Z1 Z2 }
        if {$_property_view in {ALL PSOLID}} { lappend keep E G NU RHO A TREF ST SC SS }
        if {$_property_view in {ALL PBUSH}} {
            foreach line {K B GE M} {
                if {![info exists _pbush_line_vars($line)]} { set _pbush_line_vars($line) 1 }
                if {$_pbush_line_vars($line)} {
                    foreach field [_pbush_line_fields $line] { lappend keep $field }
                }
            }
        }
        set filtered {}
        foreach col_def $cols {
            if {[lindex $col_def 0] in $keep} { lappend filtered $col_def }
        }
        set cols $filtered
    } elseif {$tab ni {general component materials library}} {
        return {}
    }
    set cols [_filter_display_cols $cols $tab]
    if {!$include_hidden} {
        set cols [_filter_hidden_cols $tab $cols]
    }
    set cols [_apply_column_order $tab $cols]
    # Row number is always first, on every tab - not user-hideable/orderable,
    # not part of _export_all_possible_cols so it never shows up in CSV/XLSX
    # export or Export Settings (purely a display convenience).
    return [linsert $cols 0 {_rownum "#" 4}]
}

proc ::nc::ui_table::_ncols_for_tab {tab} { return [llength [_cols_for_tab $tab]] }
proc ::nc::ui_table::_cols {} { variable _tab ; return [_cols_for_tab $_tab] }
proc ::nc::ui_table::_ncols {} { variable _tab ; return [_ncols_for_tab $_tab] }

proc ::nc::ui_table::_editable_fields {tab} {
    switch -- $tab {
        general {return {comp_user_name comp_type prop_user_name mat_user_name note}}
        component {return {comp_user_name comp_type prop_user_name mat_user_name note}}
        properties {return {prop_card prop_id mat_id T NSM Z1 Z2 E G NU RHO A TREF ST SC SS K1 K2 K3 K4 K5 K6 B1 B2 B3 B4 B5 B6 GE1 GE2 GE3 GE4 GE5 GE6 M1 M2 M3 M4 M5 M6 note}}
        materials {return {mat_card mat_id mat_user_name mat_label E G NU RHO A TREF GE ST SC SS note}}
        library {
            # Every column is user-editable - the schema itself is whatever
            # the imported/pasted CSV said, there's no fixed field list.
            variable _library_columns
            return $_library_columns
        }
    }
    return {}
}

# Subset of _editable_fields that is PURE user annotation - data with no
# connection to a Reload/scan from the CAE tool at all (labels, notes, group
# codes the user assigns). Used ONLY for the header green/grey cue.
# Properties/Materials editable fields are mostly real Nastran card values
# (E, RHO, mat_card, prop_id...) that Reload populates from the model - those
# stay grey even though the cell is stageable-editable for a future Apply, so
# the color answers "did this come from Reload?", not "can I click into it?".
proc ::nc::ui_table::_user_annotation_fields {tab} {
    switch -- $tab {
        general -
        component {return {comp_user_name comp_type prop_user_name mat_user_name note}}
        properties {return {note}}
        materials {return {mat_user_name mat_label note}}
        library {
            # External reference data pasted/imported by the user - none of
            # it ever comes from a the CAE tool reload.
            variable _library_columns
            return $_library_columns
        }
    }
    return {}
}

proc ::nc::ui_table::_prop_card_for_row {row} {
    return [string toupper [_dict_get $row prop_card [_dict_get $row card]]]
}

proc ::nc::ui_table::_prop_material_fields {} {
    return {mat_card mat_id E G NU RHO A TREF GE ST SC SS}
}

proc ::nc::ui_table::_prop_shell_fields {} {
    return {T NSM Z1 Z2}
}

proc ::nc::ui_table::_prop_pbush_fields {} {
    return {K1 K2 K3 K4 K5 K6 B1 B2 B3 B4 B5 B6 GE1 GE2 GE3 GE4 GE5 GE6 M1 M2 M3 M4 M5 M6}
}

proc ::nc::ui_table::_property_field_applicable {row key} {
    set card [_prop_card_for_row $row]
    if {$key in {prop_card prop_id note}} { return 1 }
    switch -- $card {
        PSHELL {
            return [expr {$key in [_prop_shell_fields] || $key in [_prop_material_fields]}]
        }
        PSOLID {
            return [expr {$key in [_prop_material_fields]}]
        }
        PBUSH {
            return [expr {$key in [_prop_pbush_fields]}]
        }
    }
    return 1
}

proc ::nc::ui_table::_col_index {tab key} {
    set i 0
    foreach col_def [_cols_for_tab $tab] {
        if {[lindex $col_def 0] eq $key} { return $i }
        incr i
    }
    return -1
}

proc ::nc::ui_table::_row_key_for_tab {tab row} {
    switch -- $tab {
        materials {return [_dict_get $row mat_id]}
        properties {return [_dict_get $row prop_id]}
        library {return [_dict_get $row _libidx]}
        default {return [_dict_get $row comp_id]}
    }
}

proc ::nc::ui_table::_tab_key_name {tab} {
    switch -- $tab {
        materials { return mat_id }
        properties { return prop_id }
        default { return comp_id }
    }
}

# Label field to match worklist text entries against, per tab - "" when a
# tab has no user-facing label of its own (Property rows are identified by
# ID/card only, not a separate label field).
proc ::nc::ui_table::_worklist_label_key {tab} {
    switch -- $tab {
        materials { return mat_user_name }
        properties { return "" }
        default { return comp_user_name }
    }
}

# Every column the Worklist dialog can filter/match on for a tab, excluding
# the Image column (thumbnails have no text to type/paste against).
proc ::nc::ui_table::_worklist_columns_for_tab {tab} {
    set out {}
    foreach col_def [_cols_for_tab $tab 1] {
        if {[lindex $col_def 0] eq "image_path"} { continue }
        lappend out $col_def
    }
    return $out
}

proc ::nc::ui_table::_duplicate_row_key_warnings {tab rows} {
    set key [_tab_key_name $tab]
    set seen [dict create]
    set warnings {}
    set row_index 1
    foreach row $rows {
        set value [string trim [_dict_get $row $key]]
        if {$value ne ""} {
            if {[dict exists $seen $value]} {
                lappend warnings "[_tab_label $tab] row $row_index: duplicate $key '$value' also appears at row [dict get $seen $value]"
            } else {
                dict set seen $value $row_index
            }
        }
        incr row_index
    }
    return $warnings
}

proc ::nc::ui_table::_component_prop_usage_counts {} {
    variable _tab_rows
    set counts [dict create]
    if {![info exists _tab_rows(component)]} { return $counts }
    foreach row $_tab_rows(component) {
        set prop_id [string trim [_dict_get $row hm_prop_id [_dict_get $row prop_id]]]
        if {$prop_id eq "" || ![string is integer -strict $prop_id] || $prop_id <= 0} { continue }
        dict incr counts $prop_id
    }
    return $counts
}

proc ::nc::ui_table::_component_prop_usage_count {row} {
    set prop_id [string trim [_dict_get $row hm_prop_id [_dict_get $row prop_id]]]
    if {$prop_id eq ""} { return 0 }
    set counts [_component_prop_usage_counts]
    if {[dict exists $counts $prop_id]} { return [dict get $counts $prop_id] }
    return 0
}

# =============================================================================
# Public API
# =============================================================================

proc ::nc::ui_table::open {model_path rows_by_tab} {
    variable _win
    variable _session_lbl
    variable _session_path
    variable _known_comp_ids_seeded
    variable _known_comp_ids_baseline
    variable _recent_new_comp_ids

    set title "Nastran Control - [file tail $model_path]"
    if {$_win eq "" || ![winfo exists $_win]} {
        _build_window $title
    } else {
        catch {wm title $_win $title}
    }
    catch {set _session_path [::nc::session::dir]}
    _store_rows $rows_by_tab
    _load_library_snapshot $_session_path
    _refresh_material_options
    _rebuild_table_columns
    _populate_current
    _update_tab_buttons
    _update_toolbar_for_tab
    _set_session_dirty 0
    # Seed the "recent new components" baseline on the very first load (no
    # scan has happened yet in this run) so nothing is flagged "new" just
    # because a session was opened - only components appearing after a
    # Reload compared to what was already here count as recent.
    set _known_comp_ids_baseline [lsort -unique -integer [get_component_ids]]
    set _known_comp_ids_seeded 1
    set _recent_new_comp_ids {}
    catch {wm deiconify $_win}
    catch {raise $_win}
    # `raise` alone changes z-order but doesn't give the window input focus
    # - on Windows, a raised-but-unfocused window can get silently pushed
    # back behind whatever still holds focus (HM's own window) almost
    # immediately, looking like the tool "opens then hides itself" even
    # though nothing else touched it. `_restore_table_window` elsewhere in
    # this file already does deiconify+raise+focus together; this is the
    # same fix applied to the initial-launch path, which was missing the
    # focus call.
    catch {focus $_win}
    variable _always_on_top_strict
    catch {wm attributes $_win -topmost [expr {$_always_on_top_strict ? 1 : 0}]}
    # One-shot "win the race" pulse: something (Windows/HM, cause not fully
    # root-caused) tries to minimize this window shortly after it opens -
    # confirmed by the user that an earlier version which forcibly kept
    # -topmost raised on a recurring poll happened to prevent this (before
    # that poll itself was reverted for a separate, unrelated bug - it
    # broke the tool's own menus by re-issuing wm attributes every 500ms).
    # A single one-time forced raise here (not a repeating poll, so it
    # can't interfere with menus) should win that same race without
    # bringing back the poll's side effects.
    after 250 [list ::nc::ui_table::_settle_topmost_after_launch]
}

proc ::nc::ui_table::_settle_topmost_after_launch {} {
    variable _win
    variable _always_on_top_strict
    if {$_win eq "" || ![winfo exists $_win]} { return }
    catch {wm deiconify $_win}
    catch {raise $_win}
    catch {focus $_win}
    catch {wm attributes $_win -topmost 1}
    if {!$_always_on_top_strict} {
        after 400 [list ::nc::ui_table::_relax_topmost_after_launch]
    }
}

proc ::nc::ui_table::_relax_topmost_after_launch {} {
    variable _win
    variable _always_on_top_strict
    if {$_win eq "" || ![winfo exists $_win]} { return }
    if {$_always_on_top_strict} { return }
    catch {wm attributes $_win -topmost 0}
}

# Native Win32 file dialogs (tk_getSaveFile/tk_getOpenFile/
# tk_chooseDirectory) can leave the owning toplevel minimized/behind once
# closed (Cancel or Open/Save) instead of returning focus to it - a
# well-known Tk-on-Windows quirk, and the likely same root cause as the
# session-open minimize this tool had (both are "a native
# modal/dialog closes, the owner doesn't reliably regain focus" in this
# embedded environment). Call this right after any such dialog call
# returns to recover, reusing the same one-shot pulse (not a recurring
# poll, so it can't reproduce the menu-closing regression from before).
proc ::nc::ui_table::_recover_focus_after_native_dialog {} {
    _settle_topmost_after_launch
}

proc ::nc::ui_table::populate_all {rows_by_tab} {
    variable _known_comp_ids_seeded
    variable _known_comp_ids_baseline
    variable _recent_new_comp_ids
    # _known_comp_ids_seeded is 0 only on the very first populate_all call
    # (launch) - every later call is a Reload/Rescan, where we don't want
    # to re-fit and blow away any width the user set manually since then.
    set is_first_populate [expr {!$_known_comp_ids_seeded}]
    _store_rows $rows_by_tab
    if {$is_first_populate} { _autofit_all_tabs_once }
    _refresh_material_options
    _rebuild_table_columns
    _populate_current
    _update_tab_buttons
    _update_toolbar_for_tab
    _set_session_dirty 0
    set current_ids [get_component_ids]
    if {!$_known_comp_ids_seeded} {
        set _known_comp_ids_baseline $current_ids
        set _known_comp_ids_seeded 1
        set _recent_new_comp_ids {}
    } else {
        array set baseline_seen {}
        foreach cid $_known_comp_ids_baseline { set baseline_seen($cid) 1 }
        set new_ids {}
        foreach cid $current_ids {
            if {![info exists baseline_seen($cid)]} { lappend new_ids $cid }
        }
        set _recent_new_comp_ids $new_ids
        set _known_comp_ids_baseline $current_ids
        if {[llength $new_ids] > 0} {
            _set_status "Reload found [llength $new_ids] new component(s). Selection > Recent New Components to pick them quickly." ok
        }
    }
}

proc ::nc::ui_table::populate {rows} {
    populate_all [dict create general $rows component $rows properties {} materials {}]
}

proc ::nc::ui_table::set_mat_rows {mat_rows} {
    variable _mat_rows
    set _mat_rows $mat_rows
    _refresh_material_options
}

proc ::nc::ui_table::get_component_ids {} {
    variable _tab_rows
    set ids {}
    if {![info exists _tab_rows(component)]} { return $ids }
    array set seen {}
    foreach row $_tab_rows(component) {
        set cid [_dict_get $row comp_id]
        if {$cid ne "" && ![info exists seen($cid)]} {
            set seen($cid) 1
            lappend ids $cid
        }
    }
    return $ids
}

proc ::nc::ui_table::set_component_mass_values {mass_by_comp} {
    variable _tab_rows
    variable _tab
    foreach tab {general component} {
        if {![info exists _tab_rows($tab)]} continue
        set out {}
        foreach row $_tab_rows($tab) {
            set cid [_dict_get $row comp_id]
            if {$cid ne "" && [dict exists $mass_by_comp $cid]} {
                set value [dict get $mass_by_comp $cid]
                dict set row mass_total_raw $value
                dict set row mass_total $value
            }
            lappend out $row
        }
        set _tab_rows($tab) $out
    }
    if {[dict size $mass_by_comp] > 0} { _set_session_dirty 1 }
    if {$_tab in {general component}} { _populate_current }
}

proc ::nc::ui_table::_preload_thumbnails {paths {px ""}} {
    variable _image_thumb_px
    if {$px eq ""} { set px $_image_thumb_px }
    set jobs {}
    foreach path $paths {
        if {$path eq "" || ![file exists $path]} { continue }
        lappend jobs [list $path $px $px]
    }
    if {[llength $jobs] == 0} { return }
    catch {_ensure_pillow_thumbnails_batch $jobs}
}

proc ::nc::ui_table::set_component_image_paths {image_by_comp} {
    variable _tab_rows
    variable _tab
    _preload_thumbnails [dict values $image_by_comp]
    set changed 0
    foreach tab {general component} {
        if {![info exists _tab_rows($tab)]} continue
        set out {}
        foreach row $_tab_rows($tab) {
            set cid [_dict_get $row comp_id]
            if {$cid ne "" && [dict exists $image_by_comp $cid]} {
                dict set row image_path [dict get $image_by_comp $cid]
                set row [_mark_dirty $row image_path]
                incr changed
            }
            lappend out $row
        }
        set _tab_rows($tab) $out
    }
    if {$changed > 0} { _set_session_dirty 1 }
    if {$_tab in {general component}} { _populate_current }
    return $changed
}

proc ::nc::ui_table::set_status {msg status} {
    _set_status $msg $status
}

proc ::nc::ui_table::get_selected_rows {} {
    variable _tbl
    variable _rows
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return {} }

    set sel_rows {}
    catch {
        foreach cell [$_tbl curselection] {
            set r [lindex [split $cell ,] 0]
            if {[string is integer -strict $r] && $r >= 1} { lappend sel_rows $r }
        }
    }
    set out {}
    foreach r [lsort -unique -integer $sel_rows] {
        set idx [expr {$r - 1}]
        if {$idx >= 0 && $idx < [llength $_rows]} { lappend out [lindex $_rows $idx] }
    }
    return $out
}

proc ::nc::ui_table::log {message} {
    ::nc::mutations::log_add $message
}

# =============================================================================
# Data helpers
# =============================================================================

proc ::nc::ui_table::_dict_get {row key {default ""}} {
    if {[dict exists $row $key]} { return [dict get $row $key] }
    return $default
}

proc ::nc::ui_table::_normalize_component_row {row} {
    variable _tab_rows
    set comp_name [_dict_get $row comp_name]
    if {![dict exists $row hm_comp_name]} { dict set row hm_comp_name $comp_name }
    if {![dict exists $row hm_prop_id]} { dict set row hm_prop_id [_dict_get $row prop_id] }
    if {![dict exists $row hm_mat_id]} { dict set row hm_mat_id [_dict_get $row mat_id] }
    if {![dict exists $row hm_material_label]} { dict set row hm_material_label [_dict_get $row material_label [_dict_get $row mat_name]] }
    # COMP. Name/MAT. Type are user-facing and must NOT default to the HM
    # name (hm_comp_name/comp_name/mat_name) - only carry forward an
    # existing label/material_label value (legacy rows that only ever had
    # that column), never fall back to the raw HM-scanned name.
    dict set row comp_user_name [_dict_get $row comp_user_name [_dict_get $row label]]
    dict set row prop_user_name [_dict_get $row prop_user_name [_dict_get $row prop_name]]
    dict set row mat_user_name [_dict_get $row mat_user_name [_dict_get $row material_label]]
    if {![dict exists $row comp_type]} { dict set row comp_type "" }
    if {![dict exists $row mat_label]} { dict set row mat_label "" }
    # mat_label only exists natively on Materials-tab rows (scan.tcl never
    # populates it on component/general rows). Resolve it by mat_id from
    # the Materials tab at normalize time so the Component tab's MAT.
    # Label column (added for the "show material info in Component" ask)
    # stays correct even if it changes on the Materials tab later - a
    # fresh lookup here, not a cached copy that could go stale.
    set comp_mat_id [_dict_get $row mat_id]
    if {[_dict_get $row mat_label] eq "" && $comp_mat_id ne "" && [info exists _tab_rows(materials)]} {
        foreach mrow $_tab_rows(materials) {
            if {[_dict_get $mrow mat_id] eq $comp_mat_id} {
                set found_label [_dict_get $mrow mat_label]
                if {$found_label ne ""} { dict set row mat_label $found_label }
                break
            }
        }
    }
    dict set row image_path [_dict_get $row image_path ""]
    dict set row note [_dict_get $row note ""]
    set mass_raw [_dict_get $row mass_total_raw]
    set mass_display [_dict_get $row mass_total]
    if {$mass_raw eq "" && $mass_display ne ""} { set mass_raw $mass_display }
    if {$mass_display eq "" && $mass_raw ne ""} { set mass_display $mass_raw }
    dict set row mass_total_raw $mass_raw
    dict set row mass_total $mass_display
    return $row
}

proc ::nc::ui_table::_store_rows {rows_by_tab} {
    variable _tab_rows
    foreach pair [_tab_defs] {
        set tab [lindex $pair 0]
        set rows {}
        if {[dict exists $rows_by_tab $tab]} {
            set rows [dict get $rows_by_tab $tab]
        } elseif {[info exists _tab_rows($tab)]} {
            set rows $_tab_rows($tab)
        }
        set out {}
        foreach row $rows {
            if {$tab in {general component}} { set row [_normalize_component_row $row] }
            if {![dict exists $row _dirty_fields]} { dict set row _dirty_fields {} }
            lappend out $row
        }
        set _tab_rows($tab) $out
    }
    _sync_image_paths_between_component_tabs
}

proc ::nc::ui_table::_sync_image_paths_between_component_tabs {} {
    variable _tab_rows
    if {![info exists _tab_rows(general)] || ![info exists _tab_rows(component)]} { return }
    set by_comp [dict create]
    foreach tab {general component} {
        foreach row $_tab_rows($tab) {
            set cid [_dict_get $row comp_id]
            set path [_dict_get $row image_path]
            if {$cid ne "" && $path ne ""} { dict set by_comp $cid $path }
        }
    }
    if {[dict size $by_comp] == 0} { return }
    foreach tab {general component} {
        set out {}
        foreach row $_tab_rows($tab) {
            set cid [_dict_get $row comp_id]
            if {$cid ne "" && [_dict_get $row image_path] eq "" && [dict exists $by_comp $cid]} {
                dict set row image_path [dict get $by_comp $cid]
            }
            lappend out $row
        }
        set _tab_rows($tab) $out
    }
}

proc ::nc::ui_table::_refresh_material_options {} {
    variable _mat_rows
    variable _tab_rows
    variable _mat_cb

    set labels {}
    if {[info exists _tab_rows(materials)]} {
        foreach r $_tab_rows(materials) {
            set label [_dict_get $r mat_user_name [_dict_get $r mat_name]]
            if {$label ne "" && [lsearch -exact $labels $label] < 0} { lappend labels $label }
        }
    }
    foreach r $_mat_rows {
        set label [_dict_get $r label]
        if {$label ne "" && [lsearch -exact $labels $label] < 0} { lappend labels $label }
    }
    if {$_mat_cb ne "" && [winfo exists $_mat_cb]} {
        catch {$_mat_cb configure -values $labels}
    }
}

proc ::nc::ui_table::_material_id_for_label {label} {
    variable _last_mat_ambiguous_msg
    set _last_mat_ambiguous_msg ""
    set ids [_material_ids_for_label $label]
    if {[llength $ids] == 0} { return "" }
    if {[llength $ids] > 1} {
        # Silently returning "" here (old behavior) left the mat_id
        # assignment skipped entirely - the cell would show the typed
        # label but the row stayed linked to whatever material it had
        # before (or none), with no indication anything was wrong. Easy
        # to hit via "Duplicate" on the Materials tab, which keeps the
        # same mat_user_name. Picking the first match keeps the row
        # linked to *a* real material instead of silently orphaning it,
        # and the warning tells the user to fix the duplicate name.
        set _last_mat_ambiguous_msg "Multiple materials named '$label' (mat_id [join $ids {, }]) - using mat_id [lindex $ids 0]. Pick from the ID | Type | Label list to avoid ambiguity."
        _set_status $_last_mat_ambiguous_msg warn
    }
    return [lindex $ids 0]
}

# "ID | Type | Label" display string for one Materials-tab row - shown in
# the Component/General "MAT. Type" dropdown/palette so assigning a material
# is unambiguous even when several materials intentionally share the same
# Type and/or Label (e.g. several batches of the same steel grade). Picking
# one resolves straight to that exact mat_id - no guessing needed.
proc ::nc::ui_table::_material_display_for_row {row} {
    set mid [_dict_get $row mat_id]
    set typ [_dict_get $row mat_user_name]
    set lbl [_dict_get $row mat_label]
    return "$mid | $typ | $lbl"
}

# Reverse of _material_display_for_row: pulls the mat_id back out of the
# leading "ID | ..." token and looks up that exact Materials-tab row. Returns
# "" if value isn't in that format (e.g. free-typed/pasted plain Type text).
proc ::nc::ui_table::_material_row_for_display {value} {
    set bar [string first "|" $value]
    if {$bar < 0} { return "" }
    set mid [string trim [string range $value 0 [expr {$bar - 1}]]]
    if {$mid eq "" || ![string is integer -strict $mid]} { return "" }
    return [_material_row_by_id $mid]
}

# Resolves whatever the user typed/picked in a Component/General "MAT. Type"
# cell to one specific Materials-tab row. Prefers the unambiguous
# "ID | Type | Label" form; falls back to matching by plain Type text (legacy typed
# input, pasted CSV values) which can still be ambiguous - same
# first-match-and-warn behavior as before for that fallback only.
proc ::nc::ui_table::_resolve_material_row_for_value {value} {
    variable _last_mat_ambiguous_msg
    set _last_mat_ambiguous_msg ""
    if {$value eq ""} { return "" }
    set row [_material_row_for_display $value]
    if {$row ne ""} { return $row }
    set mid [_material_id_for_label $value]
    if {$mid eq ""} { return "" }
    return [_material_row_by_id $mid]
}

proc ::nc::ui_table::_material_ids_for_label {label} {
    variable _mat_rows
    variable _tab_rows
    set ids {}
    if {[info exists _tab_rows(materials)]} {
        foreach r $_tab_rows(materials) {
            if {[_dict_get $r mat_user_name [_dict_get $r mat_name]] eq $label} {
                set id [_dict_get $r mat_id]
                if {$id ne "" && [lsearch -exact $ids $id] < 0} { lappend ids $id }
            }
        }
    }
    if {[llength $ids] > 0} { return $ids }
    foreach r $_mat_rows {
        if {[_dict_get $r label] eq $label} {
            set id [_dict_get $r mat_id]
            if {$id ne "" && [lsearch -exact $ids $id] < 0} { lappend ids $id }
        }
    }
    return $ids
}

proc ::nc::ui_table::_unique_nonempty {values} {
    set out {}
    array set seen {}
    foreach v $values {
        set v [string trim $v]
        if {$v ne "" && ![info exists seen($v)]} {
            set seen($v) 1
            lappend out $v
        }
    }
    return $out
}

proc ::nc::ui_table::_dropdown_values_for_key {key current} {
    variable _tab_rows
    variable _mat_rows
    variable _rows
    variable _label_bank
    set values {}
    if {[info exists _label_bank($key)]} {
        foreach v $_label_bank($key) { lappend values $v }
    }
    switch -- $key {
        comp_user_name {
            # Only the comp_user_name field itself (no fallback to
            # label/comp_name) - plus the pasted _label_bank above. A row
            # with no comp_user_name set contributes nothing here, so it
            # never shows up as a stale/duplicate suggestion.
            foreach tab {component general} {
                if {![info exists _tab_rows($tab)]} continue
                foreach row $_tab_rows($tab) {
                    set v [_dict_get $row comp_user_name]
                    if {$v ne ""} { lappend values $v }
                }
            }
        }
        mat_user_name {
            variable _tab
            # On Component/General, show "ID | Type | Label" so assigning a
            # material always resolves to one exact mat_id even when several
            # materials intentionally share the same Type/Label (e.g. several
            # batches of the same steel grade). On the Materials tab itself
            # this field IS the material's own Type - show plain Type text
            # (as before), never the ID-prefixed form, so editing it can
            # never be mistaken for re-linking the row to a different mat_id.
            if {[info exists _tab_rows(materials)]} {
                foreach row $_tab_rows(materials) {
                    if {$_tab in {general component}} {
                        set v [_material_display_for_row $row]
                    } else {
                        set v [_dict_get $row mat_user_name]
                    }
                    if {$v ne ""} { lappend values $v }
                }
            }
        }
        comp_type {
            foreach tab {component general} {
                if {![info exists _tab_rows($tab)]} continue
                foreach row $_tab_rows($tab) {
                    set v [_dict_get $row comp_type]
                    if {$v ne ""} { lappend values $v }
                }
            }
        }
        mat_label {
            if {[info exists _tab_rows(materials)]} {
                foreach row $_tab_rows(materials) {
                    set v [_dict_get $row mat_label]
                    if {$v ne ""} { lappend values $v }
                }
            }
        }
    }
    set values [_unique_nonempty $values]
    if {$current ne "" && [lsearch -exact $values $current] < 0} {
        set values [linsert $values 0 $current]
    }
    return $values
}

proc ::nc::ui_table::_label_key_label {key} {
    switch -- $key {
        comp_user_name { return "COMP. Name" }
        mat_user_name { return "MAT. Type" }
        comp_type { return "COMP. Type" }
        mat_label { return "MAT. Label" }
    }
    return $key
}

proc ::nc::ui_table::_label_allowed_key_for_tab {{preferred ""}} {
    variable _tab
    if {$preferred in {comp_user_name prop_user_name mat_user_name comp_type mat_label}} { return $preferred }
    switch -- $_tab {
        general - component { return comp_user_name }
        materials { return mat_user_name }
    }
    return ""
}

proc ::nc::ui_table::_selected_display_indices {} {
    variable _tbl
    variable _rows
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return {} }
    set sel_rows {}
    catch {
        foreach cell [$_tbl curselection] {
            set r [lindex [split $cell ,] 0]
            if {[string is integer -strict $r] && $r >= 1} { lappend sel_rows $r }
        }
    }
    set sel_rows [lsort -unique -integer $sel_rows]
    set out {}
    foreach r $sel_rows {
        if {$r >= 1 && $r <= [llength $_rows]} { lappend out $r }
    }
    return $out
}

proc ::nc::ui_table::_active_display_row_for_key {key} {
    variable _tbl
    variable _rows
    variable _tab
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return 1 }
    set active ""
    catch {set active [$_tbl index active]}
    if {$active ne ""} {
        lassign [split $active ,] r c
        if {[string is integer -strict $r] && $r >= 1 && $r <= [llength $_rows]} {
            return $r
        }
    }
    set selected [_selected_display_indices]
    if {[llength $selected] > 0} { return [lindex $selected 0] }
    return 1
}

proc ::nc::ui_table::_set_active_cell_for_key {r key} {
    variable _tbl
    variable _tab
    set c [_col_index $_tab $key]
    if {$_tbl ne "" && [winfo exists $_tbl] && $c >= 0} {
        catch {$_tbl activate $r,$c}
        catch {$_tbl selection clear all}
        catch {$_tbl selection set $r,$c $r,$c}
        catch {$_tbl see $r,$c}
    }
}

proc ::nc::ui_table::_stage_display_row_value {r key value} {
    variable _rows
    variable _tab
    if {![string is integer -strict $r] || $r < 1 || $r > [llength $_rows]} { return 0 }
    if {$key ni [_editable_fields $_tab]} { return 0 }
    set row [lindex $_rows [expr {$r - 1}]]
    set row_key [_row_key_for_tab $_tab $row]
    set row [_set_row_value $_tab $row $key $value]
    if {$_tab in {general component}} {
        _sync_component_fields [_dict_get $row comp_id] $row
    } else {
        _replace_row $_tab $row_key $row
    }
    return 1
}

proc ::nc::ui_table::_row_pending_fields {row} {
    return [_dict_get $row _pending_fields {}]
}

proc ::nc::ui_table::_row_has_pending {row} {
    return [expr {[llength [_row_pending_fields $row]] > 0}]
}

proc ::nc::ui_table::_clear_pending_row {row} {
    if {[dict exists $row _pending_fields]} { dict unset row _pending_fields }
    if {[dict exists $row _pending_values]} { dict unset row _pending_values }
    return $row
}

proc ::nc::ui_table::_set_pending_row_value {row key value} {
    variable _tab
    set pending [_row_pending_fields $row]
    if {[lsearch -exact $pending $key] < 0} { lappend pending $key }
    dict set row _pending_fields $pending
    if {$key eq "mat_user_name" && $_tab ne "materials"} {
        # Same rule as _set_row_value: only assign/resolve a material (and
        # pull mat_id + its other fields along) on general/component rows.
        # On the materials tab itself this is the row's OWN Type text being
        # renamed - never touch its mat_id. Never stage the raw "ID | ..."
        # token itself as mat_user_name - only a resolved material's fields,
        # so a stale/unresolvable reference can't leave literal junk pending.
        set mrow [_resolve_material_row_for_value $value]
        if {$mrow ne ""} {
            dict set row _pending_values mat_id [_dict_get $mrow mat_id]
            dict set row _pending_values mat_user_name [_dict_get $mrow mat_user_name]
            dict set row _pending_values material_label [_dict_get $mrow mat_user_name]
            foreach k {mat_label mat_name mat_card E G NU RHO A TREF} {
                if {[dict exists $mrow $k]} { dict set row _pending_values $k [dict get $mrow $k] }
            }
            foreach k {mat_id mat_user_name mat_label mat_name mat_card E G NU RHO A TREF} {
                if {[lsearch -exact $pending $k] < 0} { lappend pending $k }
            }
            dict set row _pending_fields $pending
        } elseif {[regexp {^\s*[0-9]+\s*\|} $value]} {
            variable _last_mat_ambiguous_msg
            set _last_mat_ambiguous_msg "Could not find a material for '$value' - it may have been removed or renamed. Row's material left unchanged."
            _set_status $_last_mat_ambiguous_msg warn
        } else {
            dict set row _pending_values mat_user_name $value
            dict set row _pending_values material_label $value
        }
        return $row
    }
    dict set row _pending_values $key $value
    switch -- $key {
        comp_user_name {
            dict set row _pending_values label $value
        }
    }
    return $row
}

proc ::nc::ui_table::_pending_display_row_value {r key value} {
    variable _rows
    variable _tab
    if {![string is integer -strict $r] || $r < 1 || $r > [llength $_rows]} { return 0 }
    if {$key ni [_editable_fields $_tab]} { return 0 }
    set row [lindex $_rows [expr {$r - 1}]]
    set row_key [_row_key_for_tab $_tab $row]
    set row [_set_pending_row_value $row $key $value]
    if {$_tab in {general component}} {
        _sync_component_fields [_dict_get $row comp_id] $row
    } else {
        _replace_row $_tab $row_key $row
    }
    return 1
}

proc ::nc::ui_table::_label_values_filtered {} {
    variable _label_target_key
    variable _label_filter
    set values [_dropdown_values_for_key $_label_target_key ""]
    set needle [string tolower [string trim $_label_filter]]
    if {$needle eq ""} { return $values }
    # A purely numeric search also matches by the list's 1-based display
    # number (the "N. label" prefix shown in the palette), not just text
    # inside the label - so typing "12" jumps straight to entry #12.
    set is_numeric [string is digit -strict $needle]
    set out {}
    set idx 0
    foreach v $values {
        incr idx
        if {[string first $needle [string tolower $v]] >= 0} {
            lappend out $v
        } elseif {$is_numeric && [string first $needle $idx] == 0} {
            lappend out $v
        }
    }
    return $out
}

proc ::nc::ui_table::_selected_label_value {} {
    variable _label_list
    variable _label_display_map
    if {$_label_list eq "" || ![winfo exists $_label_list]} { return "" }
    set sel [$_label_list curselection]
    if {[llength $sel] == 0} { return "" }
    set idx [lindex $sel 0]
    if {$idx >= 0 && $idx < [llength $_label_display_map]} {
        return [lindex $_label_display_map $idx]
    }
    return [$_label_list get $idx]
}

# Maps each currently-used label value (for the given palette key) to the
# list of owning IDs (comp_id for comp_user_name, mat_id for mat_user_name),
# so the palette can flag entries that would collide if re-applied elsewhere.
proc ::nc::ui_table::_label_owner_map {key} {
    variable _tab_rows
    set map [dict create]
    switch -- $key {
        comp_user_name {
            foreach tab {component general} {
                if {![info exists _tab_rows($tab)]} continue
                foreach row $_tab_rows($tab) {
                    set v [_dict_get $row comp_user_name]
                    set owner [_dict_get $row comp_id]
                    if {$v eq "" || $owner eq ""} continue
                    set lst {}
                    if {[dict exists $map $v]} { set lst [dict get $map $v] }
                    if {[lsearch -exact $lst $owner] < 0} { lappend lst $owner }
                    dict set map $v $lst
                }
            }
        }
        mat_user_name {
            if {[info exists _tab_rows(materials)]} {
                foreach row $_tab_rows(materials) {
                    set v [_dict_get $row mat_user_name]
                    set owner [_dict_get $row mat_id]
                    if {$v eq "" || $owner eq ""} continue
                    set lst {}
                    if {[dict exists $map $v]} { set lst [dict get $map $v] }
                    if {[lsearch -exact $lst $owner] < 0} { lappend lst $owner }
                    dict set map $v $lst
                }
            }
        }
    }
    return $map
}

proc ::nc::ui_table::_label_set_status {msg {status ok}} {
    variable _label_status
    set fg "#555555"
    switch -- $status {
        ok { set fg "#2f6f3e" }
        warn { set fg "#8a5a00" }
        error { set fg "#9b1c1c" }
    }
    if {$_label_status ne "" && [winfo exists $_label_status]} {
        catch {$_label_status configure -text $msg -foreground $fg}
    }
}

proc ::nc::ui_table::_label_refresh_list {} {
    variable _label_list
    variable _label_target_key
    variable _label_display_map
    variable _label_disabled_map
    variable _rows
    if {$_label_list eq "" || ![winfo exists $_label_list]} { return }

    # Preserve the current selection (by value) across a live refresh instead
    # of always jumping back to index 0 - refresh now runs continuously as
    # the table changes, not just on explicit palette actions.
    set keep_value ""
    catch {set keep_value [_selected_label_value]}

    $_label_list delete 0 end
    set _label_display_map {}
    set _label_disabled_map {}

    # One-name-per-owner is only enforced for Component Label; a Material
    # Label/Type is allowed to be reused across many materials, so it's
    # never greyed out as "already used" here.
    set owners [dict create]
    if {$_label_target_key eq "comp_user_name"} {
        set owners [_label_owner_map $_label_target_key]
    }
    set self_owner ""
    set r [_active_display_row_for_key $_label_target_key]
    if {[string is integer -strict $r] && $r >= 1 && $r <= [llength $_rows]} {
        set active_row [lindex $_rows [expr {$r - 1}]]
        switch -- $_label_target_key {
            comp_user_name { set self_owner [_dict_get $active_row comp_id] }
            mat_user_name  { set self_owner [_dict_get $active_row mat_id] }
        }
    }

    set values [_label_values_filtered]
    set num_width [string length [llength $values]]
    if {$num_width < 1} { set num_width 1 }

    set idx 0
    set restore_idx -1
    foreach v $values {
        lappend _label_display_map $v
        set num [format "%${num_width}d" [expr {$idx + 1}]]
        set text "$num. $v"
        set disabled 0
        if {[dict exists $owners $v]} {
            set ids [dict get $owners $v]
            if {$self_owner ne ""} {
                set ids [lsearch -all -inline -not -exact $ids $self_owner]
            }
            if {[llength $ids] > 0} { set disabled 1 }
        }
        lappend _label_disabled_map $disabled
        $_label_list insert end $text
        if {$disabled} {
            $_label_list itemconfigure $idx -foreground "#b5b5b5"
        }
        if {$v eq $keep_value} { set restore_idx $idx }
        incr idx
    }

    if {[$_label_list size] > 0} {
        set sel_idx [expr {$restore_idx >= 0 ? $restore_idx : 0}]
        $_label_list selection set $sel_idx
        $_label_list activate $sel_idx
    }
    _label_set_status "Showing [$_label_list size] label(s)." ok
}

# True when the palette's currently-selected label is already assigned to a
# different row (and thus greyed out / not assignable) - callers must refuse
# to apply it to avoid creating a duplicate label.
proc ::nc::ui_table::_label_selected_is_disabled {} {
    variable _label_list
    variable _label_disabled_map
    if {$_label_list eq "" || ![winfo exists $_label_list]} { return 0 }
    set sel [$_label_list curselection]
    if {[llength $sel] == 0} { return 0 }
    set idx [lindex $sel 0]
    if {$idx < 0 || $idx >= [llength $_label_disabled_map]} { return 0 }
    return [lindex $_label_disabled_map $idx]
}

proc ::nc::ui_table::_label_current_index {} {
    variable _label_list
    if {$_label_list eq "" || ![winfo exists $_label_list]} { return 0 }
    set sel [$_label_list curselection]
    if {[llength $sel] == 0} { return 0 }
    return [lindex $sel 0]
}

proc ::nc::ui_table::_label_select_index {idx} {
    variable _label_list
    if {$_label_list eq "" || ![winfo exists $_label_list]} { return }
    set n [$_label_list size]
    if {$n <= 0} { return }
    if {$idx < 0} { set idx 0 }
    if {$idx >= $n} { set idx [expr {$n - 1}] }
    $_label_list selection clear 0 end
    $_label_list selection set $idx
    $_label_list activate $idx
    $_label_list see $idx
}

# Unassigns the current target row's label (sets it back to empty) - always
# the row/cell that's active in the main table, regardless of what happens
# to be selected in the palette list. Staged as a pending edit like a
# normal assign, so it still goes through Apply/Cancel Pending.
#
# key defaults to the palette's own target key (button use); the right-click
# context-menu path passes its own resolved key explicitly instead, so it
# never mutates the palette's shared _label_target_key (which would desync
# the palette's title/list from what it's actually showing if the dialog
# happens to be open for a different key at the time).
proc ::nc::ui_table::_label_remove_from_cell {{key ""}} {
    variable _label_target_key
    variable _rows
    if {$key eq ""} { set key $_label_target_key }
    set r [_active_display_row_for_key $key]
    if {![string is integer -strict $r] || $r < 1 || $r > [llength $_rows]} {
        _set_status "No visible row to clear." warn
        _label_set_status "No visible row to clear." warn
        return
    }
    set row [lindex $_rows [expr {$r - 1}]]
    set current [_dict_get $row $key]
    if {$current eq ""} {
        _set_status "Row $r has no [_label_key_label $key] to remove." warn
        _label_set_status "Row $r has no [_label_key_label $key] to remove." warn
        return
    }
    if {![_pending_display_row_value $r $key ""]} {
        _set_status "Current tab/cell cannot accept [_label_key_label $key]." warn
        _label_set_status "Current tab/cell cannot accept [_label_key_label $key]." warn
        return
    }
    _populate_current
    _set_status "Pending removal of [_label_key_label $key] on row $r. Apply or cancel pending labels." warn
    _label_set_status "Pending clear on row $r." warn
}

# Right-click entry point: removes the label on whichever cell was
# right-clicked (comp_user_name/mat_user_name only), without requiring the
# Label Palette to be open first, and without touching the palette's own
# target key if it happens to be open on something else.
proc ::nc::ui_table::_on_remove_label_from_context {} {
    variable _tbl
    variable _tab
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return }
    set active ""
    catch {set active [$_tbl index active]}
    if {$active eq ""} {
        _set_status "No active cell to remove a label from." warn
        return
    }
    lassign [split $active ,] ar ac
    if {![string is integer -strict $ac]} { return }
    set cols [_cols_for_tab $_tab]
    if {$ac < 0 || $ac >= [llength $cols]} { return }
    set key [lindex [lindex $cols $ac] 0]
    if {$key ni {comp_user_name mat_user_name comp_type mat_label}} {
        _set_status "Right-click a COMP. Type/Name or MAT. Type/Label cell to remove its label." warn
        return
    }
    _label_remove_from_cell $key
}

proc ::nc::ui_table::_label_assign_active {} {
    variable _label_target_key
    variable _label_auto_next_table
    variable _label_auto_next_palette
    variable _rows
    set value [_selected_label_value]
    if {$value eq ""} {
        _label_set_status "Choose a label first." warn
        return
    }
    if {[_label_selected_is_disabled]} {
        _label_set_status "'$value' is already used by another row - pick a different label or remove it there first." warn
        return
    }
    set r [_active_display_row_for_key $_label_target_key]
    if {![string is integer -strict $r] || $r < 1 || $r > [llength $_rows]} {
        _label_set_status "No visible row to assign." warn
        return
    }
    if {![_pending_display_row_value $r $_label_target_key $value]} {
        _label_set_status "Current tab/cell cannot accept [_label_key_label $_label_target_key]." warn
        return
    }
    _populate_current
    if {$_label_auto_next_table} {
        set next_r [expr {$r + 1}]
        if {$next_r <= [llength $_rows]} { _set_active_cell_for_key $next_r $_label_target_key }
    } else {
        _set_active_cell_for_key $r $_label_target_key
    }
    if {$_label_auto_next_palette} {
        _label_select_index [expr {[_label_current_index] + 1}]
    }
    variable _last_mat_ambiguous_msg
    if {$_label_target_key eq "mat_user_name" && $_last_mat_ambiguous_msg ne ""} {
        # Don't stomp the duplicate-material warning _material_id_for_label
        # just raised - overwriting it with the generic "Pending ..."
        # message below hid the reason the row's mat_id changed to an
        # id the user didn't pick.
        _set_status $_last_mat_ambiguous_msg warn
        _label_set_status $_last_mat_ambiguous_msg warn
        set _last_mat_ambiguous_msg ""
    } else {
        _set_status "Pending [_label_key_label $_label_target_key] '$value' on row $r. Apply or cancel pending labels." warn
        _label_set_status "Pending row $r." warn
    }
}

proc ::nc::ui_table::_label_fill_selection {} {
    variable _label_target_key
    set value [_selected_label_value]
    if {$value eq ""} {
        _label_set_status "Choose a label first." warn
        return
    }
    if {[_label_selected_is_disabled]} {
        _label_set_status "'$value' is already used by another row - pick a different label or remove it there first." warn
        return
    }
    set indices [_selected_display_indices]
    if {[llength $indices] == 0} {
        set indices [list [_active_display_row_for_key $_label_target_key]]
    }
    variable _last_mat_ambiguous_msg
    set count 0
    set ambiguous_msg ""
    foreach r $indices {
        if {[_pending_display_row_value $r $_label_target_key $value]} { incr count }
        if {$_label_target_key eq "mat_user_name" && $_last_mat_ambiguous_msg ne ""} {
            set ambiguous_msg $_last_mat_ambiguous_msg
            set _last_mat_ambiguous_msg ""
        }
    }
    _populate_current
    if {$ambiguous_msg ne ""} {
        _set_status $ambiguous_msg warn
        _label_set_status $ambiguous_msg warn
    } else {
        _set_status "Pending [_label_key_label $_label_target_key] '$value' on $count row(s). Apply or cancel pending labels." warn
        _label_set_status "Pending $count row(s)." warn
    }
}

proc ::nc::ui_table::_place_companion_window {win {width 360} {height 420}} {
    variable _win
    if {$win eq "" || ![winfo exists $win]} { return }
    if {$_win ne "" && [winfo exists $_win]} {
        catch {wm transient $win $_win}
        # Center over the table window's CURRENT on-screen position (not
        # just its launch-time position) - if the user moved/resized it,
        # dialogs should still land inside it, not at some unrelated spot.
        set placed 0
        catch {
            set pw [winfo width $_win]
            set ph [winfo height $_win]
            if {$pw > 10 && $ph > 10} {
                set cx [expr {[winfo x $_win] + $pw / 2}]
                set cy [expr {[winfo y $_win] + $ph / 2}]
                set x [expr {$cx - $width / 2}]
                set y [expr {$cy - $height / 2}]
                if {$x < 0} { set x 0 }
                if {$y < 0} { set y 0 }
                wm geometry $win "${width}x${height}+${x}+${y}"
                set placed 1
            }
        }
        if {$placed} { return }
    }
    # No table window yet (e.g. the very first Session Manager at startup)
    # - fall back to centering over HM's own captured window bounds.
    catch {wm geometry $win [_centered_geometry $width $height]}
}

proc ::nc::ui_table::_label_paste_list {} {
    variable _label_target_key
    variable _label_bank
    set win .nc_label_paste
    catch {destroy $win}
    toplevel $win
    wm title $win "Paste Labels"
    wm transient $win [winfo toplevel .]
    label $win.lbl -text "One label per line for [_label_key_label $_label_target_key]:" -anchor w
    text $win.t -height 12 -width 42 -wrap none
    frame $win.buttons
    button $win.buttons.ok -text "Add" -command [list ::nc::ui_table::_label_accept_paste $win]
    button $win.buttons.cancel -text "Cancel" -command [list destroy $win]
    pack $win.lbl -side top -fill x -padx 8 -pady {8 2}
    pack $win.t -side top -fill both -expand 1 -padx 8 -pady 2
    pack $win.buttons.cancel $win.buttons.ok -side right -padx 4 -pady 6
    pack $win.buttons -side top -fill x
    _place_companion_window $win 380 340
    catch {focus $win.t}
}

proc ::nc::ui_table::_label_accept_paste {win} {
    variable _label_target_key
    variable _label_bank
    if {![winfo exists $win]} { return }
    set text [$win.t get 1.0 end]
    set values {}
    foreach line [split $text "\n"] {
        set v [string trim $line]
        if {$v ne ""} { lappend values $v }
    }
    set existing {}
    if {[info exists _label_bank($_label_target_key)]} { set existing $_label_bank($_label_target_key) }
    set _label_bank($_label_target_key) [_unique_nonempty [concat $existing $values]]
    destroy $win
    _label_refresh_list
    _label_set_status "Added [llength $values] pasted label(s)." ok
}

# Removes the currently selected palette entry from the pasted label bank.
# Only affects _label_bank (the paste-list "candidates"); if the same label
# is still an actual value on a table row, it will keep showing up because
# _dropdown_values_for_key also merges in labels already used in the table.
proc ::nc::ui_table::_label_remove_selected {} {
    variable _label_target_key
    variable _label_bank
    variable _label_display_map
    variable _label_list
    if {$_label_list eq "" || ![winfo exists $_label_list]} { return }
    set sel [$_label_list curselection]
    if {[llength $sel] == 0} {
        _label_set_status "Select a label to remove first." warn
        return
    }
    set idx [lindex $sel 0]
    if {$idx < 0 || $idx >= [llength $_label_display_map]} { return }
    set value [lindex $_label_display_map $idx]
    if {[info exists _label_bank($_label_target_key)]} {
        set pos [lsearch -exact $_label_bank($_label_target_key) $value]
        if {$pos >= 0} {
            set _label_bank($_label_target_key) [lreplace $_label_bank($_label_target_key) $pos $pos]
        }
    }
    _label_refresh_list
    _label_set_status "Removed '$value' from pasted list." ok
}

# Clears the entire pasted label bank for the current palette target key.
proc ::nc::ui_table::_label_clear_bank {} {
    variable _label_target_key
    variable _label_bank
    set _label_bank($_label_target_key) {}
    _label_refresh_list
    _label_set_status "Cleared pasted list for [_label_key_label $_label_target_key]." ok
}

proc ::nc::ui_table::_commit_pending_labels_for_tab {tab {refresh 1}} {
    variable _tab_rows
    set count 0
    if {![info exists _tab_rows($tab)]} { return 0 }
    foreach row $_tab_rows($tab) {
        if {![_row_has_pending $row]} { continue }
        set row_key [_row_key_for_tab $tab $row]
        set pending [_row_pending_fields $row]
        foreach key $pending {
            if {[dict exists $row _pending_values $key]} {
                set row [_set_row_value $tab $row $key [dict get $row _pending_values $key]]
            }
        }
        set row [_clear_pending_row $row]
        if {$tab in {general component}} {
            _sync_component_fields [_dict_get $row comp_id] $row
        } else {
            _replace_row $tab $row_key $row
            if {$tab eq "materials"} {
                if {"mat_user_name" in $pending} {
                    _sync_material_label_across_rows $row
                }
            }
        }
        incr count
    }
    if {$refresh && $count > 0} {
        _populate_current
    }
    return $count
}

proc ::nc::ui_table::_commit_pending_labels {{status 1}} {
    variable _tab
    set count [_commit_pending_labels_for_tab $_tab 1]
    if {$status} {
        if {$count > 0} {
            _set_status "Applied $count pending label row(s) to preview table." ok
            _label_set_status "Applied $count pending row(s)." ok
        } else {
            _label_set_status "No pending label rows to apply." warn
        }
    }
    return $count
}

proc ::nc::ui_table::_commit_all_pending_labels {} {
    set count 0
    foreach tab {general component properties materials} {
        incr count [_commit_pending_labels_for_tab $tab 0]
    }
    if {$count > 0} { _populate_current }
    return $count
}

proc ::nc::ui_table::_cancel_pending_labels {{status 1}} {
    variable _tab
    variable _tab_rows
    set count 0
    if {![info exists _tab_rows($_tab)]} { return 0 }
    foreach row $_tab_rows($_tab) {
        if {![_row_has_pending $row]} { continue }
        set row_key [_row_key_for_tab $_tab $row]
        set row [_clear_pending_row $row]
        if {$_tab in {general component}} {
            _sync_component_fields [_dict_get $row comp_id] $row
        } else {
            _replace_row $_tab $row_key $row
        }
        incr count
    }
    if {$count > 0} {
        _populate_current
    }
    if {$status} {
        if {$count > 0} {
            _set_status "Canceled $count pending label row(s)." ok
            _label_set_status "Canceled $count pending row(s)." ok
        } else {
            _label_set_status "No pending label rows to cancel." warn
        }
    }
    return $count
}

proc ::nc::ui_table::_open_label_palette {{preferred ""} {r ""} {c ""}} {
    variable _label_win
    variable _label_filter
    variable _label_target_key
    variable _label_target_cell
    variable _label_list
    variable _label_status
    variable _label_auto_next_table
    variable _label_auto_next_palette
    variable _tbl
    variable _tab

    if {$preferred eq "" && $_tbl ne "" && [winfo exists $_tbl]} {
        set active ""
        catch {set active [$_tbl index active]}
        if {$active ne ""} {
            lassign [split $active ,] ar ac
            if {[string is integer -strict $ac]} {
                set cols [_cols_for_tab $_tab]
                if {$ac >= 0 && $ac < [llength $cols]} {
                    set active_key [lindex [lindex $cols $ac] 0]
                    if {$active_key in {comp_user_name mat_user_name comp_type mat_label}} {
                        set preferred $active_key
                    }
                }
            }
        }
    }
    set key [_label_allowed_key_for_tab $preferred]
    if {$key eq ""} {
        _set_status "Labels can be assigned on Component/General/Material label columns." warn
        return
    }
    if {$key ni [_editable_fields $_tab]} {
        _set_status "[_label_key_label $key] is not editable in the current tab." warn
        return
    }
    set _label_target_key $key
    set _label_filter ""
    if {[string is integer -strict $r] && [string is integer -strict $c]} {
        set _label_target_cell "$r,$c"
        if {$_tbl ne "" && [winfo exists $_tbl]} {
            catch {$_tbl activate $r,$c}
            catch {$_tbl selection set $r,$c $r,$c}
        }
    } else {
        set _label_target_cell ""
    }
    set palette_path .nc_label_palette
    if {$_label_win eq "" || ![winfo exists $_label_win]} {
        if {[winfo exists $palette_path]} {
            set _label_win $palette_path
        }
    }
    if {$_label_win ne "" && [winfo exists $_label_win]} {
        if {![winfo exists $_label_win.top] || ![winfo exists $_label_win.mid.list]} {
            catch {destroy $_label_win}
            set _label_win ""
        } else {
            set _label_list $_label_win.mid.list
            if {[winfo exists $_label_win.status]} { set _label_status $_label_win.status }
        }
    }
    if {$_label_win eq "" || ![winfo exists $_label_win]} {
        set _label_win [toplevel $palette_path]
        wm title $_label_win "Label Palette"
        wm minsize $_label_win 280 260
        wm protocol $_label_win WM_DELETE_WINDOW [list wm withdraw $_label_win]
        catch {wm resizable $_label_win 1 1}
        frame $_label_win.top
        label $_label_win.top.target -text "" -anchor w -font {Arial 9 bold}
        entry $_label_win.top.find -textvariable ::nc::ui_table::_label_filter -width 30
        pack $_label_win.top.target -side top -fill x -padx 6 -pady {6 2}
        pack $_label_win.top.find -side top -fill x -padx 6 -pady {0 4}
        frame $_label_win.mid
        set _label_list [listbox $_label_win.mid.list -height 12 -exportselection 0]
        scrollbar $_label_win.mid.sy -orient vertical -command [list $_label_win.mid.list yview]
        $_label_win.mid.list configure -yscrollcommand [list $_label_win.mid.sy set]
        pack $_label_win.mid.sy -side right -fill y
        pack $_label_win.mid.list -side left -fill both -expand 1
        pack $_label_win.top -side top -fill x
        pack $_label_win.mid -side top -fill both -expand 1 -padx 6 -pady 2
        frame $_label_win.opts
        checkbutton $_label_win.opts.nextrow -text "Next Row" -variable ::nc::ui_table::_label_auto_next_table
        checkbutton $_label_win.opts.nextlabel -text "Next Label" -variable ::nc::ui_table::_label_auto_next_palette
        pack $_label_win.opts.nextrow $_label_win.opts.nextlabel -side left -padx 4 -pady 2
        pack $_label_win.opts -side top -fill x -padx 4
        frame $_label_win.buttons1
        button $_label_win.buttons1.assign -text "Assign Cell" -command {::nc::ui_table::_label_assign_active}
        button $_label_win.buttons1.fill -text "Fill Selection" -command {::nc::ui_table::_label_fill_selection}
        button $_label_win.buttons1.removecell -text "Remove Label" -command {::nc::ui_table::_label_remove_from_cell}
        button $_label_win.buttons1.apply -text "Apply Pending" -command {::nc::ui_table::_commit_pending_labels}
        pack $_label_win.buttons1.assign $_label_win.buttons1.fill $_label_win.buttons1.removecell $_label_win.buttons1.apply -side left -padx 3 -pady 2
        frame $_label_win.buttons2
        button $_label_win.buttons2.paste -text "Paste List..." -command {::nc::ui_table::_label_paste_list}
        button $_label_win.buttons2.remove -text "Remove From List" -command {::nc::ui_table::_label_remove_selected}
        button $_label_win.buttons2.clear -text "Clear List" -command {::nc::ui_table::_label_clear_bank}
        button $_label_win.buttons2.cancel -text "Cancel Pending" -command {::nc::ui_table::_cancel_pending_labels}
        pack $_label_win.buttons2.paste $_label_win.buttons2.remove $_label_win.buttons2.clear $_label_win.buttons2.cancel -side left -padx 3 -pady 2
        set _label_status [label $_label_win.status -text "" -anchor w -fg "#555555"]
        pack $_label_win.buttons1 -side top -fill x -padx 4
        pack $_label_win.buttons2 -side top -fill x -padx 4
        pack $_label_win.status -side top -fill x -padx 6 -pady {0 5}
        bind $_label_win.top.find <KeyRelease> {::nc::ui_table::_label_refresh_list}
        bind $_label_win.top.find <Return> {::nc::ui_table::_label_assign_active; break}
        bind $_label_win.mid.list <Double-Button-1> {::nc::ui_table::_label_assign_active; break}
        bind $_label_win.mid.list <Return> {::nc::ui_table::_label_assign_active; break}
        bind $_label_win <Escape> {wm withdraw .nc_label_palette; break}
        bind $_label_win <MouseWheel> {::nc::ui_table::_label_palette_wheel_scroll %X %Y %D}
    }
    $_label_win.top.target configure -text "Target: [_label_key_label $_label_target_key]"
    _label_refresh_list
    catch {wm deiconify $_label_win}
    _place_companion_window $_label_win 390 430
    catch {raise $_label_win}
    catch {focus $_label_win.top.find}
}

proc ::nc::ui_table::_mark_dirty {row key} {
    set dirty [_dict_get $row _dirty_fields {}]
    if {[lsearch -exact $dirty $key] < 0} { lappend dirty $key }
    dict set row _dirty_fields $dirty
    return $row
}

proc ::nc::ui_table::_set_row_value {tab row key value {session_dirty 1}} {
    if {$session_dirty} { _set_session_dirty 1 }
    set row [_mark_dirty $row $key]
    if {$key eq "mat_user_name" && $tab ne "materials"} {
        # On general/component rows, mat_user_name means "assign a
        # material" - via the unambiguous "ID | Type | Label" dropdown, or
        # typed Type text (legacy/CSV, resolved by name - can be
        # ambiguous). Never store the raw "ID | ..." token itself into
        # mat_user_name - only a resolved material's own fields, so a
        # stale/unresolvable reference (material deleted after the dropdown
        # was built) can't leave literal junk in the Type column.
        set mrow [_resolve_material_row_for_value $value]
        if {$mrow ne ""} {
            dict set row mat_id [_dict_get $mrow mat_id]
            dict set row mat_user_name [_dict_get $mrow mat_user_name]
            dict set row material_label [_dict_get $mrow mat_user_name]
            foreach k {mat_label mat_name mat_card E G NU RHO A TREF} {
                if {[dict exists $mrow $k]} { dict set row $k [dict get $mrow $k] }
            }
            set row [_mark_dirty $row mat_id]
        } elseif {[regexp {^\s*[0-9]+\s*\|} $value]} {
            variable _last_mat_ambiguous_msg
            set _last_mat_ambiguous_msg "Could not find a material for '$value' - it may have been removed or renamed. Row's material left unchanged."
            _set_status $_last_mat_ambiguous_msg warn
        } else {
            # Free-typed text with no match at all (typo, or a name not
            # in the Materials tab yet) - still show what was typed, same
            # as before, so the user sees their input; mat_id stays as-is.
            dict set row mat_user_name $value
            dict set row material_label $value
        }
        return $row
    }
    dict set row $key $value
    switch -- $key {
        comp_user_name { dict set row label $value }
    }
    return $row
}

proc ::nc::ui_table::_material_row_by_id {mat_id} {
    variable _tab_rows
    if {$mat_id eq "" || ![info exists _tab_rows(materials)]} { return "" }
    foreach row $_tab_rows(materials) {
        if {[_dict_get $row mat_id] eq $mat_id} { return $row }
    }
    return ""
}

proc ::nc::ui_table::_replace_material_row {mat_id new_row} {
    variable _tab_rows
    if {$mat_id eq "" || ![info exists _tab_rows(materials)]} { return 0 }
    set out {}
    set changed 0
    foreach row $_tab_rows(materials) {
        if {[_dict_get $row mat_id] eq $mat_id} {
            lappend out $new_row
            set changed 1
        } else {
            lappend out $row
        }
    }
    if {$changed} { set _tab_rows(materials) $out }
    return $changed
}

proc ::nc::ui_table::_duplicate_material_with_density {source_mat_id new_rho comp_id} {
    variable _tab_rows
    set source [_material_row_by_id $source_mat_id]
    if {$source eq ""} { return "" }
    set new_id [_next_id_for_tab materials]
    # MAT. Type is user-defined only - never fall back to mat_name (the raw
    # HM name), same rule as everywhere else this field is read.
    set base_label [_dict_get $source mat_user_name "Material"]
    set new_label "${base_label}_RHO_$new_id"
    dict set source mat_id $new_id
    dict set source mat_user_name $new_label
    dict set source mat_name $new_label
    dict set source RHO $new_rho
    dict set source note "Duplicated for target mass on component $comp_id"
    dict set source _dirty_fields {mat_id mat_user_name mat_name RHO note}
    lappend _tab_rows(materials) $source
    _refresh_material_options
    return [dict create mat_id $new_id mat_user_name $new_label mat_name $new_label]
}

proc ::nc::ui_table::_sync_component_material {comp_id mat_info} {
    variable _tab_rows
    if {$comp_id eq ""} { return }
    foreach tab {general component} {
        if {![info exists _tab_rows($tab)]} continue
        set out {}
        foreach row $_tab_rows($tab) {
            if {[_dict_get $row comp_id] eq $comp_id} {
                dict set row mat_id [dict get $mat_info mat_id]
                dict set row mat_user_name [dict get $mat_info mat_user_name]
                dict set row material_label [dict get $mat_info mat_user_name]
                if {[dict exists $mat_info mat_name]} { dict set row mat_name [dict get $mat_info mat_name] }
                set row [_mark_dirty $row mat_id]
                set row [_mark_dirty $row mat_user_name]
            }
            lappend out $row
        }
        set _tab_rows($tab) $out
    }
}

# Propagates a material label edit made on the Materials tab to every
# general/component row that references the same mat_id, so their displayed
# material name updates immediately instead of staying stuck on the old
# cached label. Mirrors _sync_component_material, but keyed by mat_id (a
# materials-tab edit isn't scoped to one comp_id).
proc ::nc::ui_table::_sync_material_label_across_rows {mat_row} {
    variable _tab_rows
    set mat_id [_dict_get $mat_row mat_id]
    if {$mat_id eq ""} { return }
    set new_label [_dict_get $mat_row mat_user_name]
    foreach tab {general component} {
        if {![info exists _tab_rows($tab)]} continue
        set out {}
        foreach row $_tab_rows($tab) {
            if {[_dict_get $row mat_id] eq $mat_id} {
                dict set row mat_user_name $new_label
                dict set row material_label $new_label
                # E/G/NU/RHO/A/TREF/mat_label/mat_name are cached once onto
                # general/component rows at scan time (see scan.tcl's
                # mat_fields) and displayed directly on the Component tab -
                # without this, editing them on the Materials tab left the
                # Component tab showing stale values with no way to notice.
                foreach key {mat_label mat_name E G NU RHO A TREF} {
                    if {[dict exists $mat_row $key]} { dict set row $key [dict get $mat_row $key] }
                }
                set row [_mark_dirty $row mat_user_name]
            }
            lappend out $row
        }
        set _tab_rows($tab) $out
    }
}

proc ::nc::ui_table::_sync_component_mass {comp_id raw_mass} {
    variable _tab_rows
    if {$comp_id eq ""} { return }
    foreach tab {general component} {
        if {![info exists _tab_rows($tab)]} continue
        set out {}
        foreach row $_tab_rows($tab) {
            if {[_dict_get $row comp_id] eq $comp_id} {
                dict set row mass_total_raw $raw_mass
                dict set row mass_total $raw_mass
                set row [_mark_dirty $row mass_total_raw]
                set row [_mark_dirty $row mass_total]
            }
            lappend out $row
        }
        set _tab_rows($tab) $out
    }
}

proc ::nc::ui_table::_adjust_density_for_target_mass {row target_raw current_raw} {
    set comp_id [_dict_get $row comp_id]
    set mat_id [_dict_get $row mat_id]
    if {$comp_id eq "" || $mat_id eq ""} { return 0 }
    if {$current_raw eq "" || ![string is double -strict $current_raw] || double($current_raw) == 0.0} {
        _set_status "Cannot adjust density: current mass is empty or zero." warn
        return 0
    }
    set mat_row [_material_row_by_id $mat_id]
    if {$mat_row eq ""} {
        _set_status "Cannot adjust density: material $mat_id was not found." warn
        return 0
    }
    set old_rho [_dict_get $mat_row RHO]
    if {$old_rho eq "" || ![string is double -strict $old_rho]} {
        _set_status "Cannot adjust density: material $mat_id has no numeric RHO." warn
        return 0
    }
    set scale [expr {double($target_raw) / double($current_raw)}]
    set new_rho [_format_scientific_3 [expr {double($old_rho) * $scale}]]
    set usage [_dict_get $mat_row usage_count 0]
    if {$usage ne "" && [string is integer -strict $usage] && $usage > 1} {
        set mat_info [_duplicate_material_with_density $mat_id $new_rho $comp_id]
        if {$mat_info eq ""} { return 0 }
        _sync_component_material $comp_id $mat_info
        _set_status "Material $mat_id is shared by $usage row(s); duplicated material [dict get $mat_info mat_id] with RHO $new_rho." warn
        return 1
    }
    set answer "no"
    catch {
        set answer [_table_message_box \
            -title "Adjust Density" \
            -icon question \
            -type yesnocancel \
            -message "Target mass changes density scale to [format %.6g $scale].\n\nCurrent RHO: $old_rho\nNew RHO: $new_rho\n\nYes = update current material\nNo = duplicate material and assign this component\nCancel = keep mass only"]
    }
    if {$answer eq "cancel"} { return 0 }
    if {$answer eq "yes"} {
        dict set mat_row RHO $new_rho
        set mat_row [_mark_dirty $mat_row RHO]
        _replace_material_row $mat_id $mat_row
        _set_status "Adjusted RHO on material $mat_id to $new_rho." ok
        return 1
    }
    set mat_info [_duplicate_material_with_density $mat_id $new_rho $comp_id]
    if {$mat_info eq ""} { return 0 }
    _sync_component_material $comp_id $mat_info
    _set_status "Duplicated material [dict get $mat_info mat_id] with RHO $new_rho and assigned component $comp_id." ok
    return 1
}

proc ::nc::ui_table::_stage_mass_value {r c new_val old_val} {
    variable _rows
    variable _tab
    variable tableData
    if {![string is integer -strict $r] || $r < 1 || $r > [llength $_rows]} { return 0 }
    set target_raw [_mass_input_to_raw $new_val]
    if {$target_raw eq "" || double($target_raw) < 0.0} {
        set tableData($r,$c) $old_val
        _set_status "Mass must be a non-negative number." warn
        return 0
    }
    set row [lindex $_rows [expr {$r - 1}]]
    set current_raw [_dict_get $row mass_total_raw [_dict_get $row mass_total]]
    set ask "no"
    if {$current_raw ne "" && [string is double -strict $current_raw] && double($current_raw) > 0.0 && $target_raw != double($current_raw)} {
        catch {
            set ask [_table_message_box \
                -title "Target Mass" \
                -icon question \
                -type yesno \
                -message "Use this target mass to adjust material density?"]
        }
    }
    if {$ask eq "yes"} {
        _adjust_density_for_target_mass $row $target_raw $current_raw
    }
    _sync_component_mass [_dict_get $row comp_id] $target_raw
    _populate_current
    _set_session_dirty 1
    _set_status "Staged target mass = [_format_mass_value $target_raw]." ok
    return 1
}

proc ::nc::ui_table::_replace_row {tab key_value new_row} {
    variable _tab_rows
    if {![info exists _tab_rows($tab)]} { return }
    if {$key_value eq ""} {
        # An empty key means the row has no identity yet (shouldn't happen
        # in normal use - materials/properties get an id at creation,
        # library gets _libidx at load). Matching on "" would silently
        # overwrite EVERY row that also happens to have an empty key
        # instead of just the intended one - refuse instead of risking
        # multi-row corruption.
        _set_status "Could not save edit: row has no $tab identifier." error
        return
    }
    set out {}
    set replaced 0
    foreach row $_tab_rows($tab) {
        if {!$replaced && [_row_key_for_tab $tab $row] eq $key_value} {
            lappend out $new_row
            set replaced 1
        } else {
            lappend out $row
        }
    }
    set _tab_rows($tab) $out
}

proc ::nc::ui_table::_sync_component_fields {cid source_row} {
    variable _tab_rows
    foreach tab {general component} {
        if {![info exists _tab_rows($tab)]} continue
        set out {}
        foreach row $_tab_rows($tab) {
            if {[_dict_get $row comp_id] eq $cid} {
                # prop_user_name ("Property Label") is in _editable_fields
                # general/component but was missing here - since general/
                # component only ever persist an edit through this proc (no
                # _replace_row call for them, see _stage_cell_value), leaving
                # it out meant editing that cell didn't even save to the tab
                # being edited, let alone the sibling tab - the next populate
                # just reverted it.
                foreach key {comp_user_name comp_type label prop_user_name mat_user_name material_label mat_id note} {
                    if {[dict exists $source_row $key]} { dict set row $key [dict get $source_row $key] }
                }
                foreach key {_pending_values _pending_fields} {
                    if {[dict exists $source_row $key]} {
                        dict set row $key [dict get $source_row $key]
                    } elseif {[dict exists $row $key]} {
                        dict unset row $key
                    }
                }
                foreach key [_dict_get $source_row _dirty_fields {}] {
                    set row [_mark_dirty $row $key]
                }
            }
            lappend out $row
        }
        set _tab_rows($tab) $out
    }
}

proc ::nc::ui_table::_session_display_name {} {
    variable _session_path
    set path $_session_path
    catch {set path [::nc::session::dir]}
    if {$path eq ""} { return "preview" }
    return $path
}

proc ::nc::ui_table::_update_session_label {} {
    variable _session_lbl
    variable _session_dirty
    variable _last_saved_hhmmss
    if {$_session_lbl eq "" || ![winfo exists $_session_lbl]} { return }
    set text "Session: [_session_display_name]"
    if {$_session_dirty} {
        append text " *"
    } elseif {$_last_saved_hhmmss ne ""} {
        append text "  (saved $_last_saved_hhmmss)"
    }
    catch {$_session_lbl configure -text $text}
}

proc ::nc::ui_table::_set_session_dirty {{dirty 1}} {
    variable _session_dirty
    set _session_dirty $dirty
    if {$dirty} {
        _autosave_schedule
    } else {
        _autosave_cancel
    }
    _update_session_label
}

proc ::nc::ui_table::set_session_dirty {{dirty 1}} {
    _set_session_dirty $dirty
}

# =============================================================================
# Auto-save engine
#
# Every table mutation funnels through _set_session_dirty 1, which debounces a
# background save (default 3 s). Long operations (capture loop, import apply,
# apply-to-HM) wrap themselves in _autosave_suspend_begin/_end so a save never
# runs mid-operation. A fingerprint-mismatched session pauses auto-save with a
# one-time notice instead of erroring on every edit; a manual Save Session can
# rebind the manifest and re-enable it. Disk failures warn once per run, then
# retry quietly on later edits.
# =============================================================================

proc ::nc::ui_table::_autosave_cancel {} {
    variable _autosave_after_id
    if {$_autosave_after_id ne ""} {
        catch {after cancel $_autosave_after_id}
        set _autosave_after_id ""
    }
}

proc ::nc::ui_table::_autosave_schedule {} {
    variable _autosave_after_id
    variable _autosave_delay_ms
    variable _autosave_enabled
    variable _autosave_timed
    # Manual-save model: never schedule a timed write. Edits stay in memory
    # (and mark the session dirty) until the user clicks Save Session.
    if {!$_autosave_timed} { return }
    if {!$_autosave_enabled} { return }
    _autosave_cancel
    catch {
        set _autosave_after_id [after $_autosave_delay_ms ::nc::ui_table::_autosave_fire]
    }
}

proc ::nc::ui_table::_autosave_suspend_begin {} {
    variable _autosave_suspend
    incr _autosave_suspend
}

proc ::nc::ui_table::_autosave_suspend_end {} {
    variable _autosave_suspend
    variable _session_dirty
    incr _autosave_suspend -1
    if {$_autosave_suspend < 0} { set _autosave_suspend 0 }
    if {$_autosave_suspend == 0 && $_session_dirty} { _autosave_schedule }
}

proc ::nc::ui_table::_autosave_fire {} {
    variable _autosave_after_id
    variable _autosave_running
    variable _autosave_suspend
    variable _autosave_enabled
    variable _autosave_warned_fail
    variable _session_dirty
    variable _win
    set _autosave_after_id ""
    if {$_autosave_running} { return }
    if {!$_autosave_enabled} { return }
    if {$_autosave_suspend > 0} { _autosave_schedule; return }
    if {!$_session_dirty} { return }
    if {[llength [info commands winfo]] > 0 && ($_win eq "" || ![winfo exists $_win])} { return }
    set dir ""
    catch {set dir [::nc::session::dir]}
    if {$dir eq ""} { return }
    set policy [dict create status adopt reason ""]
    catch {set policy [::nc::session::save_policy $dir]}
    if {[dict get $policy status] eq "block"} {
        set _autosave_enabled 0
        _set_status "Auto-save paused: session belongs to a different model. Use Save Session to rebind." warn
        catch {::nc::mutations::log_add "Auto-save paused: [dict get $policy reason]"}
        return
    }
    set _autosave_running 1
    if {[catch {_save_session_to_dir $dir 0} err]} {
        set _autosave_running 0
        _set_status "Auto-save failed: $err" warn
        if {!$_autosave_warned_fail} {
            set _autosave_warned_fail 1
            catch {_table_message_box -title "Auto-save Failed" -icon warning -type ok \
                -message "Auto-save could not write the session:\n$err\n\nSession folder:\n$dir\n\nYour edits stay in the table; auto-save keeps retrying after the next change."}
        }
        return
    }
    set _autosave_running 0
    set _autosave_warned_fail 0
    _set_status "Auto-saved [clock format [clock seconds] -format %H:%M:%S]" ok
}

proc ::nc::ui_table::_autosave_flush_now {} {
    variable _session_dirty
    _autosave_cancel
    if {!$_session_dirty} { return 1 }
    set dir ""
    catch {set dir [::nc::session::dir]}
    if {$dir eq ""} { return 0 }
    set policy [dict create status adopt reason ""]
    catch {set policy [::nc::session::save_policy $dir]}
    if {[dict get $policy status] eq "block"} { return 0 }
    if {[catch {_save_session_to_dir $dir 0}]} { return 0 }
    return 1
}

proc ::nc::ui_table::_leave_current_session_ok {} {
    # Manual-save model: switching away from a session with unsaved edits asks
    # the user what to do - Save, Discard (keep the last saved state on disk),
    # or Cancel the switch. Returns 1 to proceed with leaving, 0 to stay.
    variable _session_dirty
    if {!$_session_dirty} { return 1 }
    set answer cancel
    catch {
        set answer [_table_message_box -title "Unsaved Changes" \
            -icon warning -type yesnocancel -default yes \
            -message "You have unsaved changes in the current session.\n\nYes = Save changes\nNo = Discard changes (keep last saved data)\nCancel = stay here"]
    }
    switch -- $answer {
        yes {
            # Save; only proceed if the save actually succeeded.
            return [expr {[_on_session_save] ? 1 : 0}]
        }
        no {
            # Discard: leave without writing. The last saved state on disk is
            # untouched, so it's recoverable by reopening the session.
            return 1
        }
        default { return 0 }
    }
}

proc ::nc::ui_table::_table_message_box {args} {
    variable _win
    if {[llength [info commands winfo]] > 0 && $_win ne "" && [winfo exists $_win] && [lsearch -exact $args -parent] < 0} {
        set args [linsert $args 0 -parent $_win]
    }
    set result ""
    catch {set result [eval [list tk_messageBox] $args]}
    _restore_table_window
    return $result
}

proc ::nc::ui_table::_rows_by_tab_snapshot {} {
    variable _tab_rows
    set rows_by_tab [dict create]
    foreach pair [_tab_defs] {
        set tab [lindex $pair 0]
        set rows {}
        if {[info exists _tab_rows($tab)]} { set rows $_tab_rows($tab) }
        dict set rows_by_tab $tab $rows
    }
    return $rows_by_tab
}

proc ::nc::ui_table::_has_table_rows {} {
    variable _tab_rows
    foreach pair [_tab_defs] {
        set tab [lindex $pair 0]
        if {[info exists _tab_rows($tab)] && [llength $_tab_rows($tab)] > 0} {
            return 1
        }
    }
    return 0
}

proc ::nc::ui_table::_save_session_to_dir {dir {status 1}} {
    variable _session_path
    variable _last_saved_hhmmss
    if {$dir eq ""} {
        catch {set dir [::nc::session::dir]}
    }
    if {$dir eq ""} { return 0 }
    set header_order_by_tab [dict create]
    foreach pair [_tab_defs] {
        set tab [lindex $pair 0]
        set keys {}
        foreach col_def [_cols_for_tab $tab] { lappend keys [lindex $col_def 0] }
        if {[llength $keys] > 0} { dict set header_order_by_tab $tab $keys }
    }
    set rows_by_tab [_rows_by_tab_snapshot]
    # save_table_session and _save_library_snapshot both hard-throw on
    # missing Python/openpyxl. Preserve the previous "return 0" contract
    # so auto-save call sites don't crash the app; surface a clear error
    # to the user via _set_status when it's a manual Save (status=1).
    if {[catch {::nc::session::save_table_session $rows_by_tab $dir $header_order_by_tab} result]} {
        if {$status} {
            _set_status "Save failed: $result" error
        }
        return 0
    }
    set _session_path [dict get $result dir]
    if {[catch {_save_library_snapshot $dir} liberr]} {
        # Combined data already landed on disk successfully, but the
        # library snapshot failed - surface it, don't hide it, but the
        # session itself is not corrupt.
        if {$status} {
            _set_status "Session saved but library snapshot failed: $liberr" warn
        }
    }
    set _last_saved_hhmmss [clock format [clock seconds] -format %H:%M:%S]
    _set_session_dirty 0
    catch {::nc::session::recent_touch $_session_path}
    if {$status} {
        _set_status "Saved session: $_session_path" ok
    }
    return 1
}

# _write_session_xlsx_mirror removed (2026-07-05 xlsx-authoritative
# migration): matprop_combined.xlsx is now written directly by
# save_table_session (see lib/session.tcl) as the sole authoritative
# format. There is no longer a mirror concept - the session xlsx IS the
# session, not a companion to a CSV.

proc ::nc::ui_table::_session_internal_subfolder_names {} {
    return {edits cache thumb_cache Component_Images}
}

proc ::nc::ui_table::_resolve_session_root {path} {
    # A picked file/folder may live inside one of the session's own internal
    # subfolders (e.g. <session>/edits/matprop_general.csv). Walk up past any
    # such known internal subfolder names so the tool uses the real session
    # root, not a subfolder of it.
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

proc ::nc::ui_table::_choose_session_folder {title {mustexist 0}} {
    variable _session_path
    set initial $_session_path
    if {$initial eq ""} { catch {set initial [::nc::session::dir]} }
    if {$initial eq ""} { set initial [pwd] }
    set picked [_choose_folder_dialog $title $initial]
    if {$picked eq ""} { return "" }
    return [_resolve_session_root $picked]
}

# =============================================================================
# Custom Tk folder-picker dialog
#
# Native Windows common dialogs cannot cleanly "select a folder and stop":
# tk_getOpenFile/tk_getSaveFile require picking/typing a file, and
# tk_chooseDirectory on this embedded Tk build renders as the legacy
# tree-only browser with no address bar. This dialog is a small self-
# contained folder browser: type/see the current path, double-click a
# subfolder to enter it, Up to go back, New Folder to create one, and
# "Select This Folder" always returns wherever you're currently browsing
# (no file selection required).
# =============================================================================

namespace eval ::nc::ui_table {
    variable _folder_pick_win ""
    variable _folder_pick_current_dir ""
    variable _folder_pick_result ""
    variable _folder_pick_item_names
    array set _folder_pick_item_names {}
    # Explorer-style Back/Forward history. _back holds dirs visited before
    # the current one (top = most recent); _fwd holds dirs undone by Back
    # (top = next Forward target). Any *fresh* navigation (Up, double-click,
    # typed path) pushes the old current dir onto _back and clears _fwd -
    # same rule real Explorer uses.
    variable _folder_pick_back {}
    variable _folder_pick_fwd {}
    variable _folder_pick_rename_entry ""
}

proc ::nc::ui_table::_folder_pick_icon {} {
    set name ::nc::ui_table::_icon_folder
    if {[lsearch -exact [image names] $name] >= 0} { return $name }
    catch {image delete $name}
    image create photo $name -width 16 -height 14
    $name put "#ffffff" -to 0 0 16 14
    $name put "#8a6d1d" -to 1 3 15 13
    $name put "#f6c744" -to 2 4 14 12
    $name put "#8a6d1d" -to 2 1 9 4
    $name put "#e0a93a" -to 3 2 8 4
    return $name
}

# Tries the real Windows Explorer-style folder browser (via a throwaway
# PowerShell script running System.Windows.Forms.FolderBrowserDialog) so the
# user gets the same native look/feel as opening a folder anywhere else in
# Windows, instead of the legacy tree-only Tk dialog below. Returns "" both
# on user-Cancel and on any failure to launch PowerShell (missing/blocked on
# this machine, non-Windows, etc.) - caller falls back to the Tk dialog in
# the latter case, so this must never be the only path.
proc ::nc::ui_table::_choose_folder_dialog_native {title initial_dir {mustexist 1}} {
    if {$::tcl_platform(platform) ne "windows"} { return [list 0 ""] }
    set tmp [file join $::env(TEMP) "nc_folder_pick_[pid].ps1"]
    set out [file join $::env(TEMP) "nc_folder_pick_[pid].out"]
    set esc_title [string map {"'" "''"} $title]
    set esc_init [string map {"'" "''"} [file nativename $initial_dir]]
    set script [subst -nocommands -novariables {
Add-Type -AssemblyName System.Windows.Forms | Out-Null
$dlg = New-Object System.Windows.Forms.FolderBrowserDialog
$dlg.Description = '${esc_title}'
$dlg.ShowNewFolderButton = $true
$dlg.UseDescriptionForTitle = $true
if ('${esc_init}' -and (Test-Path -LiteralPath '${esc_init}' -PathType Container)) {
    $dlg.SelectedPath = '${esc_init}'
}
if ($dlg.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    [System.IO.File]::WriteAllText('${out}', $dlg.SelectedPath)
}
}]
    set script [string map [list {${esc_title}} $esc_title {${esc_init}} $esc_init {${out}} [file nativename $out]] $script]
    catch {file delete -force -- $out}
    set ok 0
    set picked ""
    if {![catch {
        set fh [open $tmp w]
        puts $fh $script
        close $fh
        exec powershell -NoProfile -NonInteractive -ExecutionPolicy Bypass -STA -File $tmp
        set ok 1
    }]} {
        if {[file exists $out]} {
            set fh [open $out r]
            set picked [string trim [read $fh]]
            close $fh
        }
    }
    catch {file delete -force -- $tmp}
    catch {file delete -force -- $out}
    return [list $ok $picked]
}

proc ::nc::ui_table::_choose_folder_dialog {title initial_dir} {
    if {$initial_dir eq "" || ![file isdirectory $initial_dir]} {
        set initial_dir [pwd]
    }
    lassign [_choose_folder_dialog_native $title $initial_dir] launched picked
    if {$launched} {
        if {$picked eq ""} { return "" }
        return [file normalize $picked]
    }
    return [_choose_folder_dialog_tk $title $initial_dir]
}

proc ::nc::ui_table::_choose_folder_dialog_tk {title initial_dir} {
    variable _win
    variable _folder_pick_win
    variable _folder_pick_current_dir
    variable _folder_pick_result
    variable _folder_pick_back
    variable _folder_pick_fwd

    set _folder_pick_result ""
    set _folder_pick_back {}
    set _folder_pick_fwd {}

    set w .nc_folder_pick
    catch {destroy $w}
    toplevel $w
    wm title $w $title
    catch {wm transient $w $_win}
    catch {wm minsize $w 460 360}
    wm protocol $w WM_DELETE_WINDOW {::nc::ui_table::_folder_pick_cancel}
    set _folder_pick_win $w

    set top [frame $w.top]
    pack $top -side top -fill x -padx 8 -pady {8 4}
    button $top.back -text "<" -width 2 -command {::nc::ui_table::_folder_pick_back}
    button $top.fwd -text ">" -width 2 -command {::nc::ui_table::_folder_pick_forward}
    button $top.up -text "Up" -width 5 -command {::nc::ui_table::_folder_pick_go_up}
    label $top.lbl -text "Path:"
    entry $top.path -textvariable ::nc::ui_table::_folder_pick_current_dir
    pack $top.back -side left -padx {0 2}
    pack $top.fwd -side left -padx {0 8}
    pack $top.lbl -side left -padx {0 4}
    pack $top.up -side right
    pack $top.path -side left -fill x -expand 1 -padx {0 6}
    bind $top.path <Return> {::nc::ui_table::_folder_pick_navigate_typed; break}

    set lf [frame $w.listframe -bd 1 -relief sunken -background white]
    pack $lf -side top -fill both -expand 1 -padx 8 -pady 4
    catch {package require Ttk}
    set has_ttk [expr {[llength [info commands ::ttk::treeview]] > 0}]
    if {$has_ttk} {
        set tv [ttk::treeview $lf.tree -show tree -selectmode browse \
            -yscrollcommand [list $lf.sy set]]
        scrollbar $lf.sy -orient v -command [list $tv yview]
        pack $lf.sy -side right -fill y
        pack $tv -side left -fill both -expand 1
        bind $tv <Double-Button-1> {::nc::ui_table::_folder_pick_enter_selected}
        bind $tv <Return> {::nc::ui_table::_folder_pick_enter_selected; break}
        bind $tv <MouseWheel> {%W yview scroll [expr {-(%D/120)}] units}
    } else {
        set lb [listbox $lf.list -selectmode browse -yscrollcommand [list $lf.sy set]]
        scrollbar $lf.sy -orient v -command [list $lb yview]
        pack $lf.sy -side right -fill y
        pack $lb -side left -fill both -expand 1
        bind $lb <Double-Button-1> {::nc::ui_table::_folder_pick_enter_selected}
        bind $lb <Return> {::nc::ui_table::_folder_pick_enter_selected; break}
        bind $lb <MouseWheel> {%W yview scroll [expr {-(%D/120)}] units}
    }

    set bf [frame $w.buttons]
    pack $bf -side top -fill x -padx 8 -pady {4 8}
    button $bf.newfolder -text "New Folder..." -command {::nc::ui_table::_folder_pick_new_folder}
    button $bf.select -text "Select This Folder" -command {::nc::ui_table::_folder_pick_confirm}
    button $bf.cancel -text "Cancel" -command {::nc::ui_table::_folder_pick_cancel}
    pack $bf.newfolder -side left
    pack $bf.cancel -side right
    pack $bf.select -side right -padx {0 6}

    set _folder_pick_current_dir [file normalize $initial_dir]
    _folder_pick_refresh_list
    catch {_place_companion_window $w 520 420}
    if {$has_ttk} { catch {focus $tv} } else { catch {focus $lb} }
    catch {grab $w}
    tkwait window $w
    catch {grab release $w}
    return $_folder_pick_result
}

proc ::nc::ui_table::_folder_pick_refresh_list {} {
    variable _folder_pick_win
    variable _folder_pick_current_dir
    variable _folder_pick_item_names
    set w $_folder_pick_win
    if {$w eq ""} { return }
    set names {}
    catch {
        foreach path [glob -nocomplain -directory $_folder_pick_current_dir -type d *] {
            lappend names [file tail $path]
        }
    }
    set names [lsort -dictionary $names]
    variable _folder_pick_back
    variable _folder_pick_fwd
    catch {$w.top.back configure -state [expr {[llength $_folder_pick_back] > 0 ? "normal" : "disabled"}]}
    catch {$w.top.fwd configure -state [expr {[llength $_folder_pick_fwd] > 0 ? "normal" : "disabled"}]}
    if {[winfo exists $w.listframe.tree]} {
        set tv $w.listframe.tree
        catch {$tv delete [$tv children {}]}
        array unset _folder_pick_item_names
        set icon [_folder_pick_icon]
        foreach name $names {
            set id [$tv insert {} end -text $name -image $icon]
            set _folder_pick_item_names($id) $name
        }
    } elseif {[winfo exists $w.listframe.list]} {
        set lb $w.listframe.list
        $lb delete 0 end
        foreach name $names {
            $lb insert end $name
        }
    }
}

# Central navigation entry point - every move to a *new* place (Up,
# double-click into a subfolder, typed/pasted path) goes through here so
# Back/Forward history stays consistent, mirroring Explorer: navigating
# fresh always pushes the old location onto Back and wipes Forward.
proc ::nc::ui_table::_folder_pick_goto {dir} {
    variable _folder_pick_current_dir
    variable _folder_pick_back
    variable _folder_pick_fwd
    if {$dir eq $_folder_pick_current_dir} { return }
    lappend _folder_pick_back $_folder_pick_current_dir
    set _folder_pick_fwd {}
    set _folder_pick_current_dir $dir
    _folder_pick_refresh_list
}

proc ::nc::ui_table::_folder_pick_back {} {
    variable _folder_pick_current_dir
    variable _folder_pick_back
    variable _folder_pick_fwd
    if {[llength $_folder_pick_back] == 0} { return }
    set prev [lindex $_folder_pick_back end]
    set _folder_pick_back [lrange $_folder_pick_back 0 end-1]
    lappend _folder_pick_fwd $_folder_pick_current_dir
    set _folder_pick_current_dir $prev
    _folder_pick_refresh_list
}

proc ::nc::ui_table::_folder_pick_forward {} {
    variable _folder_pick_current_dir
    variable _folder_pick_back
    variable _folder_pick_fwd
    if {[llength $_folder_pick_fwd] == 0} { return }
    set next [lindex $_folder_pick_fwd end]
    set _folder_pick_fwd [lrange $_folder_pick_fwd 0 end-1]
    lappend _folder_pick_back $_folder_pick_current_dir
    set _folder_pick_current_dir $next
    _folder_pick_refresh_list
}

proc ::nc::ui_table::_folder_pick_go_up {} {
    variable _folder_pick_current_dir
    set parent [file dirname $_folder_pick_current_dir]
    if {$parent ne $_folder_pick_current_dir} {
        _folder_pick_goto $parent
    }
}

proc ::nc::ui_table::_folder_pick_enter_selected {} {
    variable _folder_pick_win
    variable _folder_pick_current_dir
    variable _folder_pick_item_names
    set w $_folder_pick_win
    if {$w eq ""} { return }
    set name ""
    if {[winfo exists $w.listframe.tree]} {
        set tv $w.listframe.tree
        set sel [$tv selection]
        if {[llength $sel] == 0} { return }
        set id [lindex $sel 0]
        if {![info exists _folder_pick_item_names($id)]} { return }
        set name $_folder_pick_item_names($id)
    } elseif {[winfo exists $w.listframe.list]} {
        set lb $w.listframe.list
        set sel [$lb curselection]
        if {[llength $sel] == 0} { return }
        set name [$lb get [lindex $sel 0]]
    } else {
        return
    }
    set target [file join $_folder_pick_current_dir $name]
    if {[file isdirectory $target]} {
        _folder_pick_goto $target
    }
}

proc ::nc::ui_table::_folder_pick_navigate_typed {} {
    variable _folder_pick_current_dir
    # Windows "Copy as path" wraps the clipboard text in double quotes -
    # strip them (and surrounding whitespace) so a pasted path resolves
    # instead of always hitting "Not Found".
    set typed [string trim [string trim $_folder_pick_current_dir] "\""]
    if {[file isdirectory $typed]} {
        _folder_pick_goto [file normalize $typed]
    } else {
        catch {_table_message_box -title "Not Found" -icon warning -type ok \
            -message "This folder does not exist yet:\n$typed\n\nUse New Folder to create it."}
    }
}

# Picks "New folder", "New folder (2)", "New folder (3)"... - whichever
# doesn't already exist in dir, same naming Explorer uses.
proc ::nc::ui_table::_folder_pick_unique_name {dir base} {
    if {![file exists [file join $dir $base]]} { return $base }
    for {set n 2} {$n < 1000} {incr n} {
        set candidate "$base ($n)"
        if {![file exists [file join $dir $candidate]]} { return $candidate }
    }
    return "$base ([clock seconds])"
}

# Creates the folder immediately (no name dialog) then drops an editable
# text field right on top of the new row in the list, pre-selected, exactly
# like Explorer's inline rename after "New Folder" - Enter/Tab/click-away
# commits a rename, Escape keeps the default name.
proc ::nc::ui_table::_folder_pick_new_folder {} {
    variable _folder_pick_current_dir
    set name [_folder_pick_unique_name $_folder_pick_current_dir "New folder"]
    set target [file join $_folder_pick_current_dir $name]
    if {[catch {file mkdir $target}]} {
        catch {_table_message_box -title "New Folder" -icon error -type ok \
            -message "Could not create folder:\n$target"}
        return
    }
    _folder_pick_refresh_list
    _folder_pick_begin_rename $name
}

# Overlays a real Entry widget on top of the given item's row (tree or
# listbox) so the user can type a name in place, instead of a separate
# popup dialog. Committing renames the on-disk folder to match.
proc ::nc::ui_table::_folder_pick_begin_rename {name} {
    variable _folder_pick_win
    variable _folder_pick_current_dir
    variable _folder_pick_item_names
    variable _folder_pick_rename_entry
    set w $_folder_pick_win
    if {$w eq ""} { return }
    catch {destroy $_folder_pick_rename_entry}
    set _folder_pick_rename_entry ""

    if {[winfo exists $w.listframe.tree]} {
        set tv $w.listframe.tree
        set id ""
        foreach {iid iname} [array get _folder_pick_item_names] {
            if {$iname eq $name} { set id $iid; break }
        }
        if {$id eq ""} { return }
        catch {$tv see $id}
        catch {$tv selection set $id}
        set bbox [$tv bbox $id]
        if {$bbox eq ""} { return }
        lassign $bbox bx by bwidth bheight
        set ent [entry $w.listframe.rename_entry]
        place $ent -in $tv -x $bx -y $by -width [expr {max($bwidth, 120)}] -height $bheight
    } elseif {[winfo exists $w.listframe.list]} {
        set lb $w.listframe.list
        set idx [lsearch -exact [$lb get 0 end] $name]
        if {$idx < 0} { return }
        catch {$lb selection clear 0 end}
        catch {$lb selection set $idx}
        catch {$lb see $idx}
        set bbox [$lb bbox $idx]
        if {$bbox eq ""} { return }
        lassign $bbox bx by bwidth bheight
        set ent [entry $w.listframe.rename_entry]
        place $ent -in $lb -x $bx -y [expr {$by - 2}] -width [winfo width $lb] -height [expr {$bheight + 4}]
    } else {
        return
    }
    set _folder_pick_rename_entry $ent
    $ent insert 0 $name
    $ent selection range 0 end
    focus $ent
    bind $ent <Return> [list ::nc::ui_table::_folder_pick_commit_rename $name]
    bind $ent <KP_Enter> [list ::nc::ui_table::_folder_pick_commit_rename $name]
    bind $ent <Escape> {::nc::ui_table::_folder_pick_cancel_rename}
    bind $ent <FocusOut> [list ::nc::ui_table::_folder_pick_commit_rename $name]
}

proc ::nc::ui_table::_folder_pick_cancel_rename {} {
    variable _folder_pick_rename_entry
    catch {destroy $_folder_pick_rename_entry}
    set _folder_pick_rename_entry ""
}

proc ::nc::ui_table::_folder_pick_commit_rename {old_name} {
    variable _folder_pick_current_dir
    variable _folder_pick_rename_entry
    set ent $_folder_pick_rename_entry
    if {$ent eq "" || ![winfo exists $ent]} { return }
    set new_name [string trim [$ent get]]
    _folder_pick_cancel_rename
    if {$new_name eq "" || $new_name eq $old_name} { return }
    set old_path [file join $_folder_pick_current_dir $old_name]
    set new_path [file join $_folder_pick_current_dir $new_name]
    if {[file exists $new_path]} {
        catch {_table_message_box -title "New Folder" -icon warning -type ok \
            -message "A folder named '$new_name' already exists here."}
        return
    }
    if {[catch {file rename $old_path $new_path}]} {
        catch {_table_message_box -title "New Folder" -icon error -type ok \
            -message "Could not rename folder to:\n$new_path"}
        return
    }
    _folder_pick_refresh_list
}

proc ::nc::ui_table::_folder_pick_confirm {} {
    variable _folder_pick_current_dir
    variable _folder_pick_result
    variable _folder_pick_win
    catch {file mkdir $_folder_pick_current_dir}
    set _folder_pick_result [file normalize $_folder_pick_current_dir]
    catch {destroy $_folder_pick_win}
}

proc ::nc::ui_table::_folder_pick_cancel {} {
    variable _folder_pick_result
    variable _folder_pick_win
    set _folder_pick_result ""
    catch {destroy $_folder_pick_win}
}

proc ::nc::ui_table::_prompt_text {title label default_value} {
    set w .nc_prompt_text
    catch {destroy $w}
    toplevel $w
    wm title $w $title
    variable _win
    catch {wm transient $w $_win}
    catch {wm resizable $w 0 0}
    set ::nc::ui_table::_prompt_text_result ""
    set ::nc::ui_table::_prompt_text_value $default_value
    label $w.lbl -text $label -anchor w
    entry $w.entry -textvariable ::nc::ui_table::_prompt_text_value -width 34
    pack $w.lbl -side top -fill x -padx 10 -pady {10 2}
    pack $w.entry -side top -fill x -padx 10 -pady {0 8}
    set bf [frame $w.buttons]
    pack $bf -side top -fill x -padx 10 -pady {0 10}
    button $bf.ok -text "OK" -command {
        set ::nc::ui_table::_prompt_text_result $::nc::ui_table::_prompt_text_value
        destroy .nc_prompt_text
    }
    button $bf.cancel -text "Cancel" -command {destroy .nc_prompt_text}
    pack $bf.ok -side right -padx {4 0}
    pack $bf.cancel -side right
    bind $w.entry <Return> {
        set ::nc::ui_table::_prompt_text_result $::nc::ui_table::_prompt_text_value
        destroy .nc_prompt_text
    }
    bind $w <Escape> {destroy .nc_prompt_text}
    catch {_place_companion_window $w 320 110}
    catch {focus $w.entry}
    catch {grab $w}
    tkwait window $w
    catch {grab release $w}
    return $::nc::ui_table::_prompt_text_result
}

proc ::nc::ui_table::_on_session_save {} {
    variable _autosave_enabled
    set dir ""
    catch {set dir [::nc::session::dir]}
    if {$dir eq ""} {
        return [_on_session_save_as]
    }
    set policy [dict create status adopt reason ""]
    catch {set policy [::nc::session::save_policy $dir]}
    if {[dict get $policy status] eq "block"} {
        set answer no
        catch {
            set answer [_table_message_box -title "Session Belongs to Another Model" \
                -icon warning -type yesno -default no \
                -message "[dict get $policy reason]\n\nOverwrite the session manifest to match the CURRENT model and save?"]
        }
        if {$answer ne "yes"} { return 0 }
        catch {::nc::session::rebind_manifest_to_current_model $dir}
        set _autosave_enabled 1
    }
    if {[catch {set ok [_save_session_to_dir $dir 1]} err]} {
        catch {_table_message_box -title "Save Session" -icon error -type ok \
            -message "Could not save session:\n$err"}
        return 0
    }
    return $ok
}

proc ::nc::ui_table::_on_session_save_as {} {
    variable _session_path
    variable _last_saved_hhmmss
    set dir [_choose_session_folder "Save Session As (choose destination folder)" 0]
    if {$dir eq ""} { return 0 }
    set cur ""
    catch {set cur [::nc::session::dir]}
    if {$cur ne "" && [file normalize $dir] eq [file normalize $cur]} {
        return [_save_session_to_dir $dir 1]
    }
    if {[file exists [file join $dir manifest.csv]] || [file isdirectory [file join $dir edits]]} {
        set answer no
        catch {
            set answer [_table_message_box -title "Overwrite Session?" \
                -icon warning -type yesno -default no \
                -message "The destination folder already contains a session:\n$dir\n\nOverwrite its data?"]
        }
        if {$answer ne "yes"} { return 0 }
    }
    if {[catch {set result [::nc::session::save_session_as [_rows_by_tab_snapshot] $dir]} err]} {
        catch {_table_message_box -title "Save Session As" -icon error -type ok \
            -message "Could not save session:\n$err"}
        return 0
    }
    populate_all [dict get $result rows_by_tab]
    set _session_path [::nc::session::dir]
    set _last_saved_hhmmss [clock format [clock seconds] -format %H:%M:%S]
    _update_session_label
    catch {::nc::session::recent_touch $_session_path}
    set n 0
    catch {set n [dict get $result images_copied]}
    _set_status "Session duplicated to: $_session_path ($n images copied, cache excluded)" ok
    return 1
}

proc ::nc::ui_table::_on_session_new {} {
    variable _session_path
    variable _autosave_enabled
    if {![_leave_current_session_ok]} { return 0 }
    set initial ""
    catch {set initial [file normalize [::nc::session::_sessions_root]]}
    catch {file mkdir $initial}
    if {$initial eq "" || ![file isdirectory $initial]} { set initial [pwd] }
    set parent [_choose_folder_dialog "Choose Parent Folder for New Session" $initial]
    if {$parent eq ""} { return 0 }
    set name [string trim [_prompt_text "New Session" "Session name:" ""]]
    if {$name eq ""} { return 0 }
    if {[catch {set dest [::nc::session::create_session $parent $name]} err]} {
        catch {_table_message_box -title "New Session" -icon error -type ok \
            -message "Could not create session:\n$err"}
        return 0
    }
    set _session_path [::nc::session::dir]
    set _autosave_enabled 1
    catch {::nc::session::recent_touch $dest}
    populate_all [dict create general {} component {} properties {} materials {}]
    _set_status "New session created: $_session_path (empty table)" ok
    return 1
}

proc ::nc::ui_table::_on_session_manager {} {
    if {![_leave_current_session_ok]} { return 0 }
    set choice [dict create action cancel dir ""]
    catch {set choice [::nc::session_manager::show switch]}
    set action [dict get $choice action]
    set dir [dict get $choice dir]
    switch -- $action {
        open {
            return [_load_session_into_table $dir]
        }
        new {
            variable _session_path
            variable _autosave_enabled
            set _session_path [::nc::session::dir]
            set _autosave_enabled 1
            catch {::nc::session::recent_touch $dir}
            populate_all [dict create general {} component {} properties {} materials {}]
            _set_status "New session created: $_session_path (empty table)" ok
            return 1
        }
    }
    return 0
}

proc ::nc::ui_table::_on_session_open {} {
    if {![_leave_current_session_ok]} { return 0 }
    set dir [_choose_session_folder "Open Table Session Folder" 1]
    if {$dir eq ""} { return 0 }
    return [_load_session_into_table $dir]
}

proc ::nc::ui_table::_load_session_into_table {dir} {
    variable _session_path
    variable _autosave_enabled
    set _autosave_enabled 1
    ::nc::session::set_dir $dir
    set _session_path [::nc::session::dir]
    set rows_by_tab [dict create general {} component {} properties {} materials {}]
    set has_data 0
    set from_images 0
    if {![catch {set result [::nc::session::load_table_session $dir]}]} {
        set cached [dict get $result rows_by_tab]
        set ok 1
        foreach tab {general component properties materials} {
            if {![dict exists $cached $tab]} { set ok 0; break }
        }
        if {$ok} {
            set rows_by_tab [_resolve_image_paths_for_session $cached $dir]
            catch {set rows_by_tab [::nc::app::_sync_label_columns_in_rows_by_tab $rows_by_tab]}
            foreach tab {general component properties materials} {
                if {[llength [dict get $rows_by_tab $tab]] > 0} { set has_data 1; break }
            }
        }
    }
    if {!$has_data} {
        set synth [::nc::app::_synthesize_rows_from_images $dir]
        if {$synth ne ""} {
            set rows_by_tab $synth
            set has_data 1
            set from_images 1
        }
    }
    populate_all $rows_by_tab
    _refresh_material_options
    _set_session_dirty 0
    catch {::nc::session::recent_touch $_session_path}
    if {$from_images} {
        set ncomp [llength [dict get $rows_by_tab component]]
        _set_status "Opened session folder ($ncomp components synthesized from Component_Images/): $_session_path" ok
    } elseif {$has_data} {
        _set_status "Opened session folder (cached data loaded): $_session_path" ok
    } else {
        _set_status "Opened session folder (no cached data yet): $_session_path. Press Reload to read the current HM model." ok
    }
    return 1
}

proc ::nc::ui_table::_resolve_image_paths_for_session {rows_by_tab session_dir} {
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

proc ::nc::ui_table::_on_session_reveal {} {
    set dir ""
    catch {set dir [::nc::session::dir]}
    if {$dir eq ""} {
        _set_status "No active table session folder." warn
        return
    }
    _open_folder_in_explorer $dir
}

proc ::nc::ui_table::_label_palette_wheel_scroll {x y delta} {
    variable _label_win
    set target ""
    catch {set target [winfo containing $x $y]}
    if {$target ne ""} {
        set probe $target
        while {$probe ne ""} {
            if {[llength [info commands $probe]] > 0 && ![catch {$probe yview}]} {
                set target $probe
                break
            }
            set parent ""
            catch {set parent [winfo parent $probe]}
            if {$parent eq $probe} { break }
            set probe $parent
        }
    }
    if {$target eq "" || [catch {$target yview}]} {
        if {$_label_win ne "" && [winfo exists $_label_win.mid.list]} {
            set target $_label_win.mid.list
        } else {
            return
        }
    }
    set units [expr {-($delta / 120)}]
    catch {$target yview scroll $units units}
}

proc ::nc::ui_table::_open_folder_in_explorer {dir} {
    if {$dir eq ""} { return 0 }
    catch {file mkdir $dir}
    if {![file isdirectory $dir]} {
        _set_status "Folder does not exist: $dir" error
        return 0
    }
    set native $dir
    catch {set native [file nativename [file normalize $dir]]}
    if {[catch {exec explorer $native &}]} {
        _set_status "Opened: $native" ok
    } else {
        _set_status "Opened folder: $native" ok
    }
    return 1
}

proc ::nc::ui_table::_on_open_csv_folder {} {
    set dir ""
    catch {set dir [::nc::session::edits_dir]}
    if {$dir eq ""} {
        _set_status "No active table session folder." warn
        return
    }
    _open_folder_in_explorer $dir
}

proc ::nc::ui_table::_restore_table_window {} {
    variable _win
    if {$_win eq "" || ![winfo exists $_win]} { return }
    catch {wm deiconify $_win}
    catch {raise $_win}
    catch {focus $_win}
}

proc ::nc::ui_table::_on_close_window {} {
    variable _win
    variable _label_win
    variable _session_dirty
    if {$_session_dirty} {
        # Manual-save model: closing with unsaved edits asks what to do.
        # Yes = Save, No = Discard (close, keep last saved data on disk),
        # Cancel = keep the tool open.
        set answer cancel
        catch {
            set answer [_table_message_box -title "Unsaved Changes" \
                -icon warning -type yesnocancel -default yes \
                -message "You have unsaved changes.\n\nYes = Save and close\nNo = Discard changes and close\nCancel = keep working"]
        }
        switch -- $answer {
            yes {
                if {![_on_session_save]} {
                    # Save failed/aborted - don't lose the edits, stay open.
                    _restore_table_window
                    return
                }
            }
            no {
                # Discard: close without writing; disk keeps last saved state.
            }
            default {
                _restore_table_window
                return
            }
        }
    }
    _save_main_window_geometry
    catch {destroy $_label_win}
    catch {destroy $_win}
    set _win ""
}

# =============================================================================
# Window construction
# =============================================================================

proc ::nc::ui_table::_style_button {path {kind normal}} {
    if {$path eq "" || ![winfo exists $path]} { return }
    # Text-only buttons (the vast majority, now that most icons were dropped
    # as unreproducible in real HM - see docs/CLAUDE_HANDOFF.md) need a
    # permanently visible raised border, or they read as plain label text
    # sitting next to a group caption (e.g. "Data" label vs. "Reload"
    # button) instead of as clickable buttons.
    catch {$path configure -padx 5 -pady 1 -bd 1 -relief raised -highlightthickness 0 -takefocus 0 -font {Arial 8}}
    switch -- $kind {
        primary { catch {$path configure -background "#dcefdc" -activebackground "#c7e4c7"} }
        danger { catch {$path configure -background "#f0dddd" -activebackground "#e7caca"} }
        quiet { catch {$path configure -background "#f4f4f4" -activebackground "#e7e7e7"} }
        normal { catch {$path configure -background "#f7f7f7" -activebackground "#e9e9e9"} }
        info {
            # Light blue: view-only actions (Isolate/Find Comp/Highlight/
            # Invert/Reset/Validate, plane views) - never mutate the model.
            catch {$path configure -background "#dceefb" -activebackground "#c7e3f5"}
        }
        toggle {
            # Light yellow: a persistent on/off display-state toggle
            # (Show/Hide) - distinct from one-shot view actions.
            catch {$path configure -background "#fdf3cf" -activebackground "#f5e9ad"}
        }
        menu {
            # Save/Save As on the menu row are the one case that keeps the
            # flat, hover-only-raised look: they already carry a real icon,
            # so the icon itself signals "this is a button" without needing
            # a permanent border, and a border there would clash with the
            # plain menu row instead of the toolbar rows below.
            catch {$path configure -relief flat}
            catch {bind $path <Enter> {%W configure -relief raised}}
            catch {bind $path <Leave> {%W configure -relief flat}}
        }
    }
}

proc ::nc::ui_table::_add_button {parent name text cmd {kind normal} {icon_key ""} {width ""}} {
    catch {package require Ttk}
    if {[llength [info commands ttk::button]] > 0} {
        set b [ttk::button $parent.$name -text $text -command $cmd]
    } else {
        set b [button $parent.$name -text $text -command $cmd]
    }
    if {$width ne ""} { catch {$b configure -width $width} }
    if {$icon_key ne ""} {
        set img [_icon $icon_key]
        # Deliberately no -compound: Tk's default (compound none) shows the
        # image ONLY when both -image and -text are set, so a resolved icon
        # gives an icon-only button (matching HM's own icon-only toolbar
        # buttons) while a missing icon leaves the text as-is - one code
        # path, no separate icon-only/text-only branches to keep in sync.
        if {$img ne ""} { catch {$b configure -image $img} }
    }
    _style_button $b $kind
    pack $b -side left -padx {0 3} -pady 2
    return $b
}

# Real toolbar icons, loaded straight from the CAE tool's own install tree
# at runtime via config.tcl's icon_dir_candidates - never vendored, never
# guessed. Every filename below was confirmed to actually exist on disk
# under the install's own icon images folder before being added here.
#
# Scoped down to just Save/Save As (menu row) after the Find/Display/View
# row's icons (Isolate/Find Comp/Highlight/Invert/Reset/Show-Hide/Top/Front/
# Left/Iso) turned out wrong in real HM: several were HM's own multi-frame
# sprite strips (6 frames per file) that a plain Tk `image copy -from`
# cropped correctly in an isolated tclsh test, but still rendered as the
# full uncropped strip inside real HM's embedded Tcl/Tk (root cause not
# confirmed - HM's console gave no output to debug further). Per the
# user's explicit call, that whole row reverted to plain text buttons
# rather than keep guessing at a fix with no way to verify it in HM. See
# docs/CLAUDE_HANDOFF.md 2026-07-04 entries for the full trail if revisited.
array set ::nc::ui_table::_ICON_FILES {
    save        fileSave-24.png
    saveas      fileSaveAs-24.png
}

proc ::nc::ui_table::_icon {key} {
    variable _icon_cache
    if {[info exists _icon_cache($key)]} { return $_icon_cache($key) }
    set img ""
    if {[info exists ::nc::ui_table::_ICON_FILES($key)]} {
        set dir ""
        catch {set dir [::nc::config::resolve_icon_dir]}
        if {$dir ne ""} {
            set path [file join $dir $::nc::ui_table::_ICON_FILES($key)]
            if {[file exists $path]} {
                catch {
                    set img [image create photo -file $path]
                }
            }
        }
    }
    set _icon_cache($key) $img
    return $img
}

proc ::nc::ui_table::_make_group {parent name label} {
    set f [frame $parent.$name -bd 1 -relief groove -highlightthickness 0]
    if {$label ne ""} {
        # No fixed -width: a short label like "Data" doesn't need to hold
        # open the same box as "Display" - column alignment across rows
        # was traded away for keeping each label snug against its own
        # buttons instead of leaving a big empty gap.
        label $f.lbl -text $label -fg "#555555" -font {Arial 8} -anchor w
        pack $f.lbl -side left -padx {5 4} -pady 2
    }
    return $f
}

# Captures the CAE tool's own main window bounds ONCE, at the moment this tool
# is launched (before we create any Tk toplevel of our own) - at that exact
# point the user just clicked a macro button inside HM, so HM's main window
# is reliably the OS foreground window. Cached for the whole session rather
# than re-queried per dialog, since re-querying later could return one of
# OUR OWN windows instead (if a dialog is opened while the tool itself has
# focus, not HM). Confirmed real API against the user's own HM console:
# `twapi::get_window_coordinates [twapi::get_foreground_window]` returned
# {left top right bottom} matching HM's actual window
# (`twapi::get_window_text` on that hwnd read "Untitled - CAE tool 2022 -
# NastranMSC").
proc ::nc::ui_table::_capture_hm_window_rect {} {
    variable _hm_window_rect
    # Idempotent - the Session Manager can appear before the table window
    # exists (fresh startup) and calls this too, so the FIRST caller (while
    # HM is still reliably foreground) wins; a later call while the tool
    # itself has focus must not overwrite it with our own window's rect.
    if {[llength $_hm_window_rect] == 4} { return }
    if {[catch {package present twapi}] && [catch {package require twapi}]} { return }
    catch {
        set fg [twapi::get_foreground_window]
        if {$fg ne ""} {
            lassign [twapi::get_window_coordinates $fg] left top right bottom
            set w [expr {$right - $left}]
            set h [expr {$bottom - $top}]
            if {$w > 100 && $h > 100} {
                set _hm_window_rect [list $left $top $w $h]
            }
        }
    }
}

# Returns a Tk geometry string "WxH+X+Y" centering a WxH window over HM's
# captured window rect (falling back to centering on the whole screen if
# that was never captured/failed) - used for every companion dialog plus
# the tool's own main window, so nothing pops up outside HM's own window
# area or at some OS-default cascade position.
proc ::nc::ui_table::_centered_geometry {width height} {
    variable _hm_window_rect
    set cx ""
    set cy ""
    if {[llength $_hm_window_rect] == 4} {
        lassign $_hm_window_rect hx hy hw hh
        set cx [expr {$hx + $hw / 2}]
        set cy [expr {$hy + $hh / 2}]
    } else {
        catch {
            set cx [expr {[winfo screenwidth .] / 2}]
            set cy [expr {[winfo screenheight .] / 2}]
        }
    }
    if {$cx eq "" || $cy eq ""} { return "${width}x${height}" }
    set x [expr {$cx - $width / 2}]
    set y [expr {$cy - $height / 2}]
    if {$x < 0} { set x 0 }
    if {$y < 0} { set y 0 }
    return "${width}x${height}+${x}+${y}"
}

proc ::nc::ui_table::_main_window_geometry_pref_path {} {
    set dir ""
    catch {set dir $::nc::config::tool_dir}
    if {$dir eq ""} { set dir [pwd] }
    return [file join $dir nc_main_window_geometry.txt]
}

proc ::nc::ui_table::_valid_main_window_geometry {geom} {
    set geom [string trim $geom]
    if {![regexp {^([0-9]+)x([0-9]+)([+-][0-9]+)([+-][0-9]+)$} $geom -> w h x y]} {
        return ""
    }
    if {$w < 260 || $h < 160} { return "" }
    return $geom
}

proc ::nc::ui_table::_load_main_window_geometry {} {
    set path [_main_window_geometry_pref_path]
    if {![file exists $path]} { return "" }
    set geom ""
    if {[catch {
        set fp [open $path r]
        set geom [read $fp]
        close $fp
    }]} { return "" }
    return [_valid_main_window_geometry $geom]
}

proc ::nc::ui_table::_save_main_window_geometry {} {
    variable _win
    if {$_win eq "" || ![winfo exists $_win]} { return }
    set geom ""
    catch {
        update idletasks
        set w [winfo width $_win]
        set h [winfo height $_win]
        set x [winfo rootx $_win]
        set y [winfo rooty $_win]
        set geom "${w}x${h}+${x}+${y}"
    }
    set geom [_valid_main_window_geometry $geom]
    if {$geom eq ""} { return }
    set path [_main_window_geometry_pref_path]
    if {[catch {
        set fp [open $path w]
        puts $fp $geom
        close $fp
    }]} { return }
}

proc ::nc::ui_table::_schedule_main_window_geometry_save {} {
    variable _win
    variable _main_geometry_after_id
    if {$_win eq "" || ![winfo exists $_win]} { return }
    if {$_main_geometry_after_id ne ""} {
        catch {after cancel $_main_geometry_after_id}
    }
    set _main_geometry_after_id [after 350 {
        set ::nc::ui_table::_main_geometry_after_id ""
        ::nc::ui_table::_save_main_window_geometry
    }]
}

proc ::nc::ui_table::_build_window {title} {
    variable _win
    variable _root
    variable _log_w

    _capture_hm_window_rect
    set _win .nc_table
    catch {destroy $_win}
    toplevel $_win
    wm title $_win $title
    # Low floor, not a real minimum - just enough that the window can never
    # shrink to literally 0px and vanish/become unreachable. Previously
    # 920x520 which is what actually blocked shrinking the window narrower.
    catch {wm minsize $_win 260 160}
    set saved_geometry [_load_main_window_geometry]
    if {$saved_geometry ne ""} {
        catch {wm geometry $_win $saved_geometry}
    } else {
        catch {wm geometry $_win [_centered_geometry 1120 680]}
    }
    # The CAE tool's own window chrome/docking sometimes defaults a toplevel
    # to non-resizable - force both directions on explicitly so the user can
    # always freely drag the tool window wider/narrower (and taller/shorter).
    catch {wm resizable $_win 1 1}
    bind $_win <Configure> {::nc::ui_table::_schedule_main_window_geometry_save}
    wm protocol $_win WM_DELETE_WINDOW {::nc::ui_table::_on_close_window}
    set _root $_win
    if {[llength [info commands ::hwt::WindowRecess]] > 0} {
        set recess ""
        if {![catch {set recess [::hwt::WindowRecess $_win]}] && $recess ne ""} {
            if {![catch {winfo exists $recess} exists] && $exists} {
                set _root $recess
            }
        }
    }

    _load_column_layout
    _build_menubar $_root
    _build_tabbar $_root
    _build_control_area $_root
    # Log/status panel is packed BEFORE the table frame so it reserves its
    # own space (via -side bottom) from the window first; the table frame,
    # packed after with -fill both -expand 1, only gets whatever cavity is
    # left. Packing them in the opposite order let the table's -expand 1
    # claim all available space before the log panel existed, squeezing the
    # log off-window whenever a tab's toolbars grew taller (e.g. Component).
    _build_log_panel $_root
    _build_table_frame $_root
    ::nc::mutations::set_log_widget $_log_w
    variable _always_on_top_strict
    catch {wm attributes $_win -topmost [expr {$_always_on_top_strict ? 1 : 0}]}
    bind $_win <Activate> {::nc::ui_table::_on_main_focus_in}
    bind $_win <Deactivate> {::nc::ui_table::_on_main_focus_out}
    _set_status "Preview ready. Model-changing actions are staged only." ok
}

proc ::nc::ui_table::_on_main_focus_in {} {
    variable _win
    variable _always_on_top_strict
    if {$_win eq "" || ![winfo exists $_win]} { return }
    if {$_always_on_top_strict} {
        catch {wm attributes $_win -topmost 1}
    }
}

proc ::nc::ui_table::_on_main_focus_out {} {
    variable _win
    if {$_win eq "" || ![winfo exists $_win]} { return }
    after idle {::nc::ui_table::_apply_focus_out_topmost}
}

proc ::nc::ui_table::_apply_focus_out_topmost {} {
    variable _win
    variable _always_on_top_strict
    if {$_win eq "" || ![winfo exists $_win]} { return }
    if {$_always_on_top_strict} { return }
    set focused ""
    catch {set focused [focus -displayof $_win]}
    if {$focused eq ""} {
        catch {wm attributes $_win -topmost 0}
        return
    }
    set ftop ""
    catch {set ftop [winfo toplevel $focused]}
    if {$ftop eq $_win || [_toplevel_belongs_to_tool $ftop]} {
        return
    }
    catch {wm attributes $_win -topmost 0}
}

proc ::nc::ui_table::_toplevel_belongs_to_tool {top} {
    variable _win
    if {$top eq "" || ![winfo exists $top]} { return 0 }
    if {$top eq $_win} { return 1 }
    set owner ""
    catch {set owner [wm transient $top]}
    if {$owner eq ""} { return 0 }
    if {$owner eq $_win} { return 1 }
    return [_toplevel_belongs_to_tool $owner]
}

proc ::nc::ui_table::_on_toggle_always_on_top_strict {} {
    variable _always_on_top_strict
    variable _win
    if {$_win eq "" || ![winfo exists $_win]} { return }
    if {$_always_on_top_strict} {
        catch {wm attributes $_win -topmost 1}
        _set_status "Always on top: locked on." ok
    } else {
        catch {wm attributes $_win -topmost 0}
        _set_status "Always on top: off (normal window)." ok
    }
}

proc ::nc::ui_table::_build_menubar {root} {
    set mf [frame $root.menuframe -bd 0 -highlightthickness 0]
    pack $mf -side top -fill x -padx 4 -pady {4 0}
    # Menu names/grouping follow the CAE tool's own convention: File (session +
    # import/export), Edit (row/data actions), Selection (find/isolate/
    # worklist - the same idea as HM's Selection menu), View (everything
    # that only changes what's shown, not the data itself).
    foreach pair {
        {fileMenu File}
        {editMenu Edit}
        {selectionMenu Selection}
        {viewMenu View}
    } {
        lassign $pair name label
        menubutton $mf.$name -text $label -relief flat -bd 0 -padx 5 -pady 1 -anchor w
        menu $mf.$name.menu -tearoff 0
        $mf.$name configure -menu $mf.$name.menu
        pack $mf.$name -side left -padx {0 4}
    }

    # Save/Save As also live on the menu row (right-aligned) rather than
    # their own labeled toolbar row - they are global, always-available
    # actions like the menu itself, not tab-scoped. "menu" kind = no tinted
    # background, so they blend with the plain menu-row background instead
    # of standing out as a toolbar-colored button in a menu-colored row.
    # Packed right-to-left (Save As rightmost, then Save, then Always On
    # Top) so the final left-to-right order is: Always On Top, Save, Save
    # As - Always On Top ahead of the two Save buttons, as requested.
    _add_button $mf saveas "Save As..." {::nc::ui_table::_on_session_save_as} menu saveas
    _add_button $mf save "Save" {::nc::ui_table::_on_session_save} menu save
    pack $mf.saveas -side right -padx {0 6}
    pack $mf.save -side right -padx {0 4}

    # "Always On Top" lives on the menu row itself, to the left of Save/Save
    # As - it is a window-level setting, not a data/edit/review action, so
    # it does not belong among the tab toolbars below.
    checkbutton $mf.ontop -text "Always On Top" -variable ::nc::ui_table::_always_on_top_strict \
        -command {::nc::ui_table::_on_toggle_always_on_top_strict} -takefocus 0 -padx 2 -pady 0
    pack $mf.ontop -side right -padx {4 8}

    $mf.fileMenu.menu add command -label "Session Manager..." -command {::nc::ui_table::_on_session_manager}
    $mf.fileMenu.menu add separator
    $mf.fileMenu.menu add command -label "New Session..." -command {::nc::ui_table::_on_session_new}
    $mf.fileMenu.menu add command -label "Open Session..." -command {::nc::ui_table::_on_session_open}
    $mf.fileMenu.menu add command -label "Save Session" -command {::nc::ui_table::_on_session_save}
    $mf.fileMenu.menu add command -label "Save Session As..." -command {::nc::ui_table::_on_session_save_as}
    $mf.fileMenu.menu add command -label "Reveal Session Folder" -command {::nc::ui_table::_on_session_reveal}
    $mf.fileMenu.menu add separator
    $mf.fileMenu.menu add command -label "Import Tab..." -command {::nc::ui_table::_on_import}
    $mf.fileMenu.menu add command -label "Export Current Tab..." -command {::nc::ui_table::_on_export}
    $mf.fileMenu.menu add command -label "Export All..." -command {::nc::ui_table::_on_export_all}
    $mf.fileMenu.menu add command -label "Export Material Report..." -command {::nc::ui_table::_on_export_report}
    $mf.fileMenu.menu add command -label "Export Settings..." -command {::nc::ui_table::_open_export_settings_dialog}

    $mf.editMenu.menu add command -label "Reload" -command {::nc::ui_table::_on_scan}
    $mf.editMenu.menu add command -label "Reset Columns" -command {::nc::ui_table::_reset_columns}
    $mf.editMenu.menu add command -label "Copy TSV" -command {::nc::ui_table::copy_selection_to_clipboard}
    $mf.editMenu.menu add separator
    $mf.editMenu.menu add command -label "New" -command {::nc::ui_table::_on_new}
    $mf.editMenu.menu add command -label "Duplicate" -command {::nc::ui_table::_on_duplicate}
    $mf.editMenu.menu add command -label "Delete" -command {::nc::ui_table::_on_delete}
    $mf.editMenu.menu add command -label "Validate" -command {::nc::ui_table::_on_validate}
    $mf.editMenu.menu add separator
    $mf.editMenu.menu add command -label "Apply Current Tab" -command {::nc::ui_table::_on_apply}
    $mf.editMenu.menu add command -label "Apply All Staged" -command {::nc::ui_table::_on_apply_all}
    $mf.editMenu.menu add separator
    $mf.editMenu.menu add command -label "Apply to HM..." -command {::nc::ui_table::_on_apply_to_hm}

    $mf.selectionMenu.menu add command -label "Find Next" -command {::nc::ui_table::_on_find_next}
    $mf.selectionMenu.menu add command -label "Clear Find" -command {::nc::ui_table::_on_search_clear}
    $mf.selectionMenu.menu add separator
    $mf.selectionMenu.menu add command -label "Label Palette..." -command {::nc::ui_table::_open_label_palette}
    $mf.selectionMenu.menu add separator
    $mf.selectionMenu.menu add command -label "Worklist..." -command {::nc::ui_table::_on_worklist}
    $mf.selectionMenu.menu add command -label "Recent New Components" -command {::nc::ui_table::_on_filter_recent_new}
    $mf.selectionMenu.menu add command -label "Clear Worklist" -command {::nc::ui_table::_on_worklist_clear}
    $mf.selectionMenu.menu add separator
    $mf.selectionMenu.menu add command -label "Select Dirty Rows" -command {::nc::ui_table::_select_dirty_rows}
    $mf.selectionMenu.menu add command -label "Clear Selection" -command {::nc::ui_table::_clear_selection}
    $mf.selectionMenu.menu add separator
    $mf.selectionMenu.menu add command -label "Isolate" -accelerator "Shift+S" -command {::nc::ui_table::_on_isolate}
    $mf.selectionMenu.menu add command -label "Pick From Viewport" -command {::nc::ui_table::_on_select_from_viewport}
    $mf.selectionMenu.menu add command -label "Find Comp" -accelerator "Shift+F" -command {::nc::ui_table::_on_find_comp}
    $mf.selectionMenu.menu add command -label "Highlight Comp" -accelerator "Shift+H" -command {::nc::ui_table::_on_highlight_comp}
    $mf.selectionMenu.menu add command -label "Invert Last Action" -accelerator "Shift+I" -command {::nc::ui_table::_on_invert_last_action}
    $mf.selectionMenu.menu add command -label "Hide Comp" -command {::nc::ui_table::_on_hide_comp}
    $mf.selectionMenu.menu add command -label "Show Comp" -command {::nc::ui_table::_on_show_comp}
    $mf.selectionMenu.menu add command -label "Reset (Transparency + Color)" -command {::nc::ui_table::_on_reset_transparency}
    $mf.selectionMenu.menu add separator
    $mf.selectionMenu.menu add command -label "Highlight Gray Color..." -command {::nc::ui_table::_on_highlight_color_pick}

    $mf.viewMenu.menu add checkbutton -label "Show Data Toolbar" -variable ::nc::ui_table::_show_data_toolbar -command {::nc::ui_table::_refresh_layout_options}
    $mf.viewMenu.menu add checkbutton -label "Show Edit Toolbar" -variable ::nc::ui_table::_show_edit_toolbar -command {::nc::ui_table::_refresh_layout_options}
    $mf.viewMenu.menu add checkbutton -label "Show Review Toolbar" -variable ::nc::ui_table::_show_review_toolbar -command {::nc::ui_table::_refresh_layout_options}
    $mf.viewMenu.menu add checkbutton -label "Show View Toolbar" -variable ::nc::ui_table::_show_view_toolbar -command {::nc::ui_table::_refresh_layout_options}
    $mf.viewMenu.menu add checkbutton -label "Show Context Filter" -variable ::nc::ui_table::_show_context_filter -command {::nc::ui_table::_refresh_layout_options}
    $mf.viewMenu.menu add checkbutton -label "Show Status Log" -variable ::nc::ui_table::_show_status_log -command {::nc::ui_table::_refresh_layout_options}
    $mf.viewMenu.menu add separator
    $mf.viewMenu.menu add checkbutton -label "Show Images Column" -variable ::nc::ui_table::_show_images_col -command {::nc::ui_table::_on_column_visibility_changed}
    $mf.viewMenu.menu add checkbutton -label "Show Notes Column" -variable ::nc::ui_table::_show_notes_col -command {::nc::ui_table::_on_column_visibility_changed}
    $mf.viewMenu.menu add checkbutton -label "Show Material Parameters (Component tab)" -variable ::nc::ui_table::_show_mat_params_col -command {::nc::ui_table::_on_column_visibility_changed}
    $mf.viewMenu.menu add checkbutton -label "Compact Rows" -variable ::nc::ui_table::_compact_rows -command {::nc::ui_table::_on_density_changed}
    $mf.viewMenu.menu add checkbutton -label "Alternate Row Color" -variable ::nc::ui_table::_alternate_rows -command {::nc::ui_table::_on_alternate_rows_changed}
    $mf.viewMenu.menu add separator
    $mf.viewMenu.menu add command -label "Load Images..." -command {::nc::ui_table::_on_load_images}
    $mf.viewMenu.menu add command -label "Capture Images" -command {::nc::ui_table::_on_capture_images}
    $mf.viewMenu.menu add command -label "Arrange View" -command {::nc::ui_table::_on_arrange}
    $mf.viewMenu.menu add command -label "Fit Columns" -command {::nc::ui_table::_on_fit_all_columns}
    $mf.viewMenu.menu add separator
    $mf.viewMenu.menu add command -label "Image Small" -command {::nc::ui_table::_set_image_size small}
    $mf.viewMenu.menu add command -label "Image Medium" -command {::nc::ui_table::_set_image_size medium}
    $mf.viewMenu.menu add command -label "Image Large" -command {::nc::ui_table::_set_image_size large}
    $mf.viewMenu.menu add separator
    $mf.viewMenu.menu add command -label "Text Smaller" -command {::nc::ui_table::_adjust_text_size -1}
    $mf.viewMenu.menu add command -label "Text Larger" -command {::nc::ui_table::_adjust_text_size 1}
}

proc ::nc::ui_table::_build_tabbar {root} {
    variable _tabbar
    variable _tab_btns
    variable _session_lbl

    set _tabbar [frame $root.tabs -bd 0 -pady 2]
    pack $_tabbar -side top -fill x -padx 4 -pady {1 1}
    set _session_lbl [label $_tabbar.session -anchor e -fg "#555555" -text "Session: preview" -width 1]
    pack $_session_lbl -side right -fill x -expand 1 -padx {8 2}
    foreach pair [_visible_tab_defs] {
        lassign $pair tab label
        set b [button $_tabbar.t_$tab -text $label -command [list ::nc::ui_table::_set_tab $tab]]
        _style_button $b quiet
        bind $b <Button-3> [list ::nc::ui_table::_show_tab_context_menu $tab %X %Y]
        set _tab_btns($tab) $b
        pack $b -side left -padx {0 2}
    }
}

proc ::nc::ui_table::_tab_label {tab} {
    foreach pair [_tab_defs] {
        if {[lindex $pair 0] eq $tab} { return [lindex $pair 1] }
    }
    return $tab
}

proc ::nc::ui_table::_column_menu_label {col_def} {
    set key [lindex $col_def 0]
    set label [lindex $col_def 1]
    if {$label eq ""} {
        return $key
    }
    return $label
}

proc ::nc::ui_table::_show_tab_context_menu {tab X Y} {
    variable _tab_context_menu
    variable _hidden_cols
    variable _column_visible_var
    set m .nc_tab_context
    catch {destroy $m}
    set _tab_context_menu [menu $m -tearoff 0]
    set label [_tab_label $tab]
    $m add command -label "Open $label" -command [list ::nc::ui_table::_set_tab $tab]
    $m add separator
    $m add command -label "Copy Tab TSV" -command [list ::nc::ui_table::_copy_tab_tsv $tab]
    $m add command -label "Export This Tab..." -command [list ::nc::ui_table::_export_tab $tab]
    $m add command -label "Reset Columns" -command [list ::nc::ui_table::_reset_columns_for_tab $tab]
    $m add separator
    $m add command -label "Show All Columns" -command [list ::nc::ui_table::_show_all_tab_columns $tab]
    $m add separator
    $m add command -label "Columns" -state disabled
    foreach col_def [_cols_for_tab $tab 1] {
        set key [lindex $col_def 0]
        set var_name ::nc::ui_table::_column_visible_var($tab,$key)
        set hidden 0
        if {[info exists _hidden_cols($tab)] && [lsearch -exact $_hidden_cols($tab) $key] >= 0} {
            set hidden 1
        }
        set _column_visible_var($tab,$key) [expr {!$hidden}]
        $m add checkbutton -label [_column_menu_label $col_def] \
            -variable $var_name \
            -command [list ::nc::ui_table::_set_tab_column_visible $tab $key]
    }
    catch {tk_popup $m $X $Y}
}

proc ::nc::ui_table::_set_tab_column_visible {tab key} {
    variable _tab
    variable _hidden_cols
    variable _column_visible_var
    set visible 1
    if {[info exists _column_visible_var($tab,$key)]} {
        set visible $_column_visible_var($tab,$key)
    }
    if {$visible} {
        set hidden {}
        if {[info exists _hidden_cols($tab)]} { set hidden $_hidden_cols($tab) }
        set idx [lsearch -exact $hidden $key]
        if {$idx >= 0} { set hidden [lreplace $hidden $idx $idx] }
        set _hidden_cols($tab) $hidden
    } else {
        if {[llength [_cols_for_tab $tab]] <= 1} {
            set _column_visible_var($tab,$key) 1
            _set_status "Keep at least one visible column in [_tab_label $tab]." warn
            return
        }
        if {![info exists _hidden_cols($tab)]} { set _hidden_cols($tab) {} }
        if {[lsearch -exact $_hidden_cols($tab) $key] < 0} {
            lappend _hidden_cols($tab) $key
        }
    }
    if {$tab eq $_tab} {
        _rebuild_table_columns
        _populate_current
    }
    _save_column_layout
    set state [expr {$visible ? "shown" : "hidden"}]
    _set_status "Column '$key' $state in [_tab_label $tab] tab." ok
}

proc ::nc::ui_table::_show_all_tab_columns {tab} {
    variable _tab
    variable _hidden_cols
    catch {unset _hidden_cols($tab)}
    if {$tab eq $_tab} {
        _rebuild_table_columns
        _populate_current
    }
    _save_column_layout
    _set_status "All columns shown in [_tab_label $tab] tab." ok
}

proc ::nc::ui_table::_reset_columns_for_tab {tab} {
    variable _tab
    variable _col_order
    catch {unset _col_order($tab)}
    _set_tab $tab
    _on_arrange
    _save_column_layout
    _set_status "Column order and widths reset for [_tab_label $tab] tab." ok
}

proc ::nc::ui_table::_build_control_area {root} {
    variable _control_frame
    variable _tablebar
    variable _search_frame
    variable _display_frame
    variable _action_frame
    variable _io_frame
    variable _label_frame
    variable _prop_view_frame
    variable _pbush_frame

    set top [frame $root.topframe -bd 1 -relief groove -highlightthickness 0 -background "#efefef"]
    set _control_frame $top
    pack $top -side top -fill x -padx 4 -pady {1 3}

    # Three stacked rows: Find/Next/Clear alone; Display (Isolate/.../view
    # buttons) on its own row below that; then Data/Mass/Edit/View/Library
    # below Display - each row packed top-to-bottom in this exact order.
    set _search_frame [frame $top.find -bd 0 -background "#efefef"]
    set _display_frame [frame $top.display -bd 0 -background "#efefef"]
    set _action_frame [frame $top.actions -bd 0 -background "#efefef"]
    set _tablebar ""
    set _io_frame ""
    set _prop_view_frame [frame $top.propview -bd 0 -background "#efefef"]
    set _pbush_frame [frame $top.pbush -bd 0 -background "#efefef"]

    pack $_search_frame -side top -fill x -anchor nw
    pack $_display_frame -side top -fill x -anchor nw
    pack $_action_frame -side top -fill x -anchor nw

    _build_search_strip $_search_frame
    _build_focusbar $_display_frame
    _build_view_orientation_bar $_display_frame
    _build_iobar $_action_frame
    set _label_frame ""
    _build_action_buttons $_action_frame
    _build_tablebar $_action_frame
    _build_library_strip $_action_frame
    _build_assign_strip $_action_frame
    _build_property_view_bar $_prop_view_frame
    _build_pbush_bar $_pbush_frame
    bind $_search_frame <Configure> {::nc::ui_table::_schedule_toolbar_wrap}
    bind $_display_frame <Configure> {::nc::ui_table::_schedule_toolbar_wrap}
    bind $_action_frame <Configure> {::nc::ui_table::_schedule_toolbar_wrap}
    _refresh_layout_options
}

proc ::nc::ui_table::_build_search_strip {parent} {
    variable _search_group
    variable _pick_frame
    set f [_make_group $parent search "Find"]
    set _search_group $f
    entry $f.e -textvariable ::nc::ui_table::_search_text -width 28
    if {[llength [info commands ttk::combobox]] > 0} {
        ttk::combobox $f.mode -textvariable ::nc::ui_table::_search_mode -state readonly -width 18 \
            -values {"All Labels" "COMP. Name" "HM Comp. Name" "MAT. Type" "Property Label"}
    } else {
        entry $f.mode -textvariable ::nc::ui_table::_search_mode -width 18
    }
    pack $f.e $f.mode -side left -padx {0 4} -pady 3
    _add_button $f next "Next" {::nc::ui_table::_on_find_next} quiet
    _add_button $f clear "Clear" {::nc::ui_table::_on_search_clear} quiet
    pack $f -side left -padx {4 6} -pady {4 2}
    set _pick_frame [_make_group $parent pick "Viewport"]
    _add_button $_pick_frame pickcomp "Pick Comp" {::nc::ui_table::_on_select_from_viewport} info
    pack $_pick_frame -side left -padx {0 6} -pady {4 2}
    bind $f.e <Return> {::nc::ui_table::_on_find_next; break}
}

proc ::nc::ui_table::_build_assign_strip {parent} {
    variable _assign_frame
    variable _mat_cb
    set _assign_frame [_make_group $parent assign "Mass"]
    set _mat_cb ""
    button $_assign_frame.mass -text "Calculate Mass" -command {::nc::ui_table::_on_calculate_mass}
    _style_button $_assign_frame.mass quiet
    pack $_assign_frame.mass -side left -padx {0 4} -pady 2
}

proc ::nc::ui_table::_build_label_strip {parent} {
    variable _label_frame
    set f [_make_group $parent labels "Labels"]
    set _label_frame $f
    _add_button $f open "Labels..." {::nc::ui_table::_open_label_palette} primary
    pack $f -side left -padx {0 6} -pady {2 4}
}

proc ::nc::ui_table::_build_library_strip {parent} {
    variable _library_frame
    set f [_make_group $parent library "Library"]
    set _library_frame $f
    _add_button $f opencsv "Open CSV" {::nc::ui_table::_on_library_open_csv}
    _add_button $f import "Import CSV" {::nc::ui_table::_on_library_import_file}
    _add_button $f paste "Paste..." {::nc::ui_table::_on_library_paste}
    _add_button $f match "Match to Materials..." {::nc::ui_table::_on_library_match_dialog} primary
    pack $f -side left -padx {0 6} -pady {2 4}
}

proc ::nc::ui_table::_clear_editing_visual {{cell ""}} {
    variable _tbl
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return }
    if {$cell ne ""} {
        catch {$_tbl tag celltag "" $cell}
        return
    }
    _apply_tags
}

proc ::nc::ui_table::_build_action_buttons {parent} {
    variable _edit_frame
    set f [_make_group $parent edit "Edit"]
    set _edit_frame $f
    _add_button $f new "New" {::nc::ui_table::_on_new}
    _add_button $f dup "Duplicate" {::nc::ui_table::_on_duplicate}
    _add_button $f del "Delete" {::nc::ui_table::_on_delete} danger
    _add_button $f apply "Apply" {::nc::ui_table::_on_apply} primary
    pack $f -side left -padx {0 6} -pady {2 4}
}

proc ::nc::ui_table::_build_focusbar {parent} {
    variable _review_frame
    set f [_make_group $parent review "Display"]
    set _review_frame $f
    catch {package require Ttk}
    if {[llength [info commands ttk::checkbutton]] > 0} {
        ttk::checkbutton $f.fit -text "Fit" -variable ::nc::ui_table::_display_auto_fit -takefocus 0
    } else {
        checkbutton $f.fit -text "Fit" -variable ::nc::ui_table::_display_auto_fit -takefocus 0 -padx 2 -pady 0
    }
    pack $f.fit -side left -padx {0 6} -pady 2
    _add_button $f iso "Isolate" {::nc::ui_table::_on_isolate} info
    _add_button $f findcomp "Find Comp" {::nc::ui_table::_on_find_comp} info
    _add_button $f highlight "Highlight" {::nc::ui_table::_on_highlight_comp} info
    _add_button $f invertlast "Invert" {::nc::ui_table::_on_invert_last_action} info
    _add_button $f togglehide "Show/Hide" {::nc::ui_table::_on_toggle_hide_comp} toggle
    _add_button $f resettrans "Reset" {::nc::ui_table::_on_reset_transparency} info
    _add_button $f val "Validate" {::nc::ui_table::_on_validate} info
    # Left padding 4, matching every other row's FIRST group (Find, Data) -
    # Display is the first group on its row, so a left padding of 0 here
    # made it flush against (and visually clip into) the panel's own
    # border.
    pack $f -side left -padx {4 6} -pady {2 4}
}

# Standard plane views, split out into their own "View" bar (was previously
# folded into Display, per user request to keep them separate). Left click
# sets the named view; right click flips to the opposite side of that axis
# (Top<->Bottom, Front<->Rear, Left<->Right) - avoids doubling the button
# count for every axis pair. Iso has no opposite, so right click is a no-op
# for it.
proc ::nc::ui_table::_build_view_orientation_bar {parent} {
    variable _orientation_frame
    set f [_make_group $parent orientation "View"]
    set _orientation_frame $f
    _add_view_button $f viewtop "Top" top
    # Front button now drives *view "rightside" (newly discovered absolute
    # name, see Iso2/Iso3 sequences), right click "leftside" (explicit
    # override - not in the generic _view_opposite table).
    set _b_front [_add_view_button $f viewfront "Front" rightside]
    bind $_b_front <Button-3> [list ::nc::ui_table::_on_set_view leftside]
    # Left button now drives *view "front" (moved over from the old Front
    # button); the old "left" *view is no longer used by any button.
    _add_view_button $f viewleft "Left" front
    # Iso1: absolute *view iso1 jump on left click. Right click sets the
    # exact camera matrix directly via *viewset instead of the old "rear +
    # left x3 + down x2" nudge sequence. Captured live (not the earlier
    # computed-from-Iso2 guess, which turned out wrong - the horizontal
    # rotation trick doesn't safely generalize here) and rounded to clean
    # values.
    set _b_iso1 [_add_view_button $f viewiso "Iso1" iso1]
    bind $_b_iso1 <Button-3> [list ::nc::ui_table::_on_set_view_matrix \
        {-0.707106781 -0.353553391 0.612372436 0 0.707106781 -0.353553391 0.612372436 0 0 0.866025404 0.5 0 0 0 0 1 -556.227034 -389.465819 1061.3606 595.674596}]
    # Iso2 (renamed from the old "Iso3" button, same target angle): left
    # click now sets the exact camera matrix directly via *viewset (a real
    # command discovered in HM's own command1.tcl recording) instead of the
    # old "rightside + left x3 + down x2" nudge sequence - user confirmed
    # live this jumps instantly, no animation, same resulting angle. Right
    # click still uses the old nudge sequence (its matrix hasn't been
    # captured yet).
    _add_view_button_matrix $f viewiso2 "Iso2" \
        {-0.707106781 0.353553391 -0.612372436 0 -0.707106781 -0.353553391 0.612372436 0 -3.60877994e-12 0.866025404 0.5 0 -141.057296 80.8288323 0 1 -670.158415 -278.611645 197.670806 615.950281} \
        {rear right right right down down}
    # Iso3: recorded sequence - *view iso1, then up x3. Right click plays
    # the recorded inverse: *view iso1, then left x12.
    _add_view_button_seq $f viewiso3 "Iso3" {iso1 up up up} \
        {iso1 left left left left left left left left left left left left}
    pack $f -side left -padx {0 6} -pady {2 4}
}

proc ::nc::ui_table::_add_view_button {parent name text view} {
    set b [_add_button $parent $name $text [list ::nc::ui_table::_on_set_view $view] info]
    bind $b <Button-3> [list ::nc::ui_table::_on_set_view [::nc::ui_table::_view_opposite $view]]
    return $b
}

# Like _add_view_button, but drives the view via a recorded sequence of
# *view calls (relative nudges) instead of a single named preset. If
# opposite_views is given (a recorded inverse sequence), right click plays
# that instead - same left=set/right=opposite pattern as _add_view_button.
proc ::nc::ui_table::_add_view_button_seq {parent name text views {opposite_views {}}} {
    set b [_add_button $parent $name $text [list ::nc::ui_table::_on_set_view_sequence $views] info]
    if {[llength $opposite_views] > 0} {
        bind $b <Button-3> [list ::nc::ui_table::_on_set_view_sequence $opposite_views]
    }
    return $b
}

# Like _add_view_button_seq, but the primary (left click) view is a raw
# *viewset camera matrix (20 numbers, captured live from HM's own command
# recording - see _on_set_view_matrix) instead of a nudge sequence, so it
# jumps instantly with no animation. opposite_views (if given) is still a
# nudge sequence for the right-click, since its matrix hasn't been
# captured yet - swap it for _add_view_button_matrix-style opposite once
# it has.
proc ::nc::ui_table::_add_view_button_matrix {parent name text matrix {opposite_views {}}} {
    set b [_add_button $parent $name $text [list ::nc::ui_table::_on_set_view_matrix $matrix] info]
    if {[llength $opposite_views] > 0} {
        bind $b <Button-3> [list ::nc::ui_table::_on_set_view_sequence $opposite_views]
    }
    return $b
}

proc ::nc::ui_table::_view_opposite {view} {
    switch -- $view {
        top {return "bottom"}
        bottom {return "top"}
        front {return "rear"}
        rear {return "front"}
        left {return "right"}
        right {return "left"}
        default {return $view}
    }
}

proc ::nc::ui_table::_fit_hm_window_if_enabled {} {
    variable _display_auto_fit
    if {!$_display_auto_fit} { return }
    catch {*window 0 0 0 0 0}
}

# Sets a standard plane view. Confirmed real command in the CAE tool's own
# view/capture API reference:
#   *view "iso1"|"top"|"bottom"|"front"|"rear"|"left"|"right"
# No "already there" skip here (unlike _on_set_view_sequence): these are
# absolute jumps, always correct to re-run even if the tracked state thinks
# we're already there (e.g. after the user manually rotated with the mouse
# in HM, which this code has no way to detect).
proc ::nc::ui_table::_on_set_view {view} {
    variable _current_named_view
    if {[llength [info commands *view]] == 0} {
        _set_status "the CAE tool view command is not available in this session." warn
        return
    }
    set rc [catch {
        *view $view
        _fit_hm_window_if_enabled
    } err]
    if {$rc} {
        _set_status "Set view '$view' failed: $err" error
        return
    }
    set _current_named_view $view
    _set_status "View: $view" ok
}

# Drives the view through a recorded sequence of *view calls (captured live
# from HM after manually rotating to the desired angle - see Iso2 button).
# Each call after the first nudges the current orientation rather than
# jumping to an absolute preset, so order matters and the whole sequence
# must run before fitting the window. *redrawblock suppresses the screen
# update for each intermediate step (verified command, see
# reference-hm-optimization-patterns memory) so the viewport jumps straight
# to the final angle instead of visibly stepping through the rotation.
# The joined view list itself is used as the identity of the resulting
# view (two calls with the same list land on the same angle) - if already
# there, skip re-running the whole nudge sequence (and its animation).
proc ::nc::ui_table::_on_set_view_sequence {views} {
    variable _current_named_view
    set id [join $views "_"]
    if {$_current_named_view eq $id} {
        _set_status "Already at view: [join $views { -> }]" ok
        return
    }
    if {[llength [info commands *view]] == 0} {
        _set_status "the CAE tool view command is not available in this session." warn
        return
    }
    catch { *redrawblock 1 }
    set rc [catch {
        foreach v $views {
            *view $v
        }
        _fit_hm_window_if_enabled
    } err]
    catch { *redrawblock 0 }
    if {$rc} {
        _set_status "Set view sequence '$views' failed: $err" error
        return
    }
    set _current_named_view $id
    _set_status "View: [join $views { -> }]" ok
}

# Sets the exact camera state in one shot via *viewset (20 numbers: 4x4
# affine matrix in row-major order with translation in row 4, then eye
# X/Y/Z + zoom distance) instead of a chain of relative *view nudges.
# Discovered as a real command in HM's own command1.tcl recording (logged
# after both manual rotate and after *window fit) - confirmed live by the
# user to jump instantly with no animation, unlike the nudge sequences.
# Skips re-running if already at this exact matrix, same as
# _on_set_view_sequence (matrix list itself is the identity/id).
proc ::nc::ui_table::_on_set_view_matrix {matrix} {
    variable _current_named_view
    set id [join $matrix "_"]
    if {$_current_named_view eq $id} {
        _set_status "Already at this view." ok
        return
    }
    if {[llength [info commands *viewset]] == 0} {
        _set_status "the CAE tool viewset command is not available in this session." warn
        return
    }
    set rc [catch {
        *viewset {*}$matrix
        _fit_hm_window_if_enabled
    } err]
    if {$rc} {
        _set_status "Set view matrix failed: $err" error
        return
    }
    set _current_named_view $id
    _set_status "View: (exact camera state)" ok
}

proc ::nc::ui_table::_build_tablebar {parent} {
    variable _tablebar
    variable _view_frame
    # Renamed "View" -> "Image" so it doesn't collide with the plane-view
    # orientation bar (also called "View"). Arrange/S/M/L/A-/A+ were
    # dropped from the toolbar entirely (not just moved) - they duplicate
    # existing View-menu entries ("Arrange View", "Image Small/Medium/
    # Large", "Text Smaller/Larger"), so only Load/Capture Images remain
    # here as toolbar buttons.
    set f [_make_group $parent view "Image"]
    set _tablebar $f
    set _view_frame $f
    _add_button $f loadimg "Load" {::nc::ui_table::_on_load_images}
    _add_button $f capture "Capture Images" {::nc::ui_table::_on_capture_images}
    pack $f -side left -padx {0 6} -pady {2 4}
}

proc ::nc::ui_table::_build_iobar {parent} {
    variable _io_frame
    set f [_make_group $parent data "Data"]
    set _io_frame $f
    _add_button $f reload "Reload" {::nc::ui_table::_on_scan}
    _add_button $f import "Import" {::nc::ui_table::_on_import}
    _add_button $f export "Export" {::nc::ui_table::_on_export}
    # Only one CSV button per non-Library tab: opens the folder holding the
    # tab's edits/exports so the user can pick and open whichever file they
    # want. The old direct-open-active-CSV button was ambiguous (opened the
    # combined snapshot regardless of which tab was on screen) and per user
    # request has been removed - the folder-open button now covers both.
    _add_button $f opencsvfolder "Open CSV" {::nc::ui_table::_on_open_csv_folder} quiet
    _add_button $f copy "Copy" {::nc::ui_table::copy_selection_to_clipboard} quiet
    pack $f -side left -padx {4 6} -pady {2 4}
}

proc ::nc::ui_table::_build_property_view_bar {parent} {
    variable _prop_view_btns
    set f [_make_group $parent filter "Property"]
    foreach view {ALL PSHELL PSOLID PBUSH} {
        set b [button $f.[string tolower $view] -text $view -command [list ::nc::ui_table::_set_property_view $view]]
        _style_button $b quiet
        set _prop_view_btns($view) $b
        pack $b -side left -padx {0 3} -pady 2
    }
    pack $f -side left -padx {4 6} -pady {0 4}
}

proc ::nc::ui_table::_build_pbush_bar {parent} {
    variable _pbush_line_vars
    set f [_make_group $parent lines "PBUSH"]
    foreach line {K B GE M} {
        set _pbush_line_vars($line) 1
        checkbutton $f.[string tolower $line] -text $line -variable ::nc::ui_table::_pbush_line_vars($line) \
            -command {::nc::ui_table::_on_pbush_toggle} -takefocus 0 -padx 2 -pady 0
        pack $f.[string tolower $line] -side left -padx {0 8}
    }
    pack $f -side left -padx {4 6} -pady {0 4}
}

proc ::nc::ui_table::_build_table_frame {root} {
    variable _tbl
    variable _tableframe
    variable _tab
    variable _header_indicator

    set tf [frame $root.tableframe -bd 1 -relief groove -background "#d0d0d0"]
    set _tableframe $tf
    pack $tf -side top -fill both -expand 1 -padx 4 -pady {2 0}
    set _tbl [table $tf.t \
        -variable ::nc::ui_table::tableData \
        -titlerows 1 \
        -titlecols 0 \
        -rows 1 \
        -height 20 \
        -cols [_ncols_for_tab $_tab] \
        -state disabled \
        -selecttype cell \
        -selectmode extended \
        -resizeborders both \
        -relief solid \
        -bd 1 \
        -highlightthickness 0 \
        -font {Arial 9} \
        -background "#ffffff" \
        -foreground black \
        -xscrollcommand [list $tf.sx set] \
        -yscrollcommand [list $tf.sy set]]
    scrollbar $tf.sy -orient v -command [list $_tbl yview]
    scrollbar $tf.sx -orient h -command [list $_tbl xview]
    set _header_indicator [frame $tf.headerDrop -background "#1f6fb2" -bd 0 -highlightthickness 0]
    place forget $_header_indicator
    grid $_tbl -row 0 -column 0 -sticky nsew
    grid $tf.sy -row 0 -column 1 -sticky ns
    grid $tf.sx -row 1 -column 0 -sticky ew
    grid columnconfigure $tf 0 -weight 1
    grid rowconfigure $tf 0 -weight 1

    catch {$_tbl configure -borderwidth 1}
    catch {$_tbl configure -highlightcolor "#7da7d9"}
    catch {$_tbl configure -highlightbackground "#d0d0d0"}
    catch {$_tbl configure -colstretchmode none}
    catch {$_tbl configure -rowstretchmode none}
    catch {$_tbl configure -drawmode fast}
    catch {$_tbl tag configure tag_cell -background "#ffffff" -foreground "#111111" -relief ridge -borderwidth 1}
    catch {$_tbl tag configure tag_alt -background "#f7f7f7" -foreground "#111111" -relief ridge -borderwidth 1}
    catch {$_tbl tag configure tag_header -background "#666666" -foreground "#ffffff" -font [_ui_header_font] -relief raised -borderwidth 2}
    catch {$_tbl tag configure tag_header_drag -background "#4f6f93" -foreground "#ffffff" -font [_ui_header_font] -relief sunken -borderwidth 2}
    catch {$_tbl tag configure tag_case2_prop -background "#fff4c7" -foreground "#4a3a00" -relief ridge -borderwidth 1}
    catch {$_tbl tag configure tag_shared_prop -background "#ffd6d6" -foreground "#8b0000" -relief ridge -borderwidth 1}
    catch {$_tbl tag configure tag_case3_mat -background "#eeeeee" -foreground "#555555" -relief ridge -borderwidth 1}
    catch {$_tbl tag configure tag_editing -background "#ffffff" -foreground "#111111" -relief sunken -borderwidth 1}
    catch {$_tbl tag configure tag_dirty -background "#fff0b8" -foreground "#3f3100" -relief ridge -borderwidth 1}
    catch {$_tbl tag configure tag_disabled -background "#d6d6d6" -foreground "#666666" -relief ridge -borderwidth 1}
    catch {$_tbl tag configure sel -background "#dceafa" -foreground "#111111" -relief ridge -borderwidth 1}
    catch {$_tbl tag configure active -background "#e8f1fb" -foreground "#111111" -relief ridge -borderwidth 1}

    bind $_tbl <Control-c> {::nc::ui_table::copy_selection_to_clipboard; break}
    bind $_tbl <Control-C> {::nc::ui_table::copy_selection_to_clipboard; break}
    bind $_tbl <<Copy>> {::nc::ui_table::copy_selection_to_clipboard; break}
    bind $_tbl <Control-v> {::nc::ui_table::_paste_clipboard; break}
    bind $_tbl <Control-V> {::nc::ui_table::_paste_clipboard; break}
    bind $_tbl <<Paste>> {::nc::ui_table::_paste_clipboard; break}
    bind $_tbl <ButtonPress-1> {::nc::ui_table::_on_header_press %x %y}
    bind $_tbl <B1-Motion> {::nc::ui_table::_on_header_motion %x %y}
    bind $_tbl <ButtonRelease-1> {::nc::ui_table::_on_header_release %x %y}
    bind $_tbl <Double-ButtonPress-1> {::nc::ui_table::_on_double_click %x %y; break}
    bind $_tbl <Button-3> {::nc::ui_table::_show_context_menu %X %Y; break}
    bind $_tbl <Shift-S> {::nc::ui_table::_on_isolate; break}
    bind $_tbl <Shift-F> {::nc::ui_table::_on_find_comp; break}
    bind $_tbl <Shift-H> {::nc::ui_table::_on_highlight_comp; break}
    bind $_tbl <Shift-I> {::nc::ui_table::_on_invert_last_action; break}
    bind $_tbl <Return> {::nc::ui_table::_on_edit_commit; break}
    bind $_tbl <KP_Enter> {::nc::ui_table::_on_edit_commit; break}
    bind $_tbl <Escape> {::nc::ui_table::_on_edit_cancel; break}
    bind $_tbl <Left> {::nc::ui_table::_on_edit_arrow Left}
    bind $_tbl <Right> {::nc::ui_table::_on_edit_arrow Right}
    bind $_tbl <MouseWheel> {::nc::ui_table::_on_table_mousewheel %D; break}
    bind $_tbl <Button-4> {::nc::ui_table::_on_table_mousewheel 120; break}
    bind $_tbl <Button-5> {::nc::ui_table::_on_table_mousewheel -120; break}
    bind $_tbl <Enter> {catch {focus %W}}
    _rebuild_table_columns
    _apply_density
}

proc ::nc::ui_table::_on_table_mousewheel {delta} {
    variable _tbl
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return -code break }
    if {$delta > 0} {
        catch {$_tbl yview scroll -3 units}
    } elseif {$delta < 0} {
        catch {$_tbl yview scroll 3 units}
    }
    return -code break
}

proc ::nc::ui_table::_build_log_panel {root} {
    variable _log_w
    variable _status_lbl
    variable _status_frame
    variable _log_frame
    variable _log_grip
    set status [frame $root.status -bd 0 -highlightthickness 0]
    set _status_frame $status
    set _status_lbl [label $status.lbl -anchor w -fg "#555555" -text "" -width 1]
    pack $_status_lbl -side left -fill x -expand 1 -padx 6 -pady {0 2}

    # Drag grip above the log - lets the user resize it (drag up/down) by
    # changing the text widget's -height in lines, since it's packed
    # -side top rather than -fill both/expand (a fixed strip at the bottom).
    set grip [frame $root.loggrip -height 5 -bd 1 -relief raised -cursor sb_v_double_arrow -background "#c8c8c8"]
    set _log_grip $grip
    bind $grip <ButtonPress-1> {::nc::ui_table::_on_log_resize_start %Y}
    bind $grip <B1-Motion> {::nc::ui_table::_on_log_resize_drag %Y}

    set lf [frame $root.log -bd 1 -relief sunken]
    set _log_frame $lf

    # Packed with -side bottom, and BEFORE the table frame is built/packed
    # (see _build_window), so this strip always reserves its own space from
    # the bottom of the window first - the table (packed -side top -fill
    # both -expand 1 afterwards) only gets whatever is left and shrinks/
    # scrolls itself instead of squeezing the log off-window when a tab's
    # toolbars grow taller (e.g. the Component tab, which shows more toolbar
    # groups than other tabs).
    pack $lf -side bottom -fill x -padx 4 -pady {2 4}
    pack $grip -side bottom -fill x -padx 4
    pack $status -side bottom -fill x -padx 4 -pady {0 1}

    frame $lf.bar -bd 0
    pack $lf.bar -side top -fill x
    label $lf.bar.lbl -text "Log" -anchor w -fg "#555555" -font {Arial 8}
    button $lf.bar.clear -text "Clear" -command {::nc::mutations::log_clear}
    _style_button $lf.bar.clear quiet
    pack $lf.bar.lbl -side left -padx {4 0}
    pack $lf.bar.clear -side right -padx 2 -pady 1

    set _log_w [text $lf.t -height 4 -font {Courier 8} -state disabled -wrap none \
        -background "#f8f8f8" -foreground "#333" -yscrollcommand [list $lf.sy set]]
    scrollbar $lf.sy -orient v -command [list $_log_w yview]
    pack $lf.sy -side right -fill y
    pack $_log_w -side left -fill both -expand 1
}

proc ::nc::ui_table::_on_log_resize_start {rooty} {
    variable _log_resize_start_y
    variable _log_resize_start_height
    variable _log_w
    set _log_resize_start_y $rooty
    set _log_resize_start_height 4
    if {$_log_w ne "" && [winfo exists $_log_w]} {
        catch {set _log_resize_start_height [$_log_w cget -height]}
    }
}

proc ::nc::ui_table::_on_log_resize_drag {rooty} {
    variable _log_resize_start_y
    variable _log_resize_start_height
    variable _log_w
    if {$_log_w eq "" || ![winfo exists $_log_w]} { return }
    set line_h 12
    catch {set line_h [font metrics {Courier 8} -linespace]}
    if {$line_h <= 0} { set line_h 12 }
    # Dragging the grip UP (rooty decreases) should grow the log area.
    set dy [expr {$_log_resize_start_y - $rooty}]
    set delta_lines [expr {int(round(double($dy) / $line_h))}]
    set new_h [expr {$_log_resize_start_height + $delta_lines}]
    if {$new_h < 2} { set new_h 2 }
    if {$new_h > 40} { set new_h 40 }
    catch {$_log_w configure -height $new_h}
}

# =============================================================================
# Tab / toolbar state
# =============================================================================

proc ::nc::ui_table::_set_tab {tab} {
    variable _tab
    variable _sort_col
    variable _sort_dir
    variable _tab_sort_col
    variable _tab_sort_dir
    variable _tbl
    if {$tab eq $_tab} return
    # Finalize any in-progress inline edit BEFORE switching. If we don't, the
    # embedded edit entry widget stays parked at its Tktable cell coordinate
    # and overlays the same-coordinate cell of the newly shown tab - which is
    # why typing (uncommitted) in a Library cell appeared to corrupt the ID
    # column of Materials/Properties/Component (same cell coord, different
    # tab). Committing here stages the value into the CURRENT tab's data
    # (correct, since _tab hasn't changed yet), then removes the widget.
    # Done explicitly rather than relying on <FocusOut> because Tk focus
    # events are unreliable in HM's embedded Tcl (see reference-hm-tk-event
    # pitfalls).
    _finalize_active_edit
    set _tab_sort_col($_tab) $_sort_col
    set _tab_sort_dir($_tab) $_sort_dir
    set _tab $tab
    set _sort_col [expr {[info exists _tab_sort_col($tab)] ? $_tab_sort_col($tab) : 0}]
    set _sort_dir [expr {[info exists _tab_sort_dir($tab)] ? $_tab_sort_dir($tab) : "incr"}]
    if {![string is integer -strict $_sort_col]} { set _sort_col 0 }
    if {[lsearch -exact {incr decr} $_sort_dir] < 0} { set _sort_dir incr }
    # A tab switch is a different table/dataset, not a continuation of the
    # previous selection - clear it so a cell doesn't look "still selected"
    # (or still active) in a tab where the user never clicked anything.
    if {$_tbl ne "" && [winfo exists $_tbl]} {
        catch {$_tbl selection clear all}
        catch {$_tbl activate origin}
    }
    if {$tab eq "library"} { _ensure_library_default }
    _rebuild_table_columns
    _populate_current
    _update_tab_buttons
    _update_toolbar_for_tab
}

proc ::nc::ui_table::_update_tab_buttons {} {
    variable _tab
    variable _tab_btns
    foreach pair [_tab_defs] {
        set tab [lindex $pair 0]
        if {![info exists _tab_btns($tab)] || ![winfo exists $_tab_btns($tab)]} continue
        if {$tab eq $_tab} {
            catch {$_tab_btns($tab) configure -relief sunken -background "#ffffff" -activebackground "#ffffff"}
        } else {
            catch {$_tab_btns($tab) configure -relief raised -background "#ededed" -activebackground "#e2e2e2"}
        }
    }
}

proc ::nc::ui_table::_toolbar_visible_groups {groups} {
    set out {}
    foreach g $groups {
        if {$g ne "" && [winfo exists $g]} { lappend out $g }
    }
    return $out
}

proc ::nc::ui_table::_wrap_toolbar_groups {parent groups} {
    if {$parent eq "" || ![winfo exists $parent]} { return }
    set groups [_toolbar_visible_groups $groups]
    foreach g $groups {
        catch {pack forget $g}
        catch {grid forget $g}
    }
    if {[llength $groups] == 0} { return }
    catch {update idletasks}
    set avail [winfo width $parent]
    if {$avail <= 1} { set avail [winfo reqwidth $parent] }
    if {$avail <= 1} { set avail 99999 }
    set row 0
    set col 0
    set used 0
    foreach g $groups {
        set req [winfo reqwidth $g]
        set pad_left [expr {$col == 0 ? 4 : 0}]
        set pad_right 6
        set need [expr {$req + $pad_left + $pad_right}]
        if {$col > 0 && ($used + $need) > $avail} {
            incr row
            set col 0
            set used 0
            set pad_left 4
            set need [expr {$req + $pad_left + $pad_right}]
        }
        grid $g -row $row -column $col -sticky w -padx [list $pad_left $pad_right] -pady {2 4}
        incr col
        incr used $need
    }
    grid columnconfigure $parent $col -weight 1
}

proc ::nc::ui_table::_schedule_toolbar_wrap {} {
    variable _toolbar_wrap_after
    if {$_toolbar_wrap_after ne ""} { return }
    set _toolbar_wrap_after [after idle {::nc::ui_table::_wrap_visible_toolbars}]
}

proc ::nc::ui_table::_wrap_visible_toolbars {} {
    variable _toolbar_wrap_after
    variable _toolbar_wrapping
    set _toolbar_wrap_after ""
    if {$_toolbar_wrapping} { return }
    set _toolbar_wrapping 1
    catch {_update_toolbar_for_tab}
    set _toolbar_wrapping 0
}

proc ::nc::ui_table::_update_toolbar_for_tab {} {
    variable _tab
    variable _search_frame
    variable _search_group
    variable _pick_frame
    variable _assign_frame
    variable _io_frame
    variable _label_frame
    variable _edit_frame
    variable _review_frame
    variable _orientation_frame
    variable _display_frame
    variable _action_frame
    variable _view_frame
    variable _library_frame
    variable _prop_view_frame
    variable _pbush_frame
    variable _property_view
    variable _show_data_toolbar
    variable _show_edit_toolbar
    variable _show_review_toolbar
    variable _show_view_toolbar
    variable _show_context_filter

    foreach f [list $_search_group $_pick_frame $_assign_frame $_io_frame $_label_frame $_edit_frame $_review_frame $_orientation_frame $_view_frame $_library_frame $_prop_view_frame $_pbush_frame] {
        if {$f ne "" && [winfo exists $f]} {
            catch {pack forget $f}
            catch {grid forget $f}
        }
    }

    _wrap_toolbar_groups $_search_frame [list $_search_group $_pick_frame]

    if {$_tab eq "library"} {
        # Material Library is a standalone reference dataset, not part of
        # the HM model - none of the model-facing toolbars (Isolate, Find
        # Comp, Highlight, Apply, Calculate Mass, ...) apply to it. Display
        # and View (both live in _display_frame) have nothing to show here,
        # so hide the whole row instead of leaving an empty blank bar.
        if {$_display_frame ne "" && [winfo exists $_display_frame]} {
            catch {pack forget $_display_frame}
        }
        if {$_library_frame ne "" && [winfo exists $_library_frame]} {
            _wrap_toolbar_groups $_action_frame [list $_library_frame]
        }
        _update_property_view_buttons
        return
    }

    # Restore the Display/View row (in case a previous Material Library
    # visit hid it) - packed -before the Data/Edit/... row to keep the
    # Find/Display/Data top-to-bottom order regardless of forget history.
    if {$_display_frame ne "" && [winfo exists $_display_frame]} {
        if {$_action_frame ne "" && [winfo exists $_action_frame]} {
            catch {pack $_display_frame -before $_action_frame -side top -fill x -anchor nw}
        } else {
            catch {pack $_display_frame -side top -fill x -anchor nw}
        }
    }

    set action_groups {}
    if {$_show_data_toolbar && $_io_frame ne "" && [winfo exists $_io_frame]} {
        lappend action_groups $_io_frame
    }
    if {$_show_edit_toolbar && $_label_frame ne "" && [winfo exists $_label_frame] && $_tab in {general component materials}} {
        lappend action_groups $_label_frame
    }
    if {$_show_edit_toolbar && $_edit_frame ne "" && [winfo exists $_edit_frame] && $_tab in {component properties materials}} {
        _configure_edit_group_for_tab
        lappend action_groups $_edit_frame
    }

    set display_groups {}
    if {$_show_review_toolbar && $_review_frame ne "" && [winfo exists $_review_frame]} {
        lappend display_groups $_review_frame
    }
    if {$_show_review_toolbar && $_orientation_frame ne "" && [winfo exists $_orientation_frame]} {
        lappend display_groups $_orientation_frame
    }

    if {$_show_view_toolbar && $_view_frame ne "" && [winfo exists $_view_frame] && $_tab in {general component}} {
        lappend action_groups $_view_frame
    }
    # Mass packs last on this row, after Data/Edit/Image/Library - per user
    # request to push it to the end of the row instead of leading it.
    if {$_show_edit_toolbar && $_assign_frame ne "" && [winfo exists $_assign_frame] && $_tab eq "component"} {
        lappend action_groups $_assign_frame
    }
    _wrap_toolbar_groups $_display_frame $display_groups
    _wrap_toolbar_groups $_action_frame $action_groups
    if {$_show_context_filter && $_prop_view_frame ne "" && [winfo exists $_prop_view_frame] && $_tab eq "properties"} {
        catch {pack $_prop_view_frame -side top -fill x -anchor nw}
    }
    if {$_show_context_filter && $_pbush_frame ne "" && [winfo exists $_pbush_frame] && $_tab eq "properties" && $_property_view in {ALL PBUSH}} {
        catch {pack $_pbush_frame -side top -fill x -anchor nw}
    }
    _update_property_view_buttons
}

proc ::nc::ui_table::_configure_edit_group_for_tab {} {
    variable _tab
    variable _edit_frame
    if {$_edit_frame eq "" || ![winfo exists $_edit_frame]} return
    foreach name {new dup del apply} {
        set b $_edit_frame.$name
        if {[winfo exists $b]} { catch {pack forget $b} }
    }
    switch -- $_tab {
        component {
            if {[winfo exists $_edit_frame.apply]} {
                catch {pack $_edit_frame.apply -side left -padx {0 3} -pady 2}
            }
        }
        properties -
        materials {
            foreach name {new dup del apply} {
                set b $_edit_frame.$name
                if {[winfo exists $b]} { catch {pack $b -side left -padx {0 3} -pady 2} }
            }
        }
    }
}

proc ::nc::ui_table::_refresh_layout_options {} {
    variable _search_frame
    variable _display_frame
    variable _action_frame
    variable _prop_view_frame
    variable _pbush_frame
    variable _status_frame
    variable _log_frame
    variable _log_grip
    variable _show_data_toolbar
    variable _show_edit_toolbar
    variable _show_review_toolbar
    variable _show_view_toolbar
    variable _show_context_filter
    variable _show_status_log

    foreach f [list $_search_frame $_display_frame $_action_frame $_prop_view_frame $_pbush_frame] {
        if {$f ne "" && [winfo exists $f]} { catch {pack forget $f} }
    }
    if {$_show_review_toolbar && $_search_frame ne "" && [winfo exists $_search_frame]} {
        catch {pack $_search_frame -side top -fill x -anchor nw}
    }
    if {$_show_review_toolbar && $_display_frame ne "" && [winfo exists $_display_frame]} {
        catch {pack $_display_frame -side top -fill x -anchor nw}
    }
    if {($_show_data_toolbar || $_show_edit_toolbar || $_show_review_toolbar || $_show_view_toolbar) && $_action_frame ne "" && [winfo exists $_action_frame]} {
        catch {pack $_action_frame -side top -fill x -anchor nw}
    }
    _update_toolbar_for_tab

    foreach f [list $_status_frame $_log_grip $_log_frame] {
        if {$f ne "" && [winfo exists $f]} { catch {pack forget $f} }
    }
    if {$_show_status_log} {
        # Pack from the bottom, log frame first, so this strip's space is
        # reserved before the table frame's -expand 1 claims the remainder
        # (see _build_log_panel for why the order/side matters here).
        if {$_log_frame ne "" && [winfo exists $_log_frame]} {
            catch {pack $_log_frame -side bottom -fill x -padx 4 -pady {2 4}}
        }
        if {$_log_grip ne "" && [winfo exists $_log_grip]} {
            catch {pack $_log_grip -side bottom -fill x -padx 4}
        }
        if {$_status_frame ne "" && [winfo exists $_status_frame]} {
            catch {pack $_status_frame -side bottom -fill x -padx 4 -pady {0 1}}
        }
    }

    # Re-forgetting/re-packing the log strip above moves it to the end of
    # the master's slave order, which would put it AFTER the table frame
    # again (undoing the fix in _build_window) the first time any View menu
    # toolbar toggle runs this proc. Re-pack the table frame last so it goes
    # back to being the final slave and only claims leftover cavity space.
    variable _tableframe
    if {$_tableframe ne "" && [winfo exists $_tableframe]} {
        catch {pack forget $_tableframe}
        catch {pack $_tableframe -side top -fill both -expand 1 -padx 4 -pady {2 0}}
    }
}

proc ::nc::ui_table::_on_column_visibility_changed {} {
    _rebuild_table_columns
    _populate_current
    _set_status "Column visibility updated." ok
}

proc ::nc::ui_table::_on_density_changed {} {
    _apply_density
    _set_status "Row density updated." ok
}

proc ::nc::ui_table::_on_alternate_rows_changed {} {
    _apply_tags
    variable _tbl
    if {$_tbl ne "" && [winfo exists $_tbl]} { catch {$_tbl reread} }
    _set_status "Alternate row color updated." ok
}

proc ::nc::ui_table::_ui_font {} {
    variable _ui_font_size
    return [list Arial $_ui_font_size]
}

proc ::nc::ui_table::_ui_header_font {} {
    variable _ui_font_size
    return [list Arial $_ui_font_size bold]
}

proc ::nc::ui_table::_apply_table_fonts {} {
    variable _tbl
    variable _header_widgets
    variable _log_w
    variable _status_lbl
    if {$_tbl ne "" && [winfo exists $_tbl]} {
        catch {$_tbl configure -font [_ui_font]}
        catch {$_tbl tag configure tag_header -font [_ui_header_font]}
        catch {$_tbl tag configure tag_header_drag -font [_ui_header_font]}
    }
    foreach w $_header_widgets {
        if {[winfo exists $w]} { catch {$w configure -font [_ui_header_font]} }
    }
    if {$_log_w ne "" && [winfo exists $_log_w]} {
        catch {$_log_w configure -font [list Courier [expr {[lindex [_ui_font] 1] - 1}]]}
    }
    if {$_status_lbl ne "" && [winfo exists $_status_lbl]} {
        catch {$_status_lbl configure -font [_ui_font]}
    }
}

proc ::nc::ui_table::_apply_density {} {
    variable _tbl
    variable _compact_rows
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    _apply_table_fonts
    if {$_compact_rows} {
        catch {$_tbl height all 1}
    } else {
        catch {$_tbl height all 2}
    }
    catch {$_tbl reread}
}

proc ::nc::ui_table::_update_property_view_buttons {} {
    variable _property_view
    variable _prop_view_btns
    foreach view {ALL PSHELL PSOLID PBUSH} {
        if {![info exists _prop_view_btns($view)] || ![winfo exists $_prop_view_btns($view)]} continue
        if {$view eq $_property_view} {
            catch {$_prop_view_btns($view) configure -relief sunken -background "#ffffff"}
        } else {
            catch {$_prop_view_btns($view) configure -relief raised -background "#eeeeee"}
        }
    }
}

proc ::nc::ui_table::_set_property_view {view} {
    variable _property_view
    set _property_view $view
    _rebuild_table_columns
    _populate_current
    _update_toolbar_for_tab
    _set_status "Property view: $view" ok
}

proc ::nc::ui_table::_on_pbush_toggle {} {
    _rebuild_table_columns
    _populate_current
    _set_status "PBUSH line view updated." ok
}

# =============================================================================
# Table fill / filtering / sorting
# =============================================================================

proc ::nc::ui_table::_cell_value {tab row key} {
    set ct [_dict_get $row case_type 1]
    if {$tab eq "properties" && ![_property_field_applicable $row $key]} {
        return ""
    }
    if {[dict exists $row _pending_values $key]} {
        return [dict get $row _pending_values $key]
    }
    # COMP. Name/MAT. Type (below) are pure user-defined fields - no fallback
    # to label/comp_name/material_label/mat_name (the HM-sourced names). This
    # is what the table cell shows AND what gets written to CSV on export, so
    # a fallback here would silently bake the HM name into "COMP. Name" on
    # save, making it look auto-filled after reload.
    switch -- $key {
        image_path {
            set path [_dict_get $row image_path]
            if {$path eq ""} { return "" }
            return [file tail $path]
        }
        hm_comp_name { return [_dict_get $row hm_comp_name [_dict_get $row comp_name]] }
        comp_user_name { return [_dict_get $row comp_user_name] }
        prop_user_name { return [_dict_get $row prop_user_name [_dict_get $row prop_name]] }
        mat_user_name { return [_dict_get $row mat_user_name] }
        prop_card {
            set v [_dict_get $row prop_card [_dict_get $row card]]
            if {$tab in {general component}} {
                if {$ct == 3} { return "-" }
                if {$ct == 2} { return "$v (shared)" }
            }
            return $v
        }
        prop_id {
            set v [_dict_get $row prop_id]
            if {$v eq "" || $v <= 0} { return "" }
            if {$tab in {general component}} {
                set count [_component_prop_usage_count $row]
                if {$count > 1} { return "$v (shared x$count)" }
            }
            return $v
        }
        mat_id {
            set v [_dict_get $row mat_id]
            if {$tab in {general component} && $ct == 3} { return "" }
            return [expr {$v ne "" && $v > 0 ? $v : ""}]
        }
        mass_total {
            return [_format_mass_value [_dict_get $row mass_total_raw [_dict_get $row mass_total]]]
        }
        RHO {
            return [_format_scientific_3 [_dict_get $row RHO]]
        }
        default { return [_dict_get $row $key] }
    }
}

proc ::nc::ui_table::_format_mass_value {value} {
    variable _mass_unit
    set value [string trim $value]
    if {$value eq "" || ![string is double -strict $value]} { return "" }
    set numeric [expr {double($value)}]
    if {$_mass_unit eq "kg"} {
        set numeric [expr {$numeric * 1000.0}]
    }
    return [_format_decimal_trim $numeric 3]
}

proc ::nc::ui_table::_format_decimal_trim {value {places 6}} {
    if {$value eq "" || ![string is double -strict $value]} { return "" }
    set out [format "%.${places}f" [expr {double($value)}]]
    if {[string first . $out] >= 0} {
        set out [string trimright $out 0]
        set out [string trimright $out .]
    }
    if {$out eq "" || $out eq "-"} { set out "0" }
    return $out
}

proc ::nc::ui_table::_format_scientific_3 {value} {
    if {$value eq "" || ![string is double -strict $value]} { return "" }
    set out [format "%.3e" [expr {double($value)}]]
    regsub {(\.[0-9]*?)0+e} $out {\1e} out
    regsub {\.e} $out {e} out
    return $out
}

proc ::nc::ui_table::_mass_input_to_raw {value} {
    variable _mass_unit
    set value [string trim $value]
    if {$value eq "" || ![string is double -strict $value]} { return "" }
    set raw [expr {double($value)}]
    if {$_mass_unit eq "kg"} {
        set raw [expr {$raw / 1000.0}]
    }
    return $raw
}

proc ::nc::ui_table::_mass_header_label {} {
    variable _mass_unit
    return "Mass ($_mass_unit)"
}

proc ::nc::ui_table::_row_matches_search {row} {
    variable _search_text
    variable _search_mode
    set needle [string tolower [string trim $_search_text]]
    if {$needle eq ""} { return 1 }
    switch -- $_search_mode {
        "COMP. Name" { set keys {comp_user_name label} }
        "HM Comp. Name" { set keys {hm_comp_name comp_name} }
        "MAT. Type" { set keys {mat_user_name material_label} }
        "Property Label" { set keys {prop_user_name prop_name} }
        default { set keys {comp_user_name label hm_comp_name comp_name prop_user_name prop_name mat_user_name material_label mat_name mat_label comp_id prop_id mat_id} }
    }
    foreach key $keys {
        if {[string first $needle [string tolower [_dict_get $row $key]]] >= 0} { return 1 }
    }
    return 0
}

proc ::nc::ui_table::_rows_for_display {} {
    variable _tab
    variable _tab_rows
    variable _property_view
    variable _worklist_active
    variable _worklist_labels
    variable _worklist_ids
    variable _worklist_items
    variable _worklist_col

    set src [expr {[info exists _tab_rows($_tab)] ? $_tab_rows($_tab) : {}}]
    set filtered {}
    foreach row $src {
        if {$_tab eq "properties" && $_property_view in {PSHELL PSOLID PBUSH} && [_dict_get $row prop_card [_dict_get $row card]] ne $_property_view} {
            continue
        }
        if {$_worklist_active} {
            if {$_worklist_col ne ""} {
                set match_val [_cell_value $_tab $row $_worklist_col]
                if {[lsearch -exact $_worklist_items $match_val] < 0} { continue }
            } else {
                set id_val [_dict_get $row [_tab_key_name $_tab]]
                set label_key [_worklist_label_key $_tab]
                set label_val [expr {$label_key ne "" ? [_cell_value $_tab $row $label_key] : ""}]
                if {[lsearch -exact $_worklist_labels $label_val] < 0 && [lsearch -exact $_worklist_ids $id_val] < 0} { continue }
            }
        }
        if {![_row_matches_search $row]} { continue }
        lappend filtered $row
    }
    # Sorting is a one-time action applied directly to _tab_rows by
    # _sort_by_column (like Excel's Sort) - display just shows the current
    # row order, it doesn't keep re-sorting on every populate. See
    # _sort_tab_rows_once. The one exception is an active worklist: its
    # matches are re-ordered to follow the order the values were typed into
    # the Worklist dialog, not the table's native row order - a stable sort
    # (lsort's default) keeps rows tied to the same worklist entry (e.g.
    # several rows sharing one value) in their original relative order.
    if {$_worklist_active && [llength $_worklist_items] > 0} {
        set label_key [_worklist_label_key $_tab]
        set decorated {}
        foreach row $filtered {
            if {$_worklist_col ne ""} {
                set idx [lsearch -exact $_worklist_items [_cell_value $_tab $row $_worklist_col]]
            } else {
                set id_val [_dict_get $row [_tab_key_name $_tab]]
                set label_val [expr {$label_key ne "" ? [_cell_value $_tab $row $label_key] : ""}]
                set idx [lsearch -exact $_worklist_items $id_val]
                if {$idx < 0 && $label_val ne ""} { set idx [lsearch -exact $_worklist_items $label_val] }
            }
            if {$idx < 0} { set idx [llength $_worklist_items] }
            lappend decorated [list $idx $row]
        }
        set decorated [lsort -integer -index 0 $decorated]
        set filtered {}
        foreach pair $decorated { lappend filtered [lindex $pair 1] }
    }
    return $filtered
}

proc ::nc::ui_table::_rebuild_table_columns {} {
    variable _tbl
    variable _tab
    variable tableData
    variable _col_width
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    _clear_header_buttons
    catch {$_tbl configure -cols [_ncols_for_tab $_tab]}
    set c 0
    foreach col_def [_cols_for_tab $_tab] {
        lassign $col_def key header width
        if {$key eq "mass_total"} { set header [_mass_header_label] }
        if {[info exists _col_width($_tab)] && [dict exists $_col_width($_tab) $key]} {
            set width [dict get $_col_width($_tab) $key]
        }
        set tableData(0,$c) $header
        catch {$_tbl width $c $width}
        incr c
    }
    catch {$_tbl tag row tag_header 0}
    _build_header_buttons
}

proc ::nc::ui_table::_clear_header_buttons {} {
    variable _tbl
    variable _header_widgets
    variable _header_btn_to_col
    if {$_tbl ne "" && [winfo exists $_tbl]} {
        set n [catch {$_tbl cget -cols} cols]
        if {!$n} {
            for {set c 0} {$c < $cols} {incr c} {
                catch {$_tbl window configure 0,$c -window ""}
            }
        }
    }
    foreach w $_header_widgets {
        catch {destroy $w}
    }
    set _header_widgets {}
    catch {array unset _header_btn_to_col}
}

proc ::nc::ui_table::_build_header_buttons {} {
    variable _tbl
    variable _tab
    variable _header_widgets
    variable _header_btn_to_col
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    set c 0
    foreach col_def [_cols_for_tab $_tab] {
        set key [lindex $col_def 0]
        set header [lindex $col_def 1]
        if {$key eq "mass_total"} { set header [_mass_header_label] }
        # Input-consistency cue: user-editable columns (labels/notes the user
        # owns, Reload never touches) get a green-tinted header; HM-scanned /
        # read-only columns keep the neutral grey. One glance answers "is
        # this cell mine to type into, or the model's data?".
        set hdr_bg [_header_normal_bg $c]
        set b $_tbl.h$c
        catch {destroy $b}
        button $b -text $header -relief raised -bd 2 -padx 3 -pady 0 \
            -background $hdr_bg -foreground "#ffffff" \
            -activebackground "#4f6f93" -activeforeground "#ffffff" \
            -font [_ui_header_font] -takefocus 0
        catch {$b configure -cursor hand2}
        set _header_btn_to_col($b) $c
        lappend _header_widgets $b
        bind $b <ButtonPress-1> [list ::nc::ui_table::_on_header_button_press $c %X %Y]
        bind $b <B1-Motion> [list ::nc::ui_table::_on_header_button_motion $c %X %Y]
        bind $b <ButtonRelease-1> [list ::nc::ui_table::_on_header_button_release $c %X %Y]
        bind $b <Double-ButtonPress-1> [list ::nc::ui_table::_on_header_button_double $c %X %Y]
        bind $b <Motion> [list ::nc::ui_table::_on_header_button_hover $c %X %Y]
        bind $b <Button-3> [list ::nc::ui_table::_show_header_context_menu $c %X %Y]
        catch {$_tbl window configure 0,$c -window $b -sticky news}
        incr c
    }
}

proc ::nc::ui_table::_fill_table_data {} {
    variable _rows
    variable tableData
    variable _tab
    _reset_visible_row_heights
    foreach key [array names tableData] {
        if {![string match "0,*" $key]} { unset tableData($key) }
    }
    set r 1
    foreach row $_rows {
        set c 0
        foreach col_def [_cols_for_tab $_tab] {
            set key [lindex $col_def 0]
            if {$key eq "_rownum"} {
                set tableData($r,$c) $r
            } elseif {$_tab eq "library"} {
                set tableData($r,$c) [_dict_get $row $key]
            } else {
                set tableData($r,$c) [_cell_value $_tab $row $key]
            }
            incr c
        }
        incr r
    }
    _render_image_cells
}

proc ::nc::ui_table::_reset_visible_row_heights {} {
    variable _tbl
    variable _rows
    variable _tab
    variable _compact_rows
    if {$_tbl eq "" || [llength [info commands winfo]] == 0 || ![winfo exists $_tbl]} { return }
    set h [expr {$_compact_rows ? 1 : 2}]
    set has_images [expr {$_tab in {general component}}]
    set r 1
    foreach row $_rows {
        # Rows that will hold an embedded image are sized by
        # _render_image_cells, not here - resetting them first would shrink
        # then regrow every row on each populate, which is the flicker seen
        # when just switching tabs with nothing actually changed.
        set skip 0
        if {$has_images} {
            set path [_dict_get $row image_path]
            if {$path ne "" && [file exists $path]} { set skip 1 }
        }
        if {!$skip} { catch {$_tbl height $r $h} }
        incr r
    }
}

proc ::nc::ui_table::_clear_image_cells {} {
    variable _tbl
    variable _image_widgets
    if {$_tbl ne "" && [llength [info commands winfo]] > 0 && [winfo exists $_tbl]} {
        foreach w $_image_widgets {
            catch {destroy $w}
        }
    }
    set _image_widgets {}
}

proc ::nc::ui_table::_invalidate_image_photo_cache {} {
    variable _image_photo_cache
    variable _image_render_signature
    if {[array exists _image_photo_cache]} {
        foreach name [array names _image_photo_cache] {
            catch {image delete $_image_photo_cache($name)}
        }
    }
    catch {array unset _image_photo_cache}
    set _image_render_signature ""
}

proc ::nc::ui_table::_image_thumb_cache_dir {} {
    set root ""
    catch {set root [::nc::session::dir]}
    if {$root eq ""} { set root [pwd] }
    set dir [file join $root cache thumb_cache]
    if {![file isdirectory $dir]} { catch {file mkdir $dir} }
    return $dir
}

proc ::nc::ui_table::_resolve_cae_python {} {
    if {[llength [info commands ::nc::config::resolve_python]] > 0} {
        set p [::nc::config::resolve_python]
        if {$p ne ""} { return $p }
    }
    return ""
}

proc ::nc::ui_table::_pillow_thumb_path {path max_w max_h} {
    if {$path eq "" || ![file exists $path]} { return "" }
    set dir [_image_thumb_cache_dir]
    set safe [string map [list "\\" "_" "/" "_" ":" "_" " " "_" "." "_"] [file tail $path]]
    set stamp [file mtime $path]
    set size [file size $path]
    return [file join $dir "pillow_${safe}_${size}_${stamp}_${max_w}x${max_h}.png"]
}

proc ::nc::ui_table::_write_pillow_thumb_script {dir} {
    set script_path [file join $dir make_pillow_thumb.py]
    set py {
import os
import sys
from PIL import Image

try:
    RESAMPLE = Image.Resampling.LANCZOS
except AttributeError:
    RESAMPLE = Image.LANCZOS

src, dst, max_w, max_h = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4])
tmp = dst + ".tmp"
im = Image.open(src)
try:
    if im.mode not in ("RGB", "RGBA"):
        im = im.convert("RGB")
    else:
        im = im.copy()
    im.thumbnail((max_w, max_h), RESAMPLE)
    out_dir = os.path.dirname(dst)
    if out_dir and not os.path.isdir(out_dir):
        os.makedirs(out_dir)
    if os.path.exists(tmp):
        os.remove(tmp)
    im.save(tmp, "PNG")
    if os.path.exists(dst):
        os.remove(dst)
    os.rename(tmp, dst)
finally:
    im.close()
}
    set write 1
    if {[file exists $script_path]} {
        set write 0
        if {[catch {
            set fp [::open $script_path r]
            set existing [read $fp]
            close $fp
        }] || $existing ne "$py\n"} {
            set write 1
        }
    }
    if {$write} {
        set fp [::open $script_path w]
        puts $fp $py
        close $fp
    }
    return $script_path
}

proc ::nc::ui_table::_ensure_pillow_thumbnail {path max_w max_h} {
    set thumb_path [_pillow_thumb_path $path $max_w $max_h]
    if {$thumb_path eq ""} { return "" }
    if {[file exists $thumb_path]} { return $thumb_path }
    set python [_resolve_cae_python]
    if {$python eq ""} { return "" }
    set script [_write_pillow_thumb_script [file dirname $thumb_path]]
    if {[catch {exec $python $script $path $thumb_path $max_w $max_h}]} { return "" }
    if {[file exists $thumb_path]} { return $thumb_path }
    return ""
}

proc ::nc::ui_table::_write_pillow_thumb_batch_script {dir} {
    set script_path [file join $dir make_pillow_thumbs_batch.py]
    set py {
import os
import sys
from PIL import Image

try:
    RESAMPLE = Image.Resampling.LANCZOS
except AttributeError:
    RESAMPLE = Image.LANCZOS

manifest = sys.argv[1]
with open(manifest, "r", encoding="utf-8") as f:
    jobs = [line.rstrip("\n").split("\t") for line in f if line.strip()]

for job in jobs:
    if len(job) != 4:
        continue
    src, dst, max_w, max_h = job[0], job[1], int(job[2]), int(job[3])
    try:
        tmp = dst + ".tmp"
        im = Image.open(src)
        try:
            if im.mode not in ("RGB", "RGBA"):
                im = im.convert("RGB")
            else:
                im = im.copy()
            im.thumbnail((max_w, max_h), RESAMPLE)
            out_dir = os.path.dirname(dst)
            if out_dir and not os.path.isdir(out_dir):
                os.makedirs(out_dir)
            if os.path.exists(tmp):
                os.remove(tmp)
            im.save(tmp, "PNG")
            if os.path.exists(dst):
                os.remove(dst)
            os.rename(tmp, dst)
        finally:
            im.close()
    except Exception:
        continue
}
    set write 1
    if {[file exists $script_path]} {
        set write 0
        if {[catch {
            set fp [::open $script_path r]
            set existing [read $fp]
            close $fp
        }] || $existing ne "$py\n"} {
            set write 1
        }
    }
    if {$write} {
        set fp [::open $script_path w]
        puts $fp $py
        close $fp
    }
    return $script_path
}

proc ::nc::ui_table::_ensure_pillow_thumbnails_batch {jobs} {
    set pending {}
    foreach job $jobs {
        lassign $job path max_w max_h
        set thumb_path [_pillow_thumb_path $path $max_w $max_h]
        if {$thumb_path eq "" || [file exists $thumb_path]} { continue }
        lappend pending [list $path $thumb_path $max_w $max_h]
    }
    if {[llength $pending] == 0} { return }
    set python [_resolve_cae_python]
    if {$python eq ""} { return }
    set cache_dir [_image_thumb_cache_dir]
    set script [_write_pillow_thumb_batch_script $cache_dir]
    set manifest [file join $cache_dir "batch_manifest_[clock clicks].txt"]
    if {[catch {
        set fp [::open $manifest w]
        foreach job $pending {
            puts $fp [join $job "\t"]
        }
        close $fp
    }]} { return }
    catch {exec $python $script $manifest}
    catch {file delete -force -- $manifest}
}

proc ::nc::ui_table::_make_table_thumbnail {path name {max_w 96} {max_h 72}} {
    if {$path eq "" || ![file exists $path]} { return "" }
    if {[llength [info commands image]] == 0} {
        _set_status_preview "Image render failed: Tk image command is not available." warn
        return ""
    }
    catch {package require Img}
    catch {image delete $name}
    set display_path [_ensure_pillow_thumbnail $path $max_w $max_h]
    if {$display_path eq ""} { set display_path $path }
    if {[catch {image create photo $name -file $display_path} img err_opts]} {
        _set_status_preview "Image render failed: [file tail $path] ($img)" warn
        return ""
    }
    set w [image width $img]
    set h [image height $img]
    if {$w <= 0 || $h <= 0} {
        catch {image delete $img}
        return ""
    }
    set scale [expr {min(double($max_w) / double($w), double($max_h) / double($h))}]
    if {$scale >= 1.0} { return $img }
    set subsample [expr {int(ceil(1.0 / $scale))}]
    if {$subsample < 1} { set subsample 1 }
    set thumb "${name}_thumb"
    catch {image delete $thumb}
    image create photo $thumb
    $thumb copy $img -subsample $subsample $subsample
    catch {image delete $img}
    return $thumb
}

proc ::nc::ui_table::_image_cell_fit_units {{image_px 96} {pad_px 2}} {
    set zero 7
    set line_px 16
    catch {set zero [font measure [_ui_font] "0"]}
    catch {set line_px [font metrics [_ui_font] -linespace]}
    if {$zero <= 0} { set zero 7 }
    if {$line_px <= 0} { set line_px 16 }
    set target_px [expr {$image_px + (2 * $pad_px) + 2}]
    set width_chars [expr {int(ceil(double($target_px) / double($zero)))}]
    set height_units [expr {int(ceil(double($target_px) / double($line_px)))}]
    if {$width_chars < 4} { set width_chars 4 }
    if {$height_units < 1} { set height_units 1 }
    return [list $width_chars $height_units]
}

proc ::nc::ui_table::_render_image_cells {} {
    variable _tbl
    variable _rows
    variable _tab
    variable _image_widgets
    variable _image_photo_cache
    variable _image_seq
    variable _image_thumb_px
    variable _image_render_signature
    variable tableData
    if {$_tbl eq "" || [llength [info commands winfo]] == 0 || ![winfo exists $_tbl]} { return }
    if {$_tab ni {general component}} {
        _clear_image_cells
        set _image_render_signature ""
        return
    }
    set img_col [_col_index $_tab image_path]
    if {$img_col < 0} {
        _clear_image_cells
        set _image_render_signature ""
        return
    }
    # The column width must always self-fit to the current thumbnail size,
    # regardless of whether the cell widgets themselves get rebuilt below -
    # _rebuild_table_columns resets it to the column's generic default width
    # on every populate, so re-applying the fit width here can't be skipped
    # along with the image-cell render or it would silently un-fit again.
    lassign [_image_cell_fit_units $_image_thumb_px 2] image_width_chars image_height_units
    catch {$_tbl width $img_col $image_width_chars}
    # Skip the destroy/rebuild churn entirely when nothing that affects the
    # image cells has changed since the last render (e.g. switching back to
    # a tab that already has its images up) - this is what caused the
    # no-image -> flash -> image-again -> row-resize flicker on tab switch.
    set sig_parts [list $_tab $img_col $_image_thumb_px]
    foreach row $_rows { lappend sig_parts [_dict_get $row image_path] }
    set signature [join $sig_parts "\x1f"]
    if {$signature eq $_image_render_signature && [llength $_image_widgets] > 0} {
        return
    }
    set _image_render_signature $signature
    _clear_image_cells
    set r 1
    foreach row $_rows {
        set path [_dict_get $row image_path]
        if {$path ne "" && [file exists $path]} {
            set cache_key "$path|$_image_thumb_px"
            set img ""
            if {[info exists _image_photo_cache($cache_key)] \
                    && [lsearch -exact [image names] $_image_photo_cache($cache_key)] >= 0} {
                set img $_image_photo_cache($cache_key)
            } else {
                set img_name "::nc::ui_table::img_[incr _image_seq]"
                set img [_make_table_thumbnail $path $img_name $_image_thumb_px $_image_thumb_px]
                if {$img ne ""} { set _image_photo_cache($cache_key) $img }
            }
            if {$img ne ""} {
                set cell $_tbl.img_$r
                catch {destroy $cell}
                frame $cell -bd 0 -relief flat -highlightthickness 0 -background "#a8a8a8"
                frame $cell.inner -bd 0 -relief flat -highlightthickness 0 -background white
                label $cell.inner.image -image $img -bd 0 -relief flat -highlightthickness 0 -background white
                pack $cell.inner.image -fill both -expand 1
                pack $cell.inner -fill both -expand 1 -padx 1 -pady 1
                lappend _image_widgets $cell
                set tableData($r,$img_col) ""
                catch {$_tbl height $r $image_height_units}
                catch {$_tbl window configure $r,$img_col -window $cell -sticky news}
                catch {$_tbl reread}
            }
        }
        incr r
    }
    catch {update idletasks}
}

proc ::nc::ui_table::_apply_tags {} {
    variable _rows
    variable _tbl
    variable _tab
    variable _alternate_rows
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    catch {$_tbl tag celltag "" all}
    catch {$_tbl tag row tag_header 0}

    set r 1
    set ncols [_ncols_for_tab $_tab]
    foreach row $_rows {
        for {set c 0} {$c < $ncols} {incr c} {
            if {$_alternate_rows && [expr {$r % 2}] == 0} {
                catch {$_tbl tag cell tag_alt $r,$c}
            } else {
                catch {$_tbl tag cell tag_cell $r,$c}
            }
        }
        set pending [_row_pending_fields $row]
        foreach key $pending {
            set col [_col_index $_tab $key]
            if {$col >= 0} { catch {$_tbl tag cell tag_dirty $r,$col} }
        }
        if {$_tab eq "properties"} {
            set c 0
            foreach col_def [_cols_for_tab $_tab] {
                set key [lindex $col_def 0]
                if {![_property_field_applicable $row $key]} {
                    catch {$_tbl tag cell tag_disabled $r,$c}
                }
                incr c
            }
        }
        if {$_tab in {general component}} {
            set ct [_dict_get $row case_type 1]
            set pc_col [_col_index $_tab prop_card]
            set pid_col [_col_index $_tab prop_id]
            set ml_col [_col_index $_tab mat_user_name]
            set mid_col [_col_index $_tab mat_id]
            if {$ct == 2 && $pc_col >= 0} { catch {$_tbl tag cell tag_case2_prop $r,$pc_col} }
            if {[_component_prop_usage_count $row] > 1} {
                foreach c [list $pc_col $pid_col $ml_col $mid_col] {
                    if {$c >= 0} { catch {$_tbl tag cell tag_shared_prop $r,$c} }
                }
            }
            if {$ct == 3} {
                if {$ml_col >= 0} { catch {$_tbl tag cell tag_case3_mat $r,$ml_col} }
                if {$mid_col >= 0} { catch {$_tbl tag cell tag_case3_mat $r,$mid_col} }
            }
        }
        incr r
    }
}

proc ::nc::ui_table::_populate_current {} {
    variable _rows
    variable _tbl
    variable _label_win
    set _rows [_rows_for_display]
    if {$_tbl ne "" && [winfo exists $_tbl]} {
        catch {$_tbl configure -rows [expr {[llength $_rows] + 1}]}
    }
    _fill_table_data
    _apply_tags
    if {$_tbl ne "" && [winfo exists $_tbl]} {
        catch {$_tbl reread}
    }
    if {$_label_win ne "" && [winfo exists $_label_win]} {
        catch {_label_refresh_list}
    }
}

# Sorts _tab_rows($tab) IN PLACE, once - a genuine one-off action like
# Excel's column-header Sort, not a persisted live filter. Previously this
# logic ran on every populate (driven by a live _sort_col/_sort_dir state),
# so editing a cell in whatever column was last sorted - including via
# paste - silently reshuffled the whole tab on the next repopulate. Called
# only from _sort_by_column at the moment the user clicks a header.
# Operates on the full row list (not just the currently filtered/displayed
# subset) so rows hidden by search/filter stay consistently ordered too.
proc ::nc::ui_table::_sort_tab_rows_once {tab col dir} {
    variable _tab_rows
    if {![info exists _tab_rows($tab)] || [llength $_tab_rows($tab)] == 0} { return }
    set cols [_cols_for_tab $tab]
    if {![string is integer -strict $col] || $col < 0 || $col >= [llength $cols]} { return }
    if {[lsearch -exact {incr decr} $dir] < 0} { set dir incr }
    set key [lindex [lindex $cols $col] 0]
    set decorated {}
    foreach row $_tab_rows($tab) {
        lappend decorated [list [_cell_value $tab $row $key] $row]
    }
    set sort_type -dictionary
    set numeric 1
    set seen_value 0
    foreach pair $decorated {
        set v [lindex $pair 0]
        if {$v eq "" || ![string is integer -strict $v]} {
            set numeric 0
            break
        }
        set seen_value 1
    }
    if {$numeric && $seen_value} {
        set sort_type -integer
    }
    set sorted [lsort $sort_type -index 0 -$dir $decorated]
    set out {}
    foreach pair $sorted { lappend out [lindex $pair 1] }
    set _tab_rows($tab) $out
}

# =============================================================================
# Editing / events
# =============================================================================

proc ::nc::ui_table::_cell_at_xy {x y} {
    variable _tbl
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return "" }
    set cell ""
    catch {set cell [$_tbl index @$x,$y]}
    return $cell
}

proc ::nc::ui_table::_header_col_at_xy {x y} {
    set cell [_cell_at_xy $x $y]
    if {$cell eq ""} { return -1 }
    lassign [split $cell ,] r c
    if {![string is integer -strict $r] || $r != 0} { return -1 }
    if {![string is integer -strict $c]} { return -1 }
    return $c
}

proc ::nc::ui_table::_header_col_from_root {X Y} {
    variable _tbl
    variable _header_btn_to_col
    set w ""
    catch {set w [winfo containing $X $Y]}
    while {$w ne ""} {
        if {[info exists _header_btn_to_col($w)]} {
            return $_header_btn_to_col($w)
        }
        set parent ""
        catch {set parent [winfo parent $w]}
        if {$parent eq "" || $parent eq $w} { break }
        set w $parent
    }
    if {$_tbl ne "" && [winfo exists $_tbl]} {
        set x [expr {$X - [winfo rootx $_tbl]}]
        set y [expr {$Y - [winfo rooty $_tbl]}]
        return [_header_col_at_xy $x $y]
    }
    return -1
}

proc ::nc::ui_table::_header_label {col} {
    variable _tab
    set cols [_cols_for_tab $_tab]
    if {$col < 0 || $col >= [llength $cols]} { return "" }
    if {[lindex [lindex $cols $col] 0] eq "mass_total"} { return [_mass_header_label] }
    return [lindex [lindex $cols $col] 1]
}

proc ::nc::ui_table::_header_button_at_col {col} {
    variable _tbl
    set b $_tbl.h$col
    if {$b ne "" && [winfo exists $b]} { return $b }
    return ""
}

proc ::nc::ui_table::_header_button_near_right_edge {col X} {
    variable _header_resize_edge_px
    set b [_header_button_at_col $col]
    if {$b eq ""} { return 0 }
    set local_x [expr {$X - [winfo rootx $b]}]
    return [expr {$local_x >= [winfo width $b] - $_header_resize_edge_px}]
}

proc ::nc::ui_table::_font_measure_chars {text} {
    variable _tbl
    set px 0
    set zero 7
    catch {set px [font measure {Arial 9} $text]}
    catch {set zero [font measure {Arial 9} "0"]}
    if {$zero <= 0} { set zero 7 }
    return [expr {int(ceil(double($px + 18) / double($zero)))}]
}

# "Fit Columns" (View menu): auto-fits every column to its own content
# width, reusing the same per-column logic already wired to double-clicking
# a header's resize edge - just looped across all columns instead of one.
# Skips the Image column, which is sized by thumbnail pixel size (S/M/L/
# Arrange), not by text content.
proc ::nc::ui_table::_on_fit_all_columns {} {
    variable _tbl
    variable _tab
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    set c 0
    foreach col_def [_cols_for_tab $_tab] {
        set key [lindex $col_def 0]
        if {$key ne "image_path"} { _autofit_column $c }
        incr c
    }
    _set_status "All columns fit to content." ok
}

# Computes autofit widths for every column of a given tab directly from
# its row data (_tab_rows), without needing that tab's table currently
# displayed in the widget - stores straight into _col_width($tab), which
# _rebuild_table_columns already reads whenever the user switches to that
# tab. Lets startup fit every tab once, not just whichever one happens to
# be shown first.
proc ::nc::ui_table::_autofit_tab_data {tab} {
    variable _tab_rows
    variable _col_width
    set rows [expr {[info exists _tab_rows($tab)] ? $_tab_rows($tab) : {}}]
    if {![info exists _col_width($tab)]} { set _col_width($tab) [dict create] }
    foreach col_def [_cols_for_tab $tab] {
        set key [lindex $col_def 0]
        if {$key eq "image_path" || $key eq "_rownum"} continue
        set max_chars [_font_measure_chars [lindex $col_def 1]]
        foreach row $rows {
            set chars [_font_measure_chars [_cell_value $tab $row $key]]
            if {$chars > $max_chars} { set max_chars $chars }
        }
        if {$max_chars < 6} { set max_chars 6 }
        if {$max_chars > 60} { set max_chars 60 }
        dict set _col_width($tab) $key $max_chars
    }
}

# One-shot on launch: fit every tab's columns to their initial data so the
# tool doesn't open with the hardcoded default widths from
# _export_all_possible_cols - the user still has to click Fit Columns
# manually after that if the data changes shape (Reload, big edits, etc.).
proc ::nc::ui_table::_autofit_all_tabs_once {} {
    foreach tab {general component properties materials library} {
        catch { _autofit_tab_data $tab }
    }
}

proc ::nc::ui_table::_autofit_column {col} {
    variable _rows
    variable _tab
    variable _tbl
    variable _col_width
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return 0 }
    set cols [_cols_for_tab $_tab]
    if {$col < 0 || $col >= [llength $cols]} { return 0 }
    set col_def [lindex $cols $col]
    set key [lindex $col_def 0]
    set max_chars [_font_measure_chars [lindex $col_def 1]]
    foreach row $_rows {
        set chars [_font_measure_chars [_cell_value $_tab $row $key]]
        if {$chars > $max_chars} { set max_chars $chars }
    }
    if {$max_chars < 6} { set max_chars 6 }
    if {$max_chars > 60} { set max_chars 60 }
    catch {$_tbl width $col $max_chars}
    # Remember it so _rebuild_table_columns (runs on every tab switch)
    # restores this width instead of resetting to the column definition's
    # hardcoded default - previously an autofit was lost the moment you
    # switched tabs and back.
    if {![info exists _col_width($_tab)]} { set _col_width($_tab) [dict create] }
    dict set _col_width($_tab) $key $max_chars
    _set_status "Autofit column: [_header_label $col]" ok
    return 1
}

# Normal (non-drag) header background for a column: green tint for pure
# user-entered data unrelated to a the CAE tool reload (_user_annotation_fields),
# neutral grey for everything Reload/scan populates (including Nastran card
# fields that happen to be stageable-editable for a future Apply, and
# computed values like Mass). Must be used by every code path that restores
# header colors after drag feedback, or the cue disappears on column drag.
proc ::nc::ui_table::_header_normal_bg {col} {
    variable _tab
    set key [lindex [lindex [_cols_for_tab $_tab] $col] 0]
    if {$key ne "" && $key in [_user_annotation_fields $_tab]} { return "#4f7a4f" }
    return "#6b6b6b"
}

proc ::nc::ui_table::_set_header_button_visual {col state} {
    variable _tbl
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    set b $_tbl.h$col
    if {![winfo exists $b]} return
    switch -- $state {
        source {
            catch {$b configure -relief sunken -background "#315f8f" -foreground "#ffffff" -activebackground "#315f8f" -activeforeground "#ffffff"}
            catch {$b configure -cursor fleur}
        }
        default {
            catch {$b configure -relief raised -background [_header_normal_bg $col] -foreground "#ffffff" -activebackground "#4f6f93" -activeforeground "#ffffff"}
            catch {$b configure -cursor hand2}
        }
    }
}

proc ::nc::ui_table::_reset_header_drag_visuals {} {
    variable _header_widgets
    variable _header_btn_to_col
    foreach w $_header_widgets {
        if {[winfo exists $w]} {
            set col ""
            catch {set col $_header_btn_to_col($w)}
            set bg "#6b6b6b"
            if {$col ne ""} { set bg [_header_normal_bg $col] }
            catch {$w configure -relief raised -background $bg -foreground "#ffffff" -activebackground "#4f6f93" -activeforeground "#ffffff"}
            catch {$w configure -cursor hand2}
        }
    }
    _hide_header_drop_indicator
}

proc ::nc::ui_table::_set_status_preview {msg {status ok}} {
    variable _status_lbl
    set fg "#555555"
    switch -- $status {
        ok { set fg "#2f6f3e" }
        warn { set fg "#8a5a00" }
        error { set fg "#9b1c1c" }
    }
    if {$_status_lbl ne "" && [winfo exists $_status_lbl]} {
        catch {$_status_lbl configure -text $msg -foreground $fg}
    }
}

proc ::nc::ui_table::_hide_header_drop_indicator {} {
    variable _header_indicator
    if {$_header_indicator ne "" && [winfo exists $_header_indicator]} {
        catch {place forget $_header_indicator}
    }
}

proc ::nc::ui_table::_header_drop_info_from_root {X Y} {
    variable _tbl
    variable _tableframe
    variable _tab
    set target [_header_col_from_root $X $Y]
    set n [_ncols_for_tab $_tab]
    if {$target < 0 || $target >= $n || $_tbl eq "" || ![winfo exists $_tbl]} {
        return [list -1 -1 -1 ""]
    }
    set b $_tbl.h$target
    if {![winfo exists $b]} {
        return [list -1 -1 -1 ""]
    }
    set bx [winfo rootx $b]
    set bw [winfo width $b]
    if {$bw <= 0 || $_tableframe eq "" || ![winfo exists $_tableframe]} {
        return [list -1 -1 -1 ""]
    }
    if {$X < [expr {$bx + ($bw / 2)}]} {
        set slot $target
        set bar_root_x $bx
        set side before
    } else {
        set slot [expr {$target + 1}]
        set bar_root_x [expr {$bx + $bw}]
        set side after
    }
    set local_x [expr {$bar_root_x - [winfo rootx $_tableframe]}]
    return [list $target $slot $local_x $side]
}

proc ::nc::ui_table::_place_header_drop_indicator {local_x} {
    variable _tbl
    variable _tableframe
    variable _header_indicator
    if {$_tbl eq "" || ![winfo exists $_tbl] || $_tableframe eq "" || ![winfo exists $_tableframe]} {
        return
    }
    if {$_header_indicator eq "" || ![winfo exists $_header_indicator]} {
        set _header_indicator [frame $_tableframe.headerDrop -background "#1f6fb2" -bd 0 -highlightthickness 0]
    }
    set y [expr {[winfo rooty $_tbl] - [winfo rooty $_tableframe]}]
    set h [winfo height $_tbl]
    set x [expr {$local_x - 1}]
    if {$x < 0} { set x 0 }
    catch {place $_header_indicator -x $x -y $y -width 3 -height $h}
    catch {raise $_header_indicator}
}

proc ::nc::ui_table::_update_header_drop_indicator {X Y} {
    variable _header_press_col
    variable _header_drop_slot
    variable _tab
    lassign [_header_drop_info_from_root $X $Y] target slot local_x side
    set _header_drop_slot -1
    _set_header_button_visual $_header_press_col source
    if {$target < 0 || $slot < 0} {
        _hide_header_drop_indicator
        _set_status_preview "Dragging: [_header_label $_header_press_col] -> release over a column gap to move" warn
        return
    }
    if {$slot == $_header_press_col || $slot == [expr {$_header_press_col + 1}]} {
        _hide_header_drop_indicator
        _set_status_preview "Dragging: [_header_label $_header_press_col] -> same position" warn
        return
    }
    set _header_drop_slot $slot
    _place_header_drop_indicator $local_x
    set n [_ncols_for_tab $_tab]
    if {$slot >= $n} {
        set target_label "after [_header_label [expr {$n - 1}]]"
    } else {
        set target_label "before [_header_label $slot]"
    }
    _set_status_preview "Dragging: [_header_label $_header_press_col] -> insert $target_label" ok
}

proc ::nc::ui_table::_on_header_button_press {col X Y} {
    variable _tbl
    variable _header_press_col
    variable _header_dragging
    variable _header_hover_col
    variable _header_drop_slot
    variable _header_press_x
    variable _header_press_y
    variable _header_resize_col
    variable _header_resize_start_x
    variable _header_resize_start_width
    if {[_header_button_near_right_edge $col $X]} {
        set _header_resize_col $col
        set _header_resize_start_x $X
        set _header_resize_start_width 10
        catch {set _header_resize_start_width [$_tbl width $col]}
        set _header_press_col -1
        set _header_dragging 0
        _hide_header_drop_indicator
        _set_status_preview "Resize column: [_header_label $col]" ok
        return -code break
    }
    set _header_press_col $col
    set _header_dragging 0
    set _header_hover_col -1
    set _header_drop_slot -1
    set _header_press_x $X
    set _header_press_y $Y
    _hide_header_drop_indicator
    _set_header_button_visual $col source
    _set_status_preview "Press header: [_header_label $col]. Drag to move, release to sort." ok
}

proc ::nc::ui_table::_on_header_button_motion {col X Y} {
    variable _tbl
    variable _header_resize_col
    variable _header_resize_start_x
    variable _header_resize_start_width
    variable _header_press_col
    variable _header_dragging
    variable _header_press_x
    variable _header_press_y
    variable _header_drag_threshold
    if {$_header_resize_col >= 0} {
        set delta_px [expr {$X - $_header_resize_start_x}]
        set zero 7
        catch {set zero [font measure {Arial 9} "0"]}
        if {$zero <= 0} { set zero 7 }
        set delta_chars [expr {int(round(double($delta_px) / double($zero)))}]
        set width [expr {$_header_resize_start_width + $delta_chars}]
        if {$width < 4} { set width 4 }
        if {$width > 120} { set width 120 }
        catch {$_tbl width $_header_resize_col $width}
        _set_status_preview "Resize column: [_header_label $_header_resize_col] -> $width" ok
        return -code break
    }
    if {$_header_press_col < 0} { return }
    set dx [expr {abs($X - $_header_press_x)}]
    set dy [expr {abs($Y - $_header_press_y)}]
    if {!$_header_dragging && $dx < $_header_drag_threshold && $dy < $_header_drag_threshold} {
        return
    }
    set _header_dragging 1
    _update_header_drop_indicator $X $Y
}

proc ::nc::ui_table::_on_header_button_release {col X Y} {
    variable _tbl
    variable _tab
    variable _col_width
    variable _header_resize_col
    variable _header_press_col
    variable _header_dragging
    variable _header_hover_col
    variable _header_drop_slot
    if {$_header_resize_col >= 0} {
        set resized $_header_resize_col
        set _header_resize_col -1
        # Persist the manually-dragged width the same way _autofit_column
        # does, so it survives switching tabs and back too.
        set cols [_cols_for_tab $_tab]
        if {$resized >= 0 && $resized < [llength $cols]} {
            set key [lindex [lindex $cols $resized] 0]
            set w ""
            catch {set w [$_tbl width $resized]}
            if {$w ne ""} {
                if {![info exists _col_width($_tab)]} { set _col_width($_tab) [dict create] }
                dict set _col_width($_tab) $key $w
            }
        }
        _set_status "Resized column: [_header_label $resized]" ok
        return -code break
    }
    set from $_header_press_col
    set was_drag $_header_dragging
    set slot $_header_drop_slot
    if {$was_drag} {
        lassign [_header_drop_info_from_root $X $Y] target release_slot local_x side
        if {$release_slot >= 0} { set slot $release_slot }
    }
    set _header_press_col -1
    set _header_dragging 0
    set _header_hover_col -1
    set _header_drop_slot -1
    _reset_header_drag_visuals
    if {!$was_drag && $from >= 0} {
        _sort_by_column $from
        return
    }
    if {$was_drag && $from >= 0 && [_move_column_to_slot $from $slot]} {
        return
    }
    if {$was_drag} {
        _set_status "Column move canceled." warn
    }
}

proc ::nc::ui_table::_on_header_button_double {col X Y} {
    if {[_header_button_near_right_edge $col $X]} {
        _autofit_column $col
        return -code break
    }
}

proc ::nc::ui_table::_on_header_button_hover {col X Y} {
    set b [_header_button_at_col $col]
    if {$b eq ""} { return }
    if {[_header_button_near_right_edge $col $X]} {
        catch {$b configure -cursor sb_h_double_arrow}
    } else {
        catch {$b configure -cursor arrow}
    }
}

proc ::nc::ui_table::_on_header_press {x y} {
    variable _tbl
    variable _tab
    variable _header_press_col
    variable _header_dragging
    variable _rows
    set _header_press_col [_header_col_at_xy $x $y]
    set _header_dragging 0
    if {$_header_press_col >= 0 && $_tbl ne "" && [winfo exists $_tbl]} {
        catch {$_tbl tag cell tag_header_drag 0,$_header_press_col}
    }
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return }
    set cell ""
    catch {set cell [$_tbl index @$x,$y]}
    if {$cell eq ""} { return }
    lassign [split $cell ,] r c
    if {![string is integer -strict $r]} { return }
    # Clicking in the blank space below the last data row still resolves
    # to a valid (clamped) cell index in Tktable, and that click can bump
    # up the last row's rendered height (a Tktable geometry quirk when
    # the widget area extends past the configured row count) - the height
    # only self-corrects on the next full repopulate (e.g. switching tabs
    # and back), so proactively reset it right after this click settles
    # instead of leaving the bloated row visible until then.
    if {$r > [llength $_rows]} {
        after idle {catch {::nc::ui_table::_reset_visible_row_heights}}
        return
    }
    # Clicking the "#" row-number column (col 0) selects the whole row,
    # Excel-style, instead of just that one narrow cell - matches the
    # broadcast-paste feature's expectation of a multi-cell row selection
    # (_paste_target_rows already reads curselection this same way).
    if {$r >= 1 && $c == 0} {
        set last_col [expr {[_ncols_for_tab $_tab] - 1}]
        catch {
            $_tbl selection clear all
            $_tbl selection set $r,0 $r,$last_col
            $_tbl activate $r,0
        }
        return -code break
    }
}

proc ::nc::ui_table::_on_header_motion {x y} {
    variable _header_press_col
    variable _header_dragging
    if {$_header_press_col < 0} { return }
    set col [_header_col_at_xy $x $y]
    if {$col >= 0 && $col != $_header_press_col} {
        set _header_dragging 1
    }
}

proc ::nc::ui_table::_on_header_release {x y} {
    variable _tbl
    variable _header_press_col
    variable _header_dragging
    set from $_header_press_col
    set to [_header_col_at_xy $x $y]
    set was_drag $_header_dragging
    set _header_press_col -1
    set _header_dragging 0
    if {$_tbl ne "" && [winfo exists $_tbl]} {
        catch {$_tbl tag celltag "" 0,$from}
        catch {$_tbl tag row tag_header 0}
    }
    if {$from >= 0 && $to >= 0 && $from != $to && $was_drag} {
        _move_column $from $to
        return
    }
    _on_click $x $y
}

proc ::nc::ui_table::_sort_by_column {c} {
    variable _sort_col
    variable _sort_dir
    variable _tab
    if {![string is integer -strict $c] || $c < 0} { return }
    if {![string is integer -strict $_sort_col]} { set _sort_col 0 }
    if {[lsearch -exact {incr decr} $_sort_dir] < 0} { set _sort_dir incr }
    if {$c == $_sort_col} {
        set _sort_dir [expr {$_sort_dir eq "incr" ? "decr" : "incr"}]
    } else {
        set _sort_col $c
        set _sort_dir incr
    }
    # One-time sort (like Excel): reorder _tab_rows right now and leave it
    # there. _sort_col/_sort_dir are kept only so clicking the same header
    # again toggles ascending/descending - they no longer drive a live
    # re-sort on every populate (that was the old behavior that made
    # editing/pasting into a previously-sorted column look like the whole
    # table randomly reordered itself).
    _sort_tab_rows_once $_tab $_sort_col $_sort_dir
    _populate_current
}

proc ::nc::ui_table::_move_column {from to} {
    return [_move_column_to_slot $from $to]
}

proc ::nc::ui_table::_move_column_to_slot {from slot} {
    variable _tab
    variable _col_order
    set cols [_cols_for_tab $_tab]
    set n [llength $cols]
    if {$from < 0 || $from >= $n || $slot < 0 || $slot > $n} { return 0 }
    if {$slot == $from || $slot == [expr {$from + 1}]} { return 0 }
    set keys {}
    foreach col_def $cols { lappend keys [lindex $col_def 0] }
    set moved [lindex $keys $from]
    set keys [lreplace $keys $from $from]
    set insert_at $slot
    if {$slot > $from} { set insert_at [expr {$slot - 1}] }
    set keys [linsert $keys $insert_at $moved]
    set _col_order($_tab) $keys
    # Reordering columns is unrelated to sorting - this used to also
    # overwrite _sort_col/_sort_dir to point at the moved column's new
    # position, which (under the old live-re-sort architecture) silently
    # turned every column drag into an active sort. Removed; moving a
    # column no longer touches sort state at all.
    _rebuild_table_columns
    _populate_current
    _save_column_layout
    _set_status "Moved column '[lindex [lindex $cols $from] 1]' in $_tab tab." ok
    return 1
}

proc ::nc::ui_table::_on_click {x y} {
    variable _tbl
    variable _sort_col
    variable _sort_dir
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    set cell ""
    catch {set cell [$_tbl index @$x,$y]}
    if {$cell eq ""} return
    lassign [split $cell ,] r c
    if {![string is integer -strict $r] || $r != 0} return
    _sort_by_column $c
}

proc ::nc::ui_table::_cell_uses_dropdown {key} {
    return [expr {$key in {comp_user_name prop_user_name mat_user_name comp_type mat_label}}]
}

proc ::nc::ui_table::_stage_cell_value {r c key new_val old_val} {
    variable _rows
    variable _tab
    variable tableData
    if {![string is integer -strict $r] || $r < 1 || ![string is integer -strict $c]} { return 0 }
    if {$key ni [_editable_fields $_tab]} { return 0 }
    if {$_tab eq "properties"} {
        set row [lindex $_rows [expr {$r - 1}]]
        if {![_property_field_applicable $row $key]} {
            set tableData($r,$c) ""
            _apply_tags
            _set_status "$key is not applicable for [_prop_card_for_row $row]." warn
            return 0
        }
    }
    set tableData($r,$c) $new_val
    if {$new_val eq $old_val} {
        _apply_tags
        return 1
    }
    if {$key eq "mass_total" && $_tab in {general component}} {
        return [_stage_mass_value $r $c $new_val $old_val]
    }
    variable _last_mat_ambiguous_msg
    set row [lindex $_rows [expr {$r - 1}]]
    set row_key [_row_key_for_tab $_tab $row]
    set row [_set_row_value $_tab $row $key $new_val]
    if {$_tab in {general component}} {
        _sync_component_fields [_dict_get $row comp_id] $row
    } else {
        _replace_row $_tab $row_key $row
        if {$_tab eq "materials"} {
            if {$key in {mat_user_name mat_label mat_name E G NU RHO A TREF}} {
                _sync_material_label_across_rows $row
            }
        }
    }
    _populate_current
    if {$key eq "mat_user_name" && $_last_mat_ambiguous_msg ne ""} {
        # Same as the label-palette path: don't hide the duplicate-material
        # warning behind the generic "Staged ..." status.
        _set_status $_last_mat_ambiguous_msg warn
        set _last_mat_ambiguous_msg ""
    } else {
        _set_status "Staged $key = '$new_val' (preview only)." ok
    }
    return 1
}

proc ::nc::ui_table::_open_cell_dropdown {r c key} {
    variable _tbl
    variable _edit_orig
    variable _edit_col
    variable _combo_cell
    variable _combo_var
    variable _combo_widget
    variable tableData
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return 0 }
    if {[llength [info commands ttk::combobox]] == 0} { return 0 }
    _close_cell_dropdown 0
    set current ""
    if {[info exists tableData($r,$c)]} { set current $tableData($r,$c) }
    set values [_dropdown_values_for_key $key $current]
    set cb $_tbl.combo
    catch {destroy $cb}
    set _combo_var $current
    set _combo_cell "$r,$c,$key"
    set _combo_widget $cb
    set _edit_col $c
    set _edit_orig $current
    ttk::combobox $cb -textvariable ::nc::ui_table::_combo_var -values $values -state normal -font {Arial 9}
    bind $cb <<ComboboxSelected>> [list ::nc::ui_table::_on_combo_commit $r $c $key]
    bind $cb <Return> [list ::nc::ui_table::_on_combo_commit $r $c $key]
    bind $cb <KP_Enter> [list ::nc::ui_table::_on_combo_commit $r $c $key]
    bind $cb <Escape> [list ::nc::ui_table::_close_cell_dropdown 1]
    catch {$_tbl window configure $r,$c -window $cb -sticky news}
    catch {$_tbl tag cell tag_editing $r,$c}
    catch {focus $cb}
    catch {$cb selection range 0 end}
    catch {update idletasks}
    _post_cell_dropdown $cb
    _set_status_preview "Choose or type $key, then press Enter." ok
    return 1
}

proc ::nc::ui_table::_post_cell_dropdown {cb} {
    if {$cb eq "" || ![winfo exists $cb]} { return }
    if {[llength [info commands ttk::combobox::Post]] > 0} {
        if {![catch {ttk::combobox::Post $cb}]} { return }
    }
    catch {event generate $cb <Alt-Down>}
    catch {event generate $cb <Button-1> -x [expr {[winfo width $cb] - 8}] -y [expr {[winfo height $cb] / 2}]}
}

proc ::nc::ui_table::_on_combo_commit {r c key} {
    variable _tbl
    variable _edit_orig
    variable _combo_var
    variable _combo_cell
    variable _combo_widget
    if {$_tbl ne "" && [winfo exists $_tbl]} {
        catch {$_tbl window configure $r,$c -window ""}
        catch {$_tbl tag celltag "" $r,$c}
    }
    set new_val $_combo_var
    set _combo_cell ""
    _stage_cell_value $r $c $key $new_val $_edit_orig
    if {$new_val eq $_edit_orig} {
        _apply_tags
        if {$_tbl ne "" && [winfo exists $_tbl]} { catch {$_tbl reread} }
    }
    if {$_combo_widget ne ""} { catch {destroy $_combo_widget} }
    set _combo_widget ""
}

proc ::nc::ui_table::_close_cell_dropdown {{restore 1}} {
    variable _tbl
    variable _combo_cell
    variable _combo_widget
    variable _edit_orig
    variable tableData
    if {$_combo_cell eq ""} {
        set widget_alive 0
        if {$_combo_widget ne ""} { catch {set widget_alive [winfo exists $_combo_widget]} }
        if {!$widget_alive} { return }
    }
    if {$_combo_cell ne ""} {
        lassign [split $_combo_cell ,] r c key
        if {$_tbl ne "" && [winfo exists $_tbl]} {
            catch {$_tbl window configure $r,$c -window ""}
            catch {$_tbl tag celltag "" $r,$c}
        }
        if {$restore && [string is integer -strict $r] && [string is integer -strict $c]} {
            set tableData($r,$c) $_edit_orig
        }
    }
    if {$_combo_widget ne ""} { catch {destroy $_combo_widget} }
    set _combo_widget ""
    set _combo_cell ""
    _apply_tags
    if {$_tbl ne "" && [winfo exists $_tbl]} { catch {$_tbl reread} }
}

proc ::nc::ui_table::_on_double_click {x y} {
    variable _tbl
    variable _rows
    variable _tab
    variable _edit_orig
    variable _edit_col
    variable _editing_cell
    variable _edit_widget
    variable _edit_var
    variable tableData
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    set cell ""
    catch {set cell [$_tbl index @$x,$y]}
    if {$cell eq ""} return
    lassign [split $cell ,] r c
    if {![string is integer -strict $r] || ![string is integer -strict $c]} return
    if {$r == 0} {
        _autofit_column $c
        return
    }
    if {$r < 1} return
    set key [lindex [lindex [_cols_for_tab $_tab] $c] 0]
    if {$key ni [_editable_fields $_tab]} {
        return
    }
    if {$_tab eq "properties"} {
        set row [lindex $_rows [expr {$r - 1}]]
        if {![_property_field_applicable $row $key]} {
            _set_status "$key is not applicable for [_prop_card_for_row $row]." warn
            return
        }
    }
    if {[_cell_uses_dropdown $key]} {
        _open_label_palette $key $r $c
        return
    }
    _clear_editing_visual
    set _edit_col $c
    set _edit_orig $tableData($r,$c)
    set _edit_var $_edit_orig
    set _editing_cell "$r,$c"
    set _edit_widget $_tbl.edit
    catch {destroy $_edit_widget}
    entry $_edit_widget -textvariable ::nc::ui_table::_edit_var -font {Arial 9} \
        -relief solid -bd 1 -highlightthickness 1 -highlightcolor "#4f86c6"
    bind $_edit_widget <Return> {::nc::ui_table::_on_edit_commit; break}
    bind $_edit_widget <KP_Enter> {::nc::ui_table::_on_edit_commit; break}
    bind $_edit_widget <Escape> {::nc::ui_table::_on_edit_cancel; break}
    # Best-effort: clicking away (another cell/tab/widget) commits instead of
    # stranding the editor. The reliable guard is _finalize_active_edit in
    # _set_tab; this just improves the common mouse-click-away case.
    bind $_edit_widget <FocusOut> {::nc::ui_table::_finalize_active_edit}
    catch {$_tbl configure -state normal}
    catch {$_tbl activate $r,$c}
    catch {$_tbl window configure $r,$c -window $_edit_widget -sticky news}
    catch {$_tbl tag cell tag_editing $r,$c}
    catch {focus $_edit_widget}
    catch {$_edit_widget selection range 0 end}
    catch {$_edit_widget icursor end}
    _set_status_preview "Editing $key. Press Enter to commit, Esc to cancel." ok
}

proc ::nc::ui_table::_on_edit_arrow {dir} {
    variable _tbl
    variable _editing_cell
    variable _edit_widget
    if {$_editing_cell eq "" || $_edit_widget eq "" || ![winfo exists $_edit_widget]} { return }
    if {$dir eq "Left"} { catch {$_edit_widget icursor [expr {[$_edit_widget index insert] - 1}]} } else { catch {$_edit_widget icursor [expr {[$_edit_widget index insert] + 1}]} }
    return -code break
}

proc ::nc::ui_table::_editing_cell_value {r c} {
    variable _tbl
    variable _edit_widget
    variable _edit_var
    variable tableData
    if {[llength [info commands winfo]] > 0 && $_edit_widget ne "" && [winfo exists $_edit_widget]} {
        return $_edit_var
    }
    set value ""
    set got 0
    if {[llength [info commands winfo]] > 0 && $_tbl ne "" && [winfo exists $_tbl]} {
        if {![catch {set value [$_tbl get $r,$c]}]} { set got 1 }
        if {!$got && ![catch {set value [$_tbl get active]}]} { set got 1 }
    }
    if {!$got && [info exists tableData($r,$c)]} {
        set value $tableData($r,$c)
    }
    return $value
}

proc ::nc::ui_table::_on_edit_commit {} {
    variable _tbl
    variable _rows
    variable _tab
    variable _edit_orig
    variable _editing_cell
    variable _edit_widget
    variable tableData
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    if {$_editing_cell eq ""} { return }
    lassign [split $_editing_cell ,] r c
    if {![string is integer -strict $r] || $r < 1 || ![string is integer -strict $c]} {
        catch {$_tbl configure -state disabled}
        return
    }
    set key [lindex [lindex [_cols_for_tab $_tab] $c] 0]
    if {$key ni [_editable_fields $_tab]} { catch {$_tbl configure -state disabled}; return }
    if {$_tab eq "properties"} {
        set row [lindex $_rows [expr {$r - 1}]]
        if {![_property_field_applicable $row $key]} {
            catch {$_tbl configure -state disabled}
            return
        }
    }
    set new_val [_editing_cell_value $r $c]
    set tableData($r,$c) $new_val
    catch {$_tbl configure -state disabled}
    catch {$_tbl window configure $r,$c -window ""}
    if {$_edit_widget ne ""} { catch {destroy $_edit_widget} }
    set _edit_widget ""
    _clear_editing_visual $r,$c
    set _editing_cell ""
    if {[_stage_cell_value $r $c $key $new_val $_edit_orig] && $new_val eq $_edit_orig} {
        catch {$_tbl reread}
    }
}

# Commit/close any inline edit or cell dropdown currently open, so no
# embedded edit widget is left parked on a Tktable cell. Safe to call when
# nothing is being edited (both branches no-op on empty state). Called before
# a tab switch and anywhere else the grid is about to be repopulated under an
# open editor.
proc ::nc::ui_table::_finalize_active_edit {} {
    variable _editing_cell
    variable _combo_cell
    if {$_combo_cell ne ""} { catch {_close_cell_dropdown 1} }
    if {$_editing_cell ne ""} { catch {_on_edit_commit} }
}

proc ::nc::ui_table::_on_edit_cancel {} {
    variable _tbl
    variable _edit_orig
    variable _editing_cell
    variable _edit_widget
    variable tableData
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    if {$_editing_cell eq ""} { return }
    _close_cell_dropdown 1
    lassign [split $_editing_cell ,] r c
    if {[string is integer -strict $r] && $r >= 1 && [string is integer -strict $c]} {
        set tableData($r,$c) $_edit_orig
        catch {$_tbl window configure $r,$c -window ""}
        _clear_editing_visual $r,$c
        _apply_tags
        catch {$_tbl reread}
    }
    if {$_edit_widget ne ""} { catch {destroy $_edit_widget} }
    set _edit_widget ""
    catch {$_tbl configure -state disabled}
    set _editing_cell ""
}

proc ::nc::ui_table::_show_context_menu {X Y} {
    variable _context_menu
    variable _tbl
    if {$_tbl ne "" && [winfo exists $_tbl]} {
        set x [expr {$X - [winfo rootx $_tbl]}]
        set y [expr {$Y - [winfo rooty $_tbl]}]
        set col [_header_col_at_xy $x $y]
        if {$col >= 0} {
            _show_header_context_menu $col $X $Y
            return
        }
        # Right-clicking a cell moves the active-cell pointer there (so
        # single-cell actions like Remove Label always act on the cell the
        # user actually clicked, not whatever was last left-clicked), but
        # deliberately leaves the current multi-selection untouched - bulk
        # actions from this same menu (Copy, Stage Duplicate, Stage Delete,
        # Isolate) still operate on the full selection as before.
        set cell ""
        catch {set cell [$_tbl index @$x,$y]}
        if {$cell ne ""} {
            lassign [split $cell ,] cr cc
            if {[string is integer -strict $cr] && $cr >= 1} {
                catch {$_tbl activate $cell}
            }
        }
    }
    if {$_context_menu eq ""} { set _context_menu .nc_table_context }
    # Always rebuild (not just create-once-if-missing): in the CAE tool, this
    # tool's script gets re-sourced on "Reload" but the Tk interpreter - and
    # any menu widget already created in it - stays alive across that, so a
    # stale cached menu here would silently keep showing pre-reload items no
    # matter what the code says.
    catch {destroy $_context_menu}
    menu $_context_menu -tearoff 0
    $_context_menu add command -label "Copy" -command {::nc::ui_table::copy_selection_to_clipboard}
    $_context_menu add command -label "Paste" -command {::nc::ui_table::_paste_clipboard}
    $_context_menu add separator
    $_context_menu add command -label "Assign Material Label..." -command {::nc::ui_table::_on_assign}
    $_context_menu add command -label "Stage Duplicate" -command {::nc::ui_table::_on_duplicate}
    $_context_menu add command -label "Stage Delete" -command {::nc::ui_table::_on_delete}
    $_context_menu add command -label "Remove Label" -command {::nc::ui_table::_on_remove_label_from_context}
    $_context_menu add separator
    $_context_menu add command -label "Isolate" -accelerator "Shift+S" -command {::nc::ui_table::_on_isolate}
    $_context_menu add command -label "Find Comp" -accelerator "Shift+F" -command {::nc::ui_table::_on_find_comp}
    $_context_menu add command -label "Highlight Comp" -accelerator "Shift+H" -command {::nc::ui_table::_on_highlight_comp}
    $_context_menu add command -label "Invert Last Action" -accelerator "Shift+I" -command {::nc::ui_table::_on_invert_last_action}
    $_context_menu add command -label "Hide Comp" -command {::nc::ui_table::_on_hide_comp}
    $_context_menu add command -label "Show Comp" -command {::nc::ui_table::_on_show_comp}
    $_context_menu add separator
    _build_columns_submenu $_context_menu.columns
    $_context_menu add cascade -label "Show/Hide Columns" -menu $_context_menu.columns
    $_context_menu add command -label "Show All Columns" -command {::nc::ui_table::_show_all_tab_columns $::nc::ui_table::_tab}
    catch {tk_popup $_context_menu $X $Y}
}

# Same column-visibility mechanism as the tab-button right-click menu
# (_column_visible_var / _set_tab_column_visible), just reachable from a
# regular cell right-click too so you don't have to right-click the tab
# button specifically to find it.
proc ::nc::ui_table::_build_columns_submenu {menu_path} {
    variable _tab
    variable _column_visible_var
    variable _hidden_cols
    catch {destroy $menu_path}
    menu $menu_path -tearoff 0
    foreach col_def [_cols_for_tab $_tab 1] {
        set key [lindex $col_def 0]
        if {$key eq "_rownum"} continue
        set hidden 0
        if {[info exists _hidden_cols($_tab)]} {
            set hidden [expr {[lsearch -exact $_hidden_cols($_tab) $key] >= 0}]
        }
        set _column_visible_var($_tab,$key) [expr {!$hidden}]
        $menu_path add checkbutton -label [_column_menu_label $col_def] \
            -variable ::nc::ui_table::_column_visible_var($_tab,$key) \
            -command [list ::nc::ui_table::_set_tab_column_visible $_tab $key]
    }
}

proc ::nc::ui_table::_show_header_context_menu {col X Y} {
    variable _tab
    set cols [_cols_for_tab $_tab]
    if {$col < 0 || $col >= [llength $cols]} { return -code break }
    set col_def [lindex $cols $col]
    set key [lindex $col_def 0]
    set label [lindex $col_def 1]
    set menu .nc_header_context
    catch {destroy $menu}
    menu $menu -tearoff 0
    set any 0
    if {$key eq "mass_total"} {
        $menu add radiobutton -label "kg" -variable ::nc::ui_table::_mass_unit -value kg \
            -command {::nc::ui_table::_on_mass_unit_changed}
        $menu add radiobutton -label "ton" -variable ::nc::ui_table::_mass_unit -value ton \
            -command {::nc::ui_table::_on_mass_unit_changed}
        set any 1
    }
    if {$key ne "image_path"} {
        if {$any} { $menu add separator }
        $menu add command -label "Filter this column (Worklist)..." \
            -command [list ::nc::ui_table::_on_worklist $key]
        $menu add command -label "Clear this column Worklist" \
            -command [list ::nc::ui_table::_on_worklist_clear_for_col $key $label]
        set any 1
    }
    if {!$any} { return -code break }
    catch {tk_popup $menu $X $Y}
    return -code break
}

proc ::nc::ui_table::_on_mass_unit_changed {} {
    _rebuild_table_columns
    _populate_current
    _set_status "Mass unit: [_mass_header_label]" ok
}

# -----------------------------------------------------------------------------
# Paste input contract (input-consistency rework):
#   1. ID-anchored mode - if the pasted block's first line is a header row
#      containing this tab's ID column (e.g. copied straight from an exported
#      Excel sheet), every data line is matched to its row BY ID against the
#      full tab data. Screen position, sort order, and filters are ignored,
#      so a sheet exported in a different sort order still lands on the right
#      entities. Lines whose ID isn't found are skipped and counted.
#   2. Position mode (no header row) - legacy behavior, pastes onto the rows
#      as currently displayed. If more than one row is pasted while the view
#      is reordered (sorted/searched/worklist/property-filtered), a confirm
#      dialog first shows exactly which entity each line will hit.
# Both modes write only _editable_fields (HM-scanned identity fields can
# never be overwritten by paste) and stay preview-only (no HM mutation).
# -----------------------------------------------------------------------------

proc ::nc::ui_table::_paste_by_id {data_lines keys id_col} {
    variable _tab
    variable _tab_rows
    set editable [_editable_fields $_tab]
    set matched 0
    set skipped 0
    set cells 0
    # Which specific IDs got skipped and why, so the status message can
    # name them instead of just an aggregate count - a paste with a few
    # stale/mistyped IDs used to look like it "mostly worked" with no way
    # to tell which rows were silently dropped.
    set unmatched_ids {}
    set empty_id_lines 0
    foreach line $data_lines {
        if {[string trim $line] eq ""} { continue }
        set values [split $line "\t"]
        set id [string trim [lindex $values $id_col]]
        if {$id eq ""} { incr skipped; incr empty_id_lines; continue }
        set row ""
        set src [expr {[info exists _tab_rows($_tab)] ? $_tab_rows($_tab) : {}}]
        foreach r $src {
            if {[_row_key_for_tab $_tab $r] eq $id} { set row $r; break }
        }
        if {$row eq ""} { incr skipped; lappend unmatched_ids $id; continue }
        set row_key [_row_key_for_tab $_tab $row]
        set wrote 0
        for {set j 0} {$j < [llength $keys]} {incr j} {
            if {$j == $id_col} continue
            if {$j >= [llength $values]} break
            set key [lindex $keys $j]
            if {$key eq "" || $key ni $editable} continue
            if {$_tab eq "properties" && ![_property_field_applicable $row $key]} continue
            set row [_set_row_value $_tab $row $key [lindex $values $j]]
            incr wrote
        }
        if {$wrote > 0} {
            if {$_tab in {general component}} {
                _sync_component_fields [_dict_get $row comp_id] $row
            } else {
                _replace_row $_tab $row_key $row
            }
            incr matched
            incr cells $wrote
        } else {
            incr skipped
        }
    }
    _populate_current
    set msg "Pasted by ID: $matched row(s) matched, $cells cell(s) staged, $skipped line(s) skipped (preview only)."
    if {[llength $unmatched_ids] > 0} {
        append msg " No existing row for ID(s): [join $unmatched_ids {, }]."
    }
    if {$empty_id_lines > 0} {
        append msg " $empty_id_lines line(s) had a blank ID."
    }
    _set_status $msg ok
}

# Returns 1 when the first pasted line matches this tab's current header
# row exactly (all cells, case-insensitive, trimmed). Used to skip a
# header line silently on paste-back after a Copy - copy_selection_to_clipboard
# always emits headers as the first line, and without this the header
# text ("Lib No", "Material Name", ...) would land as literal values in
# the first data row on paste-back.
proc ::nc::ui_table::_paste_header_matches_cols {cells cols} {
    if {[llength $cells] != [llength $cols]} { return 0 }
    for {set i 0} {$i < [llength $cols]} {incr i} {
        set expected [string tolower [string trim [lindex [lindex $cols $i] 1]]]
        set got [string tolower [string trim [lindex $cells $i]]]
        if {$got ne $expected} { return 0 }
    }
    return 1
}

proc ::nc::ui_table::_paste_first_line_is_header {tab first_line} {
    set cells [split $first_line "\t"]
    if {$tab eq "properties"} {
        # Properties' column set/order depends on the active Property View
        # filter (ALL/PSHELL/PSOLID/PBUSH). A header copied under one view
        # has a different column count/order than another view, so only
        # checking the CURRENTLY active view missed a genuine header copied
        # under a different view - it silently fell through and got pasted
        # as literal text into row 1. Check every view's layout instead of
        # just the one active right now.
        variable _property_view
        set saved_view $_property_view
        set found 0
        foreach view {ALL PSHELL PSOLID PBUSH} {
            set _property_view $view
            if {[_paste_header_matches_cols $cells [_cols_for_tab $tab]]} { set found 1; break }
        }
        set _property_view $saved_view
        return $found
    }
    return [_paste_header_matches_cols $cells [_cols_for_tab $tab]]
}

proc ::nc::ui_table::_paste_clipboard {} {
    variable _tbl
    variable _rows
    variable _tab
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    set text ""
    catch {set text [clipboard get]}
    if {[string trim $text] eq ""} { return }
    set lines [split [string trimright $text] "\n"]

    # ID-anchored mode: first line is a header row naming this tab's ID column
    # plus at least one other recognizable column.
    if {[llength $lines] >= 2} {
        set hdr_cells [split [lindex $lines 0] "\t"]
        set keys {}
        set mapped 0
        foreach h $hdr_cells {
            set k [_import_key_for_header $_tab $h]
            lappend keys $k
            if {$k ne ""} { incr mapped }
        }
        set id_field [_import_key_field_for_tab $_tab]
        set id_col [lsearch -exact $keys $id_field]
        if {$id_col >= 0 && $mapped >= 2} {
            _paste_by_id [lrange $lines 1 end] $keys $id_col
            return
        }
    }

    # Copy-from-this-tool always emits the display header as the first line
    # (so pasting into Excel gets column names). On paste-back into the tool
    # itself, that header line would otherwise land as literal text in the
    # first data row - detect and skip it silently. Only skips when the
    # entire line matches the current tab's headers, so a genuinely-headerless
    # paste from Excel still works.
    if {[llength $lines] >= 2 && [_paste_first_line_is_header $_tab [lindex $lines 0]]} {
        set lines [lrange $lines 1 end]
    }

    # Target rows come from the user's row selection when they highlighted
    # a multi-row range; when the clipboard has fewer rows than the target
    # range, the clipboard rows tile (repeat) to fill the whole range. Only
    # rows are driven by selection - columns follow the clipboard content
    # starting at the leftmost selected column (per user's spec).
    #
    # If the selection is just a single cell (or empty), fall back to the
    # legacy "paste starting at active cell, one clipboard line per row"
    # behavior - that's what a normal cell-into-cell paste expects.
    set target_rows [_paste_target_rows]
    set active ""
    catch {set active [$_tbl index active]}
    if {$active eq ""} { set active "1,0" }
    lassign [split $active ,] start_r start_c
    if {![string is integer -strict $start_r] || $start_r < 1} { set start_r 1 }
    if {![string is integer -strict $start_c] || $start_c < 0} { set start_c 0 }
    # If the user highlighted multiple rows, override start_c with the
    # leftmost selected column so the paste block aligns with the highlight.
    set sel_c [_paste_target_start_col]
    if {[llength $target_rows] > 1 && $sel_c >= 0} { set start_c $sel_c }

    if {[llength $target_rows] <= 1} {
        # Legacy path: one clipboard line per row, going down from active.
        set target_rows {}
        for {set i 0} {$i < [llength $lines]} {incr i} {
            lappend target_rows [expr {$start_r + $i}]
        }
    }

    set cols [_cols_for_tab $_tab]
    set nlines [llength $lines]
    set changed 0
    set i 0
    foreach r $target_rows {
        if {$r < 1 || $r > [llength $_rows]} { incr i; continue }
        # Tile clipboard: pick clipboard line (i mod nlines) so a single
        # clipboard line broadcasts across all target rows, and N clipboard
        # lines cycle to fill M target rows.
        set clip_idx [expr {$nlines > 0 ? $i % $nlines : 0}]
        set values [split [lindex $lines $clip_idx] "\t"]
        set row [lindex $_rows [expr {$r - 1}]]
        set row_key [_row_key_for_tab $_tab $row]
        for {set j 0} {$j < [llength $values]} {incr j} {
            set c [expr {$start_c + $j}]
            if {$c >= [llength $cols]} break
            set key [lindex [lindex $cols $c] 0]
            if {$key ni [_editable_fields $_tab]} continue
            if {$_tab eq "properties" && ![_property_field_applicable $row $key]} continue
            set row [_set_row_value $_tab $row $key [lindex $values $j]]
            incr changed
        }
        if {$_tab in {general component}} {
            _sync_component_fields [_dict_get $row comp_id] $row
        } else {
            _replace_row $_tab $row_key $row
            if {$_tab eq "materials"} {
                _sync_material_label_across_rows $row
            }
        }
        incr i
    }
    _populate_current
    _set_status "Pasted/staged $changed cell(s) (preview only)." ok
}

# Returns the sorted list of distinct row indices currently selected in the
# Tktable (row 0 = header row is filtered out). Empty when no cell is
# selected. Used by _paste_clipboard to decide "broadcast to selection" vs
# legacy "paste at active cell" behavior.
proc ::nc::ui_table::_paste_target_rows {} {
    variable _tbl
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return {} }
    set seen [dict create]
    catch {
        foreach cell [$_tbl curselection] {
            lassign [split $cell ,] r c
            if {![string is integer -strict $r]} continue
            if {$r < 1} continue
            dict set seen $r 1
        }
    }
    return [lsort -integer [dict keys $seen]]
}

# Leftmost column index in the current selection, or -1 when no cell is
# selected. Used to align the paste block with the highlighted range.
proc ::nc::ui_table::_paste_target_start_col {} {
    variable _tbl
    if {$_tbl eq "" || ![winfo exists $_tbl]} { return -1 }
    set cs {}
    catch {
        foreach cell [$_tbl curselection] {
            lassign [split $cell ,] r c
            if {[string is integer -strict $c]} { lappend cs $c }
        }
    }
    if {[llength $cs] == 0} { return -1 }
    return [lindex [lsort -integer $cs] 0]
}

proc ::nc::ui_table::_clear_selection {} {
    variable _tbl
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    catch {$_tbl selection clear all}
    _set_status "Selection cleared." ok
}

proc ::nc::ui_table::_select_dirty_rows {} {
    variable _tbl
    variable _rows
    variable _tab
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    catch {$_tbl selection clear all}
    set ncols [_ncols_for_tab $_tab]
    set count 0
    set r 1
    foreach row $_rows {
        if {[llength [_dict_get $row _dirty_fields {}]] > 0} {
            catch {$_tbl selection set $r,0 $r,[expr {$ncols - 1}]}
            incr count
        }
        incr r
    }
    _set_status "Selected $count dirty row(s)." ok
}

# =============================================================================
# Actions
# =============================================================================

proc ::nc::ui_table::_on_assign {} {
    variable _tab
    variable _mat_label
    if {$_tab ne "component"} {
        _set_status "Switch to Component tab to stage material labels." warn
        return
    }
    set label [string trim $_mat_label]
    if {$label eq ""} {
        _set_status "Choose a Material Label first." warn
        return
    }
    set rows [get_selected_rows]
    if {[llength $rows] == 0} {
        _set_status "Select component rows first." warn
        return
    }
    foreach row $rows {
        set row [_set_row_value component $row mat_user_name $label]
        _sync_component_fields [_dict_get $row comp_id] $row
    }
    _populate_current
    _set_status "Staged Material Label '$label' on [llength $rows] row(s); no HM write." ok
}

proc ::nc::ui_table::_on_calculate_mass {} {
    variable _tab
    if {$_tab ne "component"} {
        _set_status "Switch to Component tab to calculate component mass." warn
        return
    }
    if {[llength [info commands ::nc::app::calculate_component_masses]] == 0} {
        _set_status "Mass calculation is available after launching through nastran_control.tcl." warn
        return
    }
    ::nc::app::calculate_component_masses
}

proc ::nc::ui_table::_next_id_for_tab {tab} {
    variable _tab_rows
    set key [expr {$tab eq "materials" ? "mat_id" : "prop_id"}]
    set max 0
    if {[info exists _tab_rows($tab)]} {
        foreach row $_tab_rows($tab) {
            set id [_dict_get $row $key]
            if {[string is integer -strict $id] && $id > $max} { set max $id }
        }
    }
    return [expr {$max + 1}]
}

proc ::nc::ui_table::_on_new {} {
    variable _tab
    variable _tab_rows
    if {$_tab eq "properties"} {
        set id [_next_id_for_tab properties]
        lappend _tab_rows(properties) [dict create prop_card PSHELL prop_id $id mat_card MAT1 mat_id "" T 1.0 NSM 0 Z1 "" Z2 "" note "New staged property" _dirty_fields {prop_card prop_id T note}]
        _set_session_dirty 1
        _populate_current
        _set_status "Staged new Property $id (preview only)." ok
        return
    }
    if {$_tab eq "materials"} {
        set id [_next_id_for_tab materials]
        lappend _tab_rows(materials) [dict create mat_card MAT1 mat_id $id mat_user_name "New_Material_$id" mat_label "" mat_name "MAT1_$id" E 210000 G "" NU 0.3 RHO "" A "" TREF "" GE "" ST "" SC "" SS "" note "New staged material" _dirty_fields {mat_id mat_user_name mat_name note}]
        _set_session_dirty 1
        _refresh_material_options
        _populate_current
        _set_status "Staged new Material $id (preview only)." ok
        return
    }
    _set_status "New is preview-enabled on Property and Material tabs." warn
}

proc ::nc::ui_table::_on_duplicate {} {
    variable _tab
    variable _tab_rows
    if {$_tab ni {properties materials}} {
        _set_status "Duplicate is preview-enabled on Property and Material tabs." warn
        return
    }
    set rows [get_selected_rows]
    if {[llength $rows] == 0} {
        _set_status "Select row(s) first." warn
        return
    }
    set id_key [expr {$_tab eq "materials" ? "mat_id" : "prop_id"}]
    foreach row $rows {
        set id [_next_id_for_tab $_tab]
        dict set row $id_key $id
        dict set row note "Duplicated in preview"
        dict set row _dirty_fields [list $id_key note]
        lappend _tab_rows($_tab) $row
    }
    _set_session_dirty 1
    _refresh_material_options
    _populate_current
    _set_status "Duplicated [llength $rows] row(s) in preview only." ok
}

proc ::nc::ui_table::_on_delete {} {
    variable _tab
    variable _tab_rows
    if {$_tab ni {properties materials}} {
        _set_status "Delete is preview-enabled on Property and Material tabs." warn
        return
    }
    set rows [get_selected_rows]
    if {[llength $rows] == 0} {
        _set_status "Select row(s) first." warn
        return
    }
    set doomed {}
    foreach row $rows { lappend doomed [_row_key_for_tab $_tab $row] }
    set out {}
    foreach row $_tab_rows($_tab) {
        if {[lsearch -exact $doomed [_row_key_for_tab $_tab $row]] < 0} { lappend out $row }
    }
    set _tab_rows($_tab) $out
    _set_session_dirty 1
    _refresh_material_options
    _populate_current
    _set_status "Removed [llength $doomed] row(s) from preview table only." ok
}

proc ::nc::ui_table::_on_apply {} {
    set pending_committed [_commit_pending_labels 0]
    set dirty 0
    foreach tab {general component properties materials} {
        variable _tab_rows
        if {![info exists _tab_rows($tab)]} continue
        foreach row $_tab_rows($tab) { incr dirty [llength [_dict_get $row _dirty_fields {}]] }
    }
    _set_status "Apply Tab preview: committed $pending_committed pending label row(s), $dirty staged field marker(s), no HM changes." warn
}

proc ::nc::ui_table::_dirty_counts_by_tab {} {
    variable _tab_rows
    set counts [dict create]
    foreach tab {general component properties materials} {
        set dirty 0
        if {[info exists _tab_rows($tab)]} {
            foreach row $_tab_rows($tab) {
                incr dirty [llength [_dict_get $row _dirty_fields {}]]
            }
        }
        dict set counts $tab $dirty
    }
    return $counts
}

proc ::nc::ui_table::_on_apply_all {} {
    set pending_committed [_commit_all_pending_labels]
    set counts [_dirty_counts_by_tab]
    set total 0
    foreach tab {general component properties materials} {
        incr total [dict get $counts $tab]
    }
    set msg "Apply All preview: committed $pending_committed pending label row(s), $total staged field marker(s)"
    append msg " (G:[dict get $counts general], C:[dict get $counts component], P:[dict get $counts properties], M:[dict get $counts materials]); no HM changes."
    _set_status $msg warn
}

proc ::nc::ui_table::_dirty_has_any {dirty fields} {
    foreach field $fields {
        if {[lsearch -exact $dirty $field] >= 0} { return 1 }
    }
    return 0
}

proc ::nc::ui_table::_append_limited {var_name item {limit 20}} {
    upvar 1 $var_name items
    if {[llength $items] < $limit} {
        lappend items $item
    } elseif {[llength $items] == $limit} {
        lappend items "... more blocked items omitted"
    }
}

proc ::nc::ui_table::_row_identity_label {row} {
    set cid [_dict_get $row comp_id]
    set label [_dict_get $row comp_user_name [_dict_get $row label [_dict_get $row hm_comp_name [_dict_get $row comp_name]]]]
    if {$cid ne "" && $label ne ""} { return "comp $cid ($label)" }
    if {$cid ne ""} { return "comp $cid" }
    if {$label ne ""} { return $label }
    return "component row"
}

proc ::nc::ui_table::_hm_apply_build_plan {} {
    variable _tab_rows
    variable _worklist_active
    variable _search_text
    set actions {}
    set rename_count 0
    set assign_count 0
    set unsupported 0
    set skipped 0
    set blockers {}
    set warnings {}
    set supported_fields {comp_user_name label mat_user_name material_label mat_id}
    set prop_counts [_component_prop_usage_counts]

    if {$_worklist_active || [string trim $_search_text] ne ""} {
        _append_limited blockers "Clear search/worklist before Apply to HM. Live apply is blocked while rows may be hidden."
    }

    foreach tab {general component properties materials} {
        if {![info exists _tab_rows($tab)]} continue
        foreach warning [_duplicate_row_key_warnings $tab $_tab_rows($tab)] {
            _append_limited blockers $warning
        }
    }

    set existing_names [dict create]
    set existing_names_ci [dict create]
    if {[info exists _tab_rows(component)]} {
        foreach row $_tab_rows(component) {
            set cid [_dict_get $row comp_id]
            set old_name [_dict_get $row hm_comp_name [_dict_get $row comp_name]]
            if {$old_name ne "" && $cid ne ""} {
                dict set existing_names $old_name $cid
                dict set existing_names_ci [string tolower $old_name] $cid
            }
        }
    }
    set rename_targets [dict create]
    set rename_targets_ci [dict create]
    set assign_by_prop [dict create]

    if {[info exists _tab_rows(component)]} {
        foreach row $_tab_rows(component) {
            set dirty [_dict_get $row _dirty_fields {}]
            if {[llength $dirty] == 0} { continue }
            foreach field $dirty {
                if {[lsearch -exact $supported_fields $field] < 0} {
                    incr unsupported
                    _append_limited blockers "[_row_identity_label $row]: staged field '$field' is preview-only and cannot be live-applied yet"
                }
            }
            set cid [_dict_get $row comp_id]
            if {$cid eq ""} {
                incr skipped
                _append_limited blockers "[_row_identity_label $row]: missing component ID"
                continue
            }
            if {[_dirty_has_any $dirty {comp_user_name label}]} {
                set old_name [_dict_get $row hm_comp_name [_dict_get $row comp_name]]
                set raw_name [_dict_get $row comp_user_name [_dict_get $row label]]
                set new_name $raw_name
                set new_name [::nc::labels::sanitise $new_name]
                if {$old_name eq ""} {
                    _append_limited blockers "[_row_identity_label $row]: missing HM baseline component name; rescan before apply"
                    incr skipped
                } elseif {[string trim $raw_name] eq "" || $new_name eq ""} {
                    _append_limited blockers "[_row_identity_label $row]: rename target is blank"
                    incr skipped
                } elseif {[regexp {[\r\n\t]} $raw_name]} {
                    _append_limited blockers "[_row_identity_label $row]: rename target contains tab/newline control characters"
                    incr skipped
                } elseif {$old_name ne $new_name} {
                    set target_ci [string tolower $new_name]
                    if {[dict exists $rename_targets $new_name] || [dict exists $rename_targets_ci $target_ci]} {
                        _append_limited blockers "[_row_identity_label $row]: duplicate rename target '$new_name'"
                    }
                    if {[dict exists $existing_names $new_name] && [dict get $existing_names $new_name] ne $cid} {
                        _append_limited blockers "[_row_identity_label $row]: rename target '$new_name' already exists in component [dict get $existing_names $new_name]"
                    }
                    if {[dict exists $existing_names_ci $target_ci] && [dict get $existing_names_ci $target_ci] ne $cid} {
                        _append_limited blockers "[_row_identity_label $row]: rename target '$new_name' collides case-insensitively with component [dict get $existing_names_ci $target_ci]"
                    }
                    dict set rename_targets $new_name $cid
                    dict set rename_targets_ci $target_ci $cid
                    if {$raw_name ne $new_name} {
                        lappend warnings "[_row_identity_label $row]: rename will be sanitized to '$new_name'"
                    }
                    lappend actions [dict create type rename_comp comp_id $cid prop_id [_dict_get $row prop_id] old_name $old_name new_name $new_name fields {comp_user_name label}]
                    incr rename_count
                }
            }
            if {[_dirty_has_any $dirty {mat_user_name material_label mat_id}]} {
                set prop_id [_dict_get $row hm_prop_id [_dict_get $row prop_id]]
                set mat_id [_dict_get $row mat_id]
                set old_mat_id [_dict_get $row hm_mat_id]
                set ct [_dict_get $row case_type 1]
                if {$ct == 3 || $prop_id eq "" || ![string is integer -strict $prop_id] || $prop_id <= 0} {
                    incr skipped
                    _append_limited blockers "[_row_identity_label $row]: material assignment needs a valid property ID"
                } elseif {$mat_id eq "" || ![string is integer -strict $mat_id] || $mat_id <= 0} {
                    incr skipped
                    _append_limited blockers "[_row_identity_label $row]: material assignment needs a valid target material ID"
                } elseif {$old_mat_id eq "" || ![string is integer -strict $old_mat_id] || $old_mat_id <= 0} {
                    incr skipped
                    _append_limited blockers "[_row_identity_label $row]: missing HM baseline material ID; rescan before apply"
                } elseif {$old_mat_id ne "" && $old_mat_id eq $mat_id} {
                    incr skipped
                } else {
                    set usage 0
                    if {[dict exists $prop_counts $prop_id]} { set usage [dict get $prop_counts $prop_id] }
                    if {$usage > 1} {
                        _append_limited blockers "Property $prop_id is shared by $usage component rows; material assignment is blocked until explicitly split/reviewed"
                    }
                    set entry [dict create comp_id $cid comp_label [_dict_get $row comp_user_name [_dict_get $row label]] mat_id $mat_id mat_label [_dict_get $row mat_user_name [_dict_get $row material_label]] old_mat_id $old_mat_id]
                    dict lappend assign_by_prop $prop_id $entry
                }
            }
        }
    }

    dict for {prop_id entries} $assign_by_prop {
        set targets {}
        set comp_ids {}
        set comp_labels {}
        set old_mat_id ""
        set mat_label ""
        foreach entry $entries {
            set target [dict get $entry mat_id]
            if {[lsearch -exact $targets $target] < 0} { lappend targets $target }
            lappend comp_ids [dict get $entry comp_id]
            lappend comp_labels [dict get $entry comp_label]
            if {$old_mat_id eq ""} { set old_mat_id [dict get $entry old_mat_id] }
            if {$mat_label eq ""} { set mat_label [dict get $entry mat_label] }
        }
        if {[llength $targets] > 1} {
            _append_limited blockers "Property $prop_id has conflicting target materials: [join $targets {, }]"
            continue
        }
        set mat_id [lindex $targets 0]
        lappend actions [dict create type assign_material comp_id [lindex $comp_ids 0] comp_ids $comp_ids comp_label [lindex $comp_labels 0] comp_labels $comp_labels prop_id $prop_id old_mat_id $old_mat_id mat_id $mat_id mat_label $mat_label affected_count [llength $entries] fields {mat_user_name material_label mat_id}]
        incr assign_count
    }

    foreach tab {properties materials} {
        if {![info exists _tab_rows($tab)]} continue
        foreach row $_tab_rows($tab) {
            foreach field [_dict_get $row _dirty_fields {}] {
                incr unsupported
                _append_limited blockers "[_tab_label $tab] row [_row_key_for_tab $tab $row]: staged field '$field' is preview-only and cannot be live-applied yet"
            }
        }
    }

    return [dict create actions $actions rename $rename_count assign $assign_count unsupported $unsupported skipped $skipped blockers $blockers warnings $warnings]
}

proc ::nc::ui_table::_hm_apply_confirm_message {plan} {
    set lines {}
    lappend lines "Apply verified preview changes to the live the CAE tool model?"
    lappend lines ""
    lappend lines "Rename components: [dict get $plan rename]"
    lappend lines "Assign materials: [dict get $plan assign]"
    lappend lines "Unsupported/skipped staged fields: [expr {[dict get $plan unsupported] + [dict get $plan skipped]}]"
    if {[dict exists $plan warnings] && [llength [dict get $plan warnings]] > 0} {
        lappend lines ""
        lappend lines "Warnings:"
        foreach w [lrange [dict get $plan warnings] 0 8] { lappend lines "- $w" }
    }
    lappend lines ""
    lappend lines "Only verified commands are enabled:"
    lappend lines "- verified component rename"
    lappend lines "- verified property material assignment"
    lappend lines ""
    lappend lines "Save or copy the model before continuing."
    return [join $lines "\n"]
}

proc ::nc::ui_table::_hm_apply_block_message {plan} {
    set lines {}
    lappend lines "Apply to HM is blocked by safety checks."
    lappend lines ""
    foreach blocker [dict get $plan blockers] {
        lappend lines "- $blocker"
    }
    lappend lines ""
    lappend lines "Fix the listed items, clear filters/worklists if active, or rescan to refresh HM baselines."
    return [join $lines "\n"]
}

proc ::nc::ui_table::_clear_dirty_fields_for_action {action} {
    variable _tab_rows
    set cids [_dict_get $action comp_ids {}]
    if {[llength $cids] == 0} { set cids [list [_dict_get $action comp_id]] }
    set fields [_dict_get $action fields {}]
    if {[llength $fields] == 0} { return }
    foreach tab {general component} {
        if {![info exists _tab_rows($tab)]} continue
        set out {}
        foreach row $_tab_rows($tab) {
            if {[lsearch -exact $cids [_dict_get $row comp_id]] >= 0} {
                if {[dict exists $action new_name]} {
                    dict set row hm_comp_name [dict get $action new_name]
                    dict set row comp_name [dict get $action new_name]
                    dict set row comp_user_name [dict get $action new_name]
                    dict set row label [dict get $action new_name]
                }
                if {[dict exists $action mat_id]} {
                    set new_mid [dict get $action mat_id]
                    dict set row mat_id $new_mid
                    dict set row hm_mat_id $new_mid
                    if {[dict exists $action mat_label]} { dict set row hm_material_label [dict get $action mat_label] }
                    # mat_name/mat_card/mat_user_name were cached at the last
                    # scan and are keyed off mat_id at display time - without
                    # re-deriving them here from the new mat_id, the row shows
                    # the OLD material's label/type next to the new mat_id
                    # until the next full rescan.
                    set mat_row [_material_row_by_id $new_mid]
                    if {$mat_row ne ""} {
                        dict set row mat_user_name [_dict_get $mat_row mat_user_name]
                        dict set row material_label [_dict_get $mat_row mat_user_name]
                        foreach k {mat_label mat_name mat_card E G NU RHO A TREF} {
                            if {[dict exists $mat_row $k]} { dict set row $k [dict get $mat_row $k] }
                        }
                    }
                }
                set dirty [_dict_get $row _dirty_fields {}]
                foreach field $fields {
                    set idx [lsearch -exact $dirty $field]
                    if {$idx >= 0} { set dirty [lreplace $dirty $idx $idx] }
                }
                dict set row _dirty_fields $dirty
            }
            lappend out $row
        }
        set _tab_rows($tab) $out
    }
}

proc ::nc::ui_table::_clear_successful_hm_dirty_fields {results} {
    foreach result $results {
        if {![dict exists $result status] || [dict get $result status] ne "ok"} { continue }
        if {![dict exists $result action]} { continue }
        _clear_dirty_fields_for_action [dict get $result action]
    }
    _populate_current
}

proc ::nc::ui_table::_on_apply_to_hm {} {
    _autosave_suspend_begin
    set code [catch {_on_apply_to_hm_impl} result]
    _autosave_suspend_end
    if {$code} { return -code error $result }
    return $result
}

proc ::nc::ui_table::_on_apply_to_hm_impl {} {
    set plan [_hm_apply_build_plan]
    set actions [dict get $plan actions]
    if {[dict exists $plan blockers] && [llength [dict get $plan blockers]] > 0} {
        catch {
            _table_message_box \
                -title "Apply to the CAE tool Blocked" \
                -icon error \
                -type ok \
                -message [_hm_apply_block_message $plan]
        }
        _set_status "Apply to HM blocked by [llength [dict get $plan blockers]] safety check(s)." warn
        return
    }
    if {[llength $actions] == 0} {
        _set_status "No verified HM actions to apply. Property/material create/delete/card fields remain preview-only." warn
        return
    }
    set answer no
    catch {
        set answer [_table_message_box \
            -title "Apply to the CAE tool" \
            -icon warning \
            -type yesno \
            -message [_hm_apply_confirm_message $plan]]
    }
    if {$answer ne "yes"} {
        _set_status "Apply to HM canceled." warn
        return
    }
    set result [::nc::mutations::apply_component_hm_changes $actions]
    if {[dict exists $result results]} {
        _clear_successful_hm_dirty_fields [dict get $result results]
    }
    _set_session_dirty 1
    _set_status [dict get $result message] [dict get $result status]
}

# Finds every general/component row whose prop_id (or mat_id) matches the
# given value, and returns the unique comp_id(s) that reference it. Used so
# Isolate can work from the Properties/Materials tabs, whose own rows don't
# carry a comp_id.
proc ::nc::ui_table::_comp_ids_referencing {ref_field ref_value} {
    variable _tab_rows
    set out {}
    if {$ref_value eq ""} { return $out }
    foreach tab {component general} {
        if {![info exists _tab_rows($tab)]} continue
        foreach row $_tab_rows($tab) {
            set v [_dict_get $row hm_$ref_field [_dict_get $row $ref_field]]
            set cid [_dict_get $row comp_id]
            if {$v eq $ref_value && $cid ne "" && [lsearch -exact $out $cid] < 0} {
                lappend out $cid
            }
        }
    }
    return $out
}

# Returns every comp_id known to the currently loaded table data (general
# and component tab rows), used by Find Comp / Reset to know the full "other
# components" universe to apply transparency to.
proc ::nc::ui_table::_all_known_comp_ids {} {
    variable _tab_rows
    set out {}
    foreach tab {component general} {
        if {![info exists _tab_rows($tab)]} continue
        foreach row $_tab_rows($tab) {
            set cid [_dict_get $row comp_id]
            if {$cid ne "" && [string is integer -strict $cid] && $cid > 0 && [lsearch -exact $out $cid] < 0} {
                lappend out $cid
            }
        }
    }
    return $out
}

# Component IDs currently ON SCREEN in the CAE tool's graphics viewport
# (not hidden by a prior Hide/Isolate/Show-Hide), via HM's own "displayed"
# mark selector - same *createmark/hm_getmark pattern _list_all in scan.tcl
# uses for "all". Returns "" (not {}) on any failure - e.g. this dev machine
# has no live HM session - so callers can tell "HM said nothing is visible"
# apart from "couldn't ask HM at all" and fall back accordingly.
proc ::nc::ui_table::_viewport_visible_comp_ids {} {
    catch {*clearmark components 1}
    if {[catch {*createmark components 1 "displayed"}]} { return "" }
    set ids ""
    catch {set ids [hm_getmark components 1]}
    catch {*clearmark components 1}
    return $ids
}

proc ::nc::ui_table::_unique_positive_ints {values} {
    set out {}
    foreach value $values {
        set value [string trim $value]
        if {$value ne "" && [string is integer -strict $value] && $value > 0 && [lsearch -exact $out $value] < 0} {
            lappend out $value
        }
    }
    if {[llength $out] > 1} { set out [lsort -unique -integer $out] }
    return $out
}

proc ::nc::ui_table::_viewport_selected_comp_ids {} {
    set ids {}
    foreach etype {components comps} {
        foreach script [list \
                [list *createmarkpanel $etype 1 "Select component(s) to locate in the Nastran Control table"] \
                [list *editmarkpanel $etype 1 "Select component(s) to locate in the Nastran Control table"] \
                [list *createentitypanel $etype 1 "Select component(s) to locate in the Nastran Control table"]] {
            catch {*clearmark $etype 1}
            if {[catch $script]} { continue }
            set panel_ids {}
            if {![catch {hm_getmark $etype 1} panel_ids]} {
                set ids [_unique_positive_ints $panel_ids]
                if {[llength $ids] > 0} { return $ids }
            }
        }
    }
    return {}
}

proc ::nc::ui_table::_select_component_ids_in_table {comp_ids} {
    variable _tab
    variable _rows
    variable _tbl
    variable _worklist_active
    variable _worklist_ids
    variable _worklist_labels
    variable _worklist_items
    variable _worklist_col
    variable _search_text

    set comp_ids [_unique_positive_ints $comp_ids]
    if {[llength $comp_ids] == 0} { return 0 }
    if {$_tab ne "component"} { _set_tab component }

    set row_nums {}
    set r 1
    foreach row $_rows {
        set cid [_dict_get $row comp_id]
        if {[lsearch -exact $comp_ids $cid] >= 0} { lappend row_nums $r }
        incr r
    }

    if {[llength $row_nums] == 0} {
        set _worklist_active 1
        set _worklist_ids $comp_ids
        set _worklist_labels {}
        set _worklist_items $comp_ids
        set _worklist_col ""
        set _search_text ""
        _populate_current
        set r 1
        foreach row $_rows {
            set cid [_dict_get $row comp_id]
            if {[lsearch -exact $comp_ids $cid] >= 0} { lappend row_nums $r }
            incr r
        }
    }

    if {[llength $row_nums] == 0 || $_tbl eq "" || ![winfo exists $_tbl]} { return 0 }
    catch {$_tbl selection clear all}
    set ncols [_ncols_for_tab $_tab]
    foreach r $row_nums {
        catch {$_tbl selection set $r,0 $r,[expr {$ncols - 1}]}
    }
    set first [lindex $row_nums 0]
    set active_col [_col_index $_tab comp_user_name]
    if {$active_col < 0} { set active_col [_col_index $_tab comp_id] }
    if {$active_col < 0} { set active_col 0 }
    catch {$_tbl activate $first,$active_col}
    catch {$_tbl see $first,$active_col}
    catch {focus $_tbl}
    return [llength $row_nums]
}

proc ::nc::ui_table::_on_select_from_viewport {} {
    set comp_ids [_viewport_selected_comp_ids]
    if {[llength $comp_ids] == 0} {
        _set_status "No component selected from the HyperMesh pick panel." warn
        return
    }
    set count [_select_component_ids_in_table $comp_ids]
    if {$count == 0} {
        _set_status "Selected component(s) from viewport not found in the table: [join $comp_ids {, }]. Reload from FEM if the model changed." warn
        return
    }
    _set_status "Selected $count table row(s) from viewport component ID(s): [join $comp_ids {, }]." ok
}

# One-off diagnostic - type ::nc::ui_table::_debug_viewport_mark (optionally
# with one known comp_id, e.g. ::nc::ui_table::_debug_viewport_mark 12)
# straight into the CAE tool's Tcl console to find out which mechanism this
# the CAE tool version actually supports for "is this component currently
# shown on screen" - tries every plausible mark keyword/dataname instead of
# guessing one and hoping. Not wired to any button - console/log only.
proc ::nc::ui_table::_debug_viewport_mark {{sample_id ""}} {
    foreach kw {displayed shown visible "on screen"} {
        catch {*clearmark components 1}
        set rc [catch {*createmark components 1 $kw} err]
        if {$rc} {
            puts "createmark components 1 \"$kw\": FAILED - $err"
        } else {
            set ids ""
            catch {set ids [hm_getmark components 1]}
            puts "createmark components 1 \"$kw\": OK - [llength $ids] id(s): $ids"
        }
    }
    catch {*clearmark components 1}
    if {$sample_id ne ""} {
        foreach dn {display displayed hidden is_hidden visibility show} {
            set rc [catch {hm_getentityvalue comps $sample_id $dn 0} val]
            puts "hm_getentityvalue comps $sample_id \"$dn\" 0: rc=$rc val/err=$val"
        }
        foreach info_kw {hidden ishidden displayed} {
            set rc [catch {hm_entityinfo $info_kw comps $sample_id} val]
            puts "hm_entityinfo $info_kw comps $sample_id: rc=$rc val/err=$val"
        }
    } else {
        puts "(pass a known comp_id as the argument to also probe per-component display/hidden datanames)"
    }
    return "done - see console output above"
}

# The "other components" universe Find Comp/Highlight/Isolate/Reset should
# act on - the REAL set of components currently shown in the CAE tool's own
# 3D viewport right now (via *createmark components 1 "displayed", verified
# working on a live HM session), not the tool's table/filter state at all.
# So Hide/Isolate/a previous Find Comp already having hidden something in
# the viewport is respected even if that component still sits in the
# table's current filtered rows. Falls back to the full known universe only
# if the viewport query itself fails (no live HM session - e.g. this dev
# machine, or the command isn't available for some other reason).
proc ::nc::ui_table::_displayed_comp_ids_universe {} {
    set viewport_ids [_viewport_visible_comp_ids]
    if {$viewport_ids eq ""} { return [_all_known_comp_ids] }
    return $viewport_ids
}

# Remembers what the last Isolate/Find Comp/Highlight/Show-Hide call did, so
# a single Invert button can flip whichever one ran most recently instead of
# only ever undoing Highlight. target = ids left in the normal/foreground
# state (visible/opaque/normal-colored/shown); other = the rest of that
# call's displayed universe, left in the background/dimmed state
# (hidden/transparent/greyed/hidden).
proc ::nc::ui_table::_record_last_view_action {action target other} {
    variable _last_view_action
    variable _last_view_target
    variable _last_view_other
    set _last_view_action $action
    set _last_view_target $target
    set _last_view_other $other
}

# Resolves the comp_id(s) that Isolate/Find Comp should act on for the
# currently selected row(s). Tab-aware: Properties/Materials rows don't carry
# a comp_id directly, so they're resolved via _comp_ids_referencing.
proc ::nc::ui_table::_selected_target_comp_ids {} {
    variable _tab
    set rows [get_selected_rows]
    set comp_ids {}
    switch -- $_tab {
        properties {
            foreach row $rows {
                foreach cid [_comp_ids_referencing prop_id [_dict_get $row prop_id]] { lappend comp_ids $cid }
            }
        }
        materials {
            foreach row $rows {
                foreach cid [_comp_ids_referencing mat_id [_dict_get $row mat_id]] { lappend comp_ids $cid }
            }
        }
        default {
            foreach row $rows {
                set cid [_dict_get $row comp_id]
                if {$cid ne "" && [string is integer -strict $cid] && $cid > 0} {
                    lappend comp_ids $cid
                }
            }
        }
    }
    return [lsort -unique -integer $comp_ids]
}

# Core Isolate mechanism, reusable by both the toolbar button and Invert.
# target = ids to isolate/show; other = the rest of the displayed universe
# at the time (real Isolate hides everything else in the model regardless,
# but "other" is still recorded for Invert to swap back to later).
proc ::nc::ui_table::_apply_isolate_action {target other} {
    if {[llength [info commands *isolateonlyentitybymark]] == 0} {
        _set_status "the CAE tool isolate command is not available in this session." warn
        return 0
    }
    if {[llength $target] == 0} {
        _set_status "Nothing to isolate." warn
        return 0
    }
    set rc [catch {
        catch {*setdisplayattributes 2 0}
        catch {*clearmark comps 1}
        catch {*clearmark component 2}
        *createmark component 2 "by id" {*}$target
        *createstringarray 2 "elements_on" "geometry_on"
        *isolateonlyentitybymark 2 1 2
        catch {*view "iso1"}
        _fit_hm_window_if_enabled
    } err]
    if {$rc} {
        _set_status "Isolate failed: $err" error
        return 0
    }
    _record_last_view_action isolate $target $other
    _set_status "Isolated [llength $target] component(s)." ok
    return 1
}

proc ::nc::ui_table::_on_isolate {} {
    variable _tab
    set rows [get_selected_rows]
    if {[llength $rows] == 0} {
        _set_status "Select one or more component cells first." warn
        return
    }
    set comp_ids [_selected_target_comp_ids]
    if {[llength $comp_ids] == 0} {
        if {$_tab in {properties materials}} {
            _set_status "No component currently uses the selected [_tab_label $_tab] row(s)." warn
        } else {
            _set_status "Selected row(s) have no valid component ID." warn
        }
        return
    }
    set other_ids {}
    foreach cid [_displayed_comp_ids_universe] {
        if {[lsearch -exact $comp_ids $cid] < 0} { lappend other_ids $cid }
    }
    _apply_isolate_action $comp_ids $other_ids
}

# Hide/Show Component - real command sequence confirmed both in the user's
# own recorded the CAE tool command history and in docs/API_HM's own recorded
# capture ("Actions observed:" block):
#   *createmark comps 1 "by id only" $cid
#   *createstringarray 2 "elements_on" "geometry_off"
#   *hideentitybymark 1 1 2      ;# <mark> <window=1> <array_id>
#   *showentitybymark 1 1 2
# Same 3-arg <mark> <window> <array_id> convention as *isolateonlyentitybymark
# above - "geometry_off" here is a MASK selecting which representation (FE
# elements vs geometry surfaces) the hide/show call affects, not an on/off
# toggle of the target's own state (that's *hideentitybymark vs
# *showentitybymark), so both directions correctly reuse the same array.
proc ::nc::ui_table::_hide_comp_ids {comp_ids} {
    if {[llength [info commands *hideentitybymark]] == 0} {
        _set_status "the CAE tool hide command is not available in this session." warn
        return 0
    }
    set rc [catch {
        catch {*clearmark component 2}
        *createmark component 2 "by id" {*}$comp_ids
        *createstringarray 2 "elements_on" "geometry_off"
        catch {*startnotehistorystate {Hide Component}}
        *hideentitybymark 2 1 2
        catch {*endnotehistorystate {Hide Component}}
    } err]
    if {$rc} {
        _set_status "Hide Comp failed: $err" error
        return 0
    }
    _set_status "Hid [llength $comp_ids] component(s)." ok
    return 1
}

proc ::nc::ui_table::_show_comp_ids {comp_ids} {
    if {[llength [info commands *showentitybymark]] == 0} {
        _set_status "the CAE tool show command is not available in this session." warn
        return 0
    }
    set rc [catch {
        catch {*clearmark component 2}
        *createmark component 2 "by id" {*}$comp_ids
        *createstringarray 2 "elements_on" "geometry_off"
        catch {*startnotehistorystate {Show Component}}
        *showentitybymark 2 1 2
        catch {*endnotehistorystate {Show Component}}
    } err]
    if {$rc} {
        _set_status "Show Comp failed: $err" error
        return 0
    }
    _set_status "Shown [llength $comp_ids] component(s)." ok
    return 1
}

# Reusable Show/Hide core for both the toolbar buttons and Invert. target =
# ids to show (left in the normal/shown state); other = ids to hide (the
# background/dimmed state) - mirrors the target/other convention used by
# Isolate/Find Comp/Highlight so Invert can treat all four uniformly.
proc ::nc::ui_table::_apply_hideshow_action {target other} {
    set ok 1
    if {[llength $other] > 0 && ![_hide_comp_ids $other]} { set ok 0 }
    if {[llength $target] > 0 && ![_show_comp_ids $target]} { set ok 0 }
    if {!$ok} { return 0 }
    _record_last_view_action hide $target $other
    return 1
}

proc ::nc::ui_table::_on_hide_comp {} {
    variable _tab
    set comp_ids [_selected_target_comp_ids]
    if {[llength $comp_ids] == 0} {
        if {$_tab in {properties materials}} {
            _set_status "No component currently uses the selected [_tab_label $_tab] row(s)." warn
        } else {
            _set_status "Select one or more component cells first." warn
        }
        return
    }
    if {[_hide_comp_ids $comp_ids]} {
        set other_ids {}
        foreach cid [_displayed_comp_ids_universe] {
            if {[lsearch -exact $comp_ids $cid] < 0} { lappend other_ids $cid }
        }
        _record_last_view_action hide $other_ids $comp_ids
    }
}

proc ::nc::ui_table::_on_show_comp {} {
    variable _tab
    set comp_ids [_selected_target_comp_ids]
    if {[llength $comp_ids] == 0} {
        if {$_tab in {properties materials}} {
            _set_status "No component currently uses the selected [_tab_label $_tab] row(s)." warn
        } else {
            _set_status "Select one or more component cells first." warn
        }
        return
    }
    if {[_show_comp_ids $comp_ids]} {
        set other_ids {}
        foreach cid [_displayed_comp_ids_universe] {
            if {[lsearch -exact $comp_ids $cid] < 0} { lappend other_ids $cid }
        }
        _record_last_view_action hide $comp_ids $other_ids
    }
}

# Merged Show/Hide toolbar button: tracks which component IDs this tool has
# hidden (in _hidden_comp_ids) and toggles based on the lead selected ID's
# current state, so one button serves both directions instead of two.
proc ::nc::ui_table::_on_toggle_hide_comp {} {
    variable _tab
    variable _hidden_comp_ids
    set comp_ids [_selected_target_comp_ids]
    if {[llength $comp_ids] == 0} {
        if {$_tab in {properties materials}} {
            _set_status "No component currently uses the selected [_tab_label $_tab] row(s)." warn
        } else {
            _set_status "Select one or more component cells first." warn
        }
        return
    }
    set first [lindex $comp_ids 0]
    set now_hidden [expr {[lsearch -exact $_hidden_comp_ids $first] >= 0}]
    set other_ids {}
    foreach cid [_displayed_comp_ids_universe] {
        if {[lsearch -exact $comp_ids $cid] < 0} { lappend other_ids $cid }
    }
    if {$now_hidden} {
        if {[_show_comp_ids $comp_ids]} {
            foreach cid $comp_ids {
                set idx [lsearch -exact $_hidden_comp_ids $cid]
                if {$idx >= 0} { set _hidden_comp_ids [lreplace $_hidden_comp_ids $idx $idx] }
            }
            _record_last_view_action hide $comp_ids $other_ids
        }
    } else {
        if {[_hide_comp_ids $comp_ids]} {
            foreach cid $comp_ids {
                if {[lsearch -exact $_hidden_comp_ids $cid] < 0} { lappend _hidden_comp_ids $cid }
            }
            _record_last_view_action hide $other_ids $comp_ids
        }
    }
}

# Checks that the transparency API is present before we try to use it, so a
# missing command fails loud with a clear message instead of a raw Tcl error
# or a silently broken display. Confirmed via the CAE tool's own recorded
# command history:
#   *createmark components <mark> "by id" <ids>
#   *setmarkdisplayattributes components <mark> 4 1   ;# make transparent
#   *setmarkdisplayattributes components <mark> 2 0 1 ;# clear transparent attr
# Reset must not force mesh/grid display mode; it only clears transparency and
# restores colors for component ids this UI recorded during Find/Highlight.
proc ::nc::ui_table::_transparency_api_available {} {
    return [expr {[llength [info commands *setmarkdisplayattributes]] > 0}]
}

# =============================================================================
# Highlight Comp — grey out every OTHER component so the selected one(s)
# stand out by color (as opposed to Find Comp, which uses transparency).
# the CAE tool entity colors are palette IDs, not arbitrary RGB (*colormark
# <etype> <mark> <color_id>), so the configured grey hex is matched to the
# closest available palette entry via hm_winfo entitycolors. Reset restores
# original colors with *autocolorwithmark, per the user's own recorded
# command history:
#   *autocolorwithmark components <mark>
#   *endnotehistorystate {ColorMod {Components}}
# =============================================================================

# =============================================================================
# Column layout preferences (hidden columns + custom order per tab) - an
# app-wide setting like Export Settings/highlight color, NOT part of any one
# session's saved data. Applies to the current run and every future session
# from the moment it's saved; sessions already open when the change is made
# just keep whatever layout they're already showing until touched again.
# =============================================================================

proc ::nc::ui_table::_column_layout_pref_path {} {
    set dir ""
    catch {set dir $::nc::config::tool_dir}
    if {$dir eq ""} { set dir [pwd] }
    return [file join $dir nc_column_layout.csv]
}

proc ::nc::ui_table::_save_column_layout {} {
    variable _hidden_cols
    variable _col_order
    set data {}
    foreach tab [array names _hidden_cols] {
        set idx 0
        foreach key $_hidden_cols($tab) {
            lappend data [list $tab hidden $key $idx]
            incr idx
        }
    }
    foreach tab [array names _col_order] {
        set idx 0
        foreach key $_col_order($tab) {
            lappend data [list $tab order $key $idx]
            incr idx
        }
    }
    catch {::nc::csv::write_file [_column_layout_pref_path] {tab kind key idx} $data}
}

# Called once at tool startup, before any table is built, so every tab's
# hidden-columns/order is already the saved layout on first paint - not
# something that only kicks in after the user touches a column this run.
proc ::nc::ui_table::_load_column_layout {} {
    variable _hidden_cols
    variable _col_order
    set path [_column_layout_pref_path]
    if {![file exists $path]} { return }
    set hidden_by_tab [dict create]
    set order_by_tab [dict create]
    foreach row [::nc::csv::read_dicts $path] {
        set tab [_dict_get $row tab]
        set kind [_dict_get $row kind]
        set key [_dict_get $row key]
        if {$tab eq "" || $key eq ""} continue
        if {$kind eq "hidden"} {
            dict lappend hidden_by_tab $tab $key
        } elseif {$kind eq "order"} {
            dict lappend order_by_tab $tab $key
        }
    }
    dict for {tab keys} $hidden_by_tab { set _hidden_cols($tab) $keys }
    dict for {tab keys} $order_by_tab { set _col_order($tab) $keys }
}

proc ::nc::ui_table::_highlight_color_pref_path {} {
    set dir ""
    catch {set dir $::nc::config::tool_dir}
    if {$dir eq ""} { set dir [pwd] }
    return [file join $dir nc_highlight_color.txt]
}

proc ::nc::ui_table::_highlight_gray_hex {} {
    set path [_highlight_color_pref_path]
    if {[file exists $path]} {
        set hex ""
        catch {
            set fp [open $path r]
            set hex [string trim [read $fp]]
            close $fp
        }
        if {[regexp {^#[0-9A-Fa-f]{6}$} $hex]} { return $hex }
    }
    return "#D8D8D8"
}

proc ::nc::ui_table::_set_highlight_gray_hex {hex} {
    if {![regexp {^#[0-9A-Fa-f]{6}$} $hex]} { return 0 }
    set path [_highlight_color_pref_path]
    if {[catch {
        set fp [open $path w]
        puts $fp $hex
        close $fp
    }]} { return 0 }
    return 1
}

proc ::nc::ui_table::_color_api_available {} {
    return [expr {[llength [info commands *colormark]] > 0 && [llength [info commands hm_winfo]] > 0}]
}

# Maps a #RRGGBB hex to the closest the CAE tool palette color ID (1-based) by
# nearest RGB distance, since *colormark only accepts palette IDs.
proc ::nc::ui_table::_nearest_hm_color_id {hex} {
    if {![regexp {^#([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})$} $hex -> rh gh bh]} { return "" }
    scan $rh %x tr
    scan $gh %x tg
    scan $bh %x tb
    set colors {}
    if {[catch {set colors [hm_winfo entitycolors]}]} { return "" }
    # hm_winfo entitycolors has been observed returning either a flat
    # "r g b r g b ..." list or a list of {r g b} triples - normalize to
    # flat so the foreach below always gets 3 plain numbers per color.
    set flat {}
    foreach item $colors {
        if {[llength $item] == 3} {
            foreach v $item { lappend flat $v }
        } else {
            lappend flat $item
        }
    }
    set best_id ""
    set best_dist ""
    set idx 0
    foreach {r g b} $flat {
        incr idx
        if {![string is integer -strict $r] || ![string is integer -strict $g] \
                || ![string is integer -strict $b]} { continue }
        set dr [expr {$r - $tr}]
        set dg [expr {$g - $tg}]
        set db [expr {$b - $tb}]
        set dist [expr {$dr*$dr + $dg*$dg + $db*$db}]
        if {$best_dist eq "" || $dist < $best_dist} {
            set best_dist $dist
            set best_id $idx
        }
    }
    return $best_id
}

# Pure color highlight - no isolate/hide involved at all, since nothing
# needs to be hidden: every component stays visible, only its color
# changes. Sequence: autocolor back whichever components were greyed by the
# PREVIOUS Highlight Comp call (never includes the newly-selected target, so
# its own color is never touched/reassigned), grey out the new "other"
# set, then just fit the view (*window 0 0 0 0 0) - no rotate, no isolate.
# Isolate-only is used purely to compute/fit the zoom onto the target
# (no rotate), then every other component is shown again straight away by
# re-isolating with the FULL known component set - re-isolating (not
# *showentity) is the verified-correct way to reset elements_on/geometry_on
# for everyone, so nothing stays actually hidden once colored grey.
proc ::nc::ui_table::_apply_highlight_action {target other} {
    variable _highlight_active_gray_ids
    if {[llength [info commands *isolateonlyentitybymark]] == 0} {
        _set_status "the CAE tool isolate command is not available in this session." warn
        return 0
    }
    if {![_color_api_available] || [llength [info commands *autocolorwithmark]] == 0} {
        _set_status "the CAE tool color commands are not available in this session." warn
        return 0
    }
    if {[llength $target] == 0} {
        _set_status "Nothing to highlight." warn
        return 0
    }
    set gray_hex [_highlight_gray_hex]
    set color_id [_nearest_hm_color_id $gray_hex]
    if {$color_id eq ""} {
        _set_status "Could not resolve a the CAE tool palette color for $gray_hex." error
        return 0
    }
    set all_ids [concat $target $other]
    set rc [catch {
        catch {*setdisplayattributes 2 0}
        catch {*clearmark comps 1}
        catch {*clearmark component 2}
        *createmark component 2 "by id" {*}$target
        *createstringarray 2 "elements_on" "geometry_on"
        *isolateonlyentitybymark 2 1 2
        _fit_hm_window_if_enabled
        if {[llength $all_ids] > 0} {
            catch {*clearmark component 2}
            *createmark component 2 "by id" {*}$all_ids
            *createstringarray 2 "elements_on" "geometry_on"
            *isolateonlyentitybymark 2 1 2
        }
        catch {*startnotehistorystate {ColorMod {Components}}}
        # Undo only the PREVIOUS call's grey-out first - never includes the
        # newly-selected target, so its own color is left alone.
        if {[llength $_highlight_active_gray_ids] > 0} {
            catch {*clearmark components 1}
            *createmark components 1 "by id" {*}$_highlight_active_gray_ids
            *autocolorwithmark components 1
        }
        if {[llength $other] > 0} {
            catch {*clearmark components 1}
            *createmark components 1 "by id" {*}$other
            *colormark components 1 $color_id
        }
        catch {*endnotehistorystate {ColorMod {Components}}}
    } err]
    if {$rc} {
        _set_status "Highlight Comp failed: $err" error
        return 0
    }
    set _highlight_active_gray_ids $other
    _record_last_view_action highlight $target $other
    _set_status "Highlighted [llength $target] component(s); [llength $other] other(s) greyed out." ok
    return 1
}

# Pure color highlight - no isolate/hide involved at all, since nothing
# needs to be hidden: every component stays visible, only its color
# changes. Sequence: autocolor back whichever components were greyed by the
# PREVIOUS Highlight Comp call (never includes the newly-selected target, so
# its own color is never touched/reassigned), grey out the new "other"
# set, then just fit the view (*window 0 0 0 0 0) - no rotate, no isolate.
# Isolate-only is used purely to compute/fit the zoom onto the target
# (no rotate), then every other component is shown again straight away by
# re-isolating with the FULL known component set - re-isolating (not
# *showentity) is the verified-correct way to reset elements_on/geometry_on
# for everyone, so nothing stays actually hidden once colored grey. "Other"
# is scoped to whatever the table is currently displaying, same as Find
# Comp, so a filtered view only greys out the rows still on screen.
proc ::nc::ui_table::_on_highlight_comp {} {
    variable _tab
    set comp_ids [_selected_target_comp_ids]
    if {[llength $comp_ids] == 0} {
        if {$_tab in {properties materials}} {
            _set_status "No component currently uses the selected [_tab_label $_tab] row(s)." warn
        } else {
            _set_status "Select one or more component cells first." warn
        }
        return
    }
    set all_ids [_displayed_comp_ids_universe]
    set other_ids {}
    foreach cid $all_ids {
        if {[lsearch -exact $comp_ids $cid] < 0} { lappend other_ids $cid }
    }
    _apply_highlight_action $comp_ids $other_ids
}

# Inverts whichever of Isolate / Find Comp / Highlight / Show-Hide ran most
# recently (tracked by _record_last_view_action), by swapping its target/
# other sets and re-running that same action's own mechanism. Replaces the
# old Highlight-only invert - one button now works no matter which of the
# four view actions was used last.
proc ::nc::ui_table::_on_invert_last_action {} {
    variable _last_view_action
    variable _last_view_target
    variable _last_view_other
    switch -- $_last_view_action {
        isolate {
            _apply_isolate_action $_last_view_other $_last_view_target
        }
        findcomp {
            _apply_findcomp_action $_last_view_other $_last_view_target
        }
        highlight {
            _apply_highlight_action $_last_view_other $_last_view_target
        }
        hide {
            _apply_hideshow_action $_last_view_other $_last_view_target
        }
        default {
            _set_status "Nothing to invert yet - run Isolate, Find Comp, Highlight, or Show/Hide first." warn
        }
    }
}

proc ::nc::ui_table::_on_highlight_color_pick {} {
    set current [_highlight_gray_hex]
    set picked ""
    catch {set picked [tk_chooseColor -initialcolor $current -title "Highlight Gray Color"]}
    if {$picked eq ""} { return }
    if {[_set_highlight_gray_hex $picked]} {
        _set_status "Highlight gray color set to $picked." ok
    } else {
        _set_status "Could not save highlight color setting." error
    }
}

# Focuses the view on the selected component(s) without rotating the model:
# reuses Isolate's own hide+fit mechanism to compute the zoom (skipping the
# "*view iso1" rotate step), then restores full visibility (re-isolating on
# the full component set is a no-op hide, so nothing stays hidden) while the
# camera framing from the fit sticks. Every other component is then made
# transparent (not hidden) so the target stands out.
proc ::nc::ui_table::_apply_findcomp_action {target other} {
    variable _findcomp_transparent_ids
    if {[llength [info commands *isolateonlyentitybymark]] == 0} {
        _set_status "the CAE tool isolate command is not available in this session." warn
        return 0
    }
    if {![_transparency_api_available]} {
        _set_status "the CAE tool transparency commands are not available in this session." warn
        return 0
    }
    if {[llength $target] == 0} {
        _set_status "Nothing to focus." warn
        return 0
    }
    set all_ids [concat $target $other]
    set rc [catch {
        catch {*setdisplayattributes 2 0}
        catch {*clearmark comps 1}
        catch {*clearmark component 2}
        *createmark component 2 "by id" {*}$target
        *createstringarray 2 "elements_on" "geometry_on"
        *isolateonlyentitybymark 2 1 2
        _fit_hm_window_if_enabled
        # Restore visibility by re-running isolate with every known component
        # on the mark: isolateonlyentitybymark turns elements_on/geometry_on
        # ON for marked entities and OFF for the rest, so including everyone
        # turns it back on for all of them. *showentity alone does not reset
        # that same elements_on/geometry_on flag, so components stayed hidden
        # instead of merely transparent - this is the correctness-first path.
        if {[llength $all_ids] > 0} {
            catch {*clearmark component 2}
            *createmark component 2 "by id" {*}$all_ids
            *createstringarray 2 "elements_on" "geometry_on"
            *isolateonlyentitybymark 2 1 2
        }
        catch {*startnotehistorystate {Modified FE style of Component}}
        # Do not touch the target display attributes here. Clearing the
        # target's transparency through *setmarkdisplayattributes was observed
        # to leave the selected component in wireframe/FE display in HM.
        if {[llength $other] > 0} {
            catch {*clearmark components 1}
            *createmark components 1 "by id" {*}$other
            *setmarkdisplayattributes components 1 4 1
        }
        catch {*endnotehistorystate {Modified FE style of Component}}
    } err]
    if {$rc} {
        _set_status "Find Comp failed: $err" error
        return 0
    }
    set _findcomp_transparent_ids $other
    _record_last_view_action findcomp $target $other
    _set_status "Focused on [llength $target] component(s), [llength $other] other(s) made transparent." ok
    return 1
}

proc ::nc::ui_table::_on_find_comp {} {
    variable _tab
    set comp_ids [_selected_target_comp_ids]
    if {[llength $comp_ids] == 0} {
        if {$_tab in {properties materials}} {
            _set_status "No component currently uses the selected [_tab_label $_tab] row(s)." warn
        } else {
            _set_status "Select one or more component cells first." warn
        }
        return
    }
    set all_ids [_displayed_comp_ids_universe]
    set other_ids {}
    foreach cid $all_ids {
        if {[lsearch -exact $comp_ids $cid] < 0} { lappend other_ids $cid }
    }
    _apply_findcomp_action $comp_ids $other_ids
}

# Clears transparency and restores component colors without touching visibility
# or FE display style. Prefer the ids this UI changed during Find/Highlight;
# if there is no runtime record (for example after reload/re-source), fall
# back to the currently displayed component set so Reset still behaves like a
# general cleanup button. Never call isolate/show or elements_on/geometry_on
# here: the user's display mode must be left alone.
proc ::nc::ui_table::_on_reset_transparency {} {
    variable _highlight_active_gray_ids
    variable _findcomp_transparent_ids
    variable _last_view_action
    set trans_ids [lsort -unique -integer $_findcomp_transparent_ids]
    set color_ids [lsort -unique -integer $_highlight_active_gray_ids]
    set reset_ids [lsort -unique -integer [concat $trans_ids $color_ids]]
    if {[llength $trans_ids] == 0 && [llength $color_ids] == 0} {
        set fallback_ids [_displayed_comp_ids_universe]
        if {[llength $fallback_ids] == 0} { set fallback_ids [_all_known_comp_ids] }
        set fallback_ids [lsort -unique -integer $fallback_ids]
        if {[llength $fallback_ids] == 0} {
            _set_status "Nothing to reset - no component IDs are available." warn
            return
        }
        set trans_ids $fallback_ids
        set color_ids $fallback_ids
        set reset_ids $fallback_ids
    }
    set trans_ids $reset_ids
    set color_ids $reset_ids
    set did_transparency 0
    set did_color 0
    catch {*setdisplayattributes 2 0}
    if {[llength $trans_ids] > 0 && [_transparency_api_available]} {
        set rc [catch {
            catch {*startnotehistorystate {Modified FE style of Component}}
            catch {*clearmark components 1}
            *createmark components 1 "by id" {*}$trans_ids
            *setmarkdisplayattributes components 2 0 1
            catch {*endnotehistorystate {Modified FE style of Component}}
        } err]
        if {$rc} {
            _set_status "Reset transparency failed: $err" error
            return
        }
        set did_transparency 1
        set _findcomp_transparent_ids {}
    }
    if {[llength $color_ids] > 0 && [llength [info commands *autocolorwithmark]] > 0} {
        set rc2 [catch {
            catch {*startnotehistorystate {ColorMod {Components}}}
            catch {*clearmark components 1}
            *createmark components 1 "by id" {*}$color_ids
            *autocolorwithmark components 1
            catch {*endnotehistorystate {ColorMod {Components}}}
        } err2]
        if {$rc2} {
            _set_status "Reset color failed: $err2" error
            return
        }
        set did_color 1
        set _highlight_active_gray_ids {}
    }
    catch {*setdisplayattributes 2 0}
    if {!$did_transparency && !$did_color} {
        _set_status "the CAE tool transparency/color commands are not available in this session." warn
        return
    }
    set _last_view_action ""
    _set_status "Reset transparency/color for [llength [lsort -unique -integer [concat $trans_ids $color_ids]]] component(s)." ok
}

# =============================================================================
# Material Library — a reference list of known materials (Mat Label, Mat
# Type, E, NU, RHO, ...) pasted/imported from an arbitrary CSV. Columns are
# whatever the CSV's header row says (no fixed schema), so this tab's column
# list lives in _library_columns rather than _export_all_possible_cols.
# Session-runtime only - not persisted through Save Session (the combined
# CSV has a fixed schema and doesn't know about this tab).
# =============================================================================

# Writes the Library tab's current data to <session>/library/matprop_library.csv
# so it survives closing and reopening the session, same as the other tabs.
proc ::nc::ui_table::_save_library_snapshot {dir} {
    variable _library_columns
    variable _tab_rows
    if {[llength $_library_columns] == 0} { return }
    if {![::nc::xlsx::python_ok]} {
        error "Cannot save library snapshot: [::nc::xlsx::python_unavailable_message]"
    }
    set path ""
    if {[catch {set path [::nc::session::library_snapshot_file $dir]}]} { return }
    set rows {}
    if {[info exists _tab_rows(library)]} {
        foreach row $_tab_rows(library) {
            set vals {}
            foreach col $_library_columns { lappend vals [_dict_get $row $col] }
            lappend rows $vals
        }
    }
    set tmp_csv [file join [file dirname $path] "_nc_tmp_[pid]_library.csv"]
    set tmp_xlsx "$path.nc_tmp_[pid].xlsx"
    if {[catch {
        ::nc::csv::write_file $tmp_csv $_library_columns $rows
        set ok [::nc::xlsx::convert_multi_to_xlsx [list [list Library $tmp_csv ""]] $tmp_xlsx]
        if {!$ok} {
            error "material_lib.xlsx write/verify failed"
        }
        file rename -force -- $tmp_xlsx $path
    } err]} {
        catch {file delete -force -- $tmp_xlsx}
        catch {file delete -force -- $tmp_csv}
        error $err
    }
    catch {file delete -force -- $tmp_csv}
    # Success: legacy library CSVs are now stale.
    catch {file delete -force -- [file join [file dirname $path] material_lib.csv]}
    catch {file delete -force -- [file join [file dirname $path] matprop_library.csv]}
    catch {::nc::session::_xlsx_prewarm_invalidate $path}
}

# Restores the Library tab from its saved snapshot when opening a session
# that has one; otherwise falls back to the starter skeleton. Deliberately
# only called on session open, never on Reload/rescan, so a rescan can't
# clobber Library edits made since the last save.
proc ::nc::ui_table::_load_library_snapshot {dir} {
    set path ""
    # Prefers material_lib.xlsx, falls back to material_lib.csv then the
    # older matprop_library.csv so pre-migration sessions still open.
    if {[catch {set path [::nc::session::library_snapshot_file_for_read $dir]}]} { return }
    if {![file exists $path]} {
        _ensure_library_default
        return
    }
    set rows {}
    if {[string equal -nocase [file extension $path] ".xlsx"]} {
        if {![::nc::xlsx::python_ok]} {
            _set_status "Library snapshot is .xlsx but openpyxl is unavailable — starting with an empty library." warn
            _ensure_library_default
            return
        }
        # Prewarm cache hit (populated by load_table_session's batched
        # read): first sheet's rows already parsed - skip the subprocess.
        set warmed [::nc::session::_xlsx_prewarm_get $path]
        if {[dict size $warmed] > 0} {
            # library.xlsx has 1 sheet ("Library"); the row-list stored
            # in the prewarm cache is list-of-dicts (from read_dicts).
            # _library_load_from_rows expects list-of-lists with a header
            # row as element 0, so reconstruct that shape here.
            set first_sheet_dicts [lindex [dict values $warmed] 0]
            if {[llength $first_sheet_dicts] > 0} {
                set header {}
                foreach k [dict keys [lindex $first_sheet_dicts 0]] { lappend header $k }
                set rows [list $header]
                foreach d $first_sheet_dicts {
                    set vals {}
                    foreach k $header { lappend vals [expr {[dict exists $d $k] ? [dict get $d $k] : ""}] }
                    lappend rows $vals
                }
            }
        }
        # Prewarm miss (e.g. session opened via a code path that skips
        # load_table_session's prewarm): fall back to a dedicated
        # subprocess.
        if {[llength $rows] == 0} {
            set tmpdir [file join [file dirname $path] _lib_read_[pid]]
            catch {file delete -force -- $tmpdir}
            if {[catch {file mkdir $tmpdir}] == 0} {
                set sheet_map [::nc::xlsx::convert_xlsx_to_multi_csv $path $tmpdir]
                if {[dict size $sheet_map] > 0} {
                    set csv_path [lindex [dict values $sheet_map] 0]
                    set rows [::nc::csv::read_file $csv_path]
                }
                catch {file delete -force -- $tmpdir}
            }
        }
    } else {
        set rows [::nc::csv::read_file $path]
    }
    if {[llength $rows] == 0} {
        _ensure_library_default
        return
    }
    _library_load_from_rows $rows
}

# First time the Library tab is opened in a session with nothing loaded yet,
# give it a small 2-column x 2-row starter skeleton instead of a blank grid,
# so there's something to see/paste onto. Never overwrites real data - only
# runs while _library_columns is still empty.
proc ::nc::ui_table::_ensure_library_default {} {
    variable _library_columns
    variable _tab_rows
    if {[llength $_library_columns] > 0} { return }
    set _library_columns {"Mat Label" "Mat Type"}
    set _tab_rows(library) [list \
        [dict create "Mat Label" "" "Mat Type" "" _libidx 0] \
        [dict create "Mat Label" "" "Mat Type" "" _libidx 1]]
}

proc ::nc::ui_table::_library_load_from_rows {rows} {
    variable _library_columns
    if {[llength $rows] < 1} {
        _set_status "Pasted/imported text has no header row." warn
        return 0
    }
    set header {}
    foreach h [lindex $rows 0] { lappend header [string trim $h] }
    set out {}
    # _libidx tracks the row's position in the ORIGINAL source file (after
    # the header), incrementing on every line including skipped blank ones
    # - not a separately-compacted counter over survivors only. Otherwise
    # a blank line partway through the CSV shifted every _libidx after it
    # by one relative to what the user sees as "row N" in their own
    # spreadsheet. Gaps in the resulting sequence are fine - _libidx is
    # only ever used for equality lookup (_row_key_for_tab), never as a
    # positional/lindex index.
    set orig_idx 0
    foreach raw [lrange $rows 1 end] {
        if {[llength $raw] == 0} { incr orig_idx; continue }
        set blank 1
        foreach v $raw { if {[string trim $v] ne ""} { set blank 0; break } }
        if {$blank} { incr orig_idx; continue }
        set d [::nc::csv::to_dict $header $raw]
        dict set d _libidx $orig_idx
        incr orig_idx
        lappend out $d
    }
    set _library_columns $header
    _store_rows [dict create library $out]
    _refresh_material_options
    _rebuild_table_columns
    _populate_current
    _set_status "Material Library loaded: [llength $out] row(s), [llength $header] column(s)." ok
    return 1
}

proc ::nc::ui_table::_on_library_paste {} {
    set win .nc_library_paste
    catch {destroy $win}
    toplevel $win
    wm title $win "Paste Material Library"
    label $win.lbl -anchor w -justify left -text \
        "Paste CSV text (first line = header, e.g. Mat Label,Mat Type,E,NU,RHO):"
    pack $win.lbl -side top -fill x -padx 8 -pady {8 4}
    text $win.t -width 70 -height 16 -wrap none
    pack $win.t -side top -fill both -expand 1 -padx 8 -pady 4
    frame $win.buttons
    button $win.buttons.apply -text "Load" -command [list ::nc::ui_table::_library_paste_apply $win]
    button $win.buttons.cancel -text "Cancel" -command [list destroy $win]
    _style_button $win.buttons.apply primary
    _style_button $win.buttons.cancel quiet
    pack $win.buttons.cancel -side right -padx {4 0} -pady 8
    pack $win.buttons.apply -side right -padx {4 0} -pady 8
    pack $win.buttons -side top -fill x -padx 8
    catch {_place_companion_window $win 520 420}
    catch {focus $win.t}
}

proc ::nc::ui_table::_library_paste_apply {win} {
    set text [$win.t get 1.0 end]
    set rows {}
    foreach line [split $text "\n"] {
        if {[string trim $line] eq ""} continue
        lappend rows [::nc::csv::parse_line $line]
    }
    if {[_library_load_from_rows $rows]} { catch {destroy $win} }
}

# Reads a .csv or .xlsx file into row-lists (header + data), converting
# xlsx via the same Python/openpyxl bridge the generic Import feature uses.
proc ::nc::ui_table::_library_read_file_rows {path} {
    if {[string tolower [file extension $path]] eq ".xlsx"} {
        if {![_xlsx_python_ok]} {
            _set_status "openpyxl not available in CAE Python; cannot read .xlsx." error
            return {}
        }
        set tmp_csv "[file rootname $path].nc_tmp_library_import.csv"
        if {![_convert_xlsx_to_csv $path $tmp_csv]} {
            _set_status "Failed to convert $path to CSV." error
            return {}
        }
        set rows [::nc::csv::read_file $tmp_csv]
        catch {file delete -force -- $tmp_csv}
        return $rows
    }
    return [::nc::csv::read_file $path]
}

# Import Library from disk. If <session>/library/material_lib.csv exists,
# load it silently (no prompt) - that's the canonical file the user edits
# via "Open CSV" in the toolbar, so re-importing it is the round-trip after
# an Excel edit and shouldn't ask. If missing, notify + pop a file browse
# dialog so the user can pick any CSV/XLSX to seed from.
proc ::nc::ui_table::_on_library_import_file {} {
    set dir ""
    catch {set dir [::nc::session::library_dir]}
    if {$dir eq ""} {
        _set_status "No active session - open or create one first." warn
        return
    }
    set canonical ""
    catch {set canonical [::nc::session::library_snapshot_file]}
    set path ""
    if {$canonical ne "" && [file exists $canonical]} {
        set path $canonical
    } else {
        # Legacy fallback: older sessions may have matprop_library.csv only.
        # Load that silently too so the user isn't asked to pick a file they
        # already saved into the session.
        set legacy [file join $dir matprop_library.csv]
        if {[file exists $legacy]} {
            set path $legacy
        } else {
            _set_status "material_lib.csv not found in [file tail $dir]/ - pick a CSV to import." warn
            catch {
                set path [tk_getOpenFile -title "Import Material Library" \
                    -initialdir $dir -filetypes {{"CSV/Excel files" {.csv .xlsx}} {"All files" *}}]
            }
            _recover_focus_after_native_dialog
            if {$path eq ""} { return }
        }
    }
    set rows [_library_read_file_rows $path]
    if {[llength $rows] == 0} {
        _set_status "Could not read: $path" error
        return
    }
    _library_load_from_rows $rows
    _set_status "Material Library imported from [file tail $path]." ok
}

# Opens the current session's material_lib.csv in the OS default handler
# (typically Excel) so the user can edit it side-by-side with the tool. On
# save+return, Library toolbar's "Import CSV" reloads the same file silently.
# If material_lib.csv doesn't exist yet, offer to create it now by saving
# the in-memory Library data (or an empty starter if the tab is empty).
proc ::nc::ui_table::_on_library_open_csv {} {
    variable _library_columns
    variable _tab_rows
    set path ""
    if {[catch {set path [::nc::session::library_snapshot_file]}]} {
        _set_status "No active session - open or create one first." warn
        return
    }
    if {![file exists $path]} {
        # Auto-create: write current in-memory Library rows out to the
        # canonical xlsx so Excel has something to open. Post xlsx-
        # migration this goes through the xlsx write path, not raw CSV.
        set header $_library_columns
        if {[llength $header] == 0} { set header {"Mat Label" "Mat Type" "E" "NU" "RHO"} }
        set rows {}
        if {[info exists _tab_rows(library)]} {
            foreach row $_tab_rows(library) {
                set vals {}
                foreach col $header { lappend vals [_dict_get $row $col] }
                lappend rows $vals
            }
        }
        # Xlsx path: preflight python, write scratch csv, convert.
        if {[string equal -nocase [file extension $path] ".xlsx"]} {
            if {![::nc::xlsx::python_ok]} {
                _set_status "Cannot create [file tail $path]: [::nc::xlsx::python_unavailable_message]" error
                return
            }
            set tmp_csv [file join [file dirname $path] "_nc_tmp_[pid]_libopen.csv"]
            if {[catch {::nc::csv::write_file $tmp_csv $header $rows} err]} {
                _set_status "Could not create scratch csv for library snapshot: $err" error
                return
            }
            set ok [::nc::xlsx::convert_multi_to_xlsx [list [list Library $tmp_csv ""]] $path]
            catch {file delete -force -- $tmp_csv}
            if {!$ok} {
                _set_status "Could not create [file tail $path] (openpyxl write failed)." error
                return
            }
        } else {
            # Legacy fallback path (matprop_library.csv) still uses raw CSV.
            if {[catch {::nc::csv::write_file $path $header $rows} err]} {
                _set_status "Could not create [file tail $path]: $err" error
                return
            }
        }
        _set_status "Created [file tail $path] (empty template) - opening in Excel..." ok
    }
    set native $path
    catch {set native [file nativename [file normalize $path]]}
    if {[catch {exec cmd /c start "" $native &}]} {
        # start failed (unusual). Fall back to opening the folder so the
        # user can double-click the file themselves.
        if {[catch {exec explorer [file dirname $native] &}]} {
            _set_status "Could not open $native automatically. Path: $path" error
        } else {
            _set_status "Could not open $native directly; opened its folder instead." warn
        }
        return
    }
    _set_status "Opened [file tail $path] in default handler (Excel)." ok
}

proc ::nc::ui_table::_library_pick_from_folder_dialog {candidates} {
    variable _library_pick_result
    set _library_pick_result ""
    set win .nc_library_pick
    catch {destroy $win}
    toplevel $win
    wm title $win "Choose Library File"
    label $win.msg -anchor w -text "Multiple files found in the session's library folder - pick one:"
    pack $win.msg -side top -fill x -padx 8 -pady {8 4}
    listbox $win.list -height 8 -exportselection 0
    foreach f $candidates { $win.list insert end [file tail $f] }
    $win.list selection set 0
    pack $win.list -side top -fill both -expand 1 -padx 8 -pady 4
    frame $win.buttons
    button $win.buttons.ok -text "Import" -command [list ::nc::ui_table::_library_pick_apply $win $candidates]
    button $win.buttons.cancel -text "Cancel" -command [list destroy $win]
    _style_button $win.buttons.ok primary
    _style_button $win.buttons.cancel quiet
    pack $win.buttons.cancel -side right -padx {4 0} -pady 8
    pack $win.buttons.ok -side right -padx {4 0} -pady 8
    pack $win.buttons -side top -fill x -padx 8
    catch {_place_companion_window $win 360 300}
    tkwait window $win
    return $_library_pick_result
}

proc ::nc::ui_table::_library_pick_apply {win candidates} {
    variable _library_pick_result
    set sel [$win.list curselection]
    if {[llength $sel] == 1} {
        set _library_pick_result [lindex $candidates [lindex $sel 0]]
    }
    catch {destroy $win}
}

# Library columns whose name matches (case/space/dot-insensitive) a known
# numeric Materials-tab field - only these make sense as a match key.
# Materials-tab field keys usable as a Library match key. Driven by
# _export_all_possible_cols (the same single source of truth used for the
# on-screen columns and Export) minus the handful of identity/label/text
# fields - so a new material property field added there later becomes
# matchable automatically, with nothing to update here.
proc ::nc::ui_table::_materials_matchable_field_keys {} {
    set exclude {mat_card mat_id mat_user_name mat_label mat_name note}
    set out {}
    foreach col_def [_export_all_possible_cols materials] {
        set key [lindex $col_def 0]
        if {$key ni $exclude} { lappend out $key }
    }
    return $out
}

# All Materials-tab fields the redesigned Match dialog can write into. Order
# is meaningful (used verbatim for the target-field dropdown values), so
# label-type fields sit first, then numeric material fields, then note. Skips
# mat_id (that's the natural key, not a fillable value).
proc ::nc::ui_table::_library_match_target_fields {} {
    set fields {mat_card mat_user_name mat_label}
    foreach k [_materials_matchable_field_keys] { lappend fields $k }
    lappend fields note
    return $fields
}

# Friendly display name for a target-field key in the dropdown (mat_user_name
# reads as "MAT. Type" everywhere else in the tool, mat_label as "MAT. Label",
# etc. - keep this dialog consistent).
proc ::nc::ui_table::_library_match_target_display {key} {
    switch -- $key {
        -              { return "-" }
        mat_card       { return "MAT. Card" }
        mat_user_name  { return "MAT. Type" }
        mat_label      { return "MAT. Label" }
        note           { return "Note" }
        default        { return $key }
    }
}

# Given a raw library column name (e.g. "E (MPa)", "NU (-)", "Mat Type",
# "Material Name"), return the material field key it most likely maps to, or
# "-" if there's no obvious mapping and the user must pick manually.
# Deliberately loose: strips unit-in-parens/brackets, any non-alphanumeric,
# uppercases. Auto-detect only - the dialog still lets the user override.
proc ::nc::ui_table::_library_match_auto_detect_target {lib_col} {
    set norm [string trim $lib_col]
    # Drop anything in trailing parens or square brackets - "E (MPa)" -> "E ",
    # "RHO [t/mm^3]" -> "RHO ". Runs twice in case of nested/multiple groups.
    regsub -all {\s*\([^)]*\)} $norm "" norm
    regsub -all {\s*\[[^\]]*\]} $norm "" norm
    regsub -all {[^[:alnum:]]} $norm "" norm
    set upper [string toupper $norm]
    # Label-style columns first (checked before generic key match so "MATNAME"
    # goes to mat_label instead of trying to be a material field).
    switch -- $upper {
        MATTYPE       -
        MATERIALTYPE  { return mat_user_name }
        MATNAME       -
        MATERIALNAME  -
        MATLABEL      -
        MATERIALLABEL { return mat_label }
        MATCARD       -
        MATERIALCARD  { return mat_card }
        NOTE          -
        NOTES         -
        COMMENT       -
        COMMENTS      -
        DESCRIPTION   { return note }
    }
    # Numeric material fields (E, G, NU, RHO, A, TREF, GE, ST, SC, SS) - hit
    # if the stripped/upper name matches a matchable-field key exactly.
    foreach k [_materials_matchable_field_keys] {
        if {$upper eq [string toupper $k]} { return $k }
    }
    return -
}

# Seeds the two Match dialog tables. Match starts from
# _library_match_last_match_pairs if the user has picked before this
# session, else empty (matching on nothing by default is the old
# behavior too - matching everything is almost never right). Fill starts
# from _library_match_last_fill_pairs if remembered, else auto-detected
# for every library column that has an obvious target.
proc ::nc::ui_table::_library_match_initial_pairs {} {
    variable _library_columns
    variable _library_match_last_match_pairs
    variable _library_match_last_fill_pairs
    if {[llength $_library_match_last_match_pairs] > 0} {
        set match_pairs $_library_match_last_match_pairs
    } else {
        set match_pairs {}
    }
    if {[llength $_library_match_last_fill_pairs] > 0} {
        set fill_pairs $_library_match_last_fill_pairs
    } else {
        set fill_pairs {}
        foreach col $_library_columns {
            set target [_library_match_auto_detect_target $col]
            if {$target ne "-"} { lappend fill_pairs [list $col $target] }
        }
    }
    return [list $match_pairs $fill_pairs]
}

# One row of a Match/Fill table: two readonly dropdowns (Library Column,
# Materials Field) plus a remove button. section is "match" or "fill" -
# keys the row's widget state into ::nc::ui_table::_library_pair_lib/
# _library_pair_target ($section,$id), and its id into
# _library_match_row_ids($section), so _library_match_read_pairs can walk
# still-live rows after arbitrary Add/Remove clicks without caring about
# widget paths.
proc ::nc::ui_table::_library_match_add_pair_row {section container lib_col target} {
    variable _library_columns
    variable _library_match_row_ids
    variable _library_match_next_row_id
    if {![info exists _library_match_next_row_id]} { set _library_match_next_row_id 0 }
    set id [incr _library_match_next_row_id]
    if {![info exists _library_match_row_ids($section)]} { set _library_match_row_ids($section) {} }
    lappend _library_match_row_ids($section) $id

    set lib_values [linsert $_library_columns 0 "-"]
    set target_keys [linsert [_library_match_target_fields] 0 "-"]
    set target_display {}
    foreach k $target_keys { lappend target_display [_library_match_target_display $k] }

    set row_f [frame $container.row$id]
    set lib_var ::nc::ui_table::_library_pair_lib($section,$id)
    set $lib_var [expr {$lib_col ne "" ? $lib_col : "-"}]
    ttk::combobox $row_f.lib -state readonly -values $lib_values \
        -textvariable $lib_var -width 22

    set target_var ::nc::ui_table::_library_pair_target($section,$id)
    set $target_var [_library_match_target_display [expr {$target ne "" ? $target : "-"}]]
    ttk::combobox $row_f.target -state readonly -values $target_display \
        -textvariable $target_var -width 18

    button $row_f.rm -text "✕" -width 2 \
        -command [list ::nc::ui_table::_library_match_remove_pair_row $section $id $row_f]
    _style_button $row_f.rm quiet

    pack $row_f.lib -side left -padx {0 6}
    pack $row_f.target -side left -padx {0 6}
    pack $row_f.rm -side left
    pack $row_f -side top -fill x -pady 1
    return $row_f
}

proc ::nc::ui_table::_library_match_remove_pair_row {section id row_f} {
    variable _library_match_row_ids
    catch { destroy $row_f }
    if {[info exists _library_match_row_ids($section)]} {
        set idx [lsearch -exact $_library_match_row_ids($section) $id]
        if {$idx >= 0} {
            set _library_match_row_ids($section) [lreplace $_library_match_row_ids($section) $idx $idx]
        }
    }
    unset -nocomplain ::nc::ui_table::_library_pair_lib($section,$id)
    unset -nocomplain ::nc::ui_table::_library_pair_target($section,$id)
}

# Reads the still-live rows of one section (match/fill) back into a
# {lib_col target} pair list, in the order rows were added. Rows left at
# "-"/"-" (or either side "-") are skipped - that's how a row becomes a
# no-op instead of needing a separate enable flag.
proc ::nc::ui_table::_library_match_read_pairs {section} {
    variable _library_match_row_ids
    set out {}
    if {![info exists _library_match_row_ids($section)]} { return $out }
    foreach id $_library_match_row_ids($section) {
        if {![info exists ::nc::ui_table::_library_pair_lib($section,$id)]} continue
        set lib_col $::nc::ui_table::_library_pair_lib($section,$id)
        set target [_library_match_target_key $::nc::ui_table::_library_pair_target($section,$id)]
        if {$lib_col eq "-" || $target eq "-"} continue
        lappend out [list $lib_col $target]
    }
    return $out
}

proc ::nc::ui_table::_on_library_match_dialog {} {
    variable _library_columns
    variable _library_match_row_ids
    if {[llength $_library_columns] == 0} {
        _set_status "Load the Material Library first (paste or import a CSV)." warn
        return
    }
    lassign [_library_match_initial_pairs] init_match init_fill
    if {[llength $init_match] == 0} { set init_match {{- -}} }

    set win .nc_library_match
    catch {destroy $win}
    toplevel $win
    wm title $win "Match Library to Materials Tab"

    label $win.msg -anchor w -justify left -wraplength 480 -text \
        "Match: rows here must be equal to find the right Library row for each\nMaterial. Fill: rows here copy that Library row's value into the given\nMaterials field. Use + Add Row / ✕ to edit either list."
    pack $win.msg -side top -fill x -padx 8 -pady {8 4}

    # Scrollable canvas so a long Fill list still fits.
    frame $win.body
    set canvas [canvas $win.body.c -highlightthickness 0]
    set sb [scrollbar $win.body.sb -orient vertical -command [list $canvas yview]]
    $canvas configure -yscrollcommand [list $sb set]
    pack $sb -side right -fill y
    pack $canvas -side left -fill both -expand 1
    set inner [frame $canvas.inner]
    set inner_item [$canvas create window 0 0 -anchor nw -window $inner]
    bind $canvas <Configure> [list ::nc::ui_table::_library_ambiguous_sync_inner_width $canvas $inner_item %w]
    pack $win.body -side top -fill both -expand 1 -padx 8 -pady 4

    array unset _library_match_row_ids
    set _library_match_row_ids(match) {}
    set _library_match_row_ids(fill) {}

    foreach {section title initial} [list match "Match" $init_match fill "Fill" $init_fill] {
        label $inner.${section}_hdr -text $title -anchor w -font {Arial 9 bold}
        pack $inner.${section}_hdr -side top -fill x -pady {8 0}
        set col_hdr [frame $inner.${section}_col_hdr]
        label $col_hdr.a -text "Library Column"  -width 22 -anchor w
        label $col_hdr.b -text "Materials Field" -width 18 -anchor w
        pack $col_hdr.a $col_hdr.b -side left -padx {0 6}
        pack $col_hdr -side top -fill x
        set rows_f [frame $inner.${section}_rows]
        pack $rows_f -side top -fill x
        foreach pair $initial {
            lassign $pair lib_col target
            _library_match_add_pair_row $section $rows_f $lib_col $target
        }
        button $inner.${section}_add -text "+ Add Row" \
            -command [list ::nc::ui_table::_library_match_add_pair_row $section $rows_f "" ""]
        _style_button $inner.${section}_add quiet
        pack $inner.${section}_add -side top -anchor w -pady {2 4}
    }
    update idletasks
    $canvas configure -scrollregion [$canvas bbox all]

    frame $win.buttons
    button $win.buttons.apply -text "Apply Match" \
        -command [list ::nc::ui_table::_library_match_apply $win]
    button $win.buttons.cancel -text "Cancel" -command [list destroy $win]
    _style_button $win.buttons.apply primary
    _style_button $win.buttons.cancel quiet
    pack $win.buttons.cancel -side right -padx {4 0} -pady 8
    pack $win.buttons.apply -side right -padx {4 0} -pady 8
    pack $win.buttons -side top -fill x -padx 8
    catch {_place_companion_window $win 480 520}
}

# Reverse-lookup: friendly display name -> raw target key. Symmetric with
# _library_match_target_display; used by the Apply handler to convert what
# the user picked from the combobox back into a material field key.
proc ::nc::ui_table::_library_match_target_key {display} {
    foreach k [linsert [_library_match_target_fields] 0 "-"] {
        if {[_library_match_target_display $k] eq $display} { return $k }
    }
    return -
}

# True when lib_row satisfies every {lib_col target} pair in match_pairs
# (numeric fields compared with a small relative tolerance, text compared
# exact-after-trim). No match pairs at all means nothing to test against ->
# never matches (avoids "everything matches" when the Match table is
# empty). Empty library values also don't qualify (avoids "" == "" false
# matches on missing data).
proc ::nc::ui_table::_library_row_matches_mapping {lib_row mat_row match_pairs} {
    # Backwards-compat boolean wrapper - keeps the pre-diagnostic call
    # sites working while the new detailed path (below) drives logging.
    return [dict get [_library_row_match_result $lib_row $mat_row $match_pairs] ok]
}

# Same match semantics as _library_row_matches_mapping but returns a dict
# {ok 0/1 fails [list [dict field/lib/mat/reason] ...]} instead of a naked
# 0/1, so the caller can log EXACTLY which field failed and with what
# values on which side. Blank on either side is now reported as a distinct
# "blank_lib"/"blank_mat" reason rather than a mystery zero - that was the
# most common cause of "clearly matches but tool says no" complaints
# (Materials row missing a field the Library populated, or Library column
# name subtly differing from what the match pair points at).
proc ::nc::ui_table::_library_row_match_result {lib_row mat_row match_pairs} {
    set fails {}
    if {[llength $match_pairs] == 0} {
        return [dict create ok 0 fails [list [dict create field "" lib "" mat "" reason "no_pairs"]]]
    }
    foreach entry $match_pairs {
        lassign $entry lib_col target
        set lv [string trim [_dict_get $lib_row $lib_col]]
        set mv [string trim [_dict_get $mat_row $target]]
        if {$lv eq ""} {
            lappend fails [dict create field "$lib_col->$target" lib $lv mat $mv reason "blank_lib"]
            continue
        }
        if {$mv eq ""} {
            lappend fails [dict create field "$lib_col->$target" lib $lv mat $mv reason "blank_mat"]
            continue
        }
        if {[string is double -strict $lv] && [string is double -strict $mv]} {
            set diff [expr {abs(double($lv) - double($mv))}]
            set tol [expr {1e-6 * (abs(double($mv)) + 1.0)}]
            if {$diff > $tol} {
                lappend fails [dict create field "$lib_col->$target" lib $lv mat $mv \
                    reason "numeric_diff diff=$diff tol=$tol"]
            }
        } elseif {$lv ne $mv} {
            lappend fails [dict create field "$lib_col->$target" lib $lv mat $mv reason "text_diff"]
        }
    }
    return [dict create ok [expr {[llength $fails] == 0}] fails $fails]
}

# Copies every {lib_col target} pair in fill_pairs from lib_row into the
# given materials row - the raw library value goes directly into the
# target material field key, and the field is marked dirty so the
# header-color/unsaved-* indicators pick it up.
proc ::nc::ui_table::_library_fill_from_mapping {mat_row lib_row fill_pairs} {
    foreach entry $fill_pairs {
        lassign $entry lib_col target
        set value [_dict_get $lib_row $lib_col]
        dict set mat_row $target $value
        set mat_row [_mark_dirty $mat_row $target]
    }
    return $mat_row
}

# (Snapshot/undo procs removed 2026-07-05 - Undo Match was replaced with
# a pre-Apply confirmation dialog in _library_match_apply. The snapshot
# state was fragile - any Materials-tab edit invalidated it, so "undo
# after" was a false promise. Removed procs: _library_match_snapshot_take,
# _library_match_invalidate_snapshot, _library_match_can_undo,
# _library_undo_last_match, _library_match_undo_from_dialog.)

proc ::nc::ui_table::_library_match_apply {win} {
    variable _tab_rows
    variable _library_match_last_match_pairs
    variable _library_match_last_fill_pairs
    set match_pairs [_library_match_read_pairs match]
    set fill_pairs [_library_match_read_pairs fill]

    if {[llength $match_pairs] == 0} {
        _set_status "Add at least one Match row (E, NU, RHO, ...) to find matching library rows." warn
        return
    }
    if {[llength $fill_pairs] == 0} {
        _set_status "Add at least one Fill row so there's something to write into Materials." warn
        return
    }
    if {![info exists _tab_rows(library)] || [llength $_tab_rows(library)] == 0} {
        _set_status "Material Library is empty." warn
        return
    }

    # Remember picks for next dialog open.
    set _library_match_last_match_pairs $match_pairs
    set _library_match_last_fill_pairs $fill_pairs

    # Pre-Apply confirmation. Post-Apply Undo was removed (2026-07-05) -
    # snapshot state was fragile (any Materials-tab edit invalidated it),
    # so "undo after" was a false promise. Instead, confirm BEFORE any
    # write so the user has one clear moment to back out.
    set match_desc {}
    foreach entry $match_pairs { lassign $entry lib_col target; lappend match_desc "$lib_col -> $target" }
    set fill_desc {}
    foreach entry $fill_pairs { lassign $entry lib_col target; lappend fill_desc "$lib_col -> $target" }
    set mat_count 0
    if {[info exists _tab_rows(materials)]} { set mat_count [llength $_tab_rows(materials)] }
    set lib_count [llength $_tab_rows(library)]
    set confirm_msg "Match [_tab_label materials] rows against Material Library and fill matched fields?\n\n"
    append confirm_msg "Match by: [join $match_desc {, }]\n"
    append confirm_msg "Fill: [join $fill_desc {, }]\n\n"
    append confirm_msg "$mat_count material row(s) will be checked against $lib_count library row(s).\n"
    append confirm_msg "This CANNOT be undone. Save the session first if you want a safety point."
    set answer "yes"
    catch {set answer [tk_messageBox -parent $win -type yesno -icon question \
        -title "Apply Match" -message $confirm_msg]}
    if {$answer ne "yes"} { return }

    log "Match Library to Materials: match by \[[join $match_desc {, }]\], fill \[[join $fill_desc {, }]\]"

    set matched 0
    set ambiguous {}
    set unmatched {}
    set unmatched_reasons [dict create]
    set out {}
    if {[info exists _tab_rows(materials)]} { set mat_rows $_tab_rows(materials) } else { set mat_rows {} }
    foreach row $mat_rows {
        set hits {}
        set per_lib_fails {}
        foreach lib_row $_tab_rows(library) {
            set result [_library_row_match_result $lib_row $row $match_pairs]
            if {[dict get $result ok]} {
                lappend hits $lib_row
            } else {
                # Remember the closest failure so we can tell the user
                # WHY this material didn't match anything, not just that
                # it didn't.
                lappend per_lib_fails [list \
                    [_dict_get $lib_row "Lib No"] \
                    [_dict_get $lib_row "Material Name"] \
                    [dict get $result fails]]
            }
        }
        if {[llength $hits] == 1} {
            set row [_library_fill_from_mapping $row [lindex $hits 0] $fill_pairs]
            _sync_material_label_across_rows $row
            incr matched
        } elseif {[llength $hits] > 1} {
            lappend ambiguous [dict create mat_id [_dict_get $row mat_id] hits $hits]
        } else {
            lappend unmatched $row
            dict set unmatched_reasons [_dict_get $row mat_id] $per_lib_fails
        }
        lappend out $row
    }
    set _tab_rows(materials) $out
    _set_session_dirty 1
    _refresh_material_options
    _populate_current
    catch {destroy $win}

    if {[llength $unmatched] > 0} {
        log "Match Library to Materials: [llength $unmatched] row(s) had NO matching Library entry:"
        foreach row $unmatched {
            set mid [_dict_get $row mat_id]
            set desc "  MAT ID $mid ([_dict_get $row mat_name])"
            set vals {}
            foreach entry $match_pairs {
                lassign $entry lib_col target
                lappend vals "$target=[_dict_get $row $target]"
            }
            append desc " - [join $vals {, }]"
            log $desc
            # NEW: dump per-library-row reasons so user can see EXACTLY
            # which field lost and by how much. Blank fields report as
            # "blank_lib"/"blank_mat" (very common cause), numeric diffs
            # report the actual diff and tolerance.
            if {[dict exists $unmatched_reasons $mid]} {
                foreach fail_entry [dict get $unmatched_reasons $mid] {
                    lassign $fail_entry lib_no mat_name fails
                    foreach fdict $fails {
                        set fld [dict get $fdict field]
                        set lv [dict get $fdict lib]
                        set mv [dict get $fdict mat]
                        set rsn [dict get $fdict reason]
                        log "      vs Lib $lib_no ($mat_name): $fld  lib=$lv mat=$mv  reason=$rsn"
                    }
                }
            }
        }
    }
    if {[llength $ambiguous] > 0} {
        log "Match Library to Materials: [llength $ambiguous] row(s) matched more than one Library entry (resolve dialog opened):"
        foreach entry $ambiguous {
            log "  MAT ID [dict get $entry mat_id] - [llength [dict get $entry hits]] Library candidate(s)"
        }
        _open_library_ambiguous_dialog_mapping $ambiguous $match_pairs $fill_pairs
    }

    _library_match_show_completion $matched [llength $mat_rows] \
        [llength $unmatched] [llength $ambiguous]
}

# Post-Apply informational dialog. Undo path removed 2026-07-05 (see
# _library_match_apply for rationale). Any unmatched/ambiguous count in
# the summary tells the user to check the log for per-field mismatch
# reasons - the diagnostic added same day dumps EXACTLY which field on
# which library row failed with what values, so the user can fix the
# offending cell and re-run Match instead of hoping Undo works.
proc ::nc::ui_table::_library_match_show_completion {matched total unmatched ambiguous} {
    set win .nc_library_match_result
    catch {destroy $win}
    toplevel $win
    wm title $win "Match Applied"
    set lines {}
    lappend lines "Matched $matched of $total material row(s)."
    if {$unmatched > 0} { lappend lines "$unmatched had no matching library row." }
    if {$ambiguous > 0} { lappend lines "$ambiguous were ambiguous (resolve dialog opened)." }
    label $win.msg -anchor w -justify left -text [join $lines "\n"]
    pack $win.msg -side top -fill x -padx 12 -pady {12 8}

    if {$unmatched > 0 || $ambiguous > 0} {
        label $win.hint -anchor w -justify left -foreground "#666666" -text \
            "See the log below for per-row match diagnostics -\nit names the exact field, values, and reason for each miss."
        pack $win.hint -side top -fill x -padx 12 -pady {0 8}
    }

    frame $win.buttons
    button $win.buttons.close -text "Close" -command [list destroy $win]
    _style_button $win.buttons.close primary
    pack $win.buttons.close -side right -padx {4 0} -pady 10
    pack $win.buttons -side top -fill x -padx 12

    # Build the status bar message piecewise. Inline `expr {... ? \"x\" : \"\"}`
    # inside a double-quoted string blows up when Tcl re-parses the string
    # body under HM's embedded interpreter (backslash-quote sees invalid
    # character); safer to build the string in plain Tcl.
    set msg "Matched $matched of $total."
    if {$unmatched > 0} { append msg " $unmatched unmatched." }
    if {$ambiguous > 0} { append msg " $ambiguous ambiguous." }
    set status "ok"
    if {$unmatched > 0 || $ambiguous > 0} { set status "warn" }
    _set_status $msg $status
    catch {_place_companion_window $win 380 200}
}

# Ambiguity dialog for the two-table match flow. Derives type/label columns
# from fill_pairs and the match-key columns from match_pairs directly (no
# more match_flag/fill_flag to check - membership in the list is the
# flag), and writes hits back via _library_fill_from_mapping so a hit
# fills every Fill-table target.
proc ::nc::ui_table::_open_library_ambiguous_dialog_mapping {ambiguous match_pairs fill_pairs} {
    variable _tab_rows
    set type_col ""
    set label_col ""
    foreach entry $fill_pairs {
        lassign $entry lib_col target
        if {$target eq "mat_user_name"} { set type_col $lib_col }
        if {$target eq "mat_label"} { set label_col $lib_col }
    }
    set match_cols $match_pairs
    set win .nc_library_ambiguous
    catch {destroy $win}
    toplevel $win
    wm title $win "Resolve Ambiguous Library Matches"
    label $win.msg -anchor w -justify left -wraplength 460 -text \
        "More than one Library row matched on the selected field(s) for these\nmaterial(s). Pick which one to use for each, or leave as Skip."
    pack $win.msg -side top -fill x -padx 8 -pady {8 4}

    frame $win.quick
    button $win.quick.first -text "Select First For All" -command {::nc::ui_table::_library_ambiguous_select_first}
    _style_button $win.quick.first quiet
    pack $win.quick.first -side left
    pack $win.quick -side top -fill x -padx 8 -pady {0 4}

    frame $win.body
    set canvas [canvas $win.body.c -highlightthickness 0]
    set sb [scrollbar $win.body.sb -orient vertical -command [list $canvas yview]]
    $canvas configure -yscrollcommand [list $sb set]
    pack $sb -side right -fill y
    pack $canvas -side left -fill both -expand 1
    set inner [frame $canvas.inner]
    set inner_item [$canvas create window 0 0 -anchor nw -window $inner]
    bind $canvas <Configure> [list ::nc::ui_table::_library_ambiguous_sync_inner_width $canvas $inner_item %w]
    pack $win.body -side top -fill both -expand 1 -padx 8 -pady 4

    set idx 0
    foreach entry $ambiguous {
        set mat_id [dict get $entry mat_id]
        set hits [dict get $entry hits]
        set row_f [frame $inner.r$idx]
        label $row_f.lbl -width 24 -anchor w -text "MAT ID $mat_id:"
        set values {Skip}
        foreach hit $hits {
            set desc ""
            if {$type_col ne ""} { append desc [_dict_get $hit $type_col] }
            if {$label_col ne ""} { append desc " / [_dict_get $hit $label_col]" }
            set fields {}
            foreach pair $match_cols {
                lassign $pair col target
                lappend fields "$target=[_dict_get $hit $col]"
            }
            append desc " ([join $fields {, }])"
            lappend values [string trim $desc]
        }
        ttk::combobox $row_f.combo -state readonly -values $values -width 44
        $row_f.combo set Skip
        set ::nc::ui_table::_library_ambig_combo($idx) $row_f.combo
        set ::nc::ui_table::_library_ambig_hits($idx) $hits
        set ::nc::ui_table::_library_ambig_matid($idx) $mat_id
        pack $row_f.lbl -side left
        pack $row_f.combo -side left -fill x -expand 1
        pack $row_f -side top -fill x -pady 2
        incr idx
    }
    set ::nc::ui_table::_library_ambig_count $idx
    set ::nc::ui_table::_library_ambig_fill_pairs $fill_pairs
    update idletasks
    $canvas configure -scrollregion [$canvas bbox all]

    frame $win.buttons
    button $win.buttons.apply -text "Apply Selections" \
        -command [list ::nc::ui_table::_library_ambiguous_apply_mapping $win]
    button $win.buttons.cancel -text "Close" -command [list destroy $win]
    _style_button $win.buttons.apply primary
    _style_button $win.buttons.cancel quiet
    pack $win.buttons.cancel -side right -padx {4 0} -pady 8
    pack $win.buttons.apply -side right -padx {4 0} -pady 8
    pack $win.buttons -side top -fill x -padx 8
    catch {_place_companion_window $win 520 420}
}

proc ::nc::ui_table::_library_ambiguous_apply_mapping {win} {
    variable _library_ambig_count
    variable _library_ambig_fill_pairs
    set resolved 0
    for {set i 0} {$i < $_library_ambig_count} {incr i} {
        set combo $::nc::ui_table::_library_ambig_combo($i)
        if {![winfo exists $combo]} continue
        set choice [$combo current]
        if {$choice <= 0} continue
        set hits $::nc::ui_table::_library_ambig_hits($i)
        set hit [lindex $hits [expr {$choice - 1}]]
        set mat_id $::nc::ui_table::_library_ambig_matid($i)
        set row [_material_row_by_id $mat_id]
        if {$row eq ""} continue
        set row [_library_fill_from_mapping $row $hit $_library_ambig_fill_pairs]
        _replace_row materials $mat_id $row
        _sync_material_label_across_rows $row
        incr resolved
    }
    if {$resolved > 0} {
        _set_session_dirty 1
        _refresh_material_options
        _populate_current
    }
    catch {destroy $win}
    _set_status "Resolved $resolved ambiguous match(es)." ok
}

# One combobox per ambiguous Materials row, each listing its tied Library
# candidates (plus "Skip") so the user decides which one to fill in.
proc ::nc::ui_table::_library_ambiguous_sync_inner_width {canvas item width} {
    if {![winfo exists $canvas]} return
    catch {$canvas itemconfigure $item -width $width}
}

proc ::nc::ui_table::_open_library_ambiguous_dialog {ambiguous type_col label_col match_cols} {
    variable _tab_rows
    set win .nc_library_ambiguous
    catch {destroy $win}
    toplevel $win
    wm title $win "Resolve Ambiguous Library Matches"
    label $win.msg -anchor w -justify left -wraplength 460 -text \
        "More than one Library row matches on the selected field(s) for these\nmaterial(s). Pick which one to use for each, or leave as Skip."
    pack $win.msg -side top -fill x -padx 8 -pady {8 4}

    frame $win.quick
    button $win.quick.first -text "Select First For All" -command {::nc::ui_table::_library_ambiguous_select_first}
    _style_button $win.quick.first quiet
    pack $win.quick.first -side left
    pack $win.quick -side top -fill x -padx 8 -pady {0 4}

    frame $win.body
    set canvas [canvas $win.body.c -highlightthickness 0]
    set sb [scrollbar $win.body.sb -orient vertical -command [list $canvas yview]]
    $canvas configure -yscrollcommand [list $sb set]
    pack $sb -side right -fill y
    pack $canvas -side left -fill both -expand 1
    set inner [frame $canvas.inner]
    set inner_item [$canvas create window 0 0 -anchor nw -window $inner]
    # Keep the embedded frame's width pinned to the canvas's actual width so
    # rows (and their -fill x -expand 1 comboboxes) stretch when the dialog
    # is resized, instead of staying at their initial requested width.
    bind $canvas <Configure> [list ::nc::ui_table::_library_ambiguous_sync_inner_width $canvas $inner_item %w]
    pack $win.body -side top -fill both -expand 1 -padx 8 -pady 4

    set idx 0
    foreach entry $ambiguous {
        set mat_id [dict get $entry mat_id]
        set hits [dict get $entry hits]
        set row_f [frame $inner.r$idx]
        label $row_f.lbl -width 24 -anchor w -text "MAT ID $mat_id:"
        set values {Skip}
        foreach hit $hits {
            set desc ""
            if {$type_col ne ""} { append desc [_dict_get $hit $type_col] }
            if {$label_col ne ""} { append desc " / [_dict_get $hit $label_col]" }
            set fields {}
            foreach pair $match_cols {
                lassign $pair col norm
                lappend fields "$norm=[_dict_get $hit $col]"
            }
            append desc " ([join $fields {, }])"
            lappend values [string trim $desc]
        }
        ttk::combobox $row_f.combo -state readonly -values $values -width 44
        $row_f.combo set Skip
        set ::nc::ui_table::_library_ambig_combo($idx) $row_f.combo
        set ::nc::ui_table::_library_ambig_hits($idx) $hits
        set ::nc::ui_table::_library_ambig_matid($idx) $mat_id
        pack $row_f.lbl -side left
        pack $row_f.combo -side left -fill x -expand 1
        pack $row_f -side top -fill x -pady 2
        incr idx
    }
    set ::nc::ui_table::_library_ambig_count $idx
    update idletasks
    $canvas configure -scrollregion [$canvas bbox all]

    frame $win.buttons
    button $win.buttons.apply -text "Apply Selections" -command [list ::nc::ui_table::_library_ambiguous_apply $win $type_col $label_col]
    button $win.buttons.cancel -text "Close" -command [list destroy $win]
    _style_button $win.buttons.apply primary
    _style_button $win.buttons.cancel quiet
    pack $win.buttons.cancel -side right -padx {4 0} -pady 8
    pack $win.buttons.apply -side right -padx {4 0} -pady 8
    pack $win.buttons -side top -fill x -padx 8
    catch {_place_companion_window $win 520 420}
}

# Sets every ambiguous row's combobox to its first Library candidate
# (index 1, right after "Skip") in one click, instead of leaving them all
# on Skip and requiring a manual pick for each row.
proc ::nc::ui_table::_library_ambiguous_select_first {} {
    variable _library_ambig_count
    for {set i 0} {$i < $_library_ambig_count} {incr i} {
        if {![info exists ::nc::ui_table::_library_ambig_combo($i)]} continue
        set combo $::nc::ui_table::_library_ambig_combo($i)
        if {![winfo exists $combo]} continue
        if {[$combo cget -values] eq "" || [llength [$combo cget -values]] < 2} continue
        $combo current 1
    }
    _set_status "Selected the first Library candidate for every ambiguous row." ok
}

proc ::nc::ui_table::_library_ambiguous_apply {win type_col label_col} {
    variable _tab_rows
    variable _library_ambig_count
    set resolved 0
    for {set i 0} {$i < $_library_ambig_count} {incr i} {
        set combo $::nc::ui_table::_library_ambig_combo($i)
        if {![winfo exists $combo]} continue
        set choice [$combo current]
        if {$choice <= 0} continue
        set hits $::nc::ui_table::_library_ambig_hits($i)
        set hit [lindex $hits [expr {$choice - 1}]]
        set mat_id $::nc::ui_table::_library_ambig_matid($i)
        set row [_material_row_by_id $mat_id]
        if {$row eq ""} continue
        set row [_library_fill_from_hit $row $hit $type_col $label_col]
        _replace_row materials $mat_id $row
        if {$type_col ne ""} { _sync_material_label_across_rows $row }
        incr resolved
    }
    if {$resolved > 0} {
        _set_session_dirty 1
        _refresh_material_options
        _populate_current
    }
    catch {destroy $win}
    _set_status "Resolved $resolved ambiguous match(es)." ok
}

proc ::nc::ui_table::_validate_id_field {warnings_var tab row_index row key {required 0}} {
    upvar 1 $warnings_var warnings
    set value [_dict_get $row $key]
    if {$value eq ""} {
        if {$required} {
            lappend warnings "[_tab_label $tab] row $row_index: missing $key"
        }
        return
    }
    if {![string is integer -strict $value] || $value <= 0} {
        lappend warnings "[_tab_label $tab] row $row_index: invalid $key '$value'"
    }
}

proc ::nc::ui_table::_validate_tab_rows {tab rows} {
    set warnings [_duplicate_row_key_warnings $tab $rows]
    set row_index 1
    set material_labels [dict create]
    foreach row $rows {
        switch -- $tab {
            general -
            component {
                _validate_id_field warnings $tab $row_index $row comp_id 1
                _validate_id_field warnings $tab $row_index $row prop_id 0
                _validate_id_field warnings $tab $row_index $row mat_id 0
                if {[_component_prop_usage_count $row] > 1} {
                    lappend warnings "[_tab_label $tab] row $row_index: property [_dict_get $row prop_id] is shared by [_component_prop_usage_count $row] component rows"
                }
            }
            properties {
                _validate_id_field warnings $tab $row_index $row prop_id 1
                _validate_id_field warnings $tab $row_index $row mat_id 0
                set card [_dict_get $row prop_card [_dict_get $row card]]
                if {$card ne "" && $card ni {PSHELL PSOLID PBUSH}} {
                    lappend warnings "[_tab_label $tab] row $row_index: unexpected prop_card '$card'"
                }
            }
            materials {
                _validate_id_field warnings $tab $row_index $row mat_id 1
                set label [_dict_get $row mat_user_name [_dict_get $row mat_name]]
                if {[string trim $label] eq ""} {
                    lappend warnings "[_tab_label $tab] row $row_index: missing material label/name"
                } elseif {[dict exists $material_labels $label]} {
                    lappend warnings "[_tab_label $tab] row $row_index: duplicate material label '$label' also appears at row [dict get $material_labels $label]"
                } else {
                    dict set material_labels $label $row_index
                }
            }
        }
        incr row_index
    }
    return $warnings
}

proc ::nc::ui_table::_on_validate {} {
    variable _tab_rows
    set warnings {}
    foreach tab {general component properties materials} {
        set rows {}
        if {[info exists _tab_rows($tab)]} { set rows $_tab_rows($tab) }
        set warnings [concat $warnings [_validate_tab_rows $tab $rows]]
    }
    set count [llength $warnings]
    if {$count == 0} {
        _set_status "Preview validation passed for all tabs." ok
    } else {
        set sample [join [lrange $warnings 0 2] "; "]
        if {$count > 3} {
            append sample "; ..."
        }
        _set_status "Preview validation found $count warning(s): $sample" warn
    }
}

proc ::nc::ui_table::_on_arrange {} {
    variable _tbl
    variable _tab
    variable _image_thumb_px
    variable _image_render_signature
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    set c 0
    foreach col_def [_cols_for_tab $_tab] {
        set key [lindex $col_def 0]
        if {$key eq "image_path"} {
            # The Image column's static default width (col_def's own value)
            # is unrelated to the actual thumbnail pixel size the user picks
            # via S/M/L - resetting to that default could leave the column
            # narrower than the image, clipping it. Fit it to the CURRENT
            # thumbnail size instead, same formula the renderer itself uses.
            lassign [_image_cell_fit_units $_image_thumb_px 2] img_w img_h
            catch {$_tbl width $c $img_w}
        } else {
            catch {$_tbl width $c [lindex $col_def 2]}
        }
        incr c
    }
    # Force _render_image_cells to fully re-apply PER-ROW heights, not just
    # the column width: _populate_current -> _fill_table_data ->
    # _reset_visible_row_heights deliberately skips rows that hold an image
    # (row height for those is _render_image_cells' job), and
    # _render_image_cells itself skips re-setting heights whenever its
    # cached "signature" (tab/column/thumb size/paths) hasn't changed -
    # which is exactly the case here, since Arrange doesn't touch any of
    # those. That left row heights stale after `-rows` gets reconfigured by
    # _populate_current, so images visually overflowed into the row below.
    # Clearing the signature forces the height-setting line to run again.
    set _image_render_signature ""
    _populate_current
    _set_status "Column widths reset for current tab." ok
}

proc ::nc::ui_table::_set_image_size {size} {
    variable _image_thumb_px
    variable _tab_rows
    switch -- $size {
        small { set _image_thumb_px 64 }
        medium { set _image_thumb_px 96 }
        large { set _image_thumb_px 144 }
        default { set _image_thumb_px 96 }
    }
    set paths {}
    foreach tab {general component} {
        if {![info exists _tab_rows($tab)]} continue
        foreach row $_tab_rows($tab) {
            set p [_dict_get $row image_path]
            if {$p ne ""} { lappend paths $p }
        }
    }
    if {[llength $paths] > 0} {
        _set_status "Regenerating [llength $paths] thumbnail(s) for [string totitle $size]..." ok
        catch {update idletasks}
        _preload_thumbnails $paths $_image_thumb_px
    }
    _invalidate_image_photo_cache
    _populate_current
    _set_status "Image size set to [string totitle $size]." ok
}

proc ::nc::ui_table::_adjust_text_size {delta} {
    variable _ui_font_size
    if {![string is integer -strict $delta]} { set delta 0 }
    set next [expr {$_ui_font_size + $delta}]
    if {$next < 8} { set next 8 }
    if {$next > 13} { set next 13 }
    if {$next == $_ui_font_size} {
        _set_status "Text size already at limit ($_ui_font_size)." warn
        return
    }
    set _ui_font_size $next
    _rebuild_table_columns
    _apply_density
    _populate_current
    _set_status "Text size set to $_ui_font_size." ok
}

proc ::nc::ui_table::_reset_columns {} {
    variable _tab
    variable _col_order
    catch {unset _col_order($_tab)}
    _rebuild_table_columns
    _populate_current
    _on_arrange
    _save_column_layout
    _set_status "Column order and widths reset for $_tab tab." ok
}

proc ::nc::ui_table::_on_load_images {} {
    variable _tab_rows
    set initial ""
    catch {set initial [::nc::session::dir]}
    if {$initial eq "" || ![file isdirectory $initial]} { set initial [pwd] }
    set folder [_choose_folder_dialog "Select Component Image Folder" $initial]
    if {$folder eq ""} { return }
    set image_by_comp [_load_image_folder_map $folder]
    set nimg [dict size $image_by_comp]
    set nrows 0
    if {[info exists _tab_rows(component)]} { set nrows [llength $_tab_rows(component)] }
    if {$nrows == 0 && [info exists _tab_rows(general)]} { set nrows [llength $_tab_rows(general)] }
    if {$nimg == 0} {
        _set_status "No numeric-named PNG/JPG images found in $folder (expect e.g. 100.png matching comp_id)." warn
        return
    }
    if {$nrows == 0} {
        _set_status "Table is empty — open a session or Reload from FEM first, then load images. ($nimg image(s) found in folder.)" warn
        return
    }
    set changed [set_component_image_paths $image_by_comp]
    if {$changed == 0} {
        _set_status "Found $nimg image(s) but none matched any component ID in the table. Image filename stems must match comp_id (e.g. 100.png -> comp_id 100)." warn
        return
    }
    _set_status "Loaded $changed / $nimg component image(s) from $folder" ok
}


# comp_ids (from get_component_ids) that don't have a usable image yet -
# e.g. a component added by a rescan since the last full capture. Used to
# offer "capture only the new ones" instead of redoing everything.
proc ::nc::ui_table::_component_ids_missing_image {comp_ids} {
    variable _tab_rows
    set has_image [dict create]
    if {[info exists _tab_rows(component)]} {
        foreach row $_tab_rows(component) {
            set cid [_dict_get $row comp_id]
            if {$cid eq ""} continue
            set path [_dict_get $row image_path]
            if {$path ne "" && [file exists $path]} { dict set has_image $cid 1 }
        }
    }
    set missing {}
    foreach cid $comp_ids {
        if {![dict exists $has_image $cid]} { lappend missing $cid }
    }
    return $missing
}

proc ::nc::ui_table::_on_capture_images {} {
    variable _capture_resume_comp_ids
    if {[llength [info commands ::nc::app::capture_component_images]] == 0} {
        _set_status "Capture is available after launching through nastran_control.tcl." warn
        return
    }
    set dir ""
    catch {set dir [::nc::session::dir]}
    if {$dir eq ""} { set dir [pwd] }
    set comp_ids [get_component_ids]
    if {[llength $comp_ids] == 0} {
        _set_status "No components available for image capture." warn
        return
    }
    if {[llength $_capture_resume_comp_ids] > 0} {
        set nrem [llength $_capture_resume_comp_ids]
        set ans ""
        catch {
            set ans [_table_message_box \
                -title "Resume Capture" \
                -icon question \
                -type yesnocancel \
                -message "There's an incomplete capture from earlier ($nrem component(s) remaining).\n\nYes = Resume the remaining ones\nNo = Start a full new capture\nCancel = do nothing"]
        }
        if {$ans eq "cancel" || $ans eq ""} { return }
        if {$ans eq "yes"} {
            set resume_ids $_capture_resume_comp_ids
            set _capture_resume_comp_ids {}
            _run_capture $resume_ids $dir 1
            return
        }
        set _capture_resume_comp_ids {}
    }
    set missing_ids [_component_ids_missing_image $comp_ids]
    if {[llength $missing_ids] > 0 && [llength $missing_ids] < [llength $comp_ids]} {
        set nmiss [llength $missing_ids]
        set ans ""
        catch {
            set ans [_table_message_box \
                -title "Capture Component Images" \
                -icon question \
                -type yesnocancel \
                -message "$nmiss of [llength $comp_ids] component(s) don't have an image yet (likely added since the last capture).\n\nYes = Capture only the new ones\nNo = Recapture everything from scratch\nCancel = do nothing"]
        }
        if {$ans eq "cancel" || $ans eq ""} { return }
        if {$ans eq "yes"} {
            _run_capture $missing_ids $dir 0
            return
        }
    }
    _run_capture $comp_ids $dir 0
}

proc ::nc::ui_table::_run_capture {comp_ids dir skip_confirm} {
    _autosave_suspend_begin
    set code [catch {_run_capture_impl $comp_ids $dir $skip_confirm} result]
    _autosave_suspend_end
    if {$code} { return -code error $result }
    return $result
}

proc ::nc::ui_table::_run_capture_impl {comp_ids dir skip_confirm} {
    variable _capture_cancelled
    variable _capture_resume_comp_ids
    set ncomp [llength $comp_ids]
    if {!$skip_confirm} {
        set answer "no"
        catch {
            set answer [_table_message_box \
                -title "Capture Component Images" \
                -icon question \
                -type yesno \
                -message "This will isolate and capture $ncomp component(s) one at a time,\ntemporarily changing the CAE tool display.\n\nContinue?"]
        }
        if {$answer ne "yes"} {
            _set_status "Capture cancelled before starting." warn
            return
        }
    }
    set _capture_cancelled 0
    _build_capture_progress_dialog $ncomp
    set progress_cb ::nc::ui_table::_capture_progress_update
    set cancel_cb ::nc::ui_table::_capture_is_cancelled
    set rc [catch {::nc::app::capture_component_images $dir $comp_ids $progress_cb $cancel_cb} result opts]
    catch {destroy .nc_capture_progress}
    if {$rc} {
        _set_status "Capture images failed: $result" error
        return
    }
    set remaining {}
    catch {set remaining [dict get $result _remaining_comp_ids]}
    set changed [set_component_image_paths $result]
    if {$_capture_cancelled} {
        set nrem [llength $remaining]
        set ndone [expr {$ncomp - $nrem}]
        _set_status "Capture cancelled. Loaded $changed component image path(s) before stopping." warn
        set _capture_resume_comp_ids $remaining
        if {$nrem > 0} {
            set ans2 "no"
            catch {
                set ans2 [_table_message_box \
                    -title "Resume Capture?" \
                    -icon question \
                    -type yesno \
                    -message "Capture was cancelled after $ndone/$ncomp component(s). $nrem component(s) were not captured yet.\n\nResume the remaining ones now?"]
            }
            if {$ans2 eq "yes"} {
                set _capture_resume_comp_ids {}
                _run_capture $remaining $dir 1
            }
        }
    } else {
        set _capture_resume_comp_ids {}
        _set_status "Captured/loaded $changed component image path(s)." ok
    }
}

proc ::nc::ui_table::_build_capture_progress_dialog {total} {
    variable _win
    set w .nc_capture_progress
    catch {destroy $w}
    toplevel $w
    wm title $w "Capturing Images"
    catch {wm transient $w $_win}
    catch {wm resizable $w 1 1}
    catch {wm minsize $w 380 220}
    wm protocol $w WM_DELETE_WINDOW {::nc::ui_table::_capture_request_cancel}
    if {[llength [info commands ttk::progressbar]] > 0} {
        ttk::progressbar $w.bar -orient horizontal -mode determinate -maximum [expr {max($total,1)}] -length 320
        pack $w.bar -side top -fill x -padx 10 -pady {10 6}
    }
    set lf [frame $w.logframe -bd 1 -relief sunken]
    pack $lf -side top -fill both -expand 1 -padx 10 -pady {0 8}
    set logw [text $lf.t -height 10 -width 52 -font {Courier 8} -state disabled -wrap none \
        -background "#f8f8f8" -foreground "#333" -yscrollcommand [list $lf.sy set]]
    scrollbar $lf.sy -orient v -command [list $logw yview]
    pack $lf.sy -side right -fill y
    pack $logw -side left -fill both -expand 1
    button $w.cancel -text "Cancel" -command {::nc::ui_table::_capture_request_cancel}
    pack $w.cancel -side top -pady {0 10}
    catch {_place_companion_window $w 420 300}
    _capture_log_line "Preparing to capture $total component(s)..."
    catch {update idletasks}
}

proc ::nc::ui_table::_capture_log_line {line} {
    set w .nc_capture_progress
    if {![winfo exists $w] || ![winfo exists $w.logframe.t]} { return }
    set logw $w.logframe.t
    catch {
        $logw configure -state normal
        $logw insert end "$line\n"
        $logw see end
        $logw configure -state disabled
    }
}

proc ::nc::ui_table::_capture_request_cancel {} {
    variable _capture_cancelled
    set _capture_cancelled 1
    _capture_log_line "Cancel requested -- finishing current component..."
    catch {.nc_capture_progress.cancel configure -state disabled}
    catch {update idletasks}
}

proc ::nc::ui_table::_capture_progress_update {idx total comp_id} {
    set w .nc_capture_progress
    if {![winfo exists $w]} { return }
    if {$idx eq "restore"} {
        _capture_log_line "Restoring display..."
        catch {update idletasks}
        return
    }
    if {$idx eq "restore_done"} {
        _capture_log_line "Display restored. Done."
        catch {update idletasks}
        return
    }
    _capture_log_line "Component $comp_id done. ($idx/$total)"
    if {$idx < $total} {
        _capture_log_line "Capturing next component ($idx/$total captured so far)..."
    }
    if {[winfo exists $w.bar]} {
        catch {$w.bar configure -value $idx}
    }
    catch {update idletasks}
}

proc ::nc::ui_table::_capture_is_cancelled {} {
    variable _capture_cancelled
    catch {update idletasks}
    return $_capture_cancelled
}

proc ::nc::ui_table::_load_image_folder_map {folder} {
    set image_by_comp [dict create]
    if {$folder eq "" || ![file isdirectory $folder]} { return $image_by_comp }
    foreach path [glob -nocomplain [file join $folder *]] {
        if {![file isfile $path]} { continue }
        set ext [string tolower [file extension $path]]
        if {$ext ni {.png .jpg .jpeg .bmp .gif}} { continue }
        set stem [file rootname [file tail $path]]
        if {![string is integer -strict $stem]} { continue }
        dict set image_by_comp $stem $path
    }
    return $image_by_comp
}

proc ::nc::ui_table::_mock_action {msg} {
    _set_status $msg ok
}

# =============================================================================
# Search / worklist / import-export
# =============================================================================

proc ::nc::ui_table::_on_find_next {} {
    _populate_current
    _set_status "Search filter applied: [llength $::nc::ui_table::_rows] visible row(s)." ok
}

proc ::nc::ui_table::_on_search_clear {} {
    variable _search_text
    set _search_text ""
    _populate_current
    _set_status "Search cleared." ok
}

proc ::nc::ui_table::_worklist_memory_key {tab col} {
    if {$col eq ""} { set col "__any__" }
    return "$tab|$col"
}

proc ::nc::ui_table::_worklist_parse_text {text} {
    set labels {}
    set ids {}
    set items {}
    foreach line [split $text "\n"] {
        set item [string trim $line]
        if {$item eq ""} { continue }
        set line_items [list $item]
        set tokens [regexp -all -inline {\S+} $item]
        if {[llength $tokens] > 1} {
            set all_int 1
            foreach token $tokens {
                if {![string is integer -strict $token]} { set all_int 0; break }
            }
            if {$all_int} { set line_items $tokens }
        }
        foreach item $line_items {
            if {[lsearch -exact $items $item] < 0} { lappend items $item }
            if {[string is integer -strict $item]} {
                if {[lsearch -exact $ids $item] < 0} { lappend ids $item }
            } elseif {[lsearch -exact $labels $item] < 0} {
                lappend labels $item
            }
        }
    }
    return [dict create items $items ids $ids labels $labels]
}

proc ::nc::ui_table::_worklist_remember {tab col items} {
    variable _worklist_memory
    set key [_worklist_memory_key $tab $col]
    if {[llength $items] == 0} {
        catch {unset _worklist_memory($key)}
    } else {
        set _worklist_memory($key) $items
    }
}

proc ::nc::ui_table::_worklist_recalled {tab col} {
    variable _worklist_memory
    set key [_worklist_memory_key $tab $col]
    if {[info exists _worklist_memory($key)]} { return $_worklist_memory($key) }
    return {}
}

proc ::nc::ui_table::_worklist_dialog_col_key {} {
    variable _worklist_col_pick
    variable _worklist_dialog_label_to_key
    array set label_to_key $_worklist_dialog_label_to_key
    set col ""
    if {[info exists label_to_key($_worklist_col_pick)]} { set col $label_to_key($_worklist_col_pick) }
    return $col
}

proc ::nc::ui_table::_worklist_dialog_save_current {win} {
    variable _tab
    variable _worklist_dialog_active_col
    if {![winfo exists $win] || ![winfo exists $win.t]} { return }
    set text ""
    catch {set text [$win.t get 1.0 end]}
    set parsed [_worklist_parse_text $text]
    _worklist_remember $_tab $_worklist_dialog_active_col [dict get $parsed items]
}

proc ::nc::ui_table::_worklist_dialog_load_current {win} {
    variable _tab
    variable _worklist_dialog_active_col
    if {![winfo exists $win] || ![winfo exists $win.t]} { return }
    set col [_worklist_dialog_col_key]
    set _worklist_dialog_active_col $col
    set items [_worklist_recalled $_tab $col]
    $win.t delete 1.0 end
    if {[llength $items] > 0} {
        $win.t insert 1.0 [join $items "\n"]
    }
}

proc ::nc::ui_table::_worklist_dialog_col_changed {win} {
    _worklist_dialog_save_current $win
    _worklist_dialog_load_current $win
}

proc ::nc::ui_table::_on_worklist {{preset_col ""}} {
    variable _tab
    variable _worklist_active
    variable _worklist_items
    variable _worklist_col
    variable _worklist_col_pick
    variable _worklist_dialog_active_col
    set win .nc_worklist
    catch {destroy $win}
    toplevel $win
    set noun [_tab_label $_tab]
    wm title $win "$noun Worklist"

    set col_defs [_worklist_columns_for_tab $_tab]
    set labels [list "Any column ($noun ID or Label)"]
    array set label_to_key [list [lindex $labels 0] ""]
    foreach col_def $col_defs {
        set key [lindex $col_def 0]
        set clabel [lindex $col_def 1]
        lappend labels $clabel
        set label_to_key($clabel) $key
    }
    # Right-click "Filter this column..." on a header passes its key here so
    # the dialog opens already pointed at that column - no need to hunt for
    # it in the dropdown. Falls back to whatever was last used otherwise.
    set want_col [expr {$preset_col ne "" ? $preset_col : $_worklist_col}]
    set current_label [lindex $labels 0]
    if {$want_col ne ""} {
        foreach col_def $col_defs {
            if {[lindex $col_def 0] eq $want_col} { set current_label [lindex $col_def 1]; break }
        }
    }
    set ::nc::ui_table::_worklist_col_pick $current_label
    if {$_worklist_active && [llength $_worklist_items] > 0} {
        _worklist_remember $_tab $_worklist_col $_worklist_items
    }

    frame $win.colf
    label $win.colf.lbl -text "Match against:" -anchor w
    if {[llength [info commands ttk::combobox]] > 0} {
        ttk::combobox $win.colf.pick -textvariable ::nc::ui_table::_worklist_col_pick \
            -state readonly -width 28 -values $labels
    } else {
        entry $win.colf.pick -textvariable ::nc::ui_table::_worklist_col_pick -width 28
    }
    pack $win.colf.lbl -side left -padx {0 4}
    pack $win.colf.pick -side left -fill x -expand 1
    pack $win.colf -side top -fill x -padx 8 -pady {8 2}

    label $win.msg -text "Paste one value per line - matched exactly against the column above." -anchor w
    text $win.t -height 12 -width 46
    frame $win.buttons
    button $win.buttons.apply -text "Apply" -command [list ::nc::ui_table::_apply_worklist_dialog $win]
    button $win.buttons.clearcol -text "Clear Column" -command [list ::nc::ui_table::_clear_worklist_dialog_col $win]
    button $win.buttons.cancel -text "Cancel" -command [list destroy $win]
    pack $win.msg -side top -fill x -padx 8 -pady {2 2}
    pack $win.t -side top -fill both -expand 1 -padx 8 -pady 4
    pack $win.buttons.apply $win.buttons.clearcol $win.buttons.cancel -side left -padx 4 -pady 6
    pack $win.buttons -side top -anchor e -padx 8
    set ::nc::ui_table::_worklist_dialog_label_to_key [array get label_to_key]
    set _worklist_dialog_active_col [_worklist_dialog_col_key]
    if {[winfo exists $win.colf.pick]} {
        bind $win.colf.pick <<ComboboxSelected>> [list ::nc::ui_table::_worklist_dialog_col_changed $win]
        bind $win.colf.pick <FocusOut> [list ::nc::ui_table::_worklist_dialog_col_changed $win]
    }
    _worklist_dialog_load_current $win
    _place_companion_window $win 440 380
    catch {focus $win.t}
}

proc ::nc::ui_table::_apply_worklist_dialog {win} {
    variable _worklist_active
    variable _worklist_labels
    variable _worklist_ids
    variable _worklist_items
    variable _worklist_col
    variable _worklist_col_pick
    variable _worklist_dialog_label_to_key
    variable _tab
    set noun [_tab_label $_tab]
    array set label_to_key $_worklist_dialog_label_to_key
    set col ""
    if {[info exists label_to_key($_worklist_col_pick)]} { set col $label_to_key($_worklist_col_pick) }

    set text ""
    catch {set text [$win.t get 1.0 end]}
    set parsed [_worklist_parse_text $text]
    set labels [dict get $parsed labels]
    set ids [dict get $parsed ids]
    set items [dict get $parsed items]
    if {[llength $items] == 0} {
        _set_status "Worklist needs at least one value to match." warn
        return
    }
    _worklist_remember $_tab $col $items
    set _worklist_labels $labels
    set _worklist_ids $ids
    set _worklist_items $items
    set _worklist_col $col
    set _worklist_active 1
    catch {destroy $win}
    _populate_current
    set colnote [expr {$col eq "" ? "ID/Label" : $_worklist_col_pick}]
    _set_status "Worklist active on $noun tab: [llength $items] value(s) matched against $colnote." ok
}

proc ::nc::ui_table::_clear_worklist_dialog_col {win} {
    variable _worklist_col_pick
    variable _worklist_dialog_label_to_key
    array set label_to_key $_worklist_dialog_label_to_key
    set col ""
    if {[info exists label_to_key($_worklist_col_pick)]} { set col $label_to_key($_worklist_col_pick) }
    _on_worklist_clear_for_col $col $_worklist_col_pick
    catch {destroy $win}
}

proc ::nc::ui_table::_on_worklist_clear_for_col {col label} {
    variable _worklist_active
    variable _worklist_col
    variable _tab
    _worklist_remember $_tab $col {}
    if {!$_worklist_active || $_worklist_col ne $col} {
        _set_status "Saved Worklist cleared for $label." ok
        return
    }
    _on_worklist_clear
    _set_status "Worklist cleared for $label." ok
}

proc ::nc::ui_table::_on_worklist_clear {} {
    variable _worklist_active
    variable _worklist_labels
    variable _worklist_ids
    variable _worklist_items
    variable _worklist_col
    set _worklist_active 0
    set _worklist_labels {}
    set _worklist_ids {}
    set _worklist_items {}
    set _worklist_col ""
    _populate_current
    _set_status "Worklist cleared." ok
}

# Quick-pick filter: shows only the components that appeared since the last
# Reload/scan (reuses the Worklist filter mechanism, just pre-filled instead
# of asking the user to paste IDs). Selection > Clear Worklist turns it off.
proc ::nc::ui_table::_on_filter_recent_new {} {
    variable _worklist_active
    variable _worklist_labels
    variable _worklist_ids
    variable _worklist_items
    variable _worklist_col
    variable _recent_new_comp_ids
    if {[llength $_recent_new_comp_ids] == 0} {
        _set_status "No new components since the last Reload." warn
        return
    }
    set _worklist_labels {}
    set _worklist_ids $_recent_new_comp_ids
    set _worklist_items $_recent_new_comp_ids
    set _worklist_col ""
    set _worklist_active 1
    _set_tab component
    _populate_current
    _set_status "Showing [llength $_recent_new_comp_ids] recent new component(s)." ok
}

proc ::nc::ui_table::_import_header_token {text} {
    set text [string map [list \ufeff ""] $text]
    set text [string tolower [string trim $text]]
    regsub -all {[^a-z0-9]+} $text "" text
    return $text
}

proc ::nc::ui_table::_import_key_for_header {tab header} {
    set token [_import_header_token $header]
    if {$token eq ""} { return "" }
    switch -- $token {
        masston -
        massmetricton -
        massmetrictons { return mass_total_ton }
        masskg -
        masskilogram -
        masskilograms { return mass_total }
    }
    foreach col_def [_cols_for_tab $tab 1] {
        set key [lindex $col_def 0]
        set label [lindex $col_def 1]
        if {$token eq [_import_header_token $key] || $token eq [_import_header_token $label]} {
            return $key
        }
    }
    switch -- $token {
        ncoriginalid -
        originalid -
        originalkey -
        ncoriginalkey { return _nc_original_id }
        id -
        compid -
        componentid { return comp_id }
        propid -
        propertyid { return prop_id }
        matid -
        materialid { return mat_id }
        complabel -
        componentlabel { return comp_user_name }
        label {
            switch -- $tab {
                materials { return mat_user_name }
                properties { return prop_user_name }
                default { return comp_user_name }
            }
        }
        matlabel -
        materiallabel { return mat_user_name }
        propname -
        propertyname { return prop_name }
        propcard -
        propertycard { return prop_card }
        matcard -
        materialcard { return mat_card }
        image -
        imagepath { return image_path }
        mass -
        masstotal { return mass_total }
    }
    return ""
}

proc ::nc::ui_table::_import_key_field_for_tab {tab} {
    switch -- $tab {
        properties { return prop_id }
        materials { return mat_id }
        default { return comp_id }
    }
}

proc ::nc::ui_table::_import_default_row {tab id} {
    switch -- $tab {
        properties {
            set row [dict create prop_card PSHELL prop_id $id mat_card MAT1 mat_id "" usage_count 0 note "Imported preview property"]
            foreach {k v} {
                T 1.0 NSM 0 Z1 "" Z2 "" E "" G "" NU "" RHO "" A "" TREF "" ST "" SC "" SS ""
                K1 "" K2 "" K3 "" K4 "" K5 "" K6 "" B1 "" B2 "" B3 "" B4 "" B5 "" B6 ""
                GE1 "" GE2 "" GE3 "" GE4 "" GE5 "" GE6 "" M1 "" M2 "" M3 "" M4 "" M5 "" M6 ""
            } {
                dict set row $k $v
            }
            return $row
        }
        materials {
            return [dict create mat_card MAT1 mat_id $id mat_user_name "Imported_Material_$id" mat_name "Imported_Material_$id" \
                E "" G "" NU "" RHO "" A "" TREF "" GE "" ST "" SC "" SS "" usage_count 0 note "Imported preview material"]
        }
    }
    return ""
}

proc ::nc::ui_table::_import_set_row_key {tab row key value {allow_id_change 0}} {
    set value [string trim $value]
    if {$key eq ""} { return [list $row 0] }
    if {$key in {comp_id prop_id mat_id}} {
        if {!$allow_id_change} { return [list $row 0] }
        if {$value eq "" || ![string is integer -strict $value] || $value <= 0} { return [list $row 0] }
        set old [_dict_get $row $key]
        if {$old eq $value} { return [list $row 0] }
        dict set row $key $value
        set row [_mark_dirty $row $key]
        return [list $row 1]
    }
    set old [_dict_get $row $key]
    if {$key eq "mass_total_ton"} {
        if {$value eq "" || ![string is double -strict $value]} { return [list $row 0] }
        set value [expr {double($value) * 1000.0}]
        set key mass_total
        set old [_dict_get $row mass_total_raw [_dict_get $row mass_total]]
    }
    if {$key eq "mass_total"} {
        set old [_dict_get $row mass_total_raw [_dict_get $row mass_total]]
        if {$old eq $value} { return [list $row 0] }
        dict set row mass_total_raw $value
        dict set row mass_total $value
        set row [_mark_dirty $row mass_total]
        return [list $row 1]
    }
    if {$old eq $value} { return [list $row 0] }
    if {$tab in {general component} && $key in {comp_user_name mat_user_name}} {
        set row [_set_row_value $tab $row $key $value 0]
    } else {
        dict set row $key $value
        set row [_mark_dirty $row $key]
    }
    return [list $row 1]
}

proc ::nc::ui_table::_import_csv_dicts_for_tab {tab path} {
    if {![file exists $path]} {
        return [dict create status error message "Import file not found: $path" rows {} header_keys {}]
    }
    set raw_rows [::nc::csv::read_file $path]
    if {[llength $raw_rows] < 2} {
        return [dict create status warn message "CSV has no data rows." rows {} header_keys {}]
    }
    set header [lindex $raw_rows 0]
    set header_keys {}
    set seen_headers [dict create]
    set duplicate_headers {}
    foreach h $header {
        set key [_import_key_for_header $tab $h]
        lappend header_keys $key
        if {$key ne ""} {
            if {[dict exists $seen_headers $key]} {
                lappend duplicate_headers $key
            } else {
                dict set seen_headers $key 1
            }
        }
    }
    if {[llength $duplicate_headers] > 0} {
        return [dict create status error message "CSV has duplicate mapped header(s): [join [lsort -unique $duplicate_headers] {, }]." rows {} header_keys $header_keys]
    }
    set usable 0
    foreach key $header_keys {
        if {$key ne ""} { incr usable }
    }
    if {$usable == 0} {
        return [dict create status warn message "CSV headers do not match [_tab_label $tab] columns." rows {} header_keys $header_keys]
    }
    set out {}
    foreach raw [lrange $raw_rows 1 end] {
        set d [dict create]
        for {set i 0} {$i < [llength $header_keys]} {incr i} {
            set key [lindex $header_keys $i]
            if {$key eq ""} { continue }
            set val ""
            if {$i < [llength $raw]} { set val [lindex $raw $i] }
            dict set d $key $val
        }
        lappend out $d
    }
    return [dict create status ok message "" rows $out header_keys $header_keys]
}

proc ::nc::ui_table::_import_secondary_identity_match {tab row csv_row} {
    switch -- $tab {
        materials {
            foreach key {mat_user_name mat_name} {
                set a [string trim [_dict_get $row $key]]
                set b [string trim [_dict_get $csv_row $key]]
                if {$a ne "" && $b ne "" && $a eq $b} { return 1 }
            }
            return 0
        }
        properties {
            foreach key {prop_user_name prop_name} {
                set a [string trim [_dict_get $row $key]]
                set b [string trim [_dict_get $csv_row $key]]
                if {$a ne "" && $b ne "" && $a eq $b} { return 1 }
            }
            set card_a [string trim [_dict_get $row prop_card]]
            set card_b [string trim [_dict_get $csv_row prop_card]]
            set mat_a [string trim [_dict_get $row mat_id]]
            set mat_b [string trim [_dict_get $csv_row mat_id]]
            return [expr {$card_a ne "" && $card_b ne "" && $card_a eq $card_b && $mat_a ne "" && $mat_b ne "" && $mat_a eq $mat_b}]
        }
    }
    return 0
}

proc ::nc::ui_table::_import_build_plan {tab path} {
    variable _tab_rows
    set parsed [_import_csv_dicts_for_tab $tab $path]
    if {[dict get $parsed status] ne "ok"} { return $parsed }
    set key_field [_import_key_field_for_tab $tab]
    set csv_rows [dict get $parsed rows]
    set existing {}
    if {[info exists _tab_rows($tab)]} { set existing $_tab_rows($tab) }
    set allow_position_rekey [expr {$tab in {properties materials} && [llength $csv_rows] == [llength $existing]}]

    array set csv_by_id {}
    array set csv_index_by_id {}
    array set csv_by_original_id {}
    set duplicate_ids {}
    set duplicate_original_ids {}
    set invalid 0
    set csv_index 0
    foreach csv_row $csv_rows {
        set original_id [string trim [_dict_get $csv_row _nc_original_id]]
        if {$original_id ne ""} {
            if {[string is integer -strict $original_id] && $original_id > 0} {
                if {[info exists csv_by_original_id($original_id)]} {
                    lappend duplicate_original_ids $original_id
                } else {
                    set csv_by_original_id($original_id) $csv_row
                }
            } else {
                incr invalid
            }
        }
        set id [string trim [_dict_get $csv_row $key_field]]
        if {$id eq "" || ![string is integer -strict $id] || $id <= 0} {
            incr invalid
            incr csv_index
            continue
        }
        if {[info exists csv_by_id($id)]} {
            lappend duplicate_ids $id
            incr csv_index
            continue
        }
        set csv_by_id($id) $csv_row
        set csv_index_by_id($id) $csv_index
        incr csv_index
    }
    if {[llength $duplicate_original_ids] > 0} {
        return [dict create status error message "Import blocked: duplicate NC Original ID value(s): [join [lsort -unique $duplicate_original_ids] {, }]." tab $tab path $path rows $existing changed_rows {} matched 0 id_changes 0 new 0 changed 0 invalid [expr {$invalid + [llength $duplicate_original_ids]}]]
    }
    if {[llength $duplicate_ids] > 0} {
        return [dict create status error message "Import blocked: duplicate $key_field value(s): [join [lsort -unique $duplicate_ids] {, }]." tab $tab path $path rows $existing changed_rows {} matched 0 id_changes 0 new 0 changed 0 invalid [expr {$invalid + [llength $duplicate_ids]}]]
    }

    set matched 0
    set changed 0
    set id_changes 0
    set changed_rows {}
    set out {}
    set seen {}
    set unmatched_existing_by_index [dict create]
    set row_index 0
    foreach row $existing {
        set id [_dict_get $row $key_field]
        set csv_row ""
        set match_id ""
        set allow_id_change_for_row 0
        if {$id ne "" && [info exists csv_by_original_id($id)]} {
            set csv_row $csv_by_original_id($id)
            set match_id [string trim [_dict_get $csv_row $key_field]]
            set allow_id_change_for_row 1
        } elseif {$id ne "" && [info exists csv_by_id($id)]} {
            set csv_row $csv_by_id($id)
            set match_id $id
        }
        if {$csv_row ne ""} {
            incr matched
            if {$match_id ne ""} { dict set seen $match_id 1 }
            dict for {key value} $csv_row {
                if {$key eq "_nc_original_id"} { continue }
                set allow_id_change [expr {$allow_id_change_for_row && $key eq $key_field}]
                lassign [_import_set_row_key $tab $row $key $value $allow_id_change] row did_change
                if {$did_change} {
                    incr changed
                    if {$allow_id_change} { incr id_changes }
                }
            }
            lappend changed_rows $row
        } else {
            dict set unmatched_existing_by_index $row_index $row
        }
        lappend out $row
        incr row_index
    }

    set added 0
    foreach id [array names csv_by_id] {
        if {[dict exists $seen $id]} { continue }
        set did_rekey 0
        if {$allow_position_rekey && [info exists csv_index_by_id($id)] && [dict exists $unmatched_existing_by_index $csv_index_by_id($id)]} {
            set idx $csv_index_by_id($id)
            set row [dict get $unmatched_existing_by_index $idx]
            set csv_row $csv_by_id($id)
            if {[llength $existing] == 1 || [_import_secondary_identity_match $tab $row $csv_row]} {
                dict for {key value} $csv_row {
                    if {$key eq "_nc_original_id"} { continue }
                    set allow_id_change [expr {$key eq $key_field}]
                    lassign [_import_set_row_key $tab $row $key $value $allow_id_change] row did_change
                    if {$did_change} {
                        incr changed
                        if {$allow_id_change} { incr id_changes }
                    }
                }
                set out [lreplace $out $idx $idx $row]
                lappend changed_rows $row
                dict set seen $id 1
                set did_rekey 1
            } else {
                incr invalid
            }
        }
        if {$did_rekey} { continue }
        if {$tab ni {properties materials}} {
            incr invalid
            continue
        }
        set row [_import_default_row $tab $id]
        if {$row eq ""} {
            incr invalid
            continue
        }
        dict set row $key_field $id
        set csv_row $csv_by_id($id)
        dict for {key value} $csv_row {
            lassign [_import_set_row_key $tab $row $key $value] row did_change
            if {$did_change} { incr changed }
        }
        set row [_mark_dirty $row $key_field]
        lappend out $row
        lappend changed_rows $row
        incr added
    }

    set status ok
    set final_dup [_duplicate_row_key_warnings $tab $out]
    if {[llength $final_dup] > 0} {
        return [dict create status error message "Import blocked: final [_tab_label $tab] table would contain duplicate IDs. [lindex $final_dup 0]" tab $tab path $path rows $existing changed_rows {} matched $matched id_changes $id_changes new $added changed $changed invalid [expr {$invalid + [llength $final_dup]}]]
    }
    if {$changed == 0 && $added == 0} { set status warn }
    set msg "Import preview for [_tab_label $tab]: $matched matched, $id_changes ID change(s), $added new, $changed field change(s)"
    if {$invalid > 0} { append msg ", $invalid invalid/skipped row(s)" }
    append msg "."
    return [dict create status $status message $msg tab $tab path $path rows $out changed_rows $changed_rows matched $matched id_changes $id_changes new $added changed $changed invalid $invalid]
}

proc ::nc::ui_table::_apply_import_plan {plan} {
    _autosave_suspend_begin
    set code [catch {_apply_import_plan_impl $plan} result]
    _autosave_suspend_end
    if {$code} { return -code error $result }
    return $result
}

proc ::nc::ui_table::_apply_import_plan_impl {plan} {
    variable _tab
    variable _tab_rows
    if {![dict exists $plan tab] || ![dict exists $plan rows]} {
        return [dict create status error message "Import plan is incomplete."]
    }
    set tab [dict get $plan tab]
    set changed [expr {[dict exists $plan changed] ? [dict get $plan changed] : 0}]
    set added [expr {[dict exists $plan new] ? [dict get $plan new] : 0}]
    set _tab_rows($tab) [dict get $plan rows]
    if {$tab in {general component} && [dict exists $plan changed_rows]} {
        foreach row [dict get $plan changed_rows] {
            _sync_component_fields [_dict_get $row comp_id] $row
        }
    }
    if {$changed > 0 || $added > 0} {
        _set_session_dirty 1
        _refresh_material_options
    }
    if {$tab eq $_tab} {
        _populate_current
    }
    set matched [expr {[dict exists $plan matched] ? [dict get $plan matched] : 0}]
    set id_changes [expr {[dict exists $plan id_changes] ? [dict get $plan id_changes] : 0}]
    set invalid [expr {[dict exists $plan invalid] ? [dict get $plan invalid] : 0}]
    set status ok
    if {$changed == 0 && $added == 0} { set status warn }
    set msg "Imported [_tab_label $tab] CSV: $matched matched, $id_changes ID change(s), $added new, $changed field change(s)"
    if {$invalid > 0} { append msg ", $invalid invalid/skipped row(s)" }
    append msg "."
    return [dict merge $plan [dict create status $status message $msg]]
}

proc ::nc::ui_table::_import_tab_csv {tab path} {
    set plan [_import_build_plan $tab $path]
    if {[dict get $plan status] ni {ok warn}} { return $plan }
    return [_apply_import_plan $plan]
}

proc ::nc::ui_table::_import_plan_summary_lines {plan} {
    set tab [dict get $plan tab]
    set path [dict get $plan path]
    set lines {}
    lappend lines "Tab: [_tab_label $tab]"
    lappend lines "File: $path"
    lappend lines ""
    lappend lines "Matched rows: [dict get $plan matched]"
    lappend lines "ID changes: [expr {[dict exists $plan id_changes] ? [dict get $plan id_changes] : 0}]"
    lappend lines "New preview rows: [dict get $plan new]"
    lappend lines "Changed fields: [dict get $plan changed]"
    lappend lines "Invalid/skipped rows: [dict get $plan invalid]"
    lappend lines ""
    if {[dict get $plan changed] == 0 && [dict get $plan new] == 0} {
        lappend lines "No table values will change."
    } else {
        lappend lines "Import will update preview/session data only."
        lappend lines "No the CAE tool model command will be called."
    }
    return $lines
}

proc ::nc::ui_table::_open_import_preview_dialog {plan} {
    variable _import_preview_plan
    variable _import_preview_win
    set _import_preview_plan $plan
    set win .nc_import_preview
    if {[winfo exists $win]} { catch {destroy $win} }
    set _import_preview_win $win
    toplevel $win
    wm title $win "Import Preview"
    wm protocol $win WM_DELETE_WINDOW [list destroy $win]

    label $win.title -text "Import Preview" -anchor w -font [_ui_header_font]
    text $win.summary -height 10 -width 68 -wrap word -state normal -background "#f8f8f8" -foreground "#222222"
    foreach line [_import_plan_summary_lines $plan] {
        $win.summary insert end "$line\n"
    }
    $win.summary configure -state disabled
    frame $win.buttons
    button $win.buttons.apply -text "Apply Import" -command {::nc::ui_table::_accept_import_preview}
    button $win.buttons.cancel -text "Cancel" -command [list destroy $win]
    _style_button $win.buttons.apply primary
    _style_button $win.buttons.cancel quiet

    pack $win.title -side top -fill x -padx 10 -pady {10 4}
    pack $win.summary -side top -fill both -expand 1 -padx 10 -pady 4
    pack $win.buttons.cancel -side right -padx {4 0} -pady 8
    pack $win.buttons.apply -side right -padx {4 0} -pady 8
    pack $win.buttons -side top -fill x -padx 10 -pady {0 8}
    _place_companion_window $win 520 300
    catch {raise $win}
    catch {focus $win.buttons.apply}
    _set_status [dict get $plan message] [dict get $plan status]
}

proc ::nc::ui_table::_accept_import_preview {} {
    variable _import_preview_plan
    variable _import_preview_win
    if {$_import_preview_plan eq ""} {
        _set_status "No import preview is active." warn
        return
    }
    set result [_apply_import_plan $_import_preview_plan]
    set _import_preview_plan ""
    if {$_import_preview_win ne "" && [winfo exists $_import_preview_win]} {
        catch {destroy $_import_preview_win}
    }
    set _import_preview_win ""
    _set_status [dict get $result message] [dict get $result status]
}

# Modal chooser: reload the current tab's own saved session CSV as-is (no
# match/preview), or pick a different file (existing match+preview import
# flow). Returns "own", "other", or "" if cancelled. Follows the same
# grab+tkwait+result-variable pattern as _folder_pick.
proc ::nc::ui_table::_ask_import_source_choice {tab_label own_path} {
    variable _import_choice_win ""
    variable _import_choice_result ""
    variable _win
    set _import_choice_result ""
    set w .nc_import_choice
    catch {destroy $w}
    toplevel $w
    wm title $w "Import"
    if {$_win ne "" && [winfo exists $_win]} { catch {wm transient $w $_win} }
    set _import_choice_win $w
    label $w.msg -justify left -anchor w -wraplength 380 -text \
        "Reload the [_tab_label $tab_label] tab from its own saved file:\n$own_path\n\nor pick a different file to import (with row matching and a preview)?"
    pack $w.msg -side top -fill x -padx 10 -pady {10 8}
    frame $w.buttons
    button $w.buttons.own -text "Reload Existing File" -command {::nc::ui_table::_import_choice_pick own}
    button $w.buttons.other -text "Choose Different File..." -command {::nc::ui_table::_import_choice_pick other}
    button $w.buttons.cancel -text "Cancel" -command {::nc::ui_table::_import_choice_pick {}}
    _style_button $w.buttons.own primary
    _style_button $w.buttons.cancel quiet
    pack $w.buttons.cancel -side right -padx {4 0} -pady 8
    pack $w.buttons.other -side right -padx {4 0} -pady 8
    pack $w.buttons.own -side right -padx {4 0} -pady 8
    pack $w.buttons -side top -fill x -padx 10 -pady {0 10}
    wm protocol $w WM_DELETE_WINDOW {::nc::ui_table::_import_choice_pick {}}
    catch {_place_companion_window $w 420 170}
    catch {grab $w}
    catch {focus $w.buttons.own}
    tkwait window $w
    catch {grab release $w}
    return $_import_choice_result
}

proc ::nc::ui_table::_import_choice_pick {value} {
    variable _import_choice_result
    variable _import_choice_win
    set _import_choice_result $value
    catch {destroy $_import_choice_win}
}

# Reloads the current tab's rows from the session's own combined CSV exactly
# as saved, replacing the tab's rows outright with no id matching, merging,
# or preview step. Other tabs in memory are left untouched.
proc ::nc::ui_table::_reload_tab_from_own_file {tab path} {
    # $path is the CANONICAL session-combined path (matprop_combined.xlsx).
    # Delegates to the shared _load_combined_rows_by_tab helper which
    # handles xlsx first, legacy csv fallback second.
    set dir ""
    catch {set dir [::nc::session::dir]}
    if {$dir eq ""} { set dir [file dirname [file dirname $path]] }
    if {![file exists $path] && \
        ![file exists [::nc::session::combined_session_file_legacy_csv $dir]]} {
        _set_status "No saved session data yet." warn
        return
    }
    set rows {}
    set rc [catch {
        set rows_by_tab [::nc::session::_load_combined_rows_by_tab $dir]
        set rows [expr {[dict exists $rows_by_tab $tab] ? [dict get $rows_by_tab $tab] : {}}]
        set fixed {}
        foreach row $rows {
            if {![dict exists $row _dirty_fields]} { dict set row _dirty_fields {} }
            if {![dict exists $row _pending_fields]} { dict set row _pending_fields {} }
            if {![dict exists $row _pending_values]} { dict set row _pending_values {} }
            lappend fixed $row
        }
        set rows $fixed
    } err]
    if {$rc} {
        _set_status "Reload failed: $err" error
        return
    }
    _store_rows [dict create $tab $rows]
    _refresh_material_options
    _rebuild_table_columns
    _populate_current
    _update_tab_buttons
    _set_session_dirty 0
    _set_status "Reloaded [llength $rows] row(s) for [_tab_label $tab] tab from [file tail $path]." ok
}

proc ::nc::ui_table::_on_import {} {
    variable _tab
    set own_xlsx ""
    set own_csv ""
    catch {set own_xlsx [::nc::session::combined_session_file]}
    catch {set own_csv [::nc::session::combined_session_file_legacy_csv]}
    set own_exists [expr {($own_xlsx ne "" && [file exists $own_xlsx]) ||
                          ($own_csv ne "" && [file exists $own_csv])}]
    if {$own_exists} {
        set own_display [expr {[file exists $own_xlsx] ? $own_xlsx : $own_csv}]
        set choice [_ask_import_source_choice $_tab $own_display]
        if {$choice eq ""} { return }
        if {$choice eq "own"} {
            _reload_tab_from_own_file $_tab $own_display
            return
        }
    }
    set path ""
    catch {set path [tk_getOpenFile -title "Import" -filetypes {{"Excel/CSV files" {.xlsx .csv}} {"Excel files" .xlsx} {"CSV files" .csv} {"All files" *}}]}
    _recover_focus_after_native_dialog
    if {$path eq ""} return
    set import_path $path
    set import_scratch_dir ""
    if {[string tolower [file extension $path]] eq ".xlsx"} {
        if {![::nc::xlsx::python_ok]} {
            _set_status "openpyxl not available; cannot read .xlsx. Export/import as .csv instead." error
            return
        }
        set import_scratch_dir "[file rootname $path].nc_import_[pid]"
        catch {file delete -force -- $import_scratch_dir}
        set sheet_map [::nc::xlsx::convert_xlsx_to_multi_csv $path $import_scratch_dir]
        if {[dict size $sheet_map] == 0} {
            _set_status "Failed to read .xlsx for import: $path" error
            catch {file delete -force -- $import_scratch_dir}
            return
        }
        set picked [_import_pick_sheet_for_tab $_tab $sheet_map]
        if {$picked eq ""} {
            # No auto-route: multi-sheet workbook, none matches this tab.
            # Ask the user which sheet to import (never silently guess).
            set picked_name [_ask_pick_sheet_dialog $_tab [dict keys $sheet_map]]
            if {$picked_name eq ""} {
                catch {file delete -force -- $import_scratch_dir}
                return
            }
            set picked [dict get $sheet_map $picked_name]
        }
        set import_path $picked
    }
    set plan [_import_build_plan $_tab $import_path]
    if {$import_path ne $path} {
        catch {file delete -force -- $import_path}
        if {[dict exists $plan path]} { dict set plan path $path }
    }
    if {$import_scratch_dir ne ""} { catch {file delete -force -- $import_scratch_dir} }
    if {[dict get $plan status] ni {ok warn}} {
        _set_status [dict get $plan message] [dict get $plan status]
        return
    }
    _open_import_preview_dialog $plan
}

# Sheet-aware auto-route for xlsx Import: given the current tab and the
# {sheet_name -> csv_path} map returned by convert_xlsx_to_multi_csv, pick
# the CSV to import from. Returns the picked csv_path, or "" if the caller
# must ask the user (multi-sheet workbook with no sheet name matching this
# tab's canonical label). Pure helper - kept factored out for testability.
proc ::nc::ui_table::_import_pick_sheet_for_tab {tab sheet_map} {
    if {[dict size $sheet_map] == 0} { return "" }
    # Canonical sheet names used by our own xlsx writer (see save_table_session):
    #   component -> Component
    #   properties -> Property
    #   materials -> Material
    set canonical [dict create \
        component  Component \
        properties Property \
        materials  Material]
    if {[dict exists $canonical $tab]} {
        set want [dict get $canonical $tab]
        set lwant [string tolower $want]
        dict for {name path} $sheet_map {
            if {[string tolower $name] eq $lwant} { return $path }
        }
    }
    # Single-sheet workbook: use it (matches today's effective wb.active
    # behavior for single-sheet files - no regression).
    if {[dict size $sheet_map] == 1} {
        return [lindex [dict values $sheet_map] 0]
    }
    return ""
}

# Modal picker: user chooses which sheet in a multi-sheet xlsx to import
# into the currently-open tab, when no sheet name auto-matches. Returns
# the picked sheet name (a key from the sheet_map), or "" if cancelled.
proc ::nc::ui_table::_ask_pick_sheet_dialog {tab_label sheet_names} {
    variable _sheet_pick_result ""
    variable _win
    set ::nc::ui_table::_sheet_pick_result ""
    set w .nc_pick_sheet
    catch {destroy $w}
    toplevel $w
    wm title $w "Pick sheet"
    if {$_win ne "" && [winfo exists $_win]} { catch {wm transient $w $_win} }
    label $w.msg -justify left -anchor w -wraplength 380 -text \
        "The workbook has multiple sheets. Pick which one to import into the [_tab_label $tab_label] tab:"
    pack $w.msg -side top -fill x -padx 10 -pady {10 8}
    frame $w.list
    listbox $w.list.lb -height 8 -selectmode browse -exportselection 0
    foreach name $sheet_names { $w.list.lb insert end $name }
    $w.list.lb selection set 0
    pack $w.list.lb -side left -fill both -expand 1
    pack $w.list -side top -fill both -expand 1 -padx 10
    frame $w.buttons
    button $w.buttons.ok -text "Import This Sheet" -command [list ::nc::ui_table::_pick_sheet_accept $w]
    button $w.buttons.cancel -text "Cancel" -command [list ::nc::ui_table::_pick_sheet_cancel $w]
    catch {_style_button $w.buttons.ok primary}
    catch {_style_button $w.buttons.cancel quiet}
    pack $w.buttons.cancel -side right -padx {4 0} -pady 8
    pack $w.buttons.ok -side right -padx {4 0} -pady 8
    pack $w.buttons -side top -fill x -padx 10 -pady {0 10}
    wm protocol $w WM_DELETE_WINDOW [list ::nc::ui_table::_pick_sheet_cancel $w]
    catch {_place_companion_window $w 420 260}
    catch {grab $w}
    catch {focus $w.buttons.ok}
    tkwait window $w
    catch {grab release $w}
    return $::nc::ui_table::_sheet_pick_result
}

proc ::nc::ui_table::_pick_sheet_accept {w} {
    variable _sheet_pick_result
    set sel [$w.list.lb curselection]
    if {[llength $sel] == 0} { set sel {0} }
    set _sheet_pick_result [$w.list.lb get [lindex $sel 0]]
    catch {destroy $w}
}

proc ::nc::ui_table::_pick_sheet_cancel {w} {
    variable _sheet_pick_result
    set _sheet_pick_result ""
    catch {destroy $w}
}

proc ::nc::ui_table::_rows_for_tab_export {tab} {
    variable _tab
    variable _rows
    variable _tab_rows
    if {$tab eq $_tab} { return $_rows }
    if {[info exists _tab_rows($tab)]} { return $_tab_rows($tab) }
    return {}
}

proc ::nc::ui_table::_copy_tab_tsv {tab} {
    set rows [_rows_for_tab_export $tab]
    set cols [_cols_for_tab $tab]
    if {[llength $cols] == 0} {
        _set_status "No visible columns to copy in [_tab_label $tab] tab." warn
        return
    }
    set lines {}
    set h {}
    foreach col_def $cols { lappend h [lindex $col_def 1] }
    lappend lines [join $h "\t"]
    foreach row $rows {
        set vals {}
        foreach col_def $cols {
            set val [_cell_value $tab $row [lindex $col_def 0]]
            lappend vals [string map [list "\t" " " "\n" " "] $val]
        }
        lappend lines [join $vals "\t"]
    }
    catch {
        clipboard clear
        clipboard append [join $lines "\n"]
    }
    _set_status "Copied [_tab_label $tab] tab as TSV ([llength $rows] row(s))." ok
}

proc ::nc::ui_table::_export_tab {tab} {
    set rows [_rows_for_tab_export $tab]
    if {[llength $rows] == 0} {
        _set_status "No data to export in [_tab_label $tab] tab." warn
        return
    }
    set path ""
    set initdir [_export_initial_dir]
    catch {set path [tk_getSaveFile -title "Export [_tab_label $tab]" -initialdir $initdir -initialfile "preview_$tab.xlsx" -defaultextension .xlsx -filetypes {{"Excel files" .xlsx} {"CSV files" .csv} {"All files" *}}]}
    _recover_focus_after_native_dialog
    if {$path eq ""} return
    if {[_export_tab_xlsx_or_csv $path $tab $rows]} {
        _set_status "Exported [_tab_label $tab] preview: $path" ok
    }
}

proc ::nc::ui_table::_on_export {} {
    variable _tab_rows
    set any 0
    foreach tab {general component properties materials} {
        if {[info exists _tab_rows($tab)] && [llength $_tab_rows($tab)] > 0} { set any 1; break }
    }
    if {!$any} {
        _set_status "No data to export." warn
        return
    }
    set path ""
    set initdir [_export_initial_dir]
    catch {set path [tk_getSaveFile -title "Export All Tabs" -initialdir $initdir -initialfile "preview_all.xlsx" -defaultextension .xlsx -filetypes {{"Excel files" .xlsx} {"All files" *}}]}
    _recover_focus_after_native_dialog
    if {$path eq ""} return
    set ext [string tolower [file extension $path]]
    if {$ext ne ".xlsx"} { append path ".xlsx" }
    if {[_export_all_tabs_xlsx $path]} {
        _set_status "Exported all tabs (with materials + images): $path" ok
    } else {
        _set_status "Export failed: $path" error
    }
}

proc ::nc::ui_table::_export_initial_dir {} {
    set dir ""
    catch {set dir [::nc::session::dir]}
    if {$dir ne "" && [file isdirectory $dir]} { return $dir }
    return [pwd]
}

# =============================================================================
# Material Report export - the report deliverable: one XLSX, two sheets.
#   Sheet "Material List":  MAT. Type (user label) / Mat ID / material params
#   Sheet "Component List": COMP. Type (group code) / COMP. Name / mass / ...
# Columns are customizable per sheet via Export Settings (sheets
# "Report - Material List" / "Report - Component List"); until the user saves
# a layout there, the curated defaults below apply. Read-only over table data
# - never touches HM.
# =============================================================================

proc ::nc::ui_table::_report_default_keys {sheet} {
    switch -- $sheet {
        report_materials {
            return {mat_user_name mat_label mat_id mat_card E G NU RHO A TREF GE note}
        }
        report_component {
            return {comp_type comp_user_name comp_id prop_card prop_id mat_id mat_user_name mass_total note}
        }
    }
    return {}
}

proc ::nc::ui_table::_report_cols {sheet} {
    set all [_export_all_possible_cols [_sheet_source_tab $sheet]]
    if {[::nc::export_prefs::has_sheet $sheet]} {
        # Strict: the report contains exactly the saved-enabled columns -
        # unsaved columns are NOT auto-appended (unlike the normal exports).
        return [::nc::export_prefs::apply_strict $sheet $all]
    }
    set by_key [dict create]
    foreach col_def $all { dict set by_key [lindex $col_def 0] $col_def }
    set out {}
    foreach key [_report_default_keys $sheet] {
        if {[dict exists $by_key $key]} { lappend out [dict get $by_key $key] }
    }
    return $out
}

proc ::nc::ui_table::_write_report_csv {path sheet tab rows} {
    set cols [_report_cols $sheet]
    set headers {}
    foreach col_def $cols {
        set key [lindex $col_def 0]
        if {$key eq "mass_total"} {
            lappend headers [_mass_header_label]
        } else {
            lappend headers [lindex $col_def 1]
        }
    }
    set data_rows {}
    foreach row $rows {
        set vals {}
        foreach col_def $cols {
            set key [lindex $col_def 0]
            if {$key eq "image_path"} {
                set v [_dict_get $row image_path]
            } else {
                set v [_cell_value $tab $row $key]
            }
            lappend vals [_csv_safe_export_value $key $v]
        }
        lappend data_rows $vals
    }
    ::nc::csv::write_file $path $headers $data_rows
    return [llength $cols]
}

proc ::nc::ui_table::_report_image_header {sheet} {
    foreach col_def [_report_cols $sheet] {
        if {[lindex $col_def 0] eq "image_path"} {
            return [_image_header_for_tab [_sheet_source_tab $sheet]]
        }
    }
    return ""
}

proc ::nc::ui_table::_export_report_xlsx {xlsx_path} {
    variable _tab_rows
    set mat_rows [expr {[info exists _tab_rows(materials)] ? $_tab_rows(materials) : {}}]
    set comp_rows [expr {[info exists _tab_rows(component)] ? $_tab_rows(component) : {}}]
    set root [file rootname $xlsx_path]
    set mat_tmp "${root}.nc_tmp_repmat.csv"
    set comp_tmp "${root}.nc_tmp_repcomp.csv"
    _write_report_csv $mat_tmp report_materials materials $mat_rows
    _write_report_csv $comp_tmp report_component component $comp_rows
    if {![_xlsx_python_ok]} {
        # CSV fallback: keep both files next to the requested path.
        set mat_csv "${root}_materials.csv"
        set comp_csv "${root}_components.csv"
        catch {file rename -force -- $mat_tmp $mat_csv}
        catch {file rename -force -- $comp_tmp $comp_csv}
        _set_status "openpyxl not available; report exported as CSV: $mat_csv + $comp_csv" warn
        return 1
    }
    set jobs [list \
        [list "Material List" $mat_tmp [_report_image_header report_materials]] \
        [list "Component List" $comp_tmp [_report_image_header report_component]]]
    set ok [_convert_multi_to_xlsx $jobs $xlsx_path]
    catch {file delete -force -- $mat_tmp}
    catch {file delete -force -- $comp_tmp}
    return $ok
}

proc ::nc::ui_table::_on_export_report {} {
    variable _tab_rows
    set have_mat [expr {[info exists _tab_rows(materials)] && [llength $_tab_rows(materials)] > 0}]
    set have_comp [expr {[info exists _tab_rows(component)] && [llength $_tab_rows(component)] > 0}]
    if {!$have_mat && !$have_comp} {
        _set_status "No data to report - Reload from the model first." warn
        return
    }
    set path ""
    set initdir [_export_initial_dir]
    catch {set path [tk_getSaveFile -title "Export Material Report" -initialdir $initdir -initialfile "material_report.xlsx" -defaultextension .xlsx -filetypes {{"Excel files" .xlsx} {"All files" *}}]}
    _recover_focus_after_native_dialog
    if {$path eq ""} return
    set ext [string tolower [file extension $path]]
    if {$ext ne ".xlsx"} { append path ".xlsx" }
    if {[_export_report_xlsx $path]} {
        _set_status "Exported material report (Material List + Component List): $path" ok
    } else {
        _set_status "Report export failed: $path" error
    }
}

proc ::nc::ui_table::_on_export_all {} {
    variable _tab_rows
    set initial ""
    catch {set initial [::nc::session::dir]}
    if {$initial eq "" || ![file isdirectory $initial]} { set initial [pwd] }
    set dir [_choose_folder_dialog "Export Preview Folder" $initial]
    if {$dir eq ""} return
    foreach tab {general component properties materials} {
        set rows [expr {[info exists _tab_rows($tab)] ? $_tab_rows($tab) : {}}]
        _export_tab_xlsx_or_csv [file join $dir "preview_$tab.xlsx"] $tab $rows
    }
    _set_status "Exported all preview tabs to $dir" ok
}

proc ::nc::ui_table::_csv_safe_export_value {key value} {
    if {$key ni {comp_user_name label hm_comp_name comp_name prop_user_name prop_name mat_user_name material_label mat_name note image_path}} {
        return $value
    }
    set trimmed [string trimleft $value]
    if {$trimmed eq ""} { return $value }
    set first [string index $trimmed 0]
    if {$first in {= + - @}} {
        return "'$value"
    }
    return $value
}

proc ::nc::ui_table::_write_tab_csv {path tab rows} {
    set cols [::nc::export_prefs::apply $tab [_export_all_possible_cols $tab]]
    set headers {}
    set include_original_id [expr {$tab in {properties materials}}]
    if {$include_original_id} { lappend headers "NC Original ID" }
    foreach col_def $cols {
        set key [lindex $col_def 0]
        if {$key eq "mass_total"} {
            lappend headers [_mass_header_label]
        } else {
            lappend headers [lindex $col_def 1]
        }
    }
    set data_rows {}
    foreach row $rows {
        set vals {}
        if {$include_original_id} { lappend vals [_row_key_for_tab $tab $row] }
        foreach col_def $cols {
            set key [lindex $col_def 0]
            if {$key eq "image_path"} {
                set v [_dict_get $row image_path]
            } else {
                set v [_cell_value $tab $row $key]
            }
            lappend vals [_csv_safe_export_value $key $v]
        }
        lappend data_rows $vals
    }
    ::nc::csv::write_file $path $headers $data_rows
}

# =============================================================================
# Export Settings dialog — choose which columns each exported XLSX sheet
# includes and their order. Persisted app-wide via ::nc::export_prefs, so the
# choice applies to the current session and every future one.
# =============================================================================

proc ::nc::ui_table::_export_settings_sheets {} {
    return {
        {summary "Summary"}
        {general "General"}
        {component "Component"}
        {properties "Properties"}
        {materials "Materials"}
        {report_materials "Report - Material List"}
        {report_component "Report - Component List"}
    }
}

# Report sheets draw their available columns from a source tab but keep their
# own independent saved layout, so tuning the report never disturbs the
# normal per-tab export and vice versa.
proc ::nc::ui_table::_sheet_source_tab {sheet} {
    switch -- $sheet {
        report_materials { return materials }
        report_component { return component }
        default { return $sheet }
    }
}

proc ::nc::ui_table::_export_settings_all_cols {sheet} {
    if {$sheet eq "summary"} { return [_summary_export_columns] }
    # Deliberately the full/unfiltered set (not _cols_for_tab) - so this
    # dialog always lists every possible column regardless of whatever
    # Property View filter, hidden columns, or Show Images/Notes toggle
    # happens to be active on-screen right now.
    return [_export_all_possible_cols [_sheet_source_tab $sheet]]
}

proc ::nc::ui_table::_export_settings_load_sheet {sheet} {
    set all_cols [_export_settings_all_cols $sheet]
    return [::nc::export_prefs::state_for_sheet $sheet $all_cols]
}

proc ::nc::ui_table::_export_settings_list_text {entry} {
    set mark [expr {[dict get $entry enabled] ? "\[x\]" : "\[ \]"}]
    return "$mark [dict get $entry label]"
}

proc ::nc::ui_table::_export_settings_refresh_list {} {
    variable _export_settings_win
    variable _export_settings_sheet
    variable _export_settings_cols
    set w $_export_settings_win
    if {$w eq "" || ![winfo exists $w]} { return }
    set _export_settings_cols [_export_settings_load_sheet $_export_settings_sheet]
    set lb $w.body.list
    $lb delete 0 end
    foreach entry $_export_settings_cols {
        $lb insert end [_export_settings_list_text $entry]
    }
}

proc ::nc::ui_table::_export_settings_pick_sheet {} {
    variable _export_settings_win
    variable _export_settings_sheet
    variable _export_settings_sheet_combo
    set w $_export_settings_win
    if {$w eq "" || ![winfo exists $w]} { return }
    set label [$_export_settings_sheet_combo get]
    foreach pair [_export_settings_sheets] {
        if {[lindex $pair 1] eq $label} { set _export_settings_sheet [lindex $pair 0] }
    }
    _export_settings_refresh_list
}

proc ::nc::ui_table::_export_settings_move {delta} {
    variable _export_settings_win
    variable _export_settings_cols
    set w $_export_settings_win
    if {$w eq "" || ![winfo exists $w]} { return }
    set lb $w.body.list
    set sel [$lb curselection]
    if {[llength $sel] != 1} { return }
    set idx [lindex $sel 0]
    set new_idx [expr {$idx + $delta}]
    if {$new_idx < 0 || $new_idx >= [llength $_export_settings_cols]} { return }
    set item [lindex $_export_settings_cols $idx]
    set _export_settings_cols [lreplace $_export_settings_cols $idx $idx]
    set _export_settings_cols [linsert $_export_settings_cols $new_idx $item]
    $lb delete 0 end
    foreach entry $_export_settings_cols { $lb insert end [_export_settings_list_text $entry] }
    $lb selection_set $new_idx
}

# Toggles the selected column's included/excluded state (kept in the list,
# just marked disabled) so it can always be re-enabled later without losing
# its remembered position.
proc ::nc::ui_table::_export_settings_remove {} {
    variable _export_settings_win
    variable _export_settings_cols
    set w $_export_settings_win
    if {$w eq "" || ![winfo exists $w]} { return }
    set lb $w.body.list
    set sel [$lb curselection]
    if {[llength $sel] != 1} { return }
    set idx [lindex $sel 0]
    set entry [lindex $_export_settings_cols $idx]
    dict set entry enabled [expr {![dict get $entry enabled]}]
    set _export_settings_cols [lreplace $_export_settings_cols $idx $idx $entry]
    $lb delete $idx
    $lb insert $idx [_export_settings_list_text $entry]
    $lb selection_set $idx
}

proc ::nc::ui_table::_export_settings_reset {} {
    variable _export_settings_win
    variable _export_settings_sheet
    variable _export_settings_cols
    set w $_export_settings_win
    if {$w eq "" || ![winfo exists $w]} { return }
    set _export_settings_cols {}
    foreach col_def [_export_settings_all_cols $_export_settings_sheet] {
        lappend _export_settings_cols [dict create key [lindex $col_def 0] label [lindex $col_def 1] enabled 1]
    }
    set lb $w.body.list
    $lb delete 0 end
    foreach entry $_export_settings_cols { $lb insert end [_export_settings_list_text $entry] }
}

# Saves the currently-edited sheet's column list (all known columns for that
# sheet, each with its enabled flag and display order), then persists all
# sheets — re-reading the untouched ones from disk so this dialog only ever
# changes the one sheet the user was looking at.
proc ::nc::ui_table::_export_settings_save {} {
    variable _export_settings_win
    variable _export_settings_sheet
    variable _export_settings_cols
    set all [::nc::export_prefs::load]
    set entries {}
    foreach entry $_export_settings_cols {
        lappend entries [dict create key [dict get $entry key] enabled [dict get $entry enabled]]
    }
    dict set all $_export_settings_sheet $entries
    ::nc::export_prefs::save $all
    ::nc::export_prefs::invalidate_cache
    catch {destroy $_export_settings_win}
    _set_status "Export settings saved." ok
}

proc ::nc::ui_table::_open_export_settings_dialog {} {
    variable _win
    variable _export_settings_win
    variable _export_settings_sheet
    variable _export_settings_sheet_combo
    variable _export_settings_cols
    set _export_settings_sheet general
    set w .nc_export_settings
    catch {destroy $w}
    toplevel $w
    wm title $w "Export Settings"
    if {$_win ne "" && [winfo exists $_win]} { catch {wm transient $w $_win} }
    set _export_settings_win $w

    label $w.msg -justify left -anchor w -wraplength 380 -text \
        "Chosen columns + order apply to the Export (XLSX) feature only,\nfor this and every future session. Toggle unchecks a column so it's\nskipped in the export — it is never deleted from the table itself."
    pack $w.msg -side top -fill x -padx 10 -pady {10 4}

    frame $w.sheetrow
    label $w.sheetrow.lbl -text "Sheet:"
    set sheet_labels {}
    foreach pair [_export_settings_sheets] { lappend sheet_labels [lindex $pair 1] }
    set _export_settings_sheet_combo $w.sheetrow.combo
    ttk::combobox $w.sheetrow.combo -state readonly -values $sheet_labels -width 20
    $w.sheetrow.combo set "General"
    bind $w.sheetrow.combo <<ComboboxSelected>> {::nc::ui_table::_export_settings_pick_sheet}
    pack $w.sheetrow.lbl -side left -padx {0 6}
    pack $w.sheetrow.combo -side left
    pack $w.sheetrow -side top -fill x -padx 10 -pady {0 6}

    frame $w.body
    listbox $w.body.list -selectmode browse -height 14 -width 30 -exportselection 0
    scrollbar $w.body.sb -orient vertical -command "$w.body.list yview"
    $w.body.list configure -yscrollcommand "$w.body.sb set"
    pack $w.body.sb -side right -fill y
    pack $w.body.list -side left -fill both -expand 1

    frame $w.body.moves
    button $w.body.moves.up -text "Up" -width 6 -command {::nc::ui_table::_export_settings_move -1}
    button $w.body.moves.down -text "Down" -width 6 -command {::nc::ui_table::_export_settings_move 1}
    button $w.body.moves.remove -text "Toggle" -width 6 -command {::nc::ui_table::_export_settings_remove}
    button $w.body.moves.reset -text "Reset" -width 6 -command {::nc::ui_table::_export_settings_reset}
    foreach b {up down remove reset} { _style_button $w.body.moves.$b quiet }
    pack $w.body.moves.up -side top -pady {0 4}
    pack $w.body.moves.down -side top -pady {0 10}
    pack $w.body.moves.remove -side top -pady {0 4}
    pack $w.body.moves.reset -side top
    pack $w.body.moves -side left -padx {8 0} -anchor n
    pack $w.body -side top -fill both -expand 1 -padx 10 -pady {0 10}

    frame $w.buttons
    button $w.buttons.save -text "Save" -command {::nc::ui_table::_export_settings_save}
    button $w.buttons.cancel -text "Cancel" -command {destroy .nc_export_settings}
    _style_button $w.buttons.save primary
    _style_button $w.buttons.cancel quiet
    pack $w.buttons.cancel -side right -padx {4 0} -pady 8
    pack $w.buttons.save -side right -padx {4 0} -pady 8
    pack $w.buttons -side top -fill x -padx 10 -pady {0 10}

    catch {_place_companion_window $w 460 480}
    _export_settings_refresh_list
    catch {grab $w}
    catch {focus $w.body.list}
}

# =============================================================================
# CSV <-> XLSX bridge (export/import with embedded images)
# =============================================================================

proc ::nc::ui_table::_xlsx_python_ok {} {
    set python [_resolve_cae_python]
    if {$python eq ""} { return 0 }
    if {[catch {exec $python -c "import openpyxl"}]} { return 0 }
    return 1
}

proc ::nc::ui_table::_write_csv_to_xlsx_script {dir} {
    set script_path [file join $dir csv_to_xlsx.py]
    set py {
import csv
import os
import sys

from openpyxl import Workbook
from openpyxl.drawing.image import Image as XLImage
from openpyxl.utils import get_column_letter

def to_cell_value(val):
    # Numeric-looking cells must be written as real numbers, not text -
    # otherwise Excel left-aligns them and sorts them alphabetically
    # ("10" before "2") instead of by value.
    if val == "":
        return val
    try:
        return int(val)
    except ValueError:
        pass
    try:
        return float(val)
    except ValueError:
        return val

csv_path, xlsx_path, image_header = sys.argv[1], sys.argv[2], (sys.argv[3] if len(sys.argv) > 3 else "")

with open(csv_path, newline="", encoding="utf-8-sig") as f:
    reader = csv.reader(f)
    rows = list(reader)

wb = Workbook()
ws = wb.active
if not rows:
    wb.save(xlsx_path)
    sys.exit(0)

header = rows[0]
for c, h in enumerate(header, start=1):
    ws.cell(row=1, column=c, value=h)

img_col_idx = None
if image_header and image_header in header:
    img_col_idx = header.index(image_header) + 1
    ws.column_dimensions[get_column_letter(img_col_idx)].width = 16

for r, data_row in enumerate(rows[1:], start=2):
    for c, val in enumerate(data_row, start=1):
        if img_col_idx is not None and c == img_col_idx:
            continue
        ws.cell(row=r, column=c, value=to_cell_value(val))
    if img_col_idx is not None and img_col_idx <= len(data_row):
        img_path = data_row[img_col_idx - 1]
        if img_path and os.path.isfile(img_path):
            try:
                img = XLImage(img_path)
                max_w, max_h = 96.0, 96.0
                iw = float(getattr(img, "width", 0) or 0)
                ih = float(getattr(img, "height", 0) or 0)
                if iw <= 0 or ih <= 0:
                    iw, ih = 96.0, 72.0
                scale = min(max_w / iw, max_h / ih, 1.0)
                if scale <= 0:
                    scale = 1.0
                img.width = iw * scale
                img.height = ih * scale
                anchor_col = get_column_letter(img_col_idx)
                img.anchor = "{0}{1}".format(anchor_col, r)
                ws.add_image(img)
                row_h_pts = (img.height * 72.0 / 96.0) + 4
                if row_h_pts < 30:
                    row_h_pts = 30
                ws.row_dimensions[r].height = row_h_pts
            except Exception:
                ws.cell(row=r, column=img_col_idx, value=img_path)

wb.save(xlsx_path)
}
    set write 1
    if {[file exists $script_path]} {
        set write 0
        if {[catch {
            set fp [::open $script_path r]
            set existing [read $fp]
            close $fp
        }] || $existing ne "$py\n"} {
            set write 1
        }
    }
    if {$write} {
        set fp [::open $script_path w]
        puts $fp $py
        close $fp
    }
    return $script_path
}

proc ::nc::ui_table::_write_multi_csv_to_xlsx_script {dir} {
    set script_path [file join $dir multi_csv_to_xlsx.py]
    set py {
import csv
import os
import sys

from openpyxl import Workbook
from openpyxl.drawing.image import Image as XLImage
from openpyxl.utils import get_column_letter

def to_cell_value(val):
    # Numeric-looking cells must be written as real numbers, not text -
    # otherwise Excel left-aligns them and sorts them alphabetically
    # ("10" before "2") instead of by value.
    if val == "":
        return val
    try:
        return int(val)
    except ValueError:
        pass
    try:
        return float(val)
    except ValueError:
        return val

manifest_path, xlsx_path = sys.argv[1], sys.argv[2]

jobs = []
with open(manifest_path, encoding="utf-8") as f:
    for line in f:
        line = line.rstrip("\n").rstrip("\r")
        if not line:
            continue
        parts = line.split("\t")
        while len(parts) < 3:
            parts.append("")
        jobs.append((parts[0], parts[1], parts[2]))

wb = Workbook()
default_sheet = wb.active
default_removed = False

for sheet_name, csv_path, image_header in jobs:
    if not os.path.isfile(csv_path):
        continue
    ws = wb.create_sheet(title=sheet_name[:31] if sheet_name else "Sheet")
    if not default_removed:
        wb.remove(default_sheet)
        default_removed = True
    with open(csv_path, newline="", encoding="utf-8-sig") as f:
        rows = list(csv.reader(f))
    if not rows:
        continue
    header = rows[0]
    for c, h in enumerate(header, start=1):
        ws.cell(row=1, column=c, value=h)
    img_col_idx = None
    if image_header and image_header in header:
        img_col_idx = header.index(image_header) + 1
        ws.column_dimensions[get_column_letter(img_col_idx)].width = 16
    for r, data_row in enumerate(rows[1:], start=2):
        for c, val in enumerate(data_row, start=1):
            if img_col_idx is not None and c == img_col_idx:
                continue
            ws.cell(row=r, column=c, value=to_cell_value(val))
        if img_col_idx is not None and img_col_idx <= len(data_row):
            img_path = data_row[img_col_idx - 1]
            if img_path and os.path.isfile(img_path):
                try:
                    img = XLImage(img_path)
                    max_w, max_h = 96.0, 96.0
                    iw = float(getattr(img, "width", 0) or 0)
                    ih = float(getattr(img, "height", 0) or 0)
                    if iw <= 0 or ih <= 0:
                        iw, ih = 96.0, 72.0
                    scale = min(max_w / iw, max_h / ih, 1.0)
                    if scale <= 0:
                        scale = 1.0
                    img.width = iw * scale
                    img.height = ih * scale
                    anchor_col = get_column_letter(img_col_idx)
                    img.anchor = "{0}{1}".format(anchor_col, r)
                    ws.add_image(img)
                    row_h_pts = (img.height * 72.0 / 96.0) + 4
                    if row_h_pts < 30:
                        row_h_pts = 30
                    ws.row_dimensions[r].height = row_h_pts
                except Exception:
                    ws.cell(row=r, column=img_col_idx, value=img_path)

if not default_removed:
    default_sheet.title = "Sheet1"

wb.save(xlsx_path)
}
    set write 1
    if {[file exists $script_path]} {
        set write 0
        if {[catch {
            set fp [::open $script_path r]
            set existing [read $fp]
            close $fp
        }] || $existing ne "$py\n"} {
            set write 1
        }
    }
    if {$write} {
        set fp [::open $script_path w]
        puts $fp $py
        close $fp
    }
    return $script_path
}

proc ::nc::ui_table::_convert_multi_to_xlsx {jobs xlsx_path} {
    set python [_resolve_cae_python]
    if {$python eq ""} { return 0 }
    set script [_write_multi_csv_to_xlsx_script [::nc::xlsx::_scripts_dir]]
    set manifest "[file rootname $xlsx_path].nc_manifest.txt"
    set fp [::open $manifest w]
    fconfigure $fp -encoding utf-8 -translation lf
    foreach job $jobs {
        lassign $job sheet csv_path image_header
        puts $fp "$sheet\t$csv_path\t$image_header"
    }
    close $fp
    set rc [catch {exec $python $script $manifest $xlsx_path} err]
    catch {file delete -force -- $manifest}
    if {$rc} { return 0 }
    return [file exists $xlsx_path]
}

proc ::nc::ui_table::_export_all_tabs_xlsx {xlsx_path} {
    variable _tab_rows
    if {![_xlsx_python_ok]} {
        _set_status "openpyxl not available in CAE Python; cannot write xlsx." error
        return 0
    }
    set root [file rootname $xlsx_path]
    set tmp_csvs {}
    set jobs {}

    set summary_tmp "${root}.nc_tmp_summary.csv"
    _write_summary_csv $summary_tmp
    lappend tmp_csvs $summary_tmp
    set summary_image_header ""
    foreach col_def [::nc::export_prefs::apply summary [_summary_export_columns]] {
        if {[lindex $col_def 0] eq "image"} { set summary_image_header [lindex $col_def 1] }
    }
    lappend jobs [list "Summary" $summary_tmp $summary_image_header]

    foreach tab {general component properties materials} {
        set rows [expr {[info exists _tab_rows($tab)] ? $_tab_rows($tab) : {}}]
        set tmp "${root}.nc_tmp_${tab}.csv"
        _write_tab_csv $tmp $tab $rows
        lappend tmp_csvs $tmp
        set image_header [_image_header_for_tab $tab]
        lappend jobs [list [_tab_label $tab] $tmp $image_header]
    }
    set ok [_convert_multi_to_xlsx $jobs $xlsx_path]
    foreach f $tmp_csvs { catch {file delete -force -- $f} }
    return $ok
}

proc ::nc::ui_table::_summary_export_columns {} {
    set mass_hdr [_mass_header_label]
    return [list \
        {image Image} {comp_id "Comp ID"} {comp_user_name "COMP. Name"} \
        {prop_card "Prop Card"} {prop_id "Prop ID"} \
        {mat_card "Mat Card"} {mat_id "MAT ID"} {mat_user_name "MAT. Type"} \
        {E E} {G G} {NU NU} {RHO RHO} {A A} {TREF TREF} {GE GE} {ST ST} {SC SC} {SS SS} \
        [list mass $mass_hdr] {note Note}]
}

proc ::nc::ui_table::_write_summary_csv {path} {
    variable _tab_rows
    set cols [::nc::export_prefs::apply summary [_summary_export_columns]]
    set headers {}
    foreach col_def $cols { lappend headers [lindex $col_def 1] }

    set mat_by_id [dict create]
    if {[info exists _tab_rows(materials)]} {
        foreach row $_tab_rows(materials) {
            set mid ""
            catch {set mid [dict get $row mat_id]}
            if {$mid ne ""} { dict set mat_by_id $mid $row }
        }
    }
    set mat_fields {E G NU RHO A TREF GE ST SC SS}

    set data_rows {}
    set comp_rows {}
    if {[info exists _tab_rows(component)] && [llength $_tab_rows(component)] > 0} {
        set comp_rows $_tab_rows(component)
    } elseif {[info exists _tab_rows(general)]} {
        set comp_rows $_tab_rows(general)
    }
    foreach row $comp_rows {
        set img_path [_dict_get $row image_path]
        set cid [_dict_get $row comp_id]
        set clabel [_cell_value component $row comp_user_name]
        set pcard [_cell_value component $row prop_card]
        set pid [_dict_get $row prop_id]
        set mid [_dict_get $row mat_id]
        set mlabel [_cell_value component $row mat_user_name]
        set mcard ""
        set mvals [dict create]
        if {$mid ne "" && [dict exists $mat_by_id $mid]} {
            set mrow [dict get $mat_by_id $mid]
            catch {set mcard [dict get $mrow mat_card]}
            foreach k $mat_fields {
                set v ""
                catch {set v [dict get $mrow $k]}
                dict set mvals $k $v
            }
        } else {
            foreach k $mat_fields { dict set mvals $k "" }
        }
        set mass [_cell_value component $row mass_total]
        set note [_dict_get $row note]

        set row_vals [dict create image $img_path comp_id $cid comp_user_name $clabel \
            prop_card $pcard prop_id $pid mat_card $mcard mat_id $mid mat_user_name $mlabel \
            mass $mass note $note]
        foreach k $mat_fields { dict set row_vals $k [dict get $mvals $k] }

        set safe_vals {}
        foreach col_def $cols {
            set key [lindex $col_def 0]
            set v ""
            catch {set v [dict get $row_vals $key]}
            lappend safe_vals [_csv_safe_export_value note $v]
        }
        lappend data_rows $safe_vals
    }
    ::nc::csv::write_file $path $headers $data_rows
}

proc ::nc::ui_table::_write_xlsx_to_csv_script {dir} {
    set script_path [file join $dir xlsx_to_csv.py]
    set py {
import csv
import sys

from openpyxl import load_workbook

xlsx_path, csv_path = sys.argv[1], sys.argv[2]

wb = load_workbook(xlsx_path, data_only=True)
ws = wb.active

with open(csv_path, "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    for row in ws.iter_rows(values_only=True):
        writer.writerow(["" if v is None else v for v in row])
}
    set write 1
    if {[file exists $script_path]} {
        set write 0
        if {[catch {
            set fp [::open $script_path r]
            set existing [read $fp]
            close $fp
        }] || $existing ne "$py\n"} {
            set write 1
        }
    }
    if {$write} {
        set fp [::open $script_path w]
        puts $fp $py
        close $fp
    }
    return $script_path
}

proc ::nc::ui_table::_convert_csv_to_xlsx {csv_path xlsx_path {image_header ""}} {
    set python [_resolve_cae_python]
    if {$python eq ""} { return 0 }
    set script [_write_csv_to_xlsx_script [::nc::xlsx::_scripts_dir]]
    if {[catch {exec $python $script $csv_path $xlsx_path $image_header}]} { return 0 }
    return [file exists $xlsx_path]
}

proc ::nc::ui_table::_convert_xlsx_to_csv {xlsx_path csv_path} {
    set python [_resolve_cae_python]
    if {$python eq ""} { return 0 }
    set script [_write_xlsx_to_csv_script [::nc::xlsx::_scripts_dir]]
    if {[catch {exec $python $script $xlsx_path $csv_path}]} { return 0 }
    return [file exists $csv_path]
}

proc ::nc::ui_table::_image_header_for_tab {tab} {
    if {$tab ni {general component}} { return "" }
    foreach col_def [::nc::export_prefs::apply $tab [_export_all_possible_cols $tab]] {
        if {[lindex $col_def 0] eq "image_path"} { return [lindex $col_def 1] }
    }
    return ""
}

proc ::nc::ui_table::_export_tab_xlsx_or_csv {path tab rows} {
    set ext [string tolower [file extension $path]]
    if {$ext ne ".xlsx"} {
        _write_tab_csv $path $tab $rows
        return 1
    }
    if {![_xlsx_python_ok]} {
        set csv_path "[file rootname $path].csv"
        _write_tab_csv $csv_path $tab $rows
        _set_status "openpyxl not available in CAE Python; exported CSV instead: $csv_path" warn
        return 0
    }
    set tmp_csv "[file rootname $path].nc_tmp_export.csv"
    _write_tab_csv $tmp_csv $tab $rows
    set image_header [_image_header_for_tab $tab]
    set ok [_convert_csv_to_xlsx $tmp_csv $path $image_header]
    catch {file delete -force -- $tmp_csv}
    if {!$ok} {
        set csv_path "[file rootname $path].csv"
        _write_tab_csv $csv_path $tab $rows
        _set_status "XLSX conversion failed; exported CSV instead: $csv_path" warn
        return 0
    }
    return 1
}

proc ::nc::ui_table::_on_scan {} {
    catch {tk_messageBox -message "Scan will be wired by nastran_control.tcl." -title "Nastran Control" -icon info}
}

# =============================================================================
# Clipboard / status
# =============================================================================

# Pure helper: builds the clipboard text from a selection list, header
# list, and a data dict keyed "r,c" -> value. Returns
# {text ... summary ...}.
#
# - selection is a list of "r,c" strings from Tktable's curselection (rows
#   with r<1 or non-integer coords ignored).
# - When at least one valid cell is selected, output is the bounding
#   rectangle of the selection with NO header prefix (Excel shape).
# - When selection is empty, output is the FULL table WITH the header row
#   as line 1 (fallback for whole-table copy to Excel).
# Missing cells in `data` render as "". Extracted from the Tk wrapper so
# the branching logic is testable without a live Tktable/clipboard.
proc ::nc::ui_table::_compute_copy_text {selection headers row_count data} {
    set rows_seen [dict create]
    set cols_seen [dict create]
    foreach cell $selection {
        lassign [split $cell ,] r c
        if {![string is integer -strict $r] || ![string is integer -strict $c]} continue
        if {$r < 1} continue
        dict set rows_seen $r 1
        dict set cols_seen $c 1
    }
    set lines {}
    if {[dict size $rows_seen] > 0 && [dict size $cols_seen] > 0} {
        set rs [lsort -integer [dict keys $rows_seen]]
        set cs [lsort -integer [dict keys $cols_seen]]
        set r0 [lindex $rs 0]
        set r1 [lindex $rs end]
        set c0 [lindex $cs 0]
        set c1 [lindex $cs end]
        set n 0
        for {set r $r0} {$r <= $r1} {incr r} {
            set parts {}
            for {set c $c0} {$c <= $c1} {incr c} {
                set key "$r,$c"
                set val [expr {[dict exists $data $key] ? [dict get $data $key] : ""}]
                lappend parts [string map [list "\t" " " "\n" " "] $val]
                incr n
            }
            lappend lines [join $parts "\t"]
        }
        return [dict create text [join $lines "\n"] \
            summary "Copied $n cell(s) to clipboard."]
    }
    lappend lines [join $headers "\t"]
    set ncols [llength $headers]
    for {set r 1} {$r <= $row_count} {incr r} {
        set parts {}
        for {set c 0} {$c < $ncols} {incr c} {
            set key "$r,$c"
            set val [expr {[dict exists $data $key] ? [dict get $data $key] : ""}]
            lappend parts [string map [list "\t" " " "\n" " "] $val]
        }
        lappend lines [join $parts "\t"]
    }
    return [dict create text [join $lines "\n"] \
        summary "Copied all $row_count row(s) with header."]
}

proc ::nc::ui_table::copy_selection_to_clipboard {} {
    variable _tbl
    variable _rows
    variable _tab
    variable tableData
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    # Tktable is -selecttype cell so a single click selects a single cell,
    # not a whole row. Old code discarded the column and always copied full
    # rows + a header line - that's what made a cross-tab paste (Materials
    # -> Library) drop the entire header row into row 1 instead of the
    # selected value. See _compute_copy_text for the new shape.
    set selection {}
    catch { set selection [$_tbl curselection] }
    set cols [_cols_for_tab $_tab]
    set headers {}
    foreach col_def $cols { lappend headers [lindex $col_def 1] }
    # Snapshot the visible tableData into a plain dict so the pure helper
    # doesn't have to know about namespace arrays.
    set data [dict create]
    foreach k [array names tableData] {
        dict set data $k $tableData($k)
    }
    set result [_compute_copy_text $selection $headers [llength $_rows] $data]
    catch {
        clipboard clear
        clipboard append [dict get $result text]
    }
    _set_status [dict get $result summary] ok
}

proc ::nc::ui_table::_set_status {msg status} {
    variable _status_lbl
    set fg "#555555"
    switch -- $status {
        ok { set fg "#2f6f3e" }
        warn { set fg "#8a5a00" }
        error { set fg "#9b1c1c" }
    }
    if {$_status_lbl ne "" && [winfo exists $_status_lbl]} {
        catch {$_status_lbl configure -text $msg -foreground $fg}
    }
    catch {::nc::mutations::log_add $msg}
}
