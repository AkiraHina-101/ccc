# =============================================================================
# ui_table.tcl  --  ::nc::ui_table
#
# Refined compact preview UI for Nastran Control.
#
# Preview safety rule: this module must not call model-changing HM commands.
# Edits, assignment, create/duplicate/delete/apply/isolate are staged in memory.
# Capture may call graphics/display commands through nastran_control.tcl only.
# =============================================================================

namespace eval ::nc::ui_table {
    variable _win ""
    variable _root ""
    variable _tbl ""
    variable _log_w ""
    variable _status_lbl ""
    variable _session_lbl ""
    variable _tabbar ""
    variable _control_frame ""
    variable _tablebar ""
    variable _search_frame ""
    variable _action_frame ""
    variable _io_frame ""
    variable _edit_frame ""
    variable _label_frame ""
    variable _review_frame ""
    variable _view_frame ""
    variable _prop_view_frame ""
    variable _pbush_frame ""
    variable _assign_frame ""
    variable _tableframe ""
    variable _status_frame ""
    variable _log_frame ""
    variable _mat_cb ""
    variable _context_menu ""
    variable _tab_context_menu ""

    variable _tab general
    variable _rows {}
    variable _sort_col 0
    variable _sort_dir incr
    variable _mat_rows {}
    variable _mat_label ""
    variable _mass_unit "kg"
    variable _session_path ""
    variable _session_dirty 0
    variable _autosave_after_id ""
    variable _autosave_delay_ms 3000
    variable _autosave_enabled 1
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
    variable _compact_rows 1
    variable _alternate_rows 1
    variable _ui_font_size 9
    variable _image_thumb_px 96
    variable _image_widgets {}
    variable _image_photos
    variable _image_seq 0
    variable _image_photo_cache
    variable _always_on_top_strict 0
    variable _capture_cancelled 0
    variable _capture_resume_comp_ids {}

    variable tableData
    variable _tab_btns
    variable _tab_rows
    variable _tab_sort_col
    variable _tab_sort_dir
    variable _col_order
    variable _hidden_cols
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
    }
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

