# =============================================================================
# session.tcl  —  ::nc::session
#
# Session folder management for the Nastran Control Tool.
# One session = one folder under _clean/sessions/<model_name>/.
#
# CSV files in the session folder:
#   materials.csv    — material library (mat_id, label, type, e, nu, rho, note)
#   comps.csv        — comp snapshot (comp_id, comp_name_hm, label, prop_id, prop_type, case)
#   assignments.csv  — desired state  (comp_id, material_label)
#   audit.csv        — change log     (timestamp, action, comp_id, ...)
#
# Public API:
#   ::nc::session::init {model_path}          -> session dir string; creates dirs
#   ::nc::session::dir {}                     -> current session dir (or "")
#   ::nc::session::load_comps {}              -> dict: comp_id -> dict
#   ::nc::session::load_materials {}          -> list of mat dicts
#   ::nc::session::load_assignments {}        -> dict: comp_id -> material_label
#   ::nc::session::save_comps {rows}          -> write comps.csv from scan rows
#   ::nc::session::save_materials {mat_rows}  -> write materials.csv
#   ::nc::session::save_assignments {asgn}    -> write assignments.csv (dict or list)
#   ::nc::session::append_audit {args...}     -> append one audit row
#   ::nc::session::merge_labels {rows}        -> overlay labels onto scan rows
#   ::nc::session::set_dir {dir}              -> set active session folder
#   ::nc::session::save_table_session {rows_by_tab {dir ""}}
#   ::nc::session::load_table_session {{dir ""}}
# =============================================================================

namespace eval ::nc::session {
    # Resolved at source time — lib/ -> _clean/sessions/
    variable _lib_dir [file dirname [info script]]
    variable _dir     ""
    variable _model_source ""
    variable _model_fingerprint ""
}

# -----------------------------------------------------------------------------
# Internal: sessions root directory
# -----------------------------------------------------------------------------

proc ::nc::session::_sessions_root {} {
    variable _lib_dir
    return [file join $_lib_dir .. sessions]
}

# Internal: safe directory creation
proc ::nc::session::_mkdir {dir} {
    if {$dir ne "" && ![file isdirectory $dir]} {
        file mkdir $dir
    }
}

