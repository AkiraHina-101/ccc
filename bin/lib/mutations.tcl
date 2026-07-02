# =============================================================================
# mutations.tcl  —  ::nc::mutations
#
# HyperMesh model mutations for the Nastran Control Tool.
# Covers: assign material to component, rename component label.
# Each mutation is logged to the in-memory log and to session audit.csv.
#
# Depends on: lib/labels.tcl, lib/session.tcl
# HM API used: *renamecollector, *createmark, *materialupdate, *clearmark
#   (all verified in docs/API_VERIFIED.md)
#
# Public API:
#   ::nc::mutations::assign_material {comp_rows sel_cids mat_label all_rows}
#       -> dict{status ok|warn|error  message  updated_rows}
#   ::nc::mutations::rename_comp {cid new_label rows}
#       -> dict{status ok|error  message  updated_rows}
#   ::nc::mutations::apply_component_hm_changes {actions}
#       -> dict{status ok|warn|error message results}
#   ::nc::mutations::set_log_widget {widget}
#   ::nc::mutations::log_add {message}
#   ::nc::mutations::log_clear {}
# =============================================================================

namespace eval ::nc::mutations {
    variable _log_widget ""   ;# text widget path (registered by ui_table)
    variable _log_lines  {}   ;# in-memory log lines
}

# =============================================================================
# Log
# =============================================================================

proc ::nc::mutations::set_log_widget {w} {
    variable _log_widget
    set _log_widget $w
}

proc ::nc::mutations::log_add {message} {
    variable _log_widget
    variable _log_lines

    set ts [clock format [clock seconds] -format "%H:%M:%S"]
    set line "\[$ts\] $message"
    lappend _log_lines $line

    if {$_log_widget ne "" && [winfo exists $_log_widget]} {
        catch {
            $_log_widget configure -state normal
            $_log_widget insert end "$line\n"
            $_log_widget see end
            $_log_widget configure -state disabled
        }
    }
}

proc ::nc::mutations::log_clear {} {
    variable _log_widget
    variable _log_lines

    set _log_lines {}
    if {$_log_widget ne "" && [winfo exists $_log_widget]} {
        catch {
            $_log_widget configure -state normal
            $_log_widget delete 1.0 end
            $_log_widget configure -state disabled
        }
    }
}

# =============================================================================
# Assign material
# =============================================================================

# -----------------------------------------------------------------------------
# Public: assign_material
#
# Assigns $mat_label to all components in $sel_cids (list of comp IDs).
# $comp_rows: the full current rows list (for case_type, prop_id etc.)
# $mat_rows:  list of mat dicts from session::load_materials
#             each dict has keys: mat_id, label, type, ...
#             mat_id is the HM material ID; we need the HM name for *materialupdate.
#
# Returns dict: status (ok|warn|error), message, updated_rows (same as comp_rows
# but with material_label field updated for assigned comps).
# -----------------------------------------------------------------------------