proc ::nc::ui_table::_filter_display_cols {cols} {
    variable _show_images_col
    variable _show_notes_col
    set out {}
    foreach col_def $cols {
        set key [lindex $col_def 0]
        if {!$_show_images_col && $key eq "image_path"} { continue }
        if {!$_show_notes_col && $key eq "note"} { continue }
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

proc ::nc::ui_table::_cols_for_tab {tab {include_hidden 0}} {
    variable _property_view
    variable _pbush_line_vars

    switch -- $tab {
        general {
            set cols {
                {image_path "Image" 10}
                {hm_comp_name "Component Name" 18}
                {comp_user_name "Component Label" 18}
                {comp_id "Comp ID" 8}
                {prop_name "Property Name" 16}
                {prop_user_name "Property Label" 16}
                {prop_id "Prop ID" 8}
                {prop_card "Prop Card" 10}
                {mat_user_name "Material Label" 16}
                {mat_id "MAT ID" 8}
                {note "Note" 24}
            }
        }
        component {
            set cols {
                {image_path "Image" 10}
                {comp_user_name "Component Label" 20}
                {prop_card "Prop Card" 10}
                {prop_id "Prop ID" 8}
                {mat_id "MAT ID" 8}
                {mat_user_name "Material Label" 18}
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
            }
            if {$_property_view in {ALL PSHELL}} {
                set cols [concat $cols {
                    {T "T" 10}
                    {NSM "NSM" 10}
                    {Z1 "Z1" 10}
                    {Z2 "Z2" 10}
                }]
            }
            if {$_property_view in {ALL PSOLID}} {
                set cols [concat $cols {
                    {E "E" 12}
                    {G "G" 12}
                    {NU "NU" 8}
                    {RHO "RHO" 12}
                    {A "A" 8}
                    {TREF "TREF" 8}
                    {ST "ST" 8}
                    {SC "SC" 8}
                    {SS "SS" 8}
                }]
            }
            if {$_property_view in {ALL PBUSH}} {
                foreach line {K B GE M} {
                    if {![info exists _pbush_line_vars($line)]} { set _pbush_line_vars($line) 1 }
                    if {$_pbush_line_vars($line)} {
                        foreach field [_pbush_line_fields $line] {
                            lappend cols [list $field $field 8]
                        }
                    }
                }
            }
            lappend cols {note "Note" 24}
        }
        materials {
            set cols {
                {mat_card "Mat Card" 10}
                {mat_id "Mat ID" 8}
                {mat_user_name "Material Label" 18}
                {mat_name "Material" 18}
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
        default {
            return {}
        }
    }
    set cols [_filter_display_cols $cols]
    if {!$include_hidden} {
        set cols [_filter_hidden_cols $tab $cols]
    }
    return [_apply_column_order $tab $cols]
}

proc ::nc::ui_table::_ncols_for_tab {tab} { return [llength [_cols_for_tab $tab]] }
proc ::nc::ui_table::_cols {} { variable _tab ; return [_cols_for_tab $_tab] }
proc ::nc::ui_table::_ncols {} { variable _tab ; return [_ncols_for_tab $_tab] }

proc ::nc::ui_table::_editable_fields {tab} {
    switch -- $tab {
        general {return {comp_user_name prop_user_name mat_user_name mass_total note}}
        component {return {comp_user_name mat_user_name mass_total note}}
        properties {return {prop_card prop_id mat_id T NSM Z1 Z2 E G NU RHO A TREF ST SC SS K1 K2 K3 K4 K5 K6 B1 B2 B3 B4 B5 B6 GE1 GE2 GE3 GE4 GE5 GE6 M1 M2 M3 M4 M5 M6 note}}
        materials {return {mat_card mat_id mat_user_name mat_name E G NU RHO A TREF GE ST SC SS note}}
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

    set title "Nastran Control - [file tail $model_path]"
    if {$_win eq "" || ![winfo exists $_win]} {
        _build_window $title
    } else {
        catch {wm title $_win $title}
    }
    catch {set _session_path [::nc::session::dir]}
    _store_rows $rows_by_tab
    _refresh_material_options
    _rebuild_table_columns
    _populate_current
    _update_tab_buttons
    _update_toolbar_for_tab
    _set_session_dirty 0
    catch {wm deiconify $_win}
    catch {raise $_win}
    variable _always_on_top_strict
    catch {wm attributes $_win -topmost [expr {$_always_on_top_strict ? 1 : 0}]}
}

proc ::nc::ui_table::populate_all {rows_by_tab} {
    _store_rows $rows_by_tab
    _refresh_material_options
    _rebuild_table_columns
    _populate_current
    _update_tab_buttons
    _update_toolbar_for_tab
    _set_session_dirty 0
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
    foreach row $_tab_rows(component) {
        set cid [_dict_get $row comp_id]
        if {$cid ne "" && [lsearch -exact $ids $cid] < 0} { lappend ids $cid }
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
    set comp_name [_dict_get $row comp_name]
    set label [_dict_get $row label $comp_name]
    if {$label eq ""} { set label $comp_name }
    if {![dict exists $row hm_comp_name]} { dict set row hm_comp_name $comp_name }
    if {![dict exists $row hm_prop_id]} { dict set row hm_prop_id [_dict_get $row prop_id] }
    if {![dict exists $row hm_mat_id]} { dict set row hm_mat_id [_dict_get $row mat_id] }
    if {![dict exists $row hm_material_label]} { dict set row hm_material_label [_dict_get $row material_label [_dict_get $row mat_name]] }
    dict set row comp_user_name [_dict_get $row comp_user_name $label]
    dict set row prop_user_name [_dict_get $row prop_user_name [_dict_get $row prop_name]]
    dict set row mat_user_name [_dict_get $row mat_user_name [_dict_get $row material_label [_dict_get $row mat_name]]]
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
    set ids [_material_ids_for_label $label]
    if {[llength $ids] == 1} { return [lindex $ids 0] }
    return ""
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
    foreach v $values {
        set v [string trim $v]
        if {$v ne "" && [lsearch -exact $out $v] < 0} { lappend out $v }
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
            foreach tab {component general} {
                if {![info exists _tab_rows($tab)]} continue
                foreach row $_tab_rows($tab) {
                    lappend values [_dict_get $row comp_user_name [_dict_get $row label [_dict_get $row comp_name]]]
                }
            }
        }
        mat_user_name {
            foreach row $_mat_rows {
                lappend values [_dict_get $row label [_dict_get $row mat_user_name [_dict_get $row mat_name]]]
            }
            if {[info exists _tab_rows(materials)]} {
                foreach row $_tab_rows(materials) {
                    lappend values [_dict_get $row mat_user_name [_dict_get $row mat_name]]
                }
            }
            foreach row $_rows {
                lappend values [_dict_get $row mat_user_name [_dict_get $row material_label [_dict_get $row mat_name]]]
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
        comp_user_name { return "Component Label" }
        mat_user_name { return "Material Label" }
    }
    return $key
}

proc ::nc::ui_table::_label_allowed_key_for_tab {{preferred ""}} {
    variable _tab
    if {$preferred in {comp_user_name prop_user_name mat_user_name}} { return $preferred }
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
    set pending [_row_pending_fields $row]
    if {[lsearch -exact $pending $key] < 0} { lappend pending $key }
    dict set row _pending_fields $pending
    dict set row _pending_values $key $value
    switch -- $key {
        comp_user_name {
            dict set row _pending_values label $value
        }
        mat_user_name {
            dict set row _pending_values material_label $value
            set mid [_material_id_for_label $value]
            if {$mid ne ""} {
                dict set row _pending_values mat_id $mid
                if {[lsearch -exact $pending mat_id] < 0} { lappend pending mat_id }
                dict set row _pending_fields $pending
            }
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
    set out {}
    foreach v $values {
        if {[string first $needle [string tolower $v]] >= 0} { lappend out $v }
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
                    set v [_dict_get $row comp_user_name [_dict_get $row label]]
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
                    set v [_dict_get $row mat_user_name [_dict_get $row mat_name]]
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
    variable _rows
    if {$_label_list eq "" || ![winfo exists $_label_list]} { return }
    $_label_list delete 0 end
    set _label_display_map {}

    set owners [_label_owner_map $_label_target_key]
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
    foreach v $values {
        lappend _label_display_map $v
        set num [format "%${num_width}d" [expr {$idx + 1}]]
        set text "$num. $v"
        if {[dict exists $owners $v]} {
            set ids [dict get $owners $v]
            if {$self_owner ne ""} {
                set ids [lsearch -all -inline -not -exact $ids $self_owner]
            }
            if {[llength $ids] > 0} {
                append text "  (used by ID [join $ids ", "])"
                set is_used 1
            }
        }
        $_label_list insert end $text
        if {[info exists is_used]} {
            $_label_list itemconfigure $idx -foreground "#9b1c1c"
            unset is_used
        }
        incr idx
    }

    if {[$_label_list size] > 0} {
        $_label_list selection set 0
        $_label_list activate 0
    }
    _label_set_status "Showing [$_label_list size] label(s)." ok
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
    _set_status "Pending [_label_key_label $_label_target_key] '$value' on row $r. Apply or cancel pending labels." warn
    _label_set_status "Pending row $r." warn
}

proc ::nc::ui_table::_label_fill_selection {} {
    variable _label_target_key
    set value [_selected_label_value]
    if {$value eq ""} {
        _label_set_status "Choose a label first." warn
        return
    }
    set indices [_selected_display_indices]
    if {[llength $indices] == 0} {
        set indices [list [_active_display_row_for_key $_label_target_key]]
    }
    set count 0
    foreach r $indices {
        if {[_pending_display_row_value $r $_label_target_key $value]} { incr count }
    }
    _populate_current
    _set_status "Pending [_label_key_label $_label_target_key] '$value' on $count row(s). Apply or cancel pending labels." warn
    _label_set_status "Pending $count row(s)." warn
}

proc ::nc::ui_table::_label_assign_sequence {} {
    variable _label_list
    variable _label_target_key
    variable _label_display_map
    if {$_label_list eq "" || ![winfo exists $_label_list]} { return }
    set indices [_selected_display_indices]
    if {[llength $indices] == 0} {
        _label_set_status "Select row(s) first for sequence assign." warn
        return
    }
    set start [_label_current_index]
    set available [$_label_list size]
    set count 0
    for {set i 0} {$i < [llength $indices]} {incr i} {
        set idx [expr {$start + $i}]
        if {$idx >= $available || $idx >= [llength $_label_display_map]} { break }
        set value [lindex $_label_display_map $idx]
        if {[_pending_display_row_value [lindex $indices $i] $_label_target_key $value]} { incr count }
    }
    _populate_current
    _label_select_index [expr {$start + $count}]
    _set_status "Pending $count sequential [_label_key_label $_label_target_key] value(s). Apply or cancel pending labels." warn
    _label_set_status "Pending sequence for $count row(s)." warn
}

proc ::nc::ui_table::_place_companion_window {win {width 360} {height 420}} {
    variable _win
    if {$win eq "" || ![winfo exists $win]} { return }
    update idletasks

    set parent $_win
    if {$parent eq "" || ![winfo exists $parent]} {
        catch {wm geometry $win ${width}x${height}}
        return
    }
    catch {wm transient $win $parent}

    set px [winfo rootx $parent]
    set py [winfo rooty $parent]
    set pw [winfo width $parent]
    set ph [winfo height $parent]
    if {$pw <= 1} { set pw 1120 }
    if {$ph <= 1} { set ph 680 }

    set sw [winfo screenwidth $parent]
    set sh [winfo screenheight $parent]
    set gap 10
    set min_width 260

    # Prefer whichever side (right or left of the main window) has more free
    # screen space, and shrink to fit that space instead of overlapping the
    # main window's own buttons/toolbar when the screen is too narrow.
    set right_space [expr {$sw - ($px + $pw) - $gap}]
    set left_space [expr {$px - $gap}]
    if {$right_space >= $left_space} {
        set x [expr {$px + $pw + $gap}]
        set avail $right_space
    } else {
        set avail $left_space
        set x [expr {$px - $width - $gap}]
    }
    if {$avail < $width} {
        set width [expr {$avail > $min_width ? $avail : $min_width}]
        if {$right_space >= $left_space} {
            set x [expr {$px + $pw + $gap}]
        } else {
            set x [expr {$px - $width - $gap}]
        }
    }
    if {$x + $width > $sw} { set x [expr {$sw - $width}] }
    if {$x < 0} { set x 0 }

    set y [expr {$py + 48}]
    if {$y + $height > $sh} { set height [expr {$sh - $y}] }
    if {$y + $height > $sh} { set y [expr {$sh - $height}] }
    if {$y < 0} { set y 0 }

    catch {wm geometry $win ${width}x${height}+$x+$y}
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
                    if {$active_key in {comp_user_name mat_user_name}} {
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
        frame $_label_win.buttons
        button $_label_win.buttons.assign -text "Assign Cell" -command {::nc::ui_table::_label_assign_active}
        button $_label_win.buttons.fill -text "Fill Selection" -command {::nc::ui_table::_label_fill_selection}
        button $_label_win.buttons.seq -text "Assign Sequence" -command {::nc::ui_table::_label_assign_sequence}
        button $_label_win.buttons.paste -text "Paste List..." -command {::nc::ui_table::_label_paste_list}
        button $_label_win.buttons.remove -text "Remove Selected" -command {::nc::ui_table::_label_remove_selected}
        button $_label_win.buttons.clear -text "Clear List" -command {::nc::ui_table::_label_clear_bank}
        button $_label_win.buttons.isolate -text "Isolate" -command {::nc::ui_table::_on_isolate}
        button $_label_win.buttons.apply -text "Apply Pending" -command {::nc::ui_table::_commit_pending_labels}
        button $_label_win.buttons.cancel -text "Cancel Pending" -command {::nc::ui_table::_cancel_pending_labels}
        pack $_label_win.buttons.assign $_label_win.buttons.fill $_label_win.buttons.seq $_label_win.buttons.paste $_label_win.buttons.remove $_label_win.buttons.clear $_label_win.buttons.isolate $_label_win.buttons.apply $_label_win.buttons.cancel -side left -padx 3 -pady 4
        set _label_status [label $_label_win.status -text "" -anchor w -fg "#555555"]
        pack $_label_win.buttons -side top -fill x -padx 4
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
    dict set row $key $value
    switch -- $key {
        comp_user_name { dict set row label $value }
        mat_user_name {
            dict set row material_label $value
            set mid [_material_id_for_label $value]
            if {$mid ne ""} {
                dict set row mat_id $mid
                set row [_mark_dirty $row mat_id]
            }
        }
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
    set base_label [_dict_get $source mat_user_name [_dict_get $source mat_name "Material"]]
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
    set out {}
    foreach row $_tab_rows($tab) {
        if {[_row_key_for_tab $tab $row] eq $key_value} {
            lappend out $new_row
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
                foreach key {comp_user_name label mat_user_name material_label mat_id note} {
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
    # Flush pending edits before switching away from the current session.
    # Only asks the user when the flush actually failed (blocked or disk error).
    variable _session_dirty
    if {!$_session_dirty} { return 1 }
    if {[_autosave_flush_now]} { return 1 }
    set answer no
    catch {
        set answer [_table_message_box -title "Unsaved Changes" \
            -icon warning -type yesno -default no \
            -message "The current session could not be saved.\n\nSwitch anyway and lose unsaved changes?"]
    }
    return [expr {$answer eq "yes"}]
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
    set result [::nc::session::save_table_session [_rows_by_tab_snapshot] $dir]
    set _session_path [dict get $result dir]
    set _last_saved_hhmmss [clock format [clock seconds] -format %H:%M:%S]
    _set_session_dirty 0
    catch {::nc::session::recent_touch $_session_path}
    if {$status} {
        _set_status "Saved session: $_session_path" ok
    }
    return 1
}

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

proc ::nc::ui_table::_choose_folder_dialog {title initial_dir} {
    variable _win
    variable _folder_pick_win
    variable _folder_pick_current_dir
    variable _folder_pick_result

    if {$initial_dir eq "" || ![file isdirectory $initial_dir]} {
        set initial_dir [pwd]
    }
    set _folder_pick_result ""

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
    label $top.lbl -text "Path:"
    entry $top.path -textvariable ::nc::ui_table::_folder_pick_current_dir
    button $top.up -text "Up" -width 5 -command {::nc::ui_table::_folder_pick_go_up}
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

proc ::nc::ui_table::_folder_pick_go_up {} {
    variable _folder_pick_current_dir
    set parent [file dirname $_folder_pick_current_dir]
    if {$parent ne $_folder_pick_current_dir} {
        set _folder_pick_current_dir $parent
        _folder_pick_refresh_list
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
        set _folder_pick_current_dir $target
        _folder_pick_refresh_list
    }
}

proc ::nc::ui_table::_folder_pick_navigate_typed {} {
    variable _folder_pick_current_dir
    set typed $_folder_pick_current_dir
    if {[file isdirectory $typed]} {
        set _folder_pick_current_dir [file normalize $typed]
        _folder_pick_refresh_list
    } else {
        catch {_table_message_box -title "Not Found" -icon warning -type ok \
            -message "This folder does not exist yet:\n$typed\n\nUse New Folder to create it."}
    }
}

proc ::nc::ui_table::_folder_pick_new_folder {} {
    variable _folder_pick_current_dir
    variable _folder_pick_win
    set name [_prompt_text "New Folder" "Folder name:" ""]
    if {$name eq ""} { return }
    set target [file join $_folder_pick_current_dir $name]
    if {[catch {file mkdir $target}]} {
        catch {_table_message_box -title "New Folder" -icon error -type ok \
            -message "Could not create folder:\n$target"}
        return
    }
    set _folder_pick_current_dir $target
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

proc ::nc::ui_table::_on_open_active_csv {} {
    variable _tab
    set files ""
    if {[catch {set files [::nc::session::table_session_files]}]} {
        _set_status "No active session folder. Choose/open a session first." warn
        return
    }
    if {![dict exists $files $_tab]} {
        _set_status "No CSV mapping for the current tab." warn
        return
    }
    set path [dict get $files $_tab]
    if {![file exists $path]} {
        set tab_label $_tab
        foreach pair [_tab_defs] {
            if {[lindex $pair 0] eq $_tab} { set tab_label [lindex $pair 1] }
        }
        _set_status "No CSV exported yet for the $tab_label tab. Use Export to create it first." warn
        return
    }
    if {[catch {exec cmd /c start "" $path &}]} {
        if {[catch {exec explorer [file dirname $path] &}]} {
            _set_status "CSV file: $path" ok
        } else {
            _set_status "Could not open $path directly; opened its folder instead." warn
        }
    }
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
        # Auto-save means closing normally never needs a prompt — flush and go.
        if {![_autosave_flush_now]} {
            set reason "the session could not be written"
            catch {
                set policy [::nc::session::save_policy]
                if {[dict get $policy status] eq "block"} {
                    set reason [dict get $policy reason]
                }
            }
            set answer yes
            catch {
                set answer [_table_message_box -title "Close Without Saving?" \
                    -icon warning -type yesno -default no \
                    -message "Could not save the session ($reason).\n\nClose anyway and lose unsaved changes?"]
            }
            if {$answer ne "yes"} {
                _restore_table_window
                return
            }
        }
    }
    catch {destroy $_label_win}
    catch {destroy $_win}
    set _win ""
}

# =============================================================================
# Window construction
# =============================================================================

proc ::nc::ui_table::_style_button {path {kind normal}} {
    if {$path eq "" || ![winfo exists $path]} { return }
    catch {$path configure -padx 5 -pady 1 -bd 1 -relief raised -highlightthickness 0 -takefocus 0 -font {Arial 8}}
    switch -- $kind {
        primary { catch {$path configure -background "#dcefdc" -activebackground "#c7e4c7"} }
        danger { catch {$path configure -background "#f0dddd" -activebackground "#e7caca"} }
        quiet { catch {$path configure -background "#f4f4f4" -activebackground "#e7e7e7"} }
        normal { catch {$path configure -background "#f7f7f7" -activebackground "#e9e9e9"} }
    }
}

proc ::nc::ui_table::_add_button {parent name text cmd {kind normal}} {
    set b [button $parent.$name -text $text -command $cmd]
    _style_button $b $kind
    pack $b -side left -padx {0 3} -pady 2
    return $b
}

proc ::nc::ui_table::_make_group {parent name label} {
    set f [frame $parent.$name -bd 1 -relief groove -highlightthickness 0]
    if {$label ne ""} {
        label $f.lbl -text $label -fg "#555555" -font {Arial 8} -anchor w
        pack $f.lbl -side left -padx {5 4} -pady 2
    }
    return $f
}

proc ::nc::ui_table::_build_window {title} {
    variable _win
    variable _root
    variable _log_w

    set _win .nc_table
    catch {destroy $_win}
    toplevel $_win
    wm title $_win $title
    catch {wm minsize $_win 920 520}
    catch {wm geometry $_win 1120x680}
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

    _build_menubar $_root
    _build_tabbar $_root
    _build_control_area $_root
    _build_table_frame $_root
    _build_log_panel $_root
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
    foreach pair {
        {tableMenu Table}
        {selectionMenu Selection}
        {displayMenu Display}
        {actionMenu Action}
        {sessionMenu Session}
    } {
        lassign $pair name label
        menubutton $mf.$name -text $label -relief flat -bd 0 -padx 5 -pady 1 -anchor w
        menu $mf.$name.menu -tearoff 0
        $mf.$name configure -menu $mf.$name.menu
        pack $mf.$name -side left -padx {0 4}
    }
    $mf.tableMenu.menu add command -label "Reload" -command {::nc::ui_table::_on_scan}
    $mf.tableMenu.menu add command -label "Reset Columns" -command {::nc::ui_table::_reset_columns}
    $mf.tableMenu.menu add separator
    $mf.tableMenu.menu add command -label "Import Tab..." -command {::nc::ui_table::_on_import}
    $mf.tableMenu.menu add command -label "Export Current Tab..." -command {::nc::ui_table::_on_export}
    $mf.tableMenu.menu add command -label "Export All..." -command {::nc::ui_table::_on_export_all}
    $mf.tableMenu.menu add separator
    $mf.tableMenu.menu add command -label "Copy TSV" -command {::nc::ui_table::copy_selection_to_clipboard}
    $mf.selectionMenu.menu add command -label "Find Next" -command {::nc::ui_table::_on_find_next}
    $mf.selectionMenu.menu add command -label "Clear Find" -command {::nc::ui_table::_on_search_clear}
    $mf.selectionMenu.menu add separator
    $mf.selectionMenu.menu add command -label "Label Palette..." -command {::nc::ui_table::_open_label_palette}
    $mf.selectionMenu.menu add separator
    $mf.selectionMenu.menu add command -label "Worklist..." -command {::nc::ui_table::_on_worklist}
    $mf.selectionMenu.menu add command -label "Clear Worklist" -command {::nc::ui_table::_on_worklist_clear}
    $mf.selectionMenu.menu add separator
    $mf.selectionMenu.menu add command -label "Select Dirty Rows" -command {::nc::ui_table::_select_dirty_rows}
    $mf.selectionMenu.menu add command -label "Clear Selection" -command {::nc::ui_table::_clear_selection}
    $mf.selectionMenu.menu add separator
    $mf.selectionMenu.menu add command -label "Isolate" -command {::nc::ui_table::_on_isolate}
    $mf.displayMenu.menu add checkbutton -label "Show Data Toolbar" -variable ::nc::ui_table::_show_data_toolbar -command {::nc::ui_table::_refresh_layout_options}
    $mf.displayMenu.menu add checkbutton -label "Show Edit Toolbar" -variable ::nc::ui_table::_show_edit_toolbar -command {::nc::ui_table::_refresh_layout_options}
    $mf.displayMenu.menu add checkbutton -label "Show Review Toolbar" -variable ::nc::ui_table::_show_review_toolbar -command {::nc::ui_table::_refresh_layout_options}
    $mf.displayMenu.menu add checkbutton -label "Show View Toolbar" -variable ::nc::ui_table::_show_view_toolbar -command {::nc::ui_table::_refresh_layout_options}
    $mf.displayMenu.menu add checkbutton -label "Show Context Filter" -variable ::nc::ui_table::_show_context_filter -command {::nc::ui_table::_refresh_layout_options}
    $mf.displayMenu.menu add checkbutton -label "Show Status Log" -variable ::nc::ui_table::_show_status_log -command {::nc::ui_table::_refresh_layout_options}
    $mf.displayMenu.menu add separator
    $mf.displayMenu.menu add checkbutton -label "Show Images Column" -variable ::nc::ui_table::_show_images_col -command {::nc::ui_table::_on_column_visibility_changed}
    $mf.displayMenu.menu add checkbutton -label "Show Notes Column" -variable ::nc::ui_table::_show_notes_col -command {::nc::ui_table::_on_column_visibility_changed}
    $mf.displayMenu.menu add checkbutton -label "Compact Rows" -variable ::nc::ui_table::_compact_rows -command {::nc::ui_table::_on_density_changed}
    $mf.displayMenu.menu add checkbutton -label "Alternate Row Color" -variable ::nc::ui_table::_alternate_rows -command {::nc::ui_table::_on_alternate_rows_changed}
    $mf.displayMenu.menu add separator
    $mf.displayMenu.menu add command -label "Load Images..." -command {::nc::ui_table::_on_load_images}
    $mf.displayMenu.menu add command -label "Capture Images" -command {::nc::ui_table::_on_capture_images}
    $mf.displayMenu.menu add command -label "Arrange View" -command {::nc::ui_table::_on_arrange}
    $mf.displayMenu.menu add separator
    $mf.displayMenu.menu add command -label "Image Small" -command {::nc::ui_table::_set_image_size small}
    $mf.displayMenu.menu add command -label "Image Medium" -command {::nc::ui_table::_set_image_size medium}
    $mf.displayMenu.menu add command -label "Image Large" -command {::nc::ui_table::_set_image_size large}
    $mf.displayMenu.menu add separator
    $mf.displayMenu.menu add command -label "Text Smaller" -command {::nc::ui_table::_adjust_text_size -1}
    $mf.displayMenu.menu add command -label "Text Larger" -command {::nc::ui_table::_adjust_text_size 1}
    $mf.actionMenu.menu add command -label "New" -command {::nc::ui_table::_on_new}
    $mf.actionMenu.menu add command -label "Duplicate" -command {::nc::ui_table::_on_duplicate}
    $mf.actionMenu.menu add command -label "Delete" -command {::nc::ui_table::_on_delete}
    $mf.actionMenu.menu add command -label "Validate" -command {::nc::ui_table::_on_validate}
    $mf.actionMenu.menu add separator
    $mf.actionMenu.menu add command -label "Apply Current Tab" -command {::nc::ui_table::_on_apply}
    $mf.actionMenu.menu add command -label "Apply All Staged" -command {::nc::ui_table::_on_apply_all}
    $mf.actionMenu.menu add separator
    $mf.actionMenu.menu add command -label "Apply to HM..." -command {::nc::ui_table::_on_apply_to_hm}
    $mf.sessionMenu.menu add command -label "Session Manager..." -command {::nc::ui_table::_on_session_manager}
    $mf.sessionMenu.menu add separator
    $mf.sessionMenu.menu add command -label "New Session..." -command {::nc::ui_table::_on_session_new}
    $mf.sessionMenu.menu add command -label "Open Session..." -command {::nc::ui_table::_on_session_open}
    $mf.sessionMenu.menu add command -label "Save Session" -command {::nc::ui_table::_on_session_save}
    $mf.sessionMenu.menu add command -label "Save Session As..." -command {::nc::ui_table::_on_session_save_as}
    $mf.sessionMenu.menu add separator
    $mf.sessionMenu.menu add command -label "Reveal Session Folder" -command {::nc::ui_table::_on_session_reveal}
}

proc ::nc::ui_table::_build_tabbar {root} {
    variable _tabbar
    variable _tab_btns
    variable _session_lbl

    set _tabbar [frame $root.tabs -bd 0 -pady 2]
    pack $_tabbar -side top -fill x -padx 4 -pady {1 1}
    set _session_lbl [label $_tabbar.session -anchor e -fg "#555555" -text "Session: preview" -width 1]
    pack $_session_lbl -side right -fill x -expand 1 -padx {8 2}
    foreach pair [_tab_defs] {
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
    _set_status "All columns shown in [_tab_label $tab] tab." ok
}

proc ::nc::ui_table::_reset_columns_for_tab {tab} {
    variable _tab
    variable _col_order
    catch {unset _col_order($tab)}
    _set_tab $tab
    _on_arrange
    _set_status "Column order and widths reset for [_tab_label $tab] tab." ok
}

proc ::nc::ui_table::_build_control_area {root} {
    variable _control_frame
    variable _tablebar
    variable _search_frame
    variable _action_frame
    variable _io_frame
    variable _label_frame
    variable _prop_view_frame
    variable _pbush_frame

    set top [frame $root.topframe -bd 1 -relief groove -highlightthickness 0 -background "#efefef"]
    set _control_frame $top
    pack $top -side top -fill x -padx 4 -pady {1 3}

    set _search_frame [frame $top.find -bd 0 -background "#efefef"]
    set _action_frame [frame $top.actions -bd 0 -background "#efefef"]
    set _tablebar ""
    set _io_frame ""
    set _prop_view_frame [frame $top.propview -bd 0 -background "#efefef"]
    set _pbush_frame [frame $top.pbush -bd 0 -background "#efefef"]

    pack $_search_frame -side top -fill x -anchor nw
    pack $_action_frame -side top -fill x -anchor nw

    _build_search_strip $_search_frame
    _build_assign_strip $_action_frame
    _build_iobar $_action_frame
    set _label_frame ""
    _build_action_buttons $_action_frame
    _build_focusbar $_action_frame
    _build_tablebar $_action_frame
    _build_property_view_bar $_prop_view_frame
    _build_pbush_bar $_pbush_frame
    _refresh_layout_options
}

proc ::nc::ui_table::_build_search_strip {parent} {
    set f [_make_group $parent search "Find"]
    entry $f.e -textvariable ::nc::ui_table::_search_text -width 28
    if {[llength [info commands ttk::combobox]] > 0} {
        ttk::combobox $f.mode -textvariable ::nc::ui_table::_search_mode -state readonly -width 18 \
            -values {"All Labels" "Component Label" "Component Name" "Material Label" "Property Label"}
    } else {
        entry $f.mode -textvariable ::nc::ui_table::_search_mode -width 18
    }
    pack $f.e $f.mode -side left -padx {0 4} -pady 3
    _add_button $f next "Next" {::nc::ui_table::_on_find_next} quiet
    _add_button $f clear "Clear" {::nc::ui_table::_on_search_clear} quiet
    pack $f -side left -padx {4 6} -pady {4 2}
    bind $f.e <Return> {::nc::ui_table::_on_find_next; break}
}

proc ::nc::ui_table::_build_assign_strip {parent} {
    variable _assign_frame
    variable _mat_cb
    set _assign_frame [_make_group $parent assign ""]
    set _mat_cb ""
    button $_assign_frame.mass -text "Calculate Mass" -command {::nc::ui_table::_on_calculate_mass}
    _style_button $_assign_frame.mass quiet
    pack $_assign_frame.mass -side left -padx {0 4} -pady 2
}

proc ::nc::ui_table::_build_label_strip {parent} {
    variable _label_frame
    set f [_make_group $parent labels ""]
    set _label_frame $f
    _add_button $f open "Labels..." {::nc::ui_table::_open_label_palette} primary
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
    set f [_make_group $parent edit ""]
    set _edit_frame $f
    _add_button $f new "New" {::nc::ui_table::_on_new}
    _add_button $f dup "Duplicate" {::nc::ui_table::_on_duplicate}
    _add_button $f del "Delete" {::nc::ui_table::_on_delete} danger
    _add_button $f apply "Apply" {::nc::ui_table::_on_apply} primary
    pack $f -side left -padx {0 6} -pady {2 4}
}

proc ::nc::ui_table::_build_focusbar {parent} {
    variable _review_frame
    set f [_make_group $parent review ""]
    set _review_frame $f
    _add_button $f iso "Isolate" {::nc::ui_table::_on_isolate}
    _add_button $f findcomp "Find Comp" {::nc::ui_table::_on_find_comp}
    _add_button $f resettrans "Reset" {::nc::ui_table::_on_reset_transparency}
    _add_button $f val "Validate" {::nc::ui_table::_on_validate}
    pack $f -side left -padx {0 6} -pady {2 4}
}

proc ::nc::ui_table::_build_tablebar {parent} {
    variable _tablebar
    variable _view_frame
    set f [_make_group $parent view "View"]
    set _tablebar $f
    set _view_frame $f
    _add_button $f loadimg "Images" {::nc::ui_table::_on_load_images}
    _add_button $f capture "Capture" {::nc::ui_table::_on_capture_images}
    _add_button $f arrange "Arrange" {::nc::ui_table::_on_arrange}
    _add_button $f imgs "S" {::nc::ui_table::_set_image_size small} quiet
    _add_button $f imgm "M" {::nc::ui_table::_set_image_size medium} quiet
    _add_button $f imgl "L" {::nc::ui_table::_set_image_size large} quiet
    _add_button $f fontdown "A-" {::nc::ui_table::_adjust_text_size -1} quiet
    _add_button $f fontup "A+" {::nc::ui_table::_adjust_text_size 1} quiet
    pack $f -side left -padx {0 6} -pady {2 4}
}

proc ::nc::ui_table::_build_iobar {parent} {
    variable _io_frame
    set f [_make_group $parent data "Data"]
    set _io_frame $f
    _add_button $f reload "Reload" {::nc::ui_table::_on_scan}
    _add_button $f import "Import" {::nc::ui_table::_on_import}
    _add_button $f export "Export" {::nc::ui_table::_on_export}
    _add_button $f opencsv "Open CSV" {::nc::ui_table::_on_open_active_csv} quiet
    _add_button $f opencsvfolder "CSV Folder" {::nc::ui_table::_on_open_csv_folder} quiet
    _add_button $f copy "Copy" {::nc::ui_table::copy_selection_to_clipboard} quiet
    pack $f -side left -padx {4 6} -pady {2 4}

    set wf [_make_group $parent window "Window"]
    checkbutton $wf.ontop -text "Always On Top" -variable ::nc::ui_table::_always_on_top_strict \
        -command {::nc::ui_table::_on_toggle_always_on_top_strict} -takefocus 0 -padx 2 -pady 0
    pack $wf.ontop -side left -padx {0 4}
    pack $wf -side left -padx {4 6} -pady {2 4}
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
    set status [frame $root.status -bd 0 -highlightthickness 0]
    set _status_frame $status
    set _status_lbl [label $status.lbl -anchor w -fg "#555555" -text "" -width 1]
    pack $_status_lbl -side left -fill x -expand 1 -padx 6 -pady {0 2}
    pack $status -side top -fill x -padx 4 -pady {0 1}

    set lf [frame $root.log -bd 1 -relief sunken]
    set _log_frame $lf
    pack $lf -side top -fill x -padx 4 -pady {2 4}
    set _log_w [text $lf.t -height 4 -font {Courier 8} -state disabled -wrap none \
        -background "#f8f8f8" -foreground "#333" -yscrollcommand [list $lf.sy set]]
    scrollbar $lf.sy -orient v -command [list $_log_w yview]
    pack $lf.sy -side right -fill y
    pack $_log_w -side left -fill both -expand 1
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
    if {$tab eq $_tab} return
    set _tab_sort_col($_tab) $_sort_col
    set _tab_sort_dir($_tab) $_sort_dir
    set _tab $tab
    set _sort_col [expr {[info exists _tab_sort_col($tab)] ? $_tab_sort_col($tab) : 0}]
    set _sort_dir [expr {[info exists _tab_sort_dir($tab)] ? $_tab_sort_dir($tab) : "incr"}]
    if {![string is integer -strict $_sort_col]} { set _sort_col 0 }
    if {[lsearch -exact {incr decr} $_sort_dir] < 0} { set _sort_dir incr }
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

proc ::nc::ui_table::_update_toolbar_for_tab {} {
    variable _tab
    variable _assign_frame
    variable _io_frame
    variable _label_frame
    variable _edit_frame
    variable _review_frame
    variable _view_frame
    variable _prop_view_frame
    variable _pbush_frame
    variable _property_view
    variable _show_data_toolbar
    variable _show_edit_toolbar
    variable _show_review_toolbar
    variable _show_view_toolbar
    variable _show_context_filter

    foreach f [list $_assign_frame $_io_frame $_label_frame $_edit_frame $_review_frame $_view_frame $_prop_view_frame $_pbush_frame] {
        if {$f ne "" && [winfo exists $f]} { catch {pack forget $f} }
    }

    if {$_show_data_toolbar && $_io_frame ne "" && [winfo exists $_io_frame]} {
        catch {pack $_io_frame -side left -padx {4 6} -pady {2 4}}
    }

    if {$_show_edit_toolbar && $_assign_frame ne "" && [winfo exists $_assign_frame] && $_tab eq "component"} {
        catch {pack $_assign_frame -side left -padx {0 6} -pady {2 4}}
    }
    if {$_show_edit_toolbar && $_label_frame ne "" && [winfo exists $_label_frame] && $_tab in {general component materials}} {
        catch {pack $_label_frame -side left -padx {0 6} -pady {2 4}}
    }
    if {$_show_edit_toolbar && $_edit_frame ne "" && [winfo exists $_edit_frame] && $_tab in {component properties materials}} {
        _configure_edit_group_for_tab
        catch {pack $_edit_frame -side left -padx {0 6} -pady {2 4}}
    }

    if {$_show_review_toolbar && $_review_frame ne "" && [winfo exists $_review_frame]} {
        catch {pack $_review_frame -side left -padx {0 6} -pady {2 4}}
    }

    if {$_show_view_toolbar && $_view_frame ne "" && [winfo exists $_view_frame] && $_tab in {general component}} {
        catch {pack $_view_frame -side left -padx {0 6} -pady {2 4}}
    }
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
    variable _action_frame
    variable _prop_view_frame
    variable _pbush_frame
    variable _status_frame
    variable _log_frame
    variable _show_data_toolbar
    variable _show_edit_toolbar
    variable _show_review_toolbar
    variable _show_view_toolbar
    variable _show_context_filter
    variable _show_status_log

    foreach f [list $_search_frame $_action_frame $_prop_view_frame $_pbush_frame] {
        if {$f ne "" && [winfo exists $f]} { catch {pack forget $f} }
    }
    if {$_show_review_toolbar && $_search_frame ne "" && [winfo exists $_search_frame]} {
        catch {pack $_search_frame -side top -fill x -anchor nw}
    }
    if {($_show_data_toolbar || $_show_edit_toolbar || $_show_review_toolbar || $_show_view_toolbar) && $_action_frame ne "" && [winfo exists $_action_frame]} {
        catch {pack $_action_frame -side top -fill x -anchor nw}
    }
    _update_toolbar_for_tab

    foreach f [list $_status_frame $_log_frame] {
        if {$f ne "" && [winfo exists $f]} { catch {pack forget $f} }
    }
    if {$_show_status_log} {
        if {$_status_frame ne "" && [winfo exists $_status_frame]} {
            catch {pack $_status_frame -side top -fill x -padx 4 -pady {0 1}}
        }
        if {$_log_frame ne "" && [winfo exists $_log_frame]} {
            catch {pack $_log_frame -side top -fill x -padx 4 -pady {2 4}}
        }
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
    switch -- $key {
        image_path {
            set path [_dict_get $row image_path]
            if {$path eq ""} { return "" }
            return [file tail $path]
        }
        hm_comp_name { return [_dict_get $row hm_comp_name [_dict_get $row comp_name]] }
        comp_user_name { return [_dict_get $row comp_user_name [_dict_get $row label [_dict_get $row comp_name]]] }
        prop_user_name { return [_dict_get $row prop_user_name [_dict_get $row prop_name]] }
        mat_user_name { return [_dict_get $row mat_user_name [_dict_get $row material_label [_dict_get $row mat_name]]] }
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
        "Component Label" { set keys {comp_user_name label} }
        "Component Name" { set keys {hm_comp_name comp_name} }
        "Material Label" { set keys {mat_user_name material_label mat_name} }
        "Property Label" { set keys {prop_user_name prop_name} }
        default { set keys {comp_user_name label hm_comp_name comp_name prop_user_name prop_name mat_user_name material_label mat_name comp_id prop_id mat_id} }
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

    set src [expr {[info exists _tab_rows($_tab)] ? $_tab_rows($_tab) : {}}]
    set filtered {}
    foreach row $src {
        if {$_tab eq "properties" && $_property_view in {PSHELL PSOLID PBUSH} && [_dict_get $row prop_card [_dict_get $row card]] ne $_property_view} {
            continue
        }
        if {$_tab eq "component" && $_worklist_active} {
            set label [_cell_value component $row comp_user_name]
            set cid [_dict_get $row comp_id]
            if {[lsearch -exact $_worklist_labels $label] < 0 && [lsearch -exact $_worklist_ids $cid] < 0} { continue }
        }
        if {![_row_matches_search $row]} { continue }
        lappend filtered $row
    }
    return [_sort_rows $filtered]
}

proc ::nc::ui_table::_rebuild_table_columns {} {
    variable _tbl
    variable _tab
    variable tableData
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    _clear_header_buttons
    catch {$_tbl configure -cols [_ncols_for_tab $_tab]}
    set c 0
    foreach col_def [_cols_for_tab $_tab] {
        lassign $col_def key header width
        if {$key eq "mass_total"} { set header [_mass_header_label] }
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
        set b $_tbl.h$c
        catch {destroy $b}
        button $b -text $header -relief raised -bd 2 -padx 3 -pady 0 \
            -background "#6b6b6b" -foreground "#ffffff" \
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
            set tableData($r,$c) [_cell_value $_tab $row [lindex $col_def 0]]
            incr c
        }
        incr r
    }
    _render_image_cells
}

proc ::nc::ui_table::_reset_visible_row_heights {} {
    variable _tbl
    variable _rows
    variable _compact_rows
    if {$_tbl eq "" || [llength [info commands winfo]] == 0 || ![winfo exists $_tbl]} { return }
    set h [expr {$_compact_rows ? 1 : 2}]
    for {set r 1} {$r <= [llength $_rows]} {incr r} {
        catch {$_tbl height $r $h}
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
    if {[array exists _image_photo_cache]} {
        foreach name [array names _image_photo_cache] {
            catch {image delete $_image_photo_cache($name)}
        }
    }
    catch {array unset _image_photo_cache}
}

proc ::nc::ui_table::_image_thumb_cache_dir {} {
    set root ""
    catch {set root [::nc::session::dir]}
    if {$root eq ""} { set root [pwd] }
    set dir [file join $root cache thumb_cache]
    if {![file isdirectory $dir]} { catch {file mkdir $dir} }
    return $dir
}

proc ::nc::ui_table::_altair_python_executable {} {
    if {[llength [info commands ::nc::config::resolve_python]] > 0} {
        set p [::nc::config::resolve_python]
        if {$p ne ""} { return $p }
    }
    foreach candidate {
        {C:/Program Files/Altair/2022/common/python/python3.5/win64/python.exe}
        {C:/Program Files/Altair/2022.0/common/python/python3.5/win64/python.exe}
    } {
        if {[file exists $candidate]} { return $candidate }
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
    set python [_altair_python_executable]
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
    set python [_altair_python_executable]
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
    variable tableData
    _clear_image_cells
    if {$_tbl eq "" || [llength [info commands winfo]] == 0 || ![winfo exists $_tbl]} { return }
    if {$_tab ni {general component}} { return }
    set img_col [_col_index $_tab image_path]
    if {$img_col < 0} { return }
    lassign [_image_cell_fit_units $_image_thumb_px 2] image_width_chars image_height_units
    catch {$_tbl width $img_col $image_width_chars}
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
    set _rows [_rows_for_display]
    if {$_tbl ne "" && [winfo exists $_tbl]} {
        catch {$_tbl configure -rows [expr {[llength $_rows] + 1}]}
    }
    _fill_table_data
    _apply_tags
    if {$_tbl ne "" && [winfo exists $_tbl]} {
        catch {$_tbl reread}
        catch {update idletasks}
        catch {after idle ::nc::ui_table::_render_image_cells}
    }
}

proc ::nc::ui_table::_sort_rows {rows} {
    variable _sort_col
    variable _sort_dir
    variable _tab
    if {[llength $rows] == 0} { return $rows }
    set cols [_cols_for_tab $_tab]
    if {![string is integer -strict $_sort_col] || $_sort_col < 0 || $_sort_col >= [llength $cols]} {
        set _sort_col 0
    }
    if {[lsearch -exact {incr decr} $_sort_dir] < 0} {
        set _sort_dir incr
    }
    set key [lindex [lindex $cols $_sort_col] 0]
    set decorated {}
    foreach row $rows {
        lappend decorated [list [_cell_value $_tab $row $key] $row]
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
    set sorted [lsort $sort_type -index 0 -$_sort_dir $decorated]
    set out {}
    foreach pair $sorted { lappend out [lindex $pair 1] }
    return $out
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

proc ::nc::ui_table::_autofit_column {col} {
    variable _rows
    variable _tab
    variable _tbl
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
    _set_status "Autofit column: [_header_label $col]" ok
    return 1
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
            catch {$b configure -relief raised -background "#6b6b6b" -foreground "#ffffff" -activebackground "#4f6f93" -activeforeground "#ffffff"}
            catch {$b configure -cursor hand2}
        }
    }
}

proc ::nc::ui_table::_reset_header_drag_visuals {} {
    variable _header_widgets
    foreach w $_header_widgets {
        if {[winfo exists $w]} {
            catch {$w configure -relief raised -background "#6b6b6b" -foreground "#ffffff" -activebackground "#4f6f93" -activeforeground "#ffffff"}
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
    variable _header_resize_col
    variable _header_press_col
    variable _header_dragging
    variable _header_hover_col
    variable _header_drop_slot
    if {$_header_resize_col >= 0} {
        set resized $_header_resize_col
        set _header_resize_col -1
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
    variable _header_press_col
    variable _header_dragging
    set _header_press_col [_header_col_at_xy $x $y]
    set _header_dragging 0
    if {$_header_press_col >= 0 && $_tbl ne "" && [winfo exists $_tbl]} {
        catch {$_tbl tag cell tag_header_drag 0,$_header_press_col}
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
    if {![string is integer -strict $c] || $c < 0} { return }
    if {![string is integer -strict $_sort_col]} { set _sort_col 0 }
    if {[lsearch -exact {incr decr} $_sort_dir] < 0} { set _sort_dir incr }
    if {$c == $_sort_col} {
        set _sort_dir [expr {$_sort_dir eq "incr" ? "decr" : "incr"}]
    } else {
        set _sort_col $c
        set _sort_dir incr
    }
    _populate_current
}

proc ::nc::ui_table::_move_column {from to} {
    return [_move_column_to_slot $from $to]
}

proc ::nc::ui_table::_move_column_to_slot {from slot} {
    variable _tab
    variable _sort_col
    variable _sort_dir
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
    set _sort_col $insert_at
    set _sort_dir incr
    if {![string is integer -strict $_sort_col]} { set _sort_col 0 }
    _rebuild_table_columns
    _populate_current
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
    return [expr {$key in {comp_user_name prop_user_name mat_user_name}}]
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
    set row [lindex $_rows [expr {$r - 1}]]
    set row_key [_row_key_for_tab $_tab $row]
    set row [_set_row_value $_tab $row $key $new_val]
    if {$_tab in {general component}} {
        _sync_component_fields [_dict_get $row comp_id] $row
    } else {
        _replace_row $_tab $row_key $row
    }
    _populate_current
    _set_status "Staged $key = '$new_val' (preview only)." ok
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
    }
    if {$_context_menu eq ""} { set _context_menu .nc_table_context }
    if {![winfo exists $_context_menu]} {
        catch {destroy $_context_menu}
        menu $_context_menu -tearoff 0
        $_context_menu add command -label "Copy" -command {::nc::ui_table::copy_selection_to_clipboard}
        $_context_menu add command -label "Paste" -command {::nc::ui_table::_paste_clipboard}
        $_context_menu add separator
        $_context_menu add command -label "Assign Material Label..." -command {::nc::ui_table::_on_assign}
        $_context_menu add command -label "Stage Duplicate" -command {::nc::ui_table::_on_duplicate}
        $_context_menu add command -label "Stage Delete" -command {::nc::ui_table::_on_delete}
    }
    catch {tk_popup $_context_menu $X $Y}
}

proc ::nc::ui_table::_show_header_context_menu {col X Y} {
    variable _tab
    set cols [_cols_for_tab $_tab]
    if {$col < 0 || $col >= [llength $cols]} { return -code break }
    set key [lindex [lindex $cols $col] 0]
    if {$key ne "mass_total"} { return -code break }
    set menu .nc_mass_header_context
    catch {destroy $menu}
    menu $menu -tearoff 0
    $menu add radiobutton -label "kg" -variable ::nc::ui_table::_mass_unit -value kg \
        -command {::nc::ui_table::_on_mass_unit_changed}
    $menu add radiobutton -label "ton" -variable ::nc::ui_table::_mass_unit -value ton \
        -command {::nc::ui_table::_on_mass_unit_changed}
    catch {tk_popup $menu $X $Y}
    return -code break
}

proc ::nc::ui_table::_on_mass_unit_changed {} {
    _rebuild_table_columns
    _populate_current
    _set_status "Mass unit: [_mass_header_label]" ok
}

proc ::nc::ui_table::_paste_clipboard {} {
    variable _tbl
    variable _rows
    variable _tab
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    set text ""
    catch {set text [clipboard get]}
    if {[string trim $text] eq ""} { return }
    set active ""
    catch {set active [$_tbl index active]}
    if {$active eq ""} { set active "1,0" }
    lassign [split $active ,] start_r start_c
    if {![string is integer -strict $start_r] || $start_r < 1} { set start_r 1 }
    if {![string is integer -strict $start_c] || $start_c < 0} { set start_c 0 }
    set changed 0
    set lines [split [string trimright $text] "\n"]
    for {set i 0} {$i < [llength $lines]} {incr i} {
        set r [expr {$start_r + $i}]
        if {$r > [llength $_rows]} break
        set row [lindex $_rows [expr {$r - 1}]]
        set row_key [_row_key_for_tab $_tab $row]
        set values [split [lindex $lines $i] "\t"]
        for {set j 0} {$j < [llength $values]} {incr j} {
            set c [expr {$start_c + $j}]
            set cols [_cols_for_tab $_tab]
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
        }
    }
    _populate_current
    _set_status "Pasted/staged $changed cell(s) (preview only)." ok
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
        lappend _tab_rows(materials) [dict create mat_card MAT1 mat_id $id mat_user_name "New_Material_$id" mat_name "MAT1_$id" E 210000 G "" NU 0.3 RHO "" A "" TREF "" GE "" ST "" SC "" SS "" note "New staged material" _dirty_fields {mat_id mat_user_name mat_name note}]
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
    lappend lines "Apply verified preview changes to the live HyperMesh model?"
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
                    dict set row hm_mat_id [dict get $action mat_id]
                    if {[dict exists $action mat_label]} { dict set row hm_material_label [dict get $action mat_label] }
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
                -title "Apply to HyperMesh Blocked" \
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
            -title "Apply to HyperMesh" \
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

proc ::nc::ui_table::_on_isolate {} {
    variable _tab
    set rows [get_selected_rows]
    if {[llength $rows] == 0} {
        _set_status "Select one or more component cells first." warn
        return
    }
    if {[llength [info commands *isolateonlyentitybymark]] == 0} {
        _set_status "HyperMesh isolate command is not available in this session." warn
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
    set rc [catch {
        catch {*clearmark comps 1}
        catch {*clearmark component 2}
        *createmark component 2 "by id" {*}$comp_ids
        *createstringarray 2 "elements_on" "geometry_on"
        *isolateonlyentitybymark 2 1 2
        catch {*view "iso1"}
        catch {*window 0 0 0 0 0}
    } err]
    if {$rc} {
        _set_status "Isolate failed: $err" error
        return
    }
    _set_status "Isolated [llength $comp_ids] component(s)." ok
}

# Checks that the transparency API is present before we try to use it, so a
# missing command fails loud with a clear message instead of a raw Tcl error
# or a silently broken display. Confirmed via HyperMesh's own recorded
# command history:
#   *createmark components <mark> "by id" <ids>
#   *setmarkdisplayattributes components <mark> 4 1   ;# transparent FE style
#   *setmarkdisplayattributes components <mark> 2 1   ;# normal/mesh FE style
# These are two independent display attributes (not on/off of the same one),
# so restoring "normal" is attribute 2 = 1, not attribute 4 = 0.
proc ::nc::ui_table::_transparency_api_available {} {
    return [expr {[llength [info commands *setmarkdisplayattributes]] > 0}]
}

# Focuses the view on the selected component(s) without rotating the model:
# reuses Isolate's own hide+fit mechanism to compute the zoom (skipping the
# "*view iso1" rotate step), then restores full visibility (re-isolating on
# the full component set is a no-op hide, so nothing stays hidden) while the
# camera framing from the fit sticks. Every other component is then made
# transparent (not hidden) so the target stands out.
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
    if {[llength [info commands *isolateonlyentitybymark]] == 0} {
        _set_status "HyperMesh isolate command is not available in this session." warn
        return
    }
    if {![_transparency_api_available]} {
        _set_status "HyperMesh transparency commands are not available in this session." warn
        return
    }
    set all_ids [_all_known_comp_ids]
    set other_ids {}
    foreach cid $all_ids {
        if {[lsearch -exact $comp_ids $cid] < 0} { lappend other_ids $cid }
    }
    set rc [catch {
        catch {*clearmark comps 1}
        catch {*clearmark component 2}
        *createmark component 2 "by id" {*}$comp_ids
        *createstringarray 2 "elements_on" "geometry_on"
        *isolateonlyentitybymark 2 1 2
        catch {*window 0 0 0 0 0}
        if {[llength $all_ids] > 0} {
            catch {*clearmark component 2}
            *createmark component 2 "by id" {*}$all_ids
            *createstringarray 2 "elements_on" "geometry_on"
            *isolateonlyentitybymark 2 1 2
        }
        catch {*startnotehistorystate {Modified FE style of Component}}
        # Always force the target back to normal/mesh display first: a prior
        # Find Comp call may have left it transparent (it would have been
        # part of "other_ids" back when a different component was targeted).
        catch {*clearmark components 1}
        *createmark components 1 "by id" {*}$comp_ids
        *setmarkdisplayattributes components 1 2 1
        if {[llength $other_ids] > 0} {
            catch {*clearmark components 1}
            *createmark components 1 "by id" {*}$other_ids
            *setmarkdisplayattributes components 1 4 1
        }
        catch {*endnotehistorystate {Modified FE style of Component}}
    } err]
    if {$rc} {
        _set_status "Find Comp failed: $err" error
        return
    }
    _set_status "Focused on [llength $comp_ids] component(s), [llength $other_ids] other(s) made transparent." ok
}

# Clears any transparency applied by Find Comp, restoring every known
# component to normal opaque display.
proc ::nc::ui_table::_on_reset_transparency {} {
    if {![_transparency_api_available]} {
        _set_status "HyperMesh transparency commands are not available in this session." warn
        return
    }
    set all_ids [_all_known_comp_ids]
    if {[llength $all_ids] == 0} {
        _set_status "No known components to reset." warn
        return
    }
    set rc [catch {
        catch {*startnotehistorystate {Modified FE style of Component}}
        catch {*clearmark components 1}
        *createmark components 1 "by id" {*}$all_ids
        *setmarkdisplayattributes components 1 2 1
        catch {*endnotehistorystate {Modified FE style of Component}}
    } err]
    if {$rc} {
        _set_status "Reset transparency failed: $err" error
        return
    }
    _set_status "Transparency reset for [llength $all_ids] component(s)." ok
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
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    set c 0
    foreach col_def [_cols_for_tab $_tab] {
        catch {$_tbl width $c [lindex $col_def 2]}
        incr c
    }
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
                -message "This will isolate and capture $ncomp component(s) one at a time,\ntemporarily changing the HyperMesh display.\n\nContinue?"]
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

proc ::nc::ui_table::_on_worklist {} {
    set win .nc_worklist
    catch {destroy $win}
    toplevel $win
    wm title $win "Component Worklist"
    label $win.msg -text "Paste Component ID or Component Label, one per line." -anchor w
    text $win.t -height 12 -width 46
    frame $win.buttons
    button $win.buttons.apply -text "Apply" -command [list ::nc::ui_table::_apply_worklist_dialog $win]
    button $win.buttons.cancel -text "Cancel" -command [list destroy $win]
    pack $win.msg -side top -fill x -padx 8 -pady {8 2}
    pack $win.t -side top -fill both -expand 1 -padx 8 -pady 4
    pack $win.buttons.apply $win.buttons.cancel -side left -padx 4 -pady 6
    pack $win.buttons -side top -anchor e -padx 8
    _place_companion_window $win 420 340
    catch {focus $win.t}
}

proc ::nc::ui_table::_apply_worklist_dialog {win} {
    variable _worklist_active
    variable _worklist_labels
    variable _worklist_ids
    set text ""
    catch {set text [$win.t get 1.0 end]}
    set labels {}
    set ids {}
    foreach line [split $text "\n"] {
        set item [string trim $line]
        if {$item eq ""} { continue }
        if {[string is integer -strict $item]} {
            if {[lsearch -exact $ids $item] < 0} { lappend ids $item }
        } elseif {[lsearch -exact $labels $item] < 0} {
            lappend labels $item
        }
    }
    if {[llength $labels] == 0 && [llength $ids] == 0} {
        _set_status "Worklist needs at least one Component ID or Component Label." warn
        return
    }
    set _worklist_labels $labels
    set _worklist_ids $ids
    set _worklist_active 1
    catch {destroy $win}
    _set_tab component
    _populate_current
    _set_status "Worklist active: [llength $ids] ID(s), [llength $labels] label(s)." ok
}

proc ::nc::ui_table::_on_worklist_clear {} {
    variable _worklist_active
    variable _worklist_labels
    variable _worklist_ids
    set _worklist_active 0
    set _worklist_labels {}
    set _worklist_ids {}
    _populate_current
    _set_status "Worklist cleared." ok
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
        lappend lines "No HyperMesh model command will be called."
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

proc ::nc::ui_table::_on_import {} {
    variable _tab
    set path ""
    catch {set path [tk_getOpenFile -title "Import" -filetypes {{"Excel/CSV files" {.xlsx .csv}} {"Excel files" .xlsx} {"CSV files" .csv} {"All files" *}}]}
    if {$path eq ""} return
    set import_path $path
    if {[string tolower [file extension $path]] eq ".xlsx"} {
        if {![_xlsx_python_ok]} {
            _set_status "openpyxl not available in Altair Python; cannot read .xlsx. Export/import as .csv instead." error
            return
        }
        set tmp_csv "[file rootname $path].nc_tmp_import.csv"
        if {![_convert_xlsx_to_csv $path $tmp_csv]} {
            _set_status "Failed to convert $path to CSV for import." error
            return
        }
        set import_path $tmp_csv
    }
    set plan [_import_build_plan $_tab $import_path]
    if {$import_path ne $path} {
        catch {file delete -force -- $import_path}
        if {[dict exists $plan path]} { dict set plan path $path }
    }
    if {[dict get $plan status] ni {ok warn}} {
        _set_status [dict get $plan message] [dict get $plan status]
        return
    }
    _open_import_preview_dialog $plan
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
    set cols [_cols_for_tab $tab]
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
# CSV <-> XLSX bridge (export/import with embedded images)
# =============================================================================

proc ::nc::ui_table::_xlsx_python_ok {} {
    set python [_altair_python_executable]
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
        ws.cell(row=r, column=c, value=val)
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
            ws.cell(row=r, column=c, value=val)
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
    set python [_altair_python_executable]
    if {$python eq ""} { return 0 }
    set script [_write_multi_csv_to_xlsx_script [file dirname $xlsx_path]]
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
        _set_status "openpyxl not available in Altair Python; cannot write xlsx." error
        return 0
    }
    set root [file rootname $xlsx_path]
    set tmp_csvs {}
    set jobs {}

    set summary_tmp "${root}.nc_tmp_summary.csv"
    _write_summary_csv $summary_tmp
    lappend tmp_csvs $summary_tmp
    lappend jobs [list "Summary" $summary_tmp "Image"]

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

proc ::nc::ui_table::_write_summary_csv {path} {
    variable _tab_rows
    set mass_hdr [_mass_header_label]
    set headers [list "Image" "Comp ID" "Component Label" \
        "Prop Card" "Prop ID" \
        "Mat Card" "MAT ID" "Material Label" \
        "E" "G" "NU" "RHO" "A" "TREF" "GE" "ST" "SC" "SS" \
        $mass_hdr "Note"]

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

        set vals [list $img_path $cid $clabel $pcard $pid $mcard $mid $mlabel]
        foreach k $mat_fields { lappend vals [dict get $mvals $k] }
        lappend vals $mass $note
        set safe_vals {}
        foreach v $vals { lappend safe_vals [_csv_safe_export_value note $v] }
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
    set python [_altair_python_executable]
    if {$python eq ""} { return 0 }
    set script [_write_csv_to_xlsx_script [file dirname $xlsx_path]]
    if {[catch {exec $python $script $csv_path $xlsx_path $image_header}]} { return 0 }
    return [file exists $xlsx_path]
}

proc ::nc::ui_table::_convert_xlsx_to_csv {xlsx_path csv_path} {
    set python [_altair_python_executable]
    if {$python eq ""} { return 0 }
    set script [_write_xlsx_to_csv_script [file dirname $csv_path]]
    if {[catch {exec $python $script $xlsx_path $csv_path}]} { return 0 }
    return [file exists $csv_path]
}

proc ::nc::ui_table::_image_header_for_tab {tab} {
    if {$tab ni {general component}} { return "" }
    foreach col_def [_cols_for_tab $tab] {
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
        _set_status "openpyxl not available in Altair Python; exported CSV instead: $csv_path" warn
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

proc ::nc::ui_table::copy_selection_to_clipboard {} {
    variable _tbl
    variable _rows
    variable _tab
    variable tableData
    if {$_tbl eq "" || ![winfo exists $_tbl]} return
    set sel {}
    catch {
        foreach cell [$_tbl curselection] {
            set r [lindex [split $cell ,] 0]
            if {[string is integer -strict $r] && $r >= 1} { lappend sel $r }
        }
    }
    set sel [lsort -unique -integer $sel]
    if {[llength $sel] == 0} {
        for {set r 1} {$r <= [llength $_rows]} {incr r} { lappend sel $r }
    }
    set cols [_cols_for_tab $_tab]
    set lines {}
    set h {}
    foreach col_def $cols { lappend h [lindex $col_def 1] }
    lappend lines [join $h "\t"]
    foreach r $sel {
        set parts {}
        for {set c 0} {$c < [llength $cols]} {incr c} {
            set val ""
            if {[info exists tableData($r,$c)]} { set val $tableData($r,$c) }
            lappend parts [string map [list "\t" " " "\n" " "] $val]
        }
        lappend lines [join $parts "\t"]
    }
    catch {
        clipboard clear
        clipboard append [join $lines "\n"]
    }
    _set_status "Copied [llength $sel] row(s) as TSV." ok
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
