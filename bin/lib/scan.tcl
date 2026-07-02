# =============================================================================
# scan.tcl  —  ::nc::scan
#
# Pure read module: scan HyperMesh model -> list-of-dicts for ui_table.tcl.
# No writes, no session state. Call scan_model {} to get the full component list.
#
# Public API:
#   ::nc::scan::ensure_template {}    -> 1 if template loaded, 0 if not
#   ::nc::scan::scan_model {}         -> list of row dicts (see schema below)
#   ::nc::scan::elem_count {cid}      -> element count for one component (lazy)
#
# Row dict schema:
#   comp_id    int     component ID
#   comp_name  string
#   prop_id    int     0 = Case 3 (no property)
#   prop_name  string
#   prop_card  string  PSHELL / PBUSH / ... or ""
#   mat_id     int     0 = no material
#   mat_name   string
#   mat_card   string  MAT1 / ... or ""
#   case_type  int     1=normal  2=shared-PBUSH  3=no-property
#   elem_count int     -1 = not yet fetched (call elem_count $cid lazily)
# =============================================================================

namespace eval ::nc::scan {
    variable _prop_cache   ;# array: prop_id -> dict{name card mat_id mat_name}
    variable _mat_cache    ;# array: mat_id  -> dict{name card}
    variable _prop_users   ;# array: prop_id -> list of comp_ids (for Case 2 detection)
}

# -----------------------------------------------------------------------------
# Public: ensure_template
# Load nastran/general solver template if not already loaded.
# Must be called before any hm_getcardimagename (card reads).
# Returns 1 if template is active, 0 if all candidates failed.
# -----------------------------------------------------------------------------

proc ::nc::scan::ensure_template {} {
    set t ""
    catch {set t [hm_info templatefilename]}
    if {$t ne "" && [file exists $t]} {
        return 1
    }
    set candidates {
        {C:/Program Files/Altair/2022/hwdesktop/templates/feoutput/nastran/general}
        {C:/Program Files/Altair/2022/hwdesktop/templates/feoutput/nastran/nastran}
        {C:/Program Files/Altair/2022/hwdesktop/templates/feoutput/optistruct/optistruct}
    }
    foreach candidate $candidates {
        if {[file exists $candidate]} {
            catch {*templatefileset $candidate}
            set t ""
            catch {set t [hm_info templatefilename]}
            if {$t ne ""} {
                return 1
            }
        }
    }
    return 0
}

# -----------------------------------------------------------------------------
# Public: scan_model
# Reads all components from the loaded HM model.
# Resets caches on each call — always returns fresh data.
# -----------------------------------------------------------------------------

proc ::nc::scan::scan_model {} {
    ensure_template

    array unset ::nc::scan::_prop_cache
    array unset ::nc::scan::_mat_cache
    array unset ::nc::scan::_prop_users

    set comp_ids [_list_all comps]
    if {[llength $comp_ids] == 0} {
        return {}
    }

    set rows {}
    foreach cid [lsort -integer $comp_ids] {
        lappend rows [_build_row $cid]
    }

    _detect_case2 rows

    return $rows
}

# -----------------------------------------------------------------------------
# Public: elem_count
# Lazy element count for one component. NOT called inside scan_model.
# Call from UI when the user requests count display.
# -----------------------------------------------------------------------------

proc ::nc::scan::elem_count {cid} {
    catch {*clearmark elems 1}
    set count 0
    if {![catch {*createmark elems 1 "by collector id" $cid}]} {
        catch {set count [hm_marklength elems 1]}
    }
    catch {*clearmark elems 1}
    return $count
}

# -----------------------------------------------------------------------------
# Private: _list_all
# Returns all IDs of an entity type via mark-all. Clears mark after.
# -----------------------------------------------------------------------------

proc ::nc::scan::_list_all {etype} {
    catch {*clearmark $etype 1}
    if {[catch {*createmark $etype 1 "all"}]} {
        return {}
    }
    set ids {}
    catch {set ids [hm_getmark $etype 1]}
    catch {*clearmark $etype 1}
    return $ids
}

# -----------------------------------------------------------------------------
# Private: _get_name
# Entity name with three-level fallback. Returns "" on all failures.
# -----------------------------------------------------------------------------

proc ::nc::scan::_get_name {etype id} {
    foreach script [list \
        [list hm_getvalue $etype id=$id dataname=name] \
        [list hm_getentityvalue $etype $id name 1] \
        [list hm_entityinfo name $etype $id]] {
        if {![catch $script value] && [string trim $value] ne ""} {
            return [string trim $value]
        }
    }
    return ""
}

# -----------------------------------------------------------------------------
# Private: _get_prop_id
# Property ID for a component. Returns 0 if no property (Case 3) or any error.
# Verified fallback sequence from API_VERIFIED.md.
# -----------------------------------------------------------------------------

proc ::nc::scan::_get_prop_id {cid} {
    foreach script [list \
        [list hm_getvalue comps id=$cid dataname=propertyid] \
        [list hm_getentityvalue comps +$cid property.id 0 -byid] \
        [list hm_getentityvalue comps $cid property.id 0]] {
        if {![catch $script value]} {
            set value [string trim $value]
            if {[string is integer -strict $value] && $value > 0} {
                return $value
            }
        }
    }
    return 0
}

# -----------------------------------------------------------------------------
# Private: _get_mat_id
# Material ID for a property. Returns 0 if none or any error.
# Verified fallback sequence from API_VERIFIED.md.
# -----------------------------------------------------------------------------