proc ::nc::mutations::assign_material {comp_rows sel_cids mat_label mat_rows} {
    if {[llength $sel_cids] == 0} {
        return [dict create status error message "No components selected." updated_rows $comp_rows]
    }
    if {$mat_label eq ""} {
        return [dict create status error message "No material label selected." updated_rows $comp_rows]
    }

    # Find the material dict matching the label
    set mat_row [_find_mat_by_label $mat_label $mat_rows]
    if {[llength $mat_row] == 0} {
        return [dict create status error \
            message "Material label '$mat_label' not found in session materials." \
            updated_rows $comp_rows]
    }

    set mat_id   [dict get $mat_row mat_id]
    set hm_name  [_get_hm_mat_name $mat_id]
    if {$hm_name eq ""} {
        return [dict create status error \
            message "Material ID $mat_id not found in HM model." \
            updated_rows $comp_rows]
    }
    lassign [_verify_hm_material_name_unique $mat_id $hm_name] name_status name_msg
    if {$name_status ne "ok"} {
        return [dict create status error message $name_msg updated_rows $comp_rows]
    }

    # Index rows by comp_id for fast lookup
    set row_by_cid [dict create]
    foreach r $comp_rows {
        dict set row_by_cid [dict get $r comp_id] $r
    }

    set ok_list    {}
    set warn_list  {}
    set err_list   {}
    set updated_rows $comp_rows

    foreach cid $sel_cids {
        if {![dict exists $row_by_cid $cid]} continue
        set row [dict get $row_by_cid $cid]

        set ct [dict get $row case_type]
        if {$ct == 3} {
            lappend err_list "comp $cid (Case 3, no property)"
            log_add "SKIP  [_row_label $row] — no property (Case 3)"
            continue
        }

        set prop_id [dict get $row prop_id]

        # Case 2: shared PBUSH — warn but proceed
        set warn_msg ""
        if {$ct == 2} {
            set shared_count [_count_sharing_comps $comp_rows $prop_id]
            set warn_msg "shared prop#$prop_id affects $shared_count comps"
        }

        set result [_assign_hm $prop_id $hm_name]
        lassign $result hm_status hm_err

        if {$hm_status eq "ok"} {
            # Update in-memory row
            set updated_rows [_update_row_mat $updated_rows $cid $mat_label $mat_id]

            # Audit
            set comp_label [_row_label $row]
            set mat_before [dict get $row mat_name]
            set audit_status [expr {$warn_msg ne "" ? "WARN" : "OK"}]
            catch {
                ::nc::session::append_audit APPLY $cid $comp_label $prop_id \
                    $mat_before $mat_label $audit_status $warn_msg
            }

            if {$warn_msg ne ""} {
                lappend warn_list $cid
                log_add "WARN  [_row_label $row] -> $mat_label  ($warn_msg)"
            } else {
                lappend ok_list $cid
                log_add "OK    [_row_label $row] -> $mat_label"
            }
        } else {
            lappend err_list "comp $cid: $hm_err"
            log_add "ERR   [_row_label $row] -> $mat_label  FAILED: $hm_err"
            catch {
                ::nc::session::append_audit APPLY [dict get $row comp_id] \
                    [_row_label $row] $prop_id [dict get $row mat_name] \
                    $mat_label FAIL $hm_err
            }
        }
    }

    # Build summary
    set n_ok   [llength $ok_list]
    set n_warn [llength $warn_list]
    set n_err  [llength $err_list]
    set total  [expr {$n_ok + $n_warn + $n_err}]

    if {$n_err == $total} {
        set status error
        set msg "All $n_err assignment(s) failed."
    } elseif {$n_err > 0 || $n_warn > 0} {
        set status warn
        set msg "Assigned $n_ok OK, $n_warn WARN, $n_err failed."
    } else {
        set status ok
        set msg "Assigned $n_ok component(s) to '$mat_label'."
    }

    return [dict create status $status message $msg updated_rows $updated_rows]
}

# =============================================================================
# Rename component label
# =============================================================================

# -----------------------------------------------------------------------------
# Public: rename_comp
#
# Renames the HM component name and updates the label in rows.
# $cid: component ID to rename
# $new_label: new label string
# $rows: current rows list
#
# Returns dict: status (ok|error), message, updated_rows
# -----------------------------------------------------------------------------

proc ::nc::mutations::rename_comp {cid new_label rows} {
    # Find the row
    set row [dict create]
    foreach r $rows {
        if {[dict get $r comp_id] == $cid} { set row $r; break }
    }
    if {[dict size $row] == 0} {
        return [dict create status error \
            message "Component $cid not found." \
            updated_rows $rows]
    }

    set old_hm_name [dict get $row comp_name]
    set new_label   [::nc::labels::sanitise $new_label]

    if {$new_label eq ""} {
        return [dict create status error message "Label cannot be blank." updated_rows $rows]
    }

    lassign [::nc::labels::rename_comp_in_hm $old_hm_name $new_label] hm_status hm_err
    if {$hm_status eq "error"} {
        log_add "ERR   rename comp $cid: $hm_err"
        return [dict create status error message $hm_err updated_rows $rows]
    }

    # Update rows: both comp_name (HM name changed) and label
    set updated [dict create]
    set result {}
    foreach r $rows {
        if {[dict get $r comp_id] == $cid} {
            dict set r comp_name $new_label
            dict set r label     $new_label
        }
        lappend result $r
    }

    log_add "OK    rename [dict get $row label] -> $new_label"
    return [dict create status ok \
        message "Renamed to '$new_label'." \
        updated_rows $result]
}

