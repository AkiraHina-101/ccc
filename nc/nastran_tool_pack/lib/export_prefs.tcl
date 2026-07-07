# =============================================================================
# export_prefs.tcl  —  ::nc::export_prefs
#
# App-wide (not per-session) preferences for which columns the XLSX "Export"
# feature writes per sheet, and in what order. Stored next to the tool
# install (::nc::config::tool_dir) so the same choice applies to the current
# session and every future one, until changed again via "Export Settings...".
#
# Storage format: simple key/value-ish CSV, one row per (sheet, column):
#   sheet,column_key,enabled,order_index
# Sheets: summary, general, component, properties, materials.
# Absence of the file (or of a sheet within it) means "use all columns, in
# their existing default order" — i.e. today's behavior is the default.
# =============================================================================

namespace eval ::nc::export_prefs {}

proc ::nc::export_prefs::_path {} {
    set dir ""
    catch {set dir $::nc::config::tool_dir}
    if {$dir eq ""} { set dir [pwd] }
    return [file join $dir nc_export_settings.csv]
}

# Returns a dict: sheet -> list of {key enabled} dicts, in saved order.
# Missing file / unreadable file -> empty dict (caller falls back to default).
proc ::nc::export_prefs::load {} {
    set path [_path]
    set out [dict create]
    if {![file exists $path]} { return $out }
    foreach row [::nc::csv::read_dicts $path] {
        set sheet ""
        set key ""
        catch {set sheet [dict get $row sheet]}
        catch {set key [dict get $row column_key]}
        if {$sheet eq "" || $key eq ""} continue
        set enabled 1
        catch {set enabled [dict get $row enabled]}
        set entry [dict create key $key enabled $enabled]
        if {[dict exists $out $sheet]} {
            dict lappend out $sheet $entry
        } else {
            dict set out $sheet [list $entry]
        }
    }
    return $out
}

# settings: dict sheet -> list of {key enabled} dicts, in the order to save.
proc ::nc::export_prefs::save {settings} {
    set header {sheet column_key enabled order_index}
    set data {}
    foreach sheet [dict keys $settings] {
        set idx 0
        foreach entry [dict get $settings $sheet] {
            set key [dict get $entry key]
            set enabled [dict get $entry enabled]
            lappend data [list $sheet $key $enabled $idx]
            incr idx
        }
    }
    ::nc::csv::write_file [_path] $header $data
}

# Applies a saved sheet's ordering/enable-list to a list of {key label} pairs
# (all_cols). Columns not mentioned in the saved settings are appended at the
# end, enabled, preserving all_cols' relative order — so a newly added column
# is never silently dropped just because it predates a saved settings file.
proc ::nc::export_prefs::apply {sheet all_cols} {
    variable _cache
    if {![info exists _cache]} { set _cache [load] }
    if {![dict exists $_cache $sheet]} { return $all_cols }
    set saved [dict get $_cache $sheet]
    set by_key [dict create]
    foreach pair $all_cols { dict set by_key [lindex $pair 0] $pair }
    set out {}
    set seen {}
    foreach entry $saved {
        set key [dict get $entry key]
        set enabled [dict get $entry enabled]
        if {!$enabled} { lappend seen $key; continue }
        if {[dict exists $by_key $key]} {
            lappend out [dict get $by_key $key]
            lappend seen $key
        }
    }
    foreach pair $all_cols {
        set key [lindex $pair 0]
        if {[lsearch -exact $seen $key] < 0} { lappend out $pair }
    }
    return $out
}

# Returns the FULL column list for sheet as {key label enabled} dicts, in
# saved order — unlike apply(), this includes disabled columns too, so a
# settings-editor UI can show and re-toggle them instead of losing them.
# Columns not present in the saved settings are appended, enabled, in their
# all_cols order (same "new column" fallback as apply()).
proc ::nc::export_prefs::state_for_sheet {sheet all_cols} {
    variable _cache
    if {![info exists _cache]} { set _cache [load] }
    set by_key [dict create]
    foreach pair $all_cols { dict set by_key [lindex $pair 0] $pair }
    set out {}
    set seen {}
    if {[dict exists $_cache $sheet]} {
        foreach entry [dict get $_cache $sheet] {
            set key [dict get $entry key]
            set enabled [dict get $entry enabled]
            if {[dict exists $by_key $key]} {
                set pair [dict get $by_key $key]
                lappend out [dict create key $key label [lindex $pair 1] enabled $enabled]
                lappend seen $key
            }
        }
    }
    foreach pair $all_cols {
        set key [lindex $pair 0]
        if {[lsearch -exact $seen $key] < 0} {
            lappend out [dict create key $key label [lindex $pair 1] enabled 1]
        }
    }
    return $out
}

proc ::nc::export_prefs::invalidate_cache {} {
    variable _cache
    unset -nocomplain _cache
}

# True if the user has ever saved settings for this sheet. Callers use this
# to decide between the saved layout and a code-side default column preset
# (the report sheets default to a curated subset instead of every column).
proc ::nc::export_prefs::has_sheet {sheet} {
    variable _cache
    if {![info exists _cache]} { set _cache [load] }
    return [dict exists $_cache $sheet]
}

# Like apply, but STRICT: returns only the columns explicitly saved as
# enabled, in saved order - no auto-append of columns missing from the saved
# layout. Used by the report sheets, where "customizable but exact" means the
# export contains precisely the chosen columns and nothing else.
proc ::nc::export_prefs::apply_strict {sheet all_cols} {
    variable _cache
    if {![info exists _cache]} { set _cache [load] }
    if {![dict exists $_cache $sheet]} { return $all_cols }
    set saved [dict get $_cache $sheet]
    set by_key [dict create]
    foreach pair $all_cols { dict set by_key [lindex $pair 0] $pair }
    set out {}
    foreach entry $saved {
        set key [dict get $entry key]
        if {![dict get $entry enabled]} { continue }
        if {[dict exists $by_key $key]} { lappend out [dict get $by_key $key] }
    }
    return $out
}