proc ::nc::scan::_get_mat_id {pid} {
    foreach script [list \
        [list hm_getentityvalue props +$pid material.id 0 -byid] \
        [list hm_getentityvalue props $pid material.id 0] \
        [list hm_getvalue props id=$pid dataname=materialid]] {
        if {![catch $script value]} {
            set value [string trim $value]
            if {[string is integer -strict $value] && $value > 0} {
                return $value
            }
        }
    }
    return 0
}

# -----------------------------------------------------------------------------
# Private: _get_card
# Card image name (PSHELL / MAT1 / ...) with fallback. Returns "" on failure.
# Requires template loaded — call ensure_template first.
# -----------------------------------------------------------------------------

proc ::nc::scan::_get_card {etype id} {
    foreach script [list \
        [list hm_getcardimagename $etype +$id -byid] \
        [list hm_getcardimagename $etype $id -byid]] {
        if {![catch $script value]} {
            set value [string trim $value]
            if {$value ne "" && $value ne "<None>"} {
                return $value
            }
        }
    }
    return ""
}

# -----------------------------------------------------------------------------
# Private: _read_prop
# Read and cache property fields. One HM query per unique prop_id.
# -----------------------------------------------------------------------------

proc ::nc::scan::_read_prop {pid} {
    variable _prop_cache
    if {[info exists _prop_cache($pid)]} {
        return $_prop_cache($pid)
    }
    set name   [_get_name props $pid]
    set card   [_get_card props $pid]
    set mat_id [_get_mat_id $pid]
    set mat_name ""
    if {$mat_id > 0} {
        foreach script [list \
            [list hm_getentityvalue props +$pid material.name 1 -byid] \
            [list hm_getentityvalue props $pid material.name 1]] {
            if {![catch $script value] && [string trim $value] ne ""} {
                set mat_name [string trim $value]
                break
            }
        }
    }
    set data [dict create name $name card $card mat_id $mat_id mat_name $mat_name]
    set _prop_cache($pid) $data
    return $data
}

# -----------------------------------------------------------------------------
# Private: _read_mat
# Read and cache material fields. One HM query per unique mat_id.
# -----------------------------------------------------------------------------

proc ::nc::scan::_read_mat {mid} {
    variable _mat_cache
    if {[info exists _mat_cache($mid)]} {
        return $_mat_cache($mid)
    }
    set name [_get_name mats $mid]
    set card [_get_card mats $mid]
    set data [dict create name $name card $card]
    set _mat_cache($mid) $data
    return $data
}

# -----------------------------------------------------------------------------
# Private: _build_row
# Assemble one row dict for a component. Errors are absorbed into the row.
# -----------------------------------------------------------------------------

proc ::nc::scan::_build_row {cid} {
    variable _prop_users

    set comp_name ""
    if {[catch {set comp_name [_get_name comps $cid]} err]} {
        set comp_name "ERROR:$err"
    }

    set prop_id 0
    catch {set prop_id [_get_prop_id $cid]}

    set prop_name "" ; set prop_card "" ; set mat_id 0 ; set mat_name "" ; set mat_card ""

    if {$prop_id > 0} {
        lappend _prop_users($prop_id) $cid

        if {[catch {set prop_data [_read_prop $prop_id]}]} {
            set prop_data [dict create name "" card "" mat_id 0 mat_name ""]
        }
        set prop_name [dict get $prop_data name]
        set prop_card [dict get $prop_data card]
        set mat_id    [dict get $prop_data mat_id]
        set mat_name  [dict get $prop_data mat_name]

        if {$mat_id > 0} {
            if {[catch {set mat_data [_read_mat $mat_id]}]} {
                set mat_data [dict create name $mat_name card ""]
            }
            if {$mat_name eq ""} {
                set mat_name [dict get $mat_data name]
            }
            set mat_card [dict get $mat_data card]
        }
    }

    set case_type [expr {$prop_id == 0 ? 3 : 1}]

    return [dict create \
        comp_id    $cid \
        comp_name  $comp_name \
        prop_id    $prop_id \
        prop_name  $prop_name \
        prop_card  $prop_card \
        mat_id     $mat_id \
        mat_name   $mat_name \
        mat_card   $mat_card \
        case_type  $case_type \
        elem_count -1]
}

# -----------------------------------------------------------------------------
# Private: _detect_case2
# Post-pass: tag components whose property is a PBUSH shared by >1 component.
# Mutates the rows list in place via lset.
# -----------------------------------------------------------------------------

proc ::nc::scan::_detect_case2 {rows_var} {
    upvar 1 $rows_var rows
    variable _prop_users
    variable _prop_cache

    # Build index: comp_id -> position in rows list
    set idx 0
    array set row_index {}
    foreach row $rows {
        set row_index([dict get $row comp_id]) $idx
        incr idx
    }

    foreach pid [array names _prop_users] {
        if {[llength $_prop_users($pid)] < 2} continue
        set card ""
        if {[info exists _prop_cache($pid)]} {
            set card [dict get $_prop_cache($pid) card]
        }
        if {$card ne "PBUSH"} continue
        foreach cid $_prop_users($pid) {
            if {![info exists row_index($cid)]} continue
            set i $row_index($cid)
            set row [lindex $rows $i]
            dict set row case_type 2
            lset rows $i $row
        }
    }
    array unset row_index
}