# =============================================================================
# Apply verified preview changes to HM
# =============================================================================

proc ::nc::mutations::apply_component_hm_changes {actions} {
    set preflight_results {}
    set preflight_fail 0
    foreach action $actions {
        set result [_preflight_action $action]
        if {[dict get $result status] ne "ok"} { incr preflight_fail }
        lappend preflight_results $result
    }
    if {$preflight_fail > 0} {
        return [dict create status error message "HM apply blocked: $preflight_fail preflight check(s) failed; no model command was executed." results $preflight_results]
    }

    set ok 0
    set warn 0
    set fail 0
    set results {}
    foreach action $actions {
        set type [dict get $action type]
        switch -- $type {
            rename_comp {
                set result [_apply_rename_action $action]
            }
            assign_material {
                set result [_apply_assign_action $action]
            }
            default {
                set result [dict create status warn message "Unsupported HM action '$type'." action $action]
            }
        }
        lappend results $result
        switch -- [dict get $result status] {
            ok { incr ok }
            warn { incr warn }
            default { incr fail }
        }
    }
    set total [llength $actions]
    if {$total == 0} {
        return [dict create status warn message "No verified HM actions to apply." results $results]
    }
    if {$fail == $total} {
        set status error
    } elseif {$fail > 0 || $warn > 0} {
        set status warn
    } else {
        set status ok
    }
    return [dict create status $status message "HM apply: $ok OK, $warn WARN, $fail FAIL." results $results]
}

proc ::nc::mutations::_apply_rename_action {action} {
    set cid [dict get $action comp_id]
    set old_name [dict get $action old_name]
    set new_name [dict get $action new_name]
    catch {::nc::session::append_audit HM_RENAME $cid $old_name [_dict_get_action $action prop_id ""] "" $new_name START "rename component"}
    set live_name [_get_live_comp_name $cid]
    if {$live_name eq "" || $live_name ne $old_name} {
        set msg "Preflight mismatch for comp $cid: expected name '$old_name', live name '$live_name'. Rescan before apply."
        log_add "HM FAIL rename comp $cid: $msg"
        catch {::nc::session::append_audit HM_RENAME $cid $old_name [_dict_get_action $action prop_id ""] $old_name $new_name FAIL $msg}
        return [dict create status error message $msg action $action]
    }
    lassign [::nc::labels::rename_comp_in_hm $old_name $new_name] hm_status hm_err
    if {$hm_status eq "ok"} {
        set verified [_get_live_comp_name $cid]
        if {$verified ne "" && $verified ne $new_name} {
            set msg "Post-verify failed for comp $cid rename: live name is '$verified', expected '$new_name'."
            log_add "HM FAIL rename comp $cid: $msg"
            catch {::nc::session::append_audit HM_RENAME $cid $old_name [_dict_get_action $action prop_id ""] $old_name $new_name FAIL $msg}
            return [dict create status error message $msg action $action]
        }
        log_add "HM OK rename comp $cid: $old_name -> $new_name"
        catch {::nc::session::append_audit HM_RENAME $cid $old_name [_dict_get_action $action prop_id ""] $old_name $new_name OK ""}
        return [dict create status ok message "Renamed comp $cid." action $action]
    }
    log_add "HM FAIL rename comp $cid: $hm_err"
    catch {::nc::session::append_audit HM_RENAME $cid $old_name [_dict_get_action $action prop_id ""] $old_name $new_name FAIL $hm_err}
    return [dict create status error message $hm_err action $action]
}