proc ::nc::session::_safe_name {name} {
    if {$name eq ""} { set name "untitled_session" }
    return [regsub -all {[\\/:*?"<>|]} $name "_"]
}

# -----------------------------------------------------------------------------
# Public: init
# Derive session folder from model_path, create it, set as active session.
# Returns the session directory path.
# -----------------------------------------------------------------------------

proc ::nc::session::init {model_path} {
    variable _dir
    variable _model_source
    variable _model_fingerprint
    set _model_source [string trim $model_path]
    set _model_fingerprint [_fingerprint_for_model_path $_model_source]
    set model_name [file rootname [file tail $model_path]]
    set model_name [_safe_name $model_name]
    set _dir [file join [_sessions_root] $model_name]
    _mkdir [_sessions_root]
    set_dir $_dir
    return $_dir
}

proc ::nc::session::set_model_context {model_path} {
    variable _model_source
    variable _model_fingerprint
    set _model_source [string trim $model_path]
    set _model_fingerprint [_fingerprint_for_model_path $_model_source]
    return $_model_fingerprint
}

proc ::nc::session::set_dir {dir} {
    variable _dir
    if {$dir eq ""} { error "session directory is empty" }
    _mkdir $dir
    set _dir [file normalize $dir]
    return $_dir
}

# -----------------------------------------------------------------------------
# Public: dir
# Returns the currently active session directory ("" if init not called).
# -----------------------------------------------------------------------------

proc ::nc::session::dir {} {
    variable _dir
    return $_dir
}

proc ::nc::session::_fingerprint_for_model_path {model_path} {
    set model_path [string trim $model_path]
    if {$model_path eq ""} { return "unsaved:empty" }
    set norm $model_path
    catch {set norm [file normalize $model_path]}
    set exists [file exists $model_path]
    set size ""
    set mtime ""
    if {$exists} {
        catch {set size [file size $model_path]}
        catch {set mtime [file mtime $model_path]}
    }
    return "path=$norm;exists=$exists;size=$size;mtime=$mtime"
}

proc ::nc::session::_current_model_trustworthy {} {
    variable _model_source
    set src [string trim $_model_source]
    if {$src eq "" || $src eq "untitled_model"} { return 0 }
    return 1
}

proc ::nc::session::_manifest_path {{dir ""}} {
    if {$dir eq ""} { set dir [_active_or_dir ""] }
    return [file join $dir manifest.csv]
}

proc ::nc::session::_manifest_dict {{dir ""}} {
    set path [_manifest_path $dir]
    set out [dict create]
    foreach row [::nc::csv::read_dicts $path] {
        set key ""
        set value ""
        if {[dict exists $row key]} { set key [dict get $row key] }
        if {[dict exists $row value]} { set value [dict get $row value] }
        if {$key ne ""} { dict set out $key $value }
    }
    return $out
}

proc ::nc::session::_write_manifest_values {dir source fingerprint} {
    set rows [list \
        [list schema_version 1] \
        [list model_source $source] \
        [list model_fingerprint $fingerprint] \
        [list saved_at [clock format [clock seconds] -format "%Y-%m-%dT%H:%M:%S"]]]
    ::nc::csv::write_file [_manifest_path $dir] {key value} $rows
}

proc ::nc::session::_write_manifest {{dir ""}} {
    variable _model_source
    variable _model_fingerprint
    if {$dir eq ""} { set dir [_active_or_dir ""] }
    _write_manifest_values $dir $_model_source $_model_fingerprint
}

proc ::nc::session::table_session_trust_status {{dir ""}} {
    variable _model_fingerprint
    set root [_active_or_dir $dir]
    if {![_current_model_trustworthy]} {
        return [dict create status untrusted reason "Current model has no stable file path; cached table rows are not trusted."]
    }
    set path [_manifest_path $root]
    if {![file exists $path]} {
        return [dict create status missing reason "Session manifest is missing; cached table rows are not trusted."]
    }
    set manifest [_manifest_dict $root]
    if {![dict exists $manifest model_fingerprint]} {
        return [dict create status missing reason "Session manifest has no model fingerprint; cached table rows are not trusted."]
    }
    set saved [dict get $manifest model_fingerprint]
    if {$saved ne $_model_fingerprint} {
        return [dict create status mismatch reason "Session fingerprint does not match the current model."]
    }
    return [dict create status ok reason "Session manifest matches current model."]
}

proc ::nc::session::_ensure_manifest_for_save {dir} {
    set trust [table_session_trust_status $dir]
    set status [dict get $trust status]
    if {$status in {ok missing}} {
        _write_manifest $dir
        return
    }
    if {$status eq "untrusted"} {
        # Offline save (current model has no stable file path). Never clobber a
        # stored fingerprint with "unsaved:empty" — preserve the session's
        # identity and only refresh saved_at.
        set manifest [_manifest_dict $dir]
        if {[dict exists $manifest model_fingerprint]} {
            set src ""
            catch {set src [dict get $manifest model_source]}
            _write_manifest_values $dir $src [dict get $manifest model_fingerprint]
        } else {
            _write_manifest $dir
        }
        return
    }
    error "Refusing to save table session: [dict get $trust reason]"
}

# -----------------------------------------------------------------------------
# Public: save_policy
# Cheap pre-save check for the auto-save engine. Maps trust status to:
#   ok    — session matches the current model, save freely
#   adopt — manifest missing or model offline; save preserves stored identity
#   block — fingerprint mismatch; saving would target another model's session
# -----------------------------------------------------------------------------

proc ::nc::session::save_policy {{dir ""}} {
    variable _dir
    set root $dir
    if {$root eq ""} { set root $_dir }
    if {$root eq ""} {
        return [dict create status block reason "No active session folder."]
    }
    set trust [table_session_trust_status $root]
    set status [dict get $trust status]
    set reason [dict get $trust reason]
    switch -- $status {
        ok       { return [dict create status ok reason $reason] }
        mismatch { return [dict create status block reason $reason] }
    }
    return [dict create status adopt reason $reason]
}

# -----------------------------------------------------------------------------
# Public: rebind_manifest_to_current_model
# Force-overwrite the session manifest with the CURRENT model identity.
# Only call this from an explicit user confirmation (manual Save on a
# mismatched session) — never from auto-save.
# -----------------------------------------------------------------------------

proc ::nc::session::rebind_manifest_to_current_model {{dir ""}} {
    set root [_active_or_dir $dir]
    _write_manifest $root
    return $root
}

# -----------------------------------------------------------------------------
# Public: create_session
# Create a brand-new session skeleton <parent_dir>/<name> and make it active.
# Refuses to hijack a folder that is already a session.
# -----------------------------------------------------------------------------

proc ::nc::session::create_session {parent_dir name} {
    set parent [string trim $parent_dir]
    if {$parent eq ""} { error "Parent folder is empty." }
    if {![file isdirectory $parent]} { error "Parent folder does not exist: $parent" }
    if {[string trim $name] eq ""} { error "Session name is empty." }
    set safe [_safe_name [string trim $name]]
    set dest [file normalize [file join $parent $safe]]
    if {[file exists [file join $dest manifest.csv]] || [file isdirectory [file join $dest edits]]} {
        error "Folder is already a session: $dest"
    }
    file mkdir $dest
    file mkdir [file join $dest edits]
    file mkdir [file join $dest Component_Images]
    file mkdir [file join $dest cache thumb_cache]
    set_dir $dest
    _write_manifest $dest
    return $dest
}

# -----------------------------------------------------------------------------
# Public: save_session_as
# Duplicate the active session to dest_dir: skeleton + Component_Images copied
# (cache/ deliberately NOT copied — thumbnails regenerate lazily), image_path
# values rewritten to the new folder, manifest identity preserved when the
# current model is offline/untrustworthy. Makes dest the active session.
# Returns dict {dir rows_by_tab images_copied} so the UI can re-store rows.
# -----------------------------------------------------------------------------

proc ::nc::session::save_session_as {rows_by_tab dest_dir} {
    variable _dir
    set src $_dir
    set dest [string trim $dest_dir]
    if {$dest eq ""} { error "Destination folder is empty." }
    set dest [file normalize $dest]
    if {$src ne ""} {
        set srcn [file normalize $src]
        if {$dest eq $srcn} {
            error "Destination is the current session folder — use Save Session instead."
        }
        set d $dest
        while {1} {
            set parent [file dirname $d]
            if {$parent eq $d} { break }
            if {$parent eq $srcn} {
                error "Destination is inside the current session folder."
            }
            set d $parent
        }
    }
    # Capture source identity BEFORE switching the active dir.
    set have_keep 0
    set keep_src ""
    set keep_fp ""
    if {![_current_model_trustworthy] && $src ne ""} {
        set manifest [_manifest_dict $src]
        if {[dict exists $manifest model_fingerprint]} {
            set have_keep 1
            catch {set keep_src [dict get $manifest model_source]}
            set keep_fp [dict get $manifest model_fingerprint]
        }
    }
    file mkdir $dest
    file mkdir [file join $dest edits]
    file mkdir [file join $dest Component_Images]
    file mkdir [file join $dest cache thumb_cache]
    set dest_img [file join $dest Component_Images]
    set copied 0
    if {$src ne ""} {
        set src_img [file join $src Component_Images]
        if {[file isdirectory $src_img]} {
            foreach f [glob -nocomplain -directory $src_img *] {
                if {![file isfile $f]} continue
                if {![catch {file copy -force -- $f [file join $dest_img [file tail $f]]}]} {
                    incr copied
                }
            }
        }
    }
    set out_rows [dict create]
    foreach tab [_table_tabs] {
        set rows {}
        if {[dict exists $rows_by_tab $tab]} { set rows [dict get $rows_by_tab $tab] }
        if {$tab in {general component}} {
            set new {}
            foreach row $rows {
                set p ""
                catch {set p [dict get $row image_path]}
                if {$p ne ""} {
                    set cand [file join $dest_img [file tail $p]]
                    if {[file exists $cand]} { dict set row image_path $cand }
                }
                lappend new $row
            }
            set rows $new
        }
        dict set out_rows $tab $rows
    }
    set_dir $dest
    if {$have_keep} {
        _write_manifest_values $dest $keep_src $keep_fp
    } else {
        _write_manifest $dest
    }
    save_table_session $out_rows $dest
    return [dict create dir $dest rows_by_tab $out_rows images_copied $copied]
}

# -----------------------------------------------------------------------------
# Recent-sessions store
# Tool-local CSV (path,name,last_opened,pinned), newest first, capped at 15
# unpinned entries. Override location with NC_RECENT_FILE (used by tests).
# -----------------------------------------------------------------------------

proc ::nc::session::_recent_path {} {
    variable _lib_dir
    if {[info exists ::env(NC_RECENT_FILE)] && [string trim $::env(NC_RECENT_FILE)] ne ""} {
        return [string trim $::env(NC_RECENT_FILE)]
    }
    return [file join $_lib_dir .. config recent_sessions.csv]
}

proc ::nc::session::_session_folder_exists {dir} {
    return [expr {[file exists [file join $dir manifest.csv]] ||
                  [file isdirectory [file join $dir edits]]}]
}

proc ::nc::session::recent_list {} {
    set out {}
    foreach row [::nc::csv::read_dicts [_recent_path]] {
        set path ""
        catch {set path [string trim [dict get $row path]]}
        if {$path eq ""} continue
        set name ""
        catch {set name [dict get $row name]}
        if {$name eq ""} { set name [file tail $path] }
        set last ""
        catch {set last [dict get $row last_opened]}
        set pinned 0
        catch {if {[dict get $row pinned]} { set pinned 1 }}
        lappend out [dict create path $path name $name last_opened $last \
            pinned $pinned missing [expr {![_session_folder_exists $path]}]]
    }
    return $out
}

proc ::nc::session::_recent_write {entries} {
    set rows {}
    set unpinned 0
    foreach e $entries {
        set pinned 0
        catch {if {[dict get $e pinned]} { set pinned 1 }}
        if {!$pinned} {
            incr unpinned
            if {$unpinned > 15} continue
        }
        lappend rows [list [dict get $e path] [dict get $e name] \
            [dict get $e last_opened] $pinned]
    }
    ::nc::csv::write_file [_recent_path] {path name last_opened pinned} $rows
}

proc ::nc::session::recent_touch {dir} {
    set dir [string trim $dir]
    if {$dir eq ""} { return "" }
    set norm $dir
    catch {set norm [file normalize $dir]}
    set entry [dict create path $norm name [file tail $norm] \
        last_opened [clock format [clock seconds] -format "%Y-%m-%d %H:%M:%S"] \
        pinned 0]
    set rest {}
    foreach e [recent_list] {
        set p [dict get $e path]
        catch {set p [file normalize $p]}
        if {$p eq $norm} {
            if {[dict get $e pinned]} { dict set entry pinned 1 }
            continue
        }
        lappend rest $e
    }
    _recent_write [linsert $rest 0 $entry]
    return $norm
}

proc ::nc::session::recent_remove {dir} {
    set norm $dir
    catch {set norm [file normalize $dir]}
    set rest {}
    foreach e [recent_list] {
        set p [dict get $e path]
        catch {set p [file normalize $p]}
        if {$p eq $norm} continue
        lappend rest $e
    }
    _recent_write $rest
}

# -----------------------------------------------------------------------------
# Public: session_summary
# Cheap facts about a session folder for the Session Manager list:
#   {name saved_at row_count has_images missing}
# row_count = data-line count of the component CSV (fallback: general CSV);
# plain line counting keeps the list snappy on network drives.
# -----------------------------------------------------------------------------

proc ::nc::session::session_summary {dir} {
    set name [file tail $dir]
    set saved_at ""
    set row_count ""
    set has_images 0
    set missing [expr {![_session_folder_exists $dir]}]
    if {!$missing} {
        catch {
            foreach row [::nc::csv::read_dicts [file join $dir manifest.csv]] {
                if {[dict exists $row key] && [dict get $row key] eq "saved_at"} {
                    set saved_at [dict get $row value]
                }
            }
        }
        foreach fname {matprop_component.csv matprop_general.csv} {
            set p [file join $dir edits $fname]
            if {![file exists $p]} continue
            catch {
                set fp [open $p r]
                fconfigure $fp -encoding utf-8
                set n 0
                while {[gets $fp line] >= 0} {
                    if {[string trim $line] ne ""} { incr n }
                }
                close $fp
                if {$n > 0} { set row_count [expr {$n - 1}] }
            }
            if {$row_count ne ""} { break }
        }
        set img_dir [file join $dir Component_Images]
        if {[file isdirectory $img_dir]} {
            foreach f [glob -nocomplain -directory $img_dir *] {
                if {![file isfile $f]} continue
                if {[string tolower [file extension $f]] in {.png .jpg .jpeg .bmp .gif}} {
                    set has_images 1
                    break
                }
            }
        }
    }
    return [dict create name $name saved_at $saved_at row_count $row_count \
        has_images $has_images missing $missing]
}

# -----------------------------------------------------------------------------
# Internal: path helpers
# -----------------------------------------------------------------------------

proc ::nc::session::_path {filename} {
    variable _dir
    if {$_dir eq ""} { error "session not initialised — call ::nc::session::init first" }
    return [file join $_dir $filename]
}

# -----------------------------------------------------------------------------
# Table-session CSV cache
# -----------------------------------------------------------------------------

proc ::nc::session::_active_or_dir {dir} {
    variable _dir
    if {$dir ne ""} { return [set_dir $dir] }
    if {$_dir eq ""} { error "session not initialised - call ::nc::session::init first" }
    return $_dir
}

proc ::nc::session::edits_dir {{dir ""}} {
    set root [_active_or_dir $dir]
    set edits [file join $root edits]
    _mkdir $edits
    return $edits
}

proc ::nc::session::_table_tabs {} {
    return {general component properties materials}
}

proc ::nc::session::_table_filename {tab} {
    switch -- $tab {
        general { return matprop_general.csv }
        component { return matprop_component.csv }
        properties { return matprop_properties.csv }
        materials { return matprop_materials.csv }
    }
    return "matprop_[_safe_name $tab].csv"
}

proc ::nc::session::table_session_files {{dir ""}} {
    set edits [edits_dir $dir]
    set out [dict create]
    foreach tab [_table_tabs] {
        dict set out $tab [file join $edits [_table_filename $tab]]
    }
    return $out
}

proc ::nc::session::_default_table_header {tab} {
    set meta {_dirty_fields _pending_fields _pending_values}
    switch -- $tab {
        general {
            return [concat {image_path hm_comp_name comp_user_name comp_id prop_name prop_user_name prop_id prop_card mat_user_name mat_id mass_total mass_total_raw note comp_name label mat_name material_label mat_card case_type} $meta]
        }
        component {
            return [concat {image_path comp_user_name comp_id prop_card prop_id mat_id mat_user_name mass_total mass_total_raw note label material_label case_type} $meta]
        }
        properties {
            return [concat {prop_card prop_id prop_name prop_user_name mat_card mat_id mat_name mat_user_name usage_count T NSM Z1 Z2 E G NU RHO A TREF ST SC SS K1 K2 K3 K4 K5 K6 B1 B2 B3 B4 B5 B6 GE1 GE2 GE3 GE4 GE5 GE6 M1 M2 M3 M4 M5 M6 note} $meta]
        }
        materials {
            return [concat {mat_card mat_id mat_user_name mat_name usage_count E G NU RHO A TREF GE ST SC SS note} $meta]
        }
    }
    return {}
}

proc ::nc::session::_table_headers_for_rows {tab rows {preferred_order {}}} {
    set header [expr {[llength $preferred_order] > 0 ? $preferred_order : [_default_table_header $tab]}]
    foreach row $rows {
        foreach key [dict keys $row] {
            if {[string match _* $key] && [lsearch -exact $header $key] < 0} { continue }
            if {[lsearch -exact $header $key] < 0} { lappend header $key }
        }
    }
    return $header
}

# header_order_by_tab: optional dict of tab -> preferred column order (e.g.
# the UI's current on-screen column order), used as the CSV header prefix
# instead of the hardcoded default order. Any field present in the row data
# but missing from that order (meta fields, hidden fields) is still appended
# automatically by _table_headers_for_rows, so this is purely a reordering,
# never a data-dropping operation.
proc ::nc::session::save_table_session {rows_by_tab {dir ""} {header_order_by_tab {}}} {
    set root [_active_or_dir $dir]
    _ensure_manifest_for_save $root
    set files [table_session_files $root]
    set saved 0
    foreach tab [_table_tabs] {
        set rows {}
        if {[dict exists $rows_by_tab $tab]} { set rows [dict get $rows_by_tab $tab] }
        set preferred {}
        if {[dict exists $header_order_by_tab $tab]} { set preferred [dict get $header_order_by_tab $tab] }
        set header [_table_headers_for_rows $tab $rows $preferred]
        set data {}
        foreach row $rows {
            set values {}
            foreach key $header {
                set value ""
                if {[dict exists $row $key]} { set value [dict get $row $key] }
                lappend values $value
            }
            lappend data $values
        }
        ::nc::csv::write_file [dict get $files $tab] $header $data
        incr saved
    }
    return [dict create dir $root files $files tabs $saved]
}

proc ::nc::session::load_table_session {{dir ""}} {
    set root [_active_or_dir $dir]
    set files [table_session_files $root]
    set rows_by_tab [dict create]
    foreach tab [_table_tabs] {
        set path [dict get $files $tab]
        set rows {}
        foreach row [::nc::csv::read_dicts $path] {
            if {![dict exists $row _dirty_fields]} { dict set row _dirty_fields {} }
            if {![dict exists $row _pending_fields]} { dict set row _pending_fields {} }
            if {![dict exists $row _pending_values]} { dict set row _pending_values {} }
            lappend rows $row
        }
        dict set rows_by_tab $tab $rows
    }
    return [dict create dir $root files $files rows_by_tab $rows_by_tab]
}

# -----------------------------------------------------------------------------
# Public: load_comps
# Returns a dict: comp_id -> dict{label comp_name_hm prop_id prop_type case}
# Returns {} if comps.csv doesn't exist yet.
# -----------------------------------------------------------------------------

proc ::nc::session::load_comps {} {
    set path [_path comps.csv]
    set result [dict create]
    foreach row [::nc::csv::read_dicts $path] {
        set cid [dict get $row comp_id]
        if {$cid eq ""} continue
        dict set result $cid $row
    }
    return $result
}

# -----------------------------------------------------------------------------
# Public: load_materials
# Returns a list of dicts from materials.csv.
# Each dict has keys: mat_id label type e nu rho note
# -----------------------------------------------------------------------------

proc ::nc::session::load_materials {} {
    return [::nc::csv::read_dicts [_path materials.csv]]
}

# -----------------------------------------------------------------------------
# Public: load_assignments
# Returns a dict: comp_id -> material_label
# -----------------------------------------------------------------------------

proc ::nc::session::load_assignments {} {
    set result [dict create]
    foreach row [::nc::csv::read_dicts [_path assignments.csv]] {
        set cid   [dict get $row comp_id]
        set label [dict get $row material_label]
        if {$cid eq ""} continue
        dict set result $cid $label
    }
    return $result
}

# -----------------------------------------------------------------------------
# Public: save_comps
# Writes comps.csv from the list of scan rows (augmented with label field).
# Creates or overwrites. Call after merge_labels + any label edits.
# -----------------------------------------------------------------------------

proc ::nc::session::save_comps {rows} {
    set header {comp_id comp_name_hm label prop_id prop_type case}
    set data {}
    foreach row $rows {
        set cid       [dict get $row comp_id]
        set hm_name   [dict get $row comp_name]
        set label     [expr {[dict exists $row label]    ? [dict get $row label]    : $hm_name}]
        set prop_id   [dict get $row prop_id]
        set prop_type [dict get $row prop_card]
        set case      [dict get $row case_type]
        lappend data [list $cid $hm_name $label $prop_id $prop_type $case]
    }
    ::nc::csv::write_file [_path comps.csv] $header $data
}

# -----------------------------------------------------------------------------
# Public: save_materials
# Writes materials.csv from a list of dicts.
# Expected dict keys: mat_id label type e nu rho note
# -----------------------------------------------------------------------------

proc ::nc::session::save_materials {mat_rows} {
    set header {mat_id label type e nu rho note}
    set data {}
    foreach row $mat_rows {
        set mat_id [expr {[dict exists $row mat_id] ? [dict get $row mat_id] : ""}]
        set label  [expr {[dict exists $row label]  ? [dict get $row label]  : ""}]
        set type   [expr {[dict exists $row type]   ? [dict get $row type]   : [expr {[dict exists $row mat_card] ? [dict get $row mat_card] : ""}]}]
        set e      [expr {[dict exists $row e]      ? [dict get $row e]      : ""}]
        set nu     [expr {[dict exists $row nu]     ? [dict get $row nu]     : ""}]
        set rho    [expr {[dict exists $row rho]    ? [dict get $row rho]    : ""}]
        set note   [expr {[dict exists $row note]   ? [dict get $row note]   : ""}]
        lappend data [list $mat_id $label $type $e $nu $rho $note]
    }
    ::nc::csv::write_file [_path materials.csv] $header $data
}

# -----------------------------------------------------------------------------
# Public: save_assignments
# Writes assignments.csv from a dict (comp_id -> material_label).
# -----------------------------------------------------------------------------

proc ::nc::session::save_assignments {assignments} {
    set header {comp_id material_label}
    set data {}
    dict for {cid label} $assignments {
        lappend data [list $cid $label]
    }
    ::nc::csv::write_file [_path assignments.csv] $header $data
}

# -----------------------------------------------------------------------------
# Public: append_audit
# Appends one row to audit.csv. Creates file with header if it doesn't exist.
# Usage:
#   append_audit APPLY $comp_id $comp_label $prop_id $mat_before $mat_after OK ""
#   append_audit APPLY $comp_id $comp_label $prop_id $mat_before $mat_after WARN "shared PBUSH: 2 comps"
# -----------------------------------------------------------------------------

proc ::nc::session::append_audit {action comp_id comp_label prop_id mat_before mat_after status {note ""}} {
    set path [_path audit.csv]
    set header {timestamp action comp_id comp_label prop_id mat_before mat_after status note}
    # Write header if file is new
    if {![file exists $path]} {
        ::nc::csv::write_file $path $header {}
    }
    set ts [clock format [clock seconds] -format "%Y-%m-%dT%H:%M:%S"]
    set fp [open $path a]
    fconfigure $fp -encoding utf-8
    ::nc::csv::puts_row $fp [list $ts $action $comp_id $comp_label $prop_id $mat_before $mat_after $status $note]
    close $fp
}

# -----------------------------------------------------------------------------
# Public: merge_labels
# Takes the list of row dicts from ::nc::scan::scan_model and overlays:
#   - label          (from comps.csv, falls back to comp_name if not saved)
#   - material_label (from assignments.csv, "" if not assigned)
# Returns the augmented list — scan rows are not modified in place.
# -----------------------------------------------------------------------------

proc ::nc::session::merge_labels {rows} {
    set saved_comps   [load_comps]
    set saved_asgn    [load_assignments]

    set result {}
    foreach row $rows {
        set cid [dict get $row comp_id]

        # Label: prefer saved, fall back to HM name
        set label [dict get $row comp_name]
        if {[dict exists $saved_comps $cid]} {
            set saved_label [dict get [dict get $saved_comps $cid] label]
            if {$saved_label ne ""} {
                set label $saved_label
            }
        }

        # Material label: from assignments.csv
        set material_label ""
        if {[dict exists $saved_asgn $cid]} {
            set material_label [dict get $saved_asgn $cid]
        }

        dict set row label          $label
        dict set row material_label $material_label
        lappend result $row
    }
    return $result
}
