# =============================================================================
# labels.tcl  —  ::nc::labels
#
# Label management for the Nastran Control Tool.
#
# Comp labels are written back to HyperMesh component names (safe: Nastran
# export ignores component names). Material labels live in session only.
#
# Public API:
#   ::nc::labels::sanitise {label}                      -> cleaned string
#   ::nc::labels::rename_comp_in_hm {old_name new_name} -> {ok msg} | {error msg}
#   ::nc::labels::apply_label_to_row {row new_label}    -> updated row dict
#   ::nc::labels::update_rows_label {rows cid label}    -> updated rows list
# =============================================================================

namespace eval ::nc::labels {}

# -----------------------------------------------------------------------------
# Public: sanitise
# Trims whitespace; replaces characters that break *renamecollector or CSV.
# HM component names can contain most printable chars, but we forbid
# double-quotes and commas (CSV delimiters) for safety.
# -----------------------------------------------------------------------------

proc ::nc::labels::sanitise {label} {
    set label [string trim $label]
    # Replace double-quotes and commas
    set label [string map [list "\"" "'" "," "_"] $label]
    return $label
}

# -----------------------------------------------------------------------------
# Public: rename_comp_in_hm
# Renames the HyperMesh component with name $old_name to $new_name.
# Uses verified API: *renamecollector comps $old_name $new_name
# Returns a list: {ok ""} on success, {error message} on failure.
# No-op if old_name == new_name.
# -----------------------------------------------------------------------------

proc ::nc::labels::rename_comp_in_hm {old_name new_name} {
    set new_name [sanitise $new_name]
    if {$new_name eq ""} {
        return [list error "Label cannot be blank"]
    }
    if {$old_name eq $new_name} {
        return [list ok ""]
    }
    set rc [catch {*renamecollector comps $old_name $new_name} err]
    if {$rc} {
        return [list error "Rename failed: $err"]
    }
    return [list ok ""]
}

# -----------------------------------------------------------------------------
# Public: apply_label_to_row
# Returns a copy of $row with the label field updated.
# Does NOT write to HM — call rename_comp_in_hm separately.
# -----------------------------------------------------------------------------

proc ::nc::labels::apply_label_to_row {row new_label} {
    dict set row label [sanitise $new_label]
    return $row
}

# -----------------------------------------------------------------------------
# Public: update_rows_label
# Returns the rows list with the label field updated for comp $cid.
# -----------------------------------------------------------------------------

proc ::nc::labels::update_rows_label {rows cid new_label} {
    set new_label [sanitise $new_label]
    set result {}
    foreach row $rows {
        if {[dict get $row comp_id] == $cid} {
            dict set row label $new_label
        }
        lappend result $row
    }
    return $result
}