proc ::nc::mutations::_apply_assign_action {action} {
    set cid [dict get $action comp_id]
    set prop_id [dict get $action prop_id]
    set mat_id [dict get $action mat_id]
    set label [_dict_get_action $action mat_label $mat_id]
    catch {::nc::session::append_audit HM_ASSIGN $cid [_dict_get_action $action comp_label ""] $prop_id "" $label START "assign material"}
    set expected_old [_dict_get_action $action old_mat_id ""]
    if {$expected_old ne ""} {
        set live_old [_get_live_prop_mat_id $prop_id]
        if {$live_old eq "" || ![_entity_id_equal $live_old $expected_old]} {
            set msg "Preflight mismatch for property $prop_id: expected material ID '$expected_old', live material ID '$live_old'. Rescan before apply."
            log_add "HM FAIL assign comp $cid prop $prop_id: $msg"
            catch {::nc::session::append_audit HM_ASSIGN $cid [_dict_get_action $action comp_label ""] $prop_id $expected_old $label FAIL $msg}
            return [dict create status error message $msg action $action]
        }
    }
    set hm_name [_get_hm_mat_name $mat_id]
    if {$hm_name eq ""} {
        set msg "Material ID $mat_id not found in HM model."
        log_add "HM FAIL assign comp $cid prop $prop_id: $msg"
        catch {::nc::session::append_audit HM_ASSIGN $cid [_dict_get_action $action comp_label ""] $prop_id "" $label FAIL $msg}
        return [dict create status error message $msg action $action]
    }
    lassign [_verify_hm_material_name_unique $mat_id $hm_name] name_status name_msg
    if {$name_status ne "ok"} {
        log_add "HM FAIL assign comp $cid prop $prop_id: $name_msg"
        catch {::nc::session::append_audit HM_ASSIGN $cid [_dict_get_action $action comp_label ""] $prop_id "" $label FAIL $name_msg}
        return [dict create status error message $name_msg action $action]
    }
    lassign [_assign_hm $prop_id $hm_name] hm_status hm_err
    if {$hm_status eq "ok"} {
        set live_new [_get_live_prop_mat_id $prop_id]
        if {$live_new ne "" && ![_entity_id_equal $live_new $mat_id]} {
            set msg "Post-verify failed for property $prop_id: live material ID is '$live_new', expected '$mat_id'."
            log_add "HM FAIL assign comp $cid prop $prop_id: $msg"
            catch {::nc::session::append_audit HM_ASSIGN $cid [_dict_get_action $action comp_label ""] $prop_id "" $label FAIL $msg}
            return [dict create status error message $msg action $action]
        }
        log_add "HM OK assign comp $cid prop $prop_id -> $hm_name"
        catch {::nc::session::append_audit HM_ASSIGN $cid [_dict_get_action $action comp_label ""] $prop_id "" $label OK ""}
        return [dict create status ok message "Assigned comp $cid property $prop_id to material $hm_name." action $action]
    }
    log_add "HM FAIL assign comp $cid prop $prop_id: $hm_err"
    catch {::nc::session::append_audit HM_ASSIGN $cid [_dict_get_action $action comp_label ""] $prop_id "" $label FAIL $hm_err}
    return [dict create status error message $hm_err action $action]
}

# =============================================================================
# Private helpers
# =============================================================================

proc ::nc::mutations::_find_mat_by_label {label mat_rows} {
    foreach row $mat_rows {
        if {[dict exists $row label] && [dict get $row label] eq $label} {
            return $row
        }
    }
    return {}
}

proc ::nc::mutations::_dict_get_action {action key {default ""}} {
    if {[dict exists $action $key]} { return [dict get $action $key] }
    return $default
}

proc ::nc::mutations::_preflight_action {action} {
    set type [dict get $action type]
    switch -- $type {
        rename_comp {
            set cid [dict get $action comp_id]
            set old_name [dict get $action old_name]
            set live_name [_get_live_comp_name $cid]
            if {$live_name eq "" || $live_name ne $old_name} {
                return [dict create status error message "Preflight mismatch for comp $cid: expected name '$old_name', live name '$live_name'." action $action]
            }
        }
        assign_material {
            set prop_id [dict get $action prop_id]
            set mat_id [dict get $action mat_id]
            set old_mat_id [_dict_get_action $action old_mat_id ""]
            set hm_name [_get_hm_mat_name $mat_id]
            if {$hm_name eq ""} {
                return [dict create status error message "Preflight failed: material ID $mat_id not found in HM model." action $action]
            }
            lassign [_verify_hm_material_name_unique $mat_id $hm_name] name_status name_msg
            if {$name_status ne "ok"} {
                return [dict create status error message $name_msg action $action]
            }
            if {$old_mat_id ne ""} {
                set live_mat_id [_get_live_prop_mat_id $prop_id]
                if {$live_mat_id eq "" || ![_entity_id_equal $live_mat_id $old_mat_id]} {
                    return [dict create status error message "Preflight mismatch for property $prop_id: expected material ID '$old_mat_id', live material ID '$live_mat_id'." action $action]
                }
            }
        }
        default {
            return [dict create status error message "Unsupported HM action '$type'." action $action]
        }
    }
    return [dict create status ok message "Preflight OK." action $action]
}

