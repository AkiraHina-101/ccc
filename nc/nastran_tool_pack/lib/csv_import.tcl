# =============================================================================
# csv_import.tcl  —  ::nc::csv_import
#
# CSV import for the Nastran Control Tool (Phase 7).
# Reads an exported table CSV back and updates labels + assignments in session.
#
# Expected import CSV format (matches Export CSV output from ui_table):
#   Comp Label, ID, Prop Type, Mat Label, Mat ID
#
# Rules:
#   - Match rows by Comp ID (column "ID") — comp IDs are stable.
#   - Update label if "Comp Label" cell is non-empty and different.
#   - Update material assignment if "Mat Label" cell is non-empty.
#   - Rows in CSV with unknown Comp IDs are silently skipped.
#   - Rows in current model not present in CSV keep their existing state.
#
# Public API:
#   ::nc::csv_import::import_table_csv {path current_rows}
#       -> dict{status ok|warn|error  message  updated_rows  label_changes  asgn_changes}
#
#   ::nc::csv_import::import_materials_csv {path}
#       -> dict{status ok|error  message  mat_rows}
# =============================================================================

namespace eval ::nc::csv_import {}

# -----------------------------------------------------------------------------
# Public: import_table_csv
#
# $path         : path to the CSV file (exported from ui_table or hand-edited)
# $current_rows : list of row dicts from current scan + merge_labels
#
# Returns dict:
#   status        ok | warn | error
#   message       human-readable summary
#   updated_rows  $current_rows with label and material_label fields patched
#   label_changes integer count
#   asgn_changes  integer count
# -----------------------------------------------------------------------------

proc ::nc::csv_import::import_table_csv {path current_rows} {
    if {![file exists $path]} {
        return [dict create status error \
            message "File not found: $path" \
            updated_rows $current_rows \
            label_changes 0 asgn_changes 0]
    }

    # Read CSV — first row is header
    set raw_rows [::nc::csv::read_dicts $path]
    if {[llength $raw_rows] == 0} {
        return [dict create status warn \
            message "CSV has no data rows." \
            updated_rows $current_rows \
            label_changes 0 asgn_changes 0]
    }

    # Normalise header keys: strip spaces, lower
    set normalised {}
    foreach row $raw_rows {
        set d [dict create]
        dict for {k v} $row {
            dict set d [string tolower [string trim $k]] $v
        }
        lappend normalised $d
    }

    # Build lookup: csv_comp_id -> csv_row
    set csv_by_cid [dict create]
    foreach row $normalised {
        set cid ""
        # Accept "id", "comp id", "comp_id" as the ID column
        foreach key {id {comp id} comp_id} {
            if {[dict exists $row $key]} { set cid [string trim [dict get $row $key]]; break }
        }
        if {$cid ne "" && [string is integer -strict $cid]} {
            dict set csv_by_cid $cid $row
        }
    }

    if {[dict size $csv_by_cid] == 0} {
        return [dict create status warn \
            message "CSV has no valid Comp ID column (expected \"ID\" or \"comp_id\")." \
            updated_rows $current_rows \
            label_changes 0 asgn_changes 0]
    }

    # Patch current_rows
    set updated {}
    set label_changes 0
    set asgn_changes  0
    set skipped 0

    foreach row $current_rows {
        set cid [dict get $row comp_id]
        if {![dict exists $csv_by_cid $cid]} {
            lappend updated $row
            incr skipped
            continue
        }
        set csv_row [dict get $csv_by_cid $cid]

        # Comp Label — key "comp label" or "label"
        set new_label ""
        foreach key {{comp label} label} {
            if {[dict exists $csv_row $key]} {
                set new_label [string trim [dict get $csv_row $key]]
                break
            }
        }
        if {$new_label ne "" && $new_label ne [dict get $row label]} {
            dict set row label $new_label
            incr label_changes
        }

        # Mat Label — key "mat label" or "material_label"
        set new_mat_label ""
        foreach key {{mat label} material_label {mat_label}} {
            if {[dict exists $csv_row $key]} {
                set new_mat_label [string trim [dict get $csv_row $key]]
                break
            }
        }
        # Only update if non-empty and different; don't overwrite with blank
        if {$new_mat_label ne "" && $new_mat_label ne [dict get $row material_label]} {
            # Only for Case 1 or Case 2 (Case 3 has no property)
            if {[dict get $row case_type] != 3} {
                dict set row material_label $new_mat_label
                incr asgn_changes
            }
        }

        lappend updated $row
    }

    set total [expr {$label_changes + $asgn_changes}]
    if {$total == 0} {
        set status warn
        set msg "Import complete — no changes detected ($skipped rows not in CSV)."
    } else {
        set status ok
        set msg "Imported: $label_changes label(s) updated, $asgn_changes assignment(s) updated."
        if {$skipped > 0} { append msg " ($skipped rows not in CSV kept unchanged.)" }
    }

    return [dict create \
        status        $status \
        message       $msg \
        updated_rows  $updated \
        label_changes $label_changes \
        asgn_changes  $asgn_changes]
}

# -----------------------------------------------------------------------------
# Public: import_materials_csv
#
# $path: path to a materials CSV with columns: mat_id, label, type, e, nu, rho, note
# Returns dict: status ok|error, message, mat_rows (list of dicts)
# -----------------------------------------------------------------------------

proc ::nc::csv_import::import_materials_csv {path} {
    if {![file exists $path]} {
        return [dict create status error message "File not found: $path" mat_rows {}]
    }

    set raw [::nc::csv::read_dicts $path]
    if {[llength $raw] == 0} {
        return [dict create status warn message "CSV has no data rows." mat_rows {}]
    }

    # Normalise keys
    set mat_rows {}
    set skipped 0
    foreach row $raw {
        set d [dict create]
        dict for {k v} $row {
            dict set d [string tolower [string trim $k]] [string trim $v]
        }
        # mat_id is required
        set mid ""
        foreach key {mat_id {mat id} id} {
            if {[dict exists $d $key]} { set mid [dict get $d $key]; break }
        }
        if {$mid eq "" || ![string is integer -strict $mid]} {
            incr skipped
            continue
        }
        # Normalise the dict to expected keys
        set out [dict create \
            mat_id $mid \
            label  [expr {[dict exists $d label]  ? [dict get $d label]  : ""}] \
            type   [expr {[dict exists $d type]   ? [dict get $d type]   : ""}] \
            e      [expr {[dict exists $d e]      ? [dict get $d e]      : ""}] \
            nu     [expr {[dict exists $d nu]     ? [dict get $d nu]     : ""}] \
            rho    [expr {[dict exists $d rho]    ? [dict get $d rho]    : ""}] \
            note   [expr {[dict exists $d note]   ? [dict get $d note]   : ""}] \
        ]
        lappend mat_rows $out
    }

    set n [llength $mat_rows]
    if {$n == 0} {
        return [dict create status warn message "No valid material rows found." mat_rows {}]
    }
    set msg "Imported $n material(s)."
    if {$skipped > 0} { append msg " ($skipped rows skipped — missing mat_id.)" }

    return [dict create status ok message $msg mat_rows $mat_rows]
}