proc ::nc::mutations::_get_live_comp_name {comp_id} {
    set name ""
    catch {set name [hm_getvalue comps id=$comp_id dataname=name]}
    if {$name eq ""} {
        catch {set name [hm_getentityvalue comps $comp_id name 1]}
    }
    return [string trim $name]
}

proc ::nc::mutations::_entity_id_equal {a b} {
    set a [string trim $a]
    set b [string trim $b]
    if {$a eq $b} { return 1 }
    if {[string is double -strict $a] && [string is double -strict $b]} {
        return [expr {double($a) == double($b)}]
    }
    return 0
}

proc ::nc::mutations::_get_live_prop_mat_id {prop_id} {
    set mat_id ""
    catch {set mat_id [hm_getvalue props id=$prop_id dataname=materialid]}
    if {$mat_id eq ""} {
        catch {set mat_id [hm_getvalue props id=$prop_id dataname=material.id]}
    }
    if {$mat_id eq ""} {
        catch {set mat_id [hm_getentityvalue props $prop_id materialid 1]}
    }
    if {$mat_id eq ""} {
        catch {set mat_id [hm_getentityvalue props $prop_id material.id 1]}
    }
    return [string trim $mat_id]
}

proc ::nc::mutations::_get_hm_mat_name {mat_id} {
    set name ""
    catch {set name [hm_getvalue mats id=$mat_id dataname=name]}
    if {$name eq ""} {
        catch {set name [hm_getentityvalue mats $mat_id name 1]}
    }
    return [string trim $name]
}

proc ::nc::mutations::_get_hm_mat_ids_by_name {mat_name} {
    set ids {}
    if {$mat_name eq ""} { return $ids }
    catch {
        *clearmark mats 1
        *createmark mats 1 "$mat_name"
        set ids [hm_getmark mats 1]
        *clearmark mats 1
    }
    if {[llength $ids] == 0} {
        catch {
            *clearmark mats 1
            *createmark mats 1 "by name" "$mat_name"
            set ids [hm_getmark mats 1]
            *clearmark mats 1
        }
    }
    catch {*clearmark mats 1}
    return $ids
}

proc ::nc::mutations::_verify_hm_material_name_unique {mat_id mat_name} {
    set ids [_get_hm_mat_ids_by_name $mat_name]
    if {[llength $ids] == 0} {
        return [list ok ""]
    }
    set matches 0
    foreach id $ids {
        if {[_entity_id_equal $id $mat_id]} { incr matches }
    }
    if {$matches == 0} {
        return [list error "Material name '$mat_name' resolves to HM material ID(s) [join $ids {, }], not target ID $mat_id."]
    }
    if {[llength $ids] > 1} {
        return [list error "Material name '$mat_name' is ambiguous in HM material ID(s) [join $ids {, }]; name-based material update is blocked."]
    }
    return [list ok ""]
}

proc ::nc::mutations::_assign_hm {prop_id mat_hm_name} {
    set rc [catch {
        *clearmark props 1
        *createmark props 1 "by id only" $prop_id
        *materialupdate props 1 "$mat_hm_name"
        *clearmark props 1
    } err]
    if {$rc} {
        catch {*clearmark props 1}
        return [list error $err]
    }
    return [list ok ""]
}

proc ::nc::mutations::_row_label {row} {
    if {[dict exists $row label] && [dict get $row label] ne ""} {
        return [dict get $row label]
    }
    return [dict get $row comp_name]
}

proc ::nc::mutations::_count_sharing_comps {rows prop_id} {
    set count 0
    foreach r $rows {
        if {[dict get $r prop_id] == $prop_id} { incr count }
    }
    return $count
}

proc ::nc::mutations::_update_row_mat {rows cid mat_label mat_id} {
    set result {}
    foreach r $rows {
        if {[dict get $r comp_id] == $cid} {
            dict set r material_label $mat_label
            dict set r mat_id        $mat_id
        }
        lappend result $r
    }
    return $result
}
