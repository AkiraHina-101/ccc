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
    # Per-dir memo of {mtime dict source_path} for _manifest_dict, so
    # trust/save/summary paths that read the same manifest back-to-back
    # don't each spawn their own Python subprocess. Invalidated by mtime
    # mismatch on next read (auto) OR by explicit call after
    # _write_manifest_values. Never grows unbounded - one entry per dir
    # ever inspected during this session.
    array set _manifest_cache {}
    # Per-dir memo of {mtime {comp prop mat}} for combined-file row
    # counts. Session Manager list rendered 2 Python subprocesses per
    # recent session before this cache landed (~0.5s each × N sessions
    # in the list); cached hits are instant.
    array set _combined_counts_cache {}
    # Per-xlsx memo of {mtime raw_rows} used by the batched-read prewarm
    # on session open, so the combined + library reads share ONE Python
    # subprocess (interpreter startup is the dominant cost). Populated
    # by _prewarm_session_reads at the top of load_table_session; hit
    # by _read_combined_xlsx_sections and by _load_library_snapshot's
    # cache accessor. Cleared on save (_combined_prewarm_invalidate,
    # _library_prewarm_invalidate).
    array set _xlsx_prewarm_cache {}
}

# xlsx_io lives alongside this file (both are in lib/). Sourced here so the
# core session I/O can hard-block Save/Load on missing python without
# depending on the UI layer. Idempotent - re-sourcing rebinds the same procs.
if {[info commands ::nc::xlsx::python_ok] eq ""} {
    catch {source [file join [file dirname [info script]] xlsx_io.tcl]}
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

# Canonical manifest file: manifest.xlsx (Python+openpyxl required to write).
# Legacy path manifest.csv is still read as fallback so sessions saved before
# the xlsx migration keep loading; the next successful save rewrites them.
proc ::nc::session::_manifest_path {{dir ""}} {
    if {$dir eq ""} { set dir [_active_or_dir ""] }
    return [file join $dir manifest.xlsx]
}

proc ::nc::session::_manifest_path_legacy_csv {{dir ""}} {
    if {$dir eq ""} { set dir [_active_or_dir ""] }
    return [file join $dir manifest.csv]
}

# Existence check that accepts either format - callers need to know if a
# session has a manifest, not which flavor.
proc ::nc::session::_manifest_exists {{dir ""}} {
    if {$dir eq ""} { set dir [_active_or_dir ""] }
    return [expr {[file exists [file join $dir manifest.xlsx]] ||
                  [file exists [file join $dir manifest.csv]]}]
}

# Read manifest into a key -> value dict. Prefers manifest.xlsx (via a
# Python subprocess); falls back to legacy manifest.csv when the xlsx is
# absent OR when python isn't available (letting Session Manager still
# render a session's saved_at even on a python-less machine).
proc ::nc::session::_manifest_dict {{dir ""}} {
    variable _manifest_cache
    if {$dir eq ""} { set dir [_active_or_dir ""] }
    set norm $dir
    catch {set norm [file normalize $dir]}
    set xlsx_path [file join $dir manifest.xlsx]
    set legacy_path [file join $dir manifest.csv]
    # Determine the source we'd actually read from and its mtime; use that
    # pair as the cache key. If it hasn't changed since our last read, skip
    # the whole subprocess + parse dance.
    set src ""
    if {[file exists $xlsx_path]} {
        set src $xlsx_path
    } elseif {[file exists $legacy_path]} {
        set src $legacy_path
    }
    set mt ""
    if {$src ne ""} { catch {set mt [file mtime $src]} }
    if {$src ne "" && [info exists _manifest_cache($norm)]} {
        lassign $_manifest_cache($norm) c_src c_mt c_dict
        if {$c_src eq $src && $c_mt eq $mt} { return $c_dict }
    }
    set out [dict create]
    if {[file exists $xlsx_path] && [::nc::xlsx::python_ok]} {
        set tmpdir [file join $dir cache _manifest_read_[pid]]
        catch {file delete -force -- $tmpdir}
        if {[catch {file mkdir $tmpdir}] == 0} {
            set sheet_map [::nc::xlsx::convert_xlsx_to_multi_csv $xlsx_path $tmpdir]
            if {[dict size $sheet_map] > 0} {
                set csv_path [lindex [dict values $sheet_map] 0]
                set out [_manifest_dict_from_csv $csv_path]
            }
            catch {file delete -force -- $tmpdir}
        }
    } elseif {[file exists $legacy_path]} {
        set out [_manifest_dict_from_csv $legacy_path]
    }
    if {$src ne ""} { set _manifest_cache($norm) [list $src $mt $out] }
    return $out
}

# Called after any code path that rewrites the manifest so the next read
# picks up fresh values without waiting for mtime granularity. _write_
# manifest_values already invalidates itself; other write paths (rare)
# can call this directly.
proc ::nc::session::_manifest_cache_invalidate {{dir ""}} {
    variable _manifest_cache
    if {$dir eq ""} { set dir [_active_or_dir ""] }
    set norm $dir
    catch {set norm [file normalize $dir]}
    catch {unset _manifest_cache($norm)}
}

proc ::nc::session::_manifest_dict_from_csv {path} {
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

# Write manifest as manifest.xlsx (1 sheet "Manifest", 2 columns key/value).
# Hard-errors when python+openpyxl is unavailable - no silent CSV fallback.
# Verify-then-swap: write to temp xlsx, only rename over the real path after
# the in-script sanity check passes. Deletes legacy manifest.csv on success.
proc ::nc::session::_write_manifest_values {dir source fingerprint} {
    set rows [list \
        [list schema_version 1] \
        [list model_source $source] \
        [list model_fingerprint $fingerprint] \
        [list saved_at [clock format [clock seconds] -format "%Y-%m-%dT%H:%M:%S"]]]
    if {![::nc::xlsx::python_ok]} {
        error "Cannot save session manifest: [::nc::xlsx::python_unavailable_message]"
    }
    set final [file join $dir manifest.xlsx]
    set tmp_xlsx "$final.nc_tmp_[pid].xlsx"
    set tmp_csv [file join $dir _manifest_write.nc_tmp_[pid].csv]
    if {[catch {
        ::nc::csv::write_file $tmp_csv {key value} $rows
        set ok [::nc::xlsx::convert_multi_to_xlsx [list [list Manifest $tmp_csv ""]] $tmp_xlsx]
        if {!$ok} {
            error "manifest.xlsx write/verify failed (openpyxl subprocess did not produce a valid file)"
        }
        file rename -force -- $tmp_xlsx $final
    } err]} {
        catch {file delete -force -- $tmp_xlsx}
        catch {file delete -force -- $tmp_csv}
        error $err
    }
    catch {file delete -force -- $tmp_csv}
    # Success: legacy CSV manifest is now stale, remove it so no reader has
    # to guess which flavor is authoritative.
    catch {file delete -force -- [file join $dir manifest.csv]}
    _manifest_cache_invalidate $dir
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
    if {![_manifest_exists $root]} {
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
    if {[file exists [file join $dest manifest.xlsx]] ||
        [file exists [file join $dest manifest.csv]] ||
        [file isdirectory [file join $dest edits]]} {
        error "Folder is already a session: $dest"
    }
    file mkdir $dest
    file mkdir [file join $dest edits]
    file mkdir [file join $dest Component_Images]
    file mkdir [file join $dest cache thumb_cache]
    file mkdir [file join $dest library]
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
    file mkdir [file join $dest library]
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
    return [expr {[file exists [file join $dir manifest.xlsx]] ||
                  [file exists [file join $dir manifest.csv]] ||
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

# Data-line count (excluding the header row) of a CSV file, or "" if the
# file doesn't exist/is empty. Plain line counting (not full CSV parsing)
# keeps the Session Manager list snappy on network drives.
proc ::nc::session::_csv_data_row_count {path} {
    if {![file exists $path]} { return "" }
    set n ""
    catch {
        set fp [open $path r]
        fconfigure $fp -encoding utf-8
        set lines 0
        while {[gets $fp line] >= 0} {
            if {[string trim $line] ne ""} { incr lines }
        }
        close $fp
        if {$lines > 0} { set n [expr {$lines - 1}] }
    }
    return $n
}

# -----------------------------------------------------------------------------
# Public: session_summary
# Cheap facts about a session folder for the Session Manager list:
#   {name saved_at comp_count prop_count mat_count has_images missing}
#
# The sole on-disk save format is ONE combined CSV (matprop_combined.csv -
# see combined_session_file/_split_combined_rows) with one row per Component
# plus trailing orphan rows for any Property/Material not used by a
# Component. A plain per-file line count (the first version of this fix)
# is wrong for that format: Property/Material counts need DISTINCT
# prop_id/mat_id across every row (they repeat once per Component that uses
# them), not a raw line count. Reuses _split_combined_rows - the exact same
# logic load_table_session uses - instead of re-deriving separate counting
# logic that could drift out of sync with the real format.
# -----------------------------------------------------------------------------

# Bulk-prewarm helper for Session Manager: reads manifest.xlsx + combined.xlsx
# from every listed dir in ONE Python subprocess, populates BOTH caches
# (_manifest_cache and _xlsx_prewarm_cache used by session_summary) so
# the subsequent per-dir session_summary calls all hit cache. Cuts N ×
# 2 subprocess opens (~0.5s each) down to ONE, dropping Session Manager
# list render from ~10-20s (N=10) to ~1-2s.
proc ::nc::session::prewarm_summaries {dirs} {
    variable _manifest_cache
    variable _xlsx_prewarm_cache
    if {![::nc::xlsx::python_ok]} { return }
    set jobs {}
    set needed [dict create]  ;# norm_path -> mtime  (jobs we still need)
    foreach dir $dirs {
        foreach fname {manifest.xlsx edits/matprop_combined.xlsx} {
            set path [file join $dir $fname]
            if {![file exists $path]} continue
            set norm $path
            catch {set norm [file normalize $path]}
            set mt ""
            catch {set mt [file mtime $path]}
            # Skip if manifest or combined already cached at this mtime.
            if {[string match "*manifest.xlsx" $path]} {
                set dnorm $dir
                catch {set dnorm [file normalize $dir]}
                if {[info exists _manifest_cache($dnorm)]} {
                    lassign $_manifest_cache($dnorm) c_src c_mt _
                    if {$c_src eq $path && $c_mt eq $mt} continue
                }
            } else {
                if {[info exists _xlsx_prewarm_cache($norm)]} {
                    lassign $_xlsx_prewarm_cache($norm) c_mt _
                    if {$c_mt eq $mt} continue
                }
            }
            dict set needed $norm [list $path $mt $dir]
            lappend jobs [list $path $norm]
        }
    }
    if {[llength $jobs] == 0} { return }
    set root_dir [lindex $dirs 0]
    set scratch [file join $root_dir cache _summaries_prewarm_[pid]]
    catch {file delete -force -- $scratch}
    if {[catch {file mkdir $scratch}]} { return }
    set batch [::nc::xlsx::convert_xlsx_batch_to_multi_csv $jobs $scratch]
    if {[dict size $batch] == 0} {
        catch {file delete -force -- $scratch}
        return
    }
    dict for {norm sheet_map} $batch {
        if {![dict exists $needed $norm]} continue
        lassign [dict get $needed $norm] path mt owner_dir
        set dnorm $owner_dir
        catch {set dnorm [file normalize $owner_dir]}
        # Parse into dicts while scratch CSVs still exist.
        set parsed [dict create]
        dict for {sheet csv_path} $sheet_map {
            dict set parsed $sheet [::nc::csv::read_dicts $csv_path]
        }
        if {[string match "*manifest.xlsx" $path]} {
            # Manifest sheet is the first (and only) sheet - flatten into
            # the same {key -> value} shape _manifest_dict returns.
            set first_dicts [lindex [dict values $parsed] 0]
            set mdict [dict create]
            foreach row $first_dicts {
                set k ""
                set v ""
                if {[dict exists $row key]} { set k [dict get $row key] }
                if {[dict exists $row value]} { set v [dict get $row value] }
                if {$k ne ""} { dict set mdict $k $v }
            }
            set _manifest_cache($dnorm) [list $path $mt $mdict]
        } else {
            # Combined - stash in prewarm cache so a later
            # session_summary/load hits it.
            set _xlsx_prewarm_cache($norm) [list $mt $parsed]
        }
    }
    catch {file delete -force -- $scratch}
}

proc ::nc::session::session_summary {dir} {
    set name [file tail $dir]
    set saved_at ""
    set comp_count ""
    set prop_count ""
    set mat_count ""
    set has_images 0
    set missing [expr {![_session_folder_exists $dir]}]
    if {!$missing} {
        catch {
            set mf [_manifest_dict $dir]
            if {[dict exists $mf saved_at]} { set saved_at [dict get $mf saved_at] }
        }
        set xlsx_path [file join $dir edits matprop_combined.xlsx]
        set csv_path [file join $dir edits matprop_combined.csv]
        if {[file exists $xlsx_path]} {
            if {[::nc::xlsx::python_ok]} {
                catch {
                    set counts [_combined_row_counts_from_xlsx $xlsx_path $dir]
                    set comp_count [dict get $counts component]
                    set prop_count [dict get $counts property]
                    set mat_count [dict get $counts material]
                }
            } else {
                # xlsx-only session on a python-less machine: user can still
                # see the session exists but the counts are unknowable.
                # Displayed as "?" in Session Manager (per plan) - narrow,
                # deliberate exception to the hard-block rule for browsing.
                set comp_count "?"
                set prop_count "?"
                set mat_count "?"
            }
        } elseif {[file exists $csv_path]} {
            catch {
                set split_rows [_split_combined_rows $csv_path]
                set comp_count [llength [dict get $split_rows component]]
                set prop_count [llength [dict get $split_rows properties]]
                set mat_count [llength [dict get $split_rows materials]]
            }
        } else {
            # Legacy fallback for sessions saved before the combined-CSV
            # format existed (separate per-tab files - see
            # table_session_files) - a plain line count is correct here
            # since each tab's file only ever holds that tab's own rows.
            set comp_count [_csv_data_row_count [file join $dir edits matprop_component.csv]]
            set prop_count [_csv_data_row_count [file join $dir edits matprop_properties.csv]]
            set mat_count [_csv_data_row_count [file join $dir edits matprop_materials.csv]]
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
    return [dict create name $name saved_at $saved_at \
        comp_count $comp_count prop_count $prop_count mat_count $mat_count \
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

# Where a user manually drops Material Library .csv/.xlsx files for the tool
# to pick up via the Library tab's "Import CSV..." button - separate from
# edits/ (the tool's own generated per-tab data) since this one is meant to
# be hand-populated.
proc ::nc::session::library_dir {{dir ""}} {
    set root [_active_or_dir $dir]
    set lib [file join $root library]
    _mkdir $lib
    return $lib
}

# Canonical filename for the Library tab's data file. This is both the
# source-of-truth CSV the user edits (via "Open CSV" in the Library
# toolbar - opens this file in the OS default handler) and the tool's own
# save target on Session Save. One file, one name - deliberately different
# from the old matprop_library.csv snapshot filename; legacy sessions
# missing material_lib.csv but still having matprop_library.csv are handled
# by library_snapshot_file_for_read below (backward-compat fallback).
proc ::nc::session::library_snapshot_file {{dir ""}} {
    return [file join [library_dir $dir] material_lib.xlsx]
}

# Read fallback chain: new material_lib.xlsx -> legacy material_lib.csv ->
# older legacy matprop_library.csv. Writes always go to material_lib.xlsx
# so any legacy session migrates on next save.
proc ::nc::session::library_snapshot_file_for_read {{dir ""}} {
    set xlsx [file join [library_dir $dir] material_lib.xlsx]
    if {[file exists $xlsx]} { return $xlsx }
    set csv [file join [library_dir $dir] material_lib.csv]
    if {[file exists $csv]} { return $csv }
    set legacy [file join [library_dir $dir] matprop_library.csv]
    if {[file exists $legacy]} { return $legacy }
    return $xlsx
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

# Canonical combined session file: matprop_combined.xlsx (3 sheets:
# Component / Property / Material). Python+openpyxl is required to
# read or write it. Legacy matprop_combined.csv (single-file normalized
# 3-section format from the 2026-07-05 CSV design) is still accepted as a
# READ fallback so pre-migration sessions keep loading; the next successful
# Save rewrites them in xlsx and removes the .csv.
proc ::nc::session::combined_session_file {{dir ""}} {
    return [file join [edits_dir $dir] matprop_combined.xlsx]
}

proc ::nc::session::combined_session_file_legacy_csv {{dir ""}} {
    return [file join [edits_dir $dir] matprop_combined.csv]
}

proc ::nc::session::_dget {d key {default ""}} {
    if {[dict exists $d $key]} { return [dict get $d $key] }
    return $default
}

# Union of general+component's own header (order-preserving, first
# occurrence wins) - this is the Component SECTION's header in the
# normalized on-disk format. Neither _default_table_header general nor
# component ever included the technical Property/Material fields
# (T/NSM/.../E/G/NU/RHO/...), only prop_id/mat_id (as foreign keys) plus a
# few cached display names (prop_name, mat_user_name, ...) - so this
# naturally excludes the field duplication the old flat format had,
# without needing to touch _default_table_header itself.
proc ::nc::session::_normalized_component_header {} {
    set seen {}
    set out {}
    foreach key [concat [_default_table_header general] [_default_table_header component]] {
        if {[lsearch -exact $seen $key] < 0} {
            lappend seen $key
            lappend out $key
        }
    }
    return $out
}

# Sentinel row literal marking the start of a section in the normalized
# combined file - a section's rows run until EOF or the next marker.
proc ::nc::session::_section_marker {name} { return "#SECTION:$name" }

# Builds the 3 normalized sections (component/property/material) from
# rows_by_tab (general/component/properties/materials). Property and
# Material each keep their OWN real field values exactly once (straight
# from _tab_rows(properties/materials), already unique by prop_id/mat_id)
# - never duplicated onto every Component row that references them, the
# way the old flat format did. This also means unused ("orphan")
# properties/materials just round-trip naturally as ordinary rows in
# their own section - no more blank-comp_id trick needed.
proc ::nc::session::_build_normalized_sections {rows_by_tab} {
    set general_rows {}
    set component_rows {}
    set prop_rows {}
    set mat_rows {}
    if {[dict exists $rows_by_tab general]} { set general_rows [dict get $rows_by_tab general] }
    if {[dict exists $rows_by_tab component]} { set component_rows [dict get $rows_by_tab component] }
    if {[dict exists $rows_by_tab properties]} { set prop_rows [dict get $rows_by_tab properties] }
    if {[dict exists $rows_by_tab materials]} { set mat_rows [dict get $rows_by_tab materials] }

    set general_by_id [dict create]
    foreach row $general_rows {
        set cid [_dget $row comp_id]
        if {$cid eq ""} continue
        dict set general_by_id $cid $row
    }
    set component_by_id [dict create]
    set comp_ids {}
    foreach row $component_rows {
        set cid [_dget $row comp_id]
        if {$cid eq ""} continue
        if {[lsearch -exact $comp_ids $cid] < 0} { lappend comp_ids $cid }
        dict set component_by_id $cid $row
    }
    foreach cid [dict keys $general_by_id] {
        if {[lsearch -exact $comp_ids $cid] < 0} { lappend comp_ids $cid }
    }

    # General and Component are supposed to be the exact same component
    # data (populate_all always seeds both from the same row list) - this
    # merge (general first, component wins on overlap) preserves that
    # exact same precedence the old format used, but now produces ONE row
    # stored once instead of two independently-drifting copies.
    set component_section {}
    foreach cid $comp_ids {
        set merged [dict create]
        if {[dict exists $general_by_id $cid]} {
            foreach {k v} [dict get $general_by_id $cid] { dict set merged $k $v }
        }
        if {[dict exists $component_by_id $cid]} {
            foreach {k v} [dict get $component_by_id $cid] { dict set merged $k $v }
        }
        dict set merged comp_id $cid
        lappend component_section $merged
    }

    return [dict create component $component_section property $prop_rows material $mat_rows]
}

# Reads combined_session_file's on-disk format from $path and rebuilds
# rows_by_tab (general/component/properties/materials) - the same output
# shape every caller already expects. Detects new (sectioned) vs old
# (flat single-table) format by content: the new format's very first row
# is the "#SECTION:component" marker. Old sessions (saved before this
# format existed) keep loading via _split_combined_rows_legacy_flat with
# zero migration step; the next Save rewrites them in the new format.
proc ::nc::session::_split_combined_rows {path} {
    set raw [::nc::csv::read_file $path]
    if {[llength $raw] == 0} {
        return [dict create general {} component {} properties {} materials {}]
    }
    if {[lindex [lindex $raw 0] 0] eq [_section_marker component]} {
        return [_split_normalized_sections $raw]
    }
    return [_split_combined_rows_legacy_flat [_dictify_rows $raw]]
}

# read_file returns raw parsed row-lists (needed so _split_combined_rows
# can sniff the format from the first cell before deciding how to parse) -
# this applies the first row as a header exactly like ::nc::csv::read_dicts
# does, for the legacy flat-format path.
proc ::nc::session::_dictify_rows {raw} {
    if {[llength $raw] < 2} { return {} }
    set header [lindex $raw 0]
    set out {}
    foreach row [lrange $raw 1 end] { lappend out [::nc::csv::to_dict $header $row] }
    return $out
}

proc ::nc::session::_split_normalized_sections {raw} {
    set sections [dict create component {} property {} material {}]
    set current ""
    set current_header {}
    foreach row $raw {
        set first [lindex $row 0]
        if {$first eq [_section_marker component] || $first eq [_section_marker property] \
                || $first eq [_section_marker material]} {
            set current [string range $first [string length "#SECTION:"] end]
            set current_header {}
            continue
        }
        if {$current eq ""} continue
        if {[llength $current_header] == 0} {
            set current_header $row
            continue
        }
        dict lappend sections $current [::nc::csv::to_dict $current_header $row]
    }

    set general_header [_default_table_header general]
    set component_header [_default_table_header component]
    set general_rows {}
    set component_rows {}
    foreach row [dict get $sections component] {
        set grow [dict create]
        foreach key $general_header { dict set grow $key [_dget $row $key] }
        lappend general_rows $grow
        set crow [dict create]
        foreach key $component_header { dict set crow $key [_dget $row $key] }
        lappend component_rows $crow
    }

    set prop_header [_default_table_header properties]
    set prop_rows {}
    foreach row [dict get $sections property] {
        set prow [dict create]
        foreach key $prop_header { dict set prow $key [_dget $row $key] }
        lappend prop_rows $prow
    }

    set mat_header [_default_table_header materials]
    set mat_rows {}
    foreach row [dict get $sections material] {
        set mrow [dict create]
        foreach key $mat_header { dict set mrow $key [_dget $row $key] }
        lappend mat_rows $mrow
    }

    return [dict create general $general_rows component $component_rows properties $prop_rows materials $mat_rows]
}

# Old flat single-table format (pre-existing sessions: one row per
# Component with every Property/Material field inlined, orphans appended
# with comp_id blank, note/usage_count collision-avoided via
# prop_note/mat_note/prop_usage_count/mat_usage_count). Kept verbatim
# (this used to be the body of _split_combined_rows itself) purely for
# backward compatibility - never written anymore, only read.
proc ::nc::session::_split_combined_rows_legacy_flat {combined_rows} {
    set general_header [_default_table_header general]
    set component_header [_default_table_header component]
    set prop_header [_default_table_header properties]
    set mat_header [_default_table_header materials]

    set general_rows {}
    set component_rows {}
    set prop_by_id [dict create]
    set prop_order {}
    set mat_by_id [dict create]
    set mat_order {}

    foreach row $combined_rows {
        set cid [_dget $row comp_id]
        set pid [_dget $row prop_id]
        set mid [_dget $row mat_id]

        if {$cid ne ""} {
            set grow [dict create]
            foreach key $general_header { dict set grow $key [_dget $row $key] }
            lappend general_rows $grow

            set crow [dict create]
            foreach key $component_header { dict set crow $key [_dget $row $key] }
            lappend component_rows $crow
        }

        if {$pid ne "" && ![dict exists $prop_by_id $pid]} {
            lappend prop_order $pid
            set prow [dict create]
            foreach key $prop_header {
                if {$key eq "usage_count"} {
                    dict set prow usage_count [_dget $row prop_usage_count]
                } elseif {$key eq "note"} {
                    dict set prow note [_dget $row prop_note]
                } else {
                    dict set prow $key [_dget $row $key]
                }
            }
            dict set prop_by_id $pid $prow
        }
        if {$mid ne "" && ![dict exists $mat_by_id $mid]} {
            lappend mat_order $mid
            set mrow [dict create]
            foreach key $mat_header {
                if {$key eq "usage_count"} {
                    dict set mrow usage_count [_dget $row mat_usage_count]
                } elseif {$key eq "note"} {
                    dict set mrow note [_dget $row mat_note]
                } else {
                    dict set mrow $key [_dget $row $key]
                }
            }
            dict set mat_by_id $mid $mrow
        }
    }

    set prop_rows {}
    foreach pid $prop_order { lappend prop_rows [dict get $prop_by_id $pid] }
    set mat_rows {}
    foreach mid $mat_order { lappend mat_rows [dict get $mat_by_id $mid] }

    return [dict create general $general_rows component $component_rows properties $prop_rows materials $mat_rows]
}

# Writes the 3 normalized sections to one CSV file: a "#SECTION:name"
# marker row, then a header row, then that section's data rows - repeated
# for component/property/material. Same atomic write + UTF-8 BOM pattern
# as ::nc::csv::write_file (temp file + rename so a crash mid-write can
# never leave a truncated/corrupt file), just looped over 3 blocks
# instead of a single header+rows shape.
proc ::nc::session::_write_normalized_sections_file {path sections_with_headers} {
    set dir [file dirname $path]
    if {$dir ne "" && $dir ne "." && ![file isdirectory $dir]} {
        file mkdir $dir
    }
    set tmp "$path.nc_tmp_[pid]"
    set fp ""
    if {[catch {
        set fp [open $tmp w]
        fconfigure $fp -encoding utf-8
        puts -nonewline $fp [format %c 0xFEFF]
        foreach entry $sections_with_headers {
            lassign $entry name header rows
            puts $fp [_section_marker $name]
            ::nc::csv::puts_row $fp $header
            foreach row $rows { ::nc::csv::puts_row $fp $row }
        }
        close $fp
        set fp ""
        file rename -force -- $tmp $path
    } err]} {
        if {$fp ne ""} { catch {close $fp} }
        catch {file delete -force -- $tmp}
        error $err
    }
}

# Reshapes 3 lists of dicts (component/property/material - as read from
# xlsx sheets or CSV sections) into rows_by_tab = {general ... component ...
# properties ... materials ...}. Mirrors the same field-filtering logic
# _split_normalized_sections already uses, factored out so both the legacy
# CSV-sectioned reader and the new xlsx reader share exactly one reshape
# path (avoids format drift between them).
proc ::nc::session::_reshape_normalized_dicts_to_rows_by_tab {component_dicts property_dicts material_dicts} {
    set general_header [_default_table_header general]
    set component_header [_default_table_header component]
    set prop_header [_default_table_header properties]
    set mat_header [_default_table_header materials]

    set general_rows {}
    set component_rows {}
    foreach row $component_dicts {
        set grow [dict create]
        foreach key $general_header { dict set grow $key [_dget $row $key] }
        lappend general_rows $grow
        set crow [dict create]
        foreach key $component_header { dict set crow $key [_dget $row $key] }
        lappend component_rows $crow
    }
    set prop_rows {}
    foreach row $property_dicts {
        set prow [dict create]
        foreach key $prop_header { dict set prow $key [_dget $row $key] }
        lappend prop_rows $prow
    }
    set mat_rows {}
    foreach row $material_dicts {
        set mrow [dict create]
        foreach key $mat_header { dict set mrow $key [_dget $row $key] }
        lappend mat_rows $mrow
    }
    return [dict create general $general_rows component $component_rows \
        properties $prop_rows materials $mat_rows]
}

# Batched-read prewarm: reads combined.xlsx + library.xlsx in ONE Python
# subprocess (interpreter startup dominates the cost of reading small
# workbooks), parses each into ready-to-consume dicts/rows, and stashes
# them in _xlsx_prewarm_cache keyed by (xlsx_path, mtime) so the
# individual readers (_read_combined_xlsx_sections, _load_library_snapshot)
# find their data waiting instead of firing their own subprocess.
proc ::nc::session::_prewarm_session_reads {dir} {
    variable _xlsx_prewarm_cache
    if {![::nc::xlsx::python_ok]} { return }
    set combined_path [file join $dir edits matprop_combined.xlsx]
    set library_path [file join $dir library material_lib.xlsx]
    set jobs {}
    set mts [dict create]
    foreach path [list $combined_path $library_path] {
        if {[file exists $path]} {
            set mt ""
            catch {set mt [file mtime $path]}
            set norm $path
            catch {set norm [file normalize $path]}
            # Skip if already cached at this mtime.
            if {[info exists _xlsx_prewarm_cache($norm)]} {
                lassign $_xlsx_prewarm_cache($norm) c_mt _
                if {$c_mt eq $mt} { continue }
            }
            dict set mts $norm $mt
            lappend jobs [list $path $norm]
        }
    }
    if {[llength $jobs] == 0} { return }
    set scratch [file join $dir cache _prewarm_[pid]]
    catch {file delete -force -- $scratch}
    if {[catch {file mkdir $scratch}]} { return }
    set batch [::nc::xlsx::convert_xlsx_batch_to_multi_csv $jobs $scratch]
    if {[dict size $batch] == 0} {
        catch {file delete -force -- $scratch}
        return
    }
    dict for {norm sheet_map} $batch {
        # Parse into dicts NOW while the scratch CSVs still exist.
        set parsed [dict create]
        dict for {sheet csv_path} $sheet_map {
            dict set parsed $sheet [::nc::csv::read_dicts $csv_path]
        }
        set mt [dict get $mts $norm]
        set _xlsx_prewarm_cache($norm) [list $mt $parsed]
    }
    catch {file delete -force -- $scratch}
}

# Accessor: returns cached parsed sheets for an xlsx path IF cache is
# fresh (mtime matches), else empty dict. Callers fall back to their
# own single-file read when this returns empty.
proc ::nc::session::_xlsx_prewarm_get {xlsx_path} {
    variable _xlsx_prewarm_cache
    if {![file exists $xlsx_path]} { return [dict create] }
    set norm $xlsx_path
    catch {set norm [file normalize $xlsx_path]}
    if {![info exists _xlsx_prewarm_cache($norm)]} { return [dict create] }
    lassign $_xlsx_prewarm_cache($norm) c_mt parsed
    set mt ""
    catch {set mt [file mtime $xlsx_path]}
    if {$c_mt ne $mt} { return [dict create] }
    return $parsed
}

proc ::nc::session::_xlsx_prewarm_invalidate {xlsx_path} {
    variable _xlsx_prewarm_cache
    set norm $xlsx_path
    catch {set norm [file normalize $xlsx_path]}
    catch {unset _xlsx_prewarm_cache($norm)}
}

# Extract per-section dict lists from a matprop_combined.xlsx file. Preflight
# python_ok BEFORE calling. Returns [dict create component ... property ...
# material ...] or throws on failure. Sheet names are matched case-
# insensitively so files that got resaved from Excel with slightly different
# capitalization still load. Consults the prewarm cache first so a session-
# open that pre-batched both reads doesn't spawn a second subprocess here.
proc ::nc::session::_read_combined_xlsx_sections {xlsx_path {scratch_dir ""}} {
    if {![::nc::xlsx::python_ok]} {
        error "Cannot read [file tail $xlsx_path]: [::nc::xlsx::python_unavailable_message]"
    }
    # Prewarm cache hit: parsed dicts already sitting in memory, no
    # subprocess needed.
    set warmed [_xlsx_prewarm_get $xlsx_path]
    if {[dict size $warmed] > 0} {
        array set by_lower {}
        dict for {name dicts} $warmed { set by_lower([string tolower $name]) $dicts }
        set component_dicts {}
        set property_dicts {}
        set material_dicts {}
        foreach {lname target} {component component property property material material} {
            if {[info exists by_lower($lname)]} {
                switch -- $target {
                    component { set component_dicts $by_lower($lname) }
                    property { set property_dicts $by_lower($lname) }
                    material { set material_dicts $by_lower($lname) }
                }
            }
        }
        return [dict create component $component_dicts \
            property $property_dicts material $material_dicts]
    }
    if {$scratch_dir eq ""} {
        set scratch_dir [file join [file dirname $xlsx_path] _combined_read_[pid]]
    }
    catch {file delete -force -- $scratch_dir}
    file mkdir $scratch_dir
    set sheet_map [::nc::xlsx::convert_xlsx_to_multi_csv $xlsx_path $scratch_dir]
    if {[dict size $sheet_map] == 0} {
        catch {file delete -force -- $scratch_dir}
        error "Failed to read [file tail $xlsx_path]: openpyxl subprocess produced no sheets"
    }
    array set by_lower {}
    dict for {name path} $sheet_map { set by_lower([string tolower $name]) $path }
    set component_dicts {}
    set property_dicts {}
    set material_dicts {}
    foreach {lname target} {component component property property material material} {
        if {[info exists by_lower($lname)]} {
            set path $by_lower($lname)
            set dicts [::nc::csv::read_dicts $path]
            switch -- $target {
                component { set component_dicts $dicts }
                property { set property_dicts $dicts }
                material { set material_dicts $dicts }
            }
        }
    }
    catch {file delete -force -- $scratch_dir}
    return [dict create component $component_dicts \
        property $property_dicts material $material_dicts]
}

# Session Manager row counts from an xlsx-format combined file. Hard-fails
# only if python_ok is 0; caller already gates on that and shows "?".
# Cached by mtime so opening Session Manager over N recent sessions
# doesn't fire 2N Python subprocesses on every list refresh - only the
# first time each session is inspected in the current tool run.
proc ::nc::session::_combined_row_counts_from_xlsx {xlsx_path dir} {
    variable _combined_counts_cache
    set norm $xlsx_path
    catch {set norm [file normalize $xlsx_path]}
    set mt ""
    catch {set mt [file mtime $xlsx_path]}
    if {[info exists _combined_counts_cache($norm)]} {
        lassign $_combined_counts_cache($norm) c_mt c_dict
        if {$c_mt eq $mt} { return $c_dict }
    }
    set sections [_read_combined_xlsx_sections $xlsx_path]
    set out [dict create \
        component [llength [dict get $sections component]] \
        property [llength [dict get $sections property]] \
        material [llength [dict get $sections material]]]
    set _combined_counts_cache($norm) [list $mt $out]
    return $out
}

# Invalidate the combined-counts cache for a specific xlsx path (or the
# active session's combined file if none given). save_table_session
# calls this after a successful write so the next session_summary /
# reload picks up the fresh counts without waiting on mtime granularity.
proc ::nc::session::_combined_counts_cache_invalidate {{xlsx_path ""}} {
    variable _combined_counts_cache
    if {$xlsx_path eq ""} {
        catch {set xlsx_path [combined_session_file ""]}
    }
    if {$xlsx_path eq ""} { return }
    set norm $xlsx_path
    catch {set norm [file normalize $xlsx_path]}
    catch {unset _combined_counts_cache($norm)}
}

# Unified load helper used by both load_table_session AND
# ui_table.tcl::_reload_tab_from_own_file, so the xlsx-vs-legacy-csv
# branching logic lives in exactly one place.
proc ::nc::session::_load_combined_rows_by_tab {dir} {
    set xlsx_path [combined_session_file $dir]
    set csv_path [combined_session_file_legacy_csv $dir]
    if {[file exists $xlsx_path]} {
        set sections [_read_combined_xlsx_sections $xlsx_path]
        return [_reshape_normalized_dicts_to_rows_by_tab \
            [dict get $sections component] \
            [dict get $sections property] \
            [dict get $sections material]]
    }
    if {[file exists $csv_path]} {
        return [_split_combined_rows $csv_path]
    }
    return [dict create general {} component {} properties {} materials {}]
}

proc ::nc::session::_default_table_header {tab} {
    set meta {_dirty_fields _pending_fields _pending_values}
    switch -- $tab {
        general {
            return [concat {image_path hm_comp_name comp_user_name comp_type comp_id prop_name prop_user_name prop_id prop_card mat_user_name mat_id mass_total mass_total_raw note comp_name label mat_name material_label mat_card case_type} $meta]
        }
        component {
            return [concat {image_path hm_comp_name comp_name comp_user_name comp_type comp_id prop_name prop_user_name prop_card prop_id mat_id mat_user_name mass_total mass_total_raw note label material_label case_type} $meta]
        }
        properties {
            return [concat {prop_card prop_id prop_name prop_user_name mat_card mat_id mat_name mat_user_name usage_count T NSM Z1 Z2 E G NU RHO A TREF ST SC SS K1 K2 K3 K4 K5 K6 B1 B2 B3 B4 B5 B6 GE1 GE2 GE3 GE4 GE5 GE6 M1 M2 M3 M4 M5 M6 note} $meta]
        }
        materials {
            return [concat {mat_card mat_id mat_user_name mat_label mat_name usage_count E G NU RHO A TREF GE ST SC SS note} $meta]
        }
    }
    return {}
}

# header_order_by_tab: optional dict with a general/component preferred
# column order (e.g. the UI's current on-screen column order), used as the
# combined CSV's header prefix instead of the default order. Any field not
# mentioned is still appended automatically, so this is purely a reordering,
# never a data-dropping operation.
proc ::nc::session::save_table_session {rows_by_tab {dir ""} {header_order_by_tab {}}} {
    set root [_active_or_dir $dir]
    # Preflight: Save writes THREE xlsx artifacts (manifest + combined
    # data + library upstream in the UI layer). Fail fast BEFORE touching
    # disk if python isn't available, so we never leave a partial migration
    # or corrupt an existing good session.
    if {![::nc::xlsx::python_ok]} {
        error "Cannot save session: [::nc::xlsx::python_unavailable_message]"
    }
    _ensure_manifest_for_save $root
    set sections [_build_normalized_sections $rows_by_tab]

    set component_header [_normalized_component_header]
    set preferred {}
    if {[dict exists $header_order_by_tab general]} {
        set preferred [dict get $header_order_by_tab general]
    } elseif {[dict exists $header_order_by_tab component]} {
        set preferred [dict get $header_order_by_tab component]
    }
    if {[llength $preferred] > 0} {
        set ordered {}
        foreach key $preferred {
            if {[lsearch -exact $component_header $key] >= 0 && [lsearch -exact $ordered $key] < 0} {
                lappend ordered $key
            }
        }
        foreach key $component_header {
            if {[lsearch -exact $ordered $key] < 0} { lappend ordered $key }
        }
        set component_header $ordered
    }
    set prop_header [_default_table_header properties]
    set mat_header [_default_table_header materials]

    # Write 3 scratch CSVs (internal field-key headers, NOT display labels -
    # these round-trip through the reader by exact key match, no fuzzy
    # header matching). Same directory as the target xlsx so the final
    # rename is same-volume atomic.
    set final_xlsx [combined_session_file $root]
    set edits [file dirname $final_xlsx]
    set tmp_xlsx "$final_xlsx.nc_tmp_[pid].xlsx"
    set tmp_comp [file join $edits "_nc_tmp_[pid]_component.csv"]
    set tmp_prop [file join $edits "_nc_tmp_[pid]_property.csv"]
    set tmp_mat [file join $edits "_nc_tmp_[pid]_material.csv"]
    set scratch_files [list $tmp_comp $tmp_prop $tmp_mat]
    if {[catch {
        set component_data {}
        foreach row [dict get $sections component] {
            set values {}
            foreach key $component_header { lappend values [_dget $row $key] }
            lappend component_data $values
        }
        set prop_data {}
        foreach row [dict get $sections property] {
            set values {}
            foreach key $prop_header { lappend values [_dget $row $key] }
            lappend prop_data $values
        }
        set mat_data {}
        foreach row [dict get $sections material] {
            set values {}
            foreach key $mat_header { lappend values [_dget $row $key] }
            lappend mat_data $values
        }
        ::nc::csv::write_file $tmp_comp $component_header $component_data
        ::nc::csv::write_file $tmp_prop $prop_header $prop_data
        ::nc::csv::write_file $tmp_mat $mat_header $mat_data
        # No image embedding on the authoritative round-trip file - image
        # embedding is a nice-to-have for export/preview, and adds openpyxl
        # fragility a round-trip data file should not carry.
        set jobs [list \
            [list Component $tmp_comp ""] \
            [list Property $tmp_prop ""] \
            [list Material $tmp_mat ""]]
        set ok [::nc::xlsx::convert_multi_to_xlsx $jobs $tmp_xlsx]
        if {!$ok} {
            error "matprop_combined.xlsx write/verify failed (openpyxl subprocess did not produce a valid file)"
        }
        # Atomic swap - the previous good file is untouched until this line.
        file rename -force -- $tmp_xlsx $final_xlsx
    } err]} {
        catch {file delete -force -- $tmp_xlsx}
        foreach f $scratch_files { catch {file delete -force -- $f} }
        error $err
    }
    foreach f $scratch_files { catch {file delete -force -- $f} }
    # Success: legacy .csv counterparts are now stale. Delete them so
    # there is exactly one source of truth on disk. No-ops if they never
    # existed (fresh session or already-migrated session).
    catch {file delete -force -- [combined_session_file_legacy_csv $root]}
    foreach f [dict values [table_session_files $root]] {
        catch {file delete -force -- $f}
    }
    _combined_counts_cache_invalidate $final_xlsx
    _xlsx_prewarm_invalidate $final_xlsx
    return [dict create dir $root files [dict create combined $final_xlsx] tabs 1]
}

proc ::nc::session::load_table_session {{dir ""}} {
    set root [_active_or_dir $dir]
    set xlsx_path [combined_session_file $root]
    set csv_path [combined_session_file_legacy_csv $root]
    # Prewarm: batch-read combined.xlsx + library.xlsx in ONE Python
    # subprocess so the follow-up _read_combined_xlsx_sections and the
    # later _load_library_snapshot don't each pay Python startup
    # (~300-500ms). Silently no-ops on legacy csv-only sessions.
    catch {_prewarm_session_reads $root}
    set rows_by_tab [dict create]
    if {[file exists $xlsx_path]} {
        if {![::nc::xlsx::python_ok]} {
            error "Cannot load [file tail $xlsx_path]: [::nc::xlsx::python_unavailable_message]"
        }
        set sections [_read_combined_xlsx_sections $xlsx_path]
        set rows_by_tab [_reshape_normalized_dicts_to_rows_by_tab \
            [dict get $sections component] \
            [dict get $sections property] \
            [dict get $sections material]]
    } elseif {[file exists $csv_path]} {
        # Legacy csv format (2026-07-05 CSV-sectioned OR ancient flat) still
        # loads with zero python needed - the next successful save migrates
        # it to xlsx.
        set rows_by_tab [_split_combined_rows $csv_path]
    } else {
        # Even older fallback: separate per-tab CSV files.
        set legacy_files [table_session_files $root]
        foreach tab [_table_tabs] {
            set rows {}
            foreach row [::nc::csv::read_dicts [dict get $legacy_files $tab]] { lappend rows $row }
            dict set rows_by_tab $tab $rows
        }
    }
    foreach tab [_table_tabs] {
        set rows {}
        if {[dict exists $rows_by_tab $tab]} { set rows [dict get $rows_by_tab $tab] }
        set fixed {}
        foreach row $rows {
            if {![dict exists $row _dirty_fields]} { dict set row _dirty_fields {} }
            if {![dict exists $row _pending_fields]} { dict set row _pending_fields {} }
            if {![dict exists $row _pending_values]} { dict set row _pending_values {} }
            lappend fixed $row
        }
        dict set rows_by_tab $tab $fixed
    }
    return [dict create dir $root files [dict create combined $xlsx_path] rows_by_tab $rows_by_tab]
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

        # Label: saved user label only. NEVER fall back to the HM comp name -
        # label feeds comp_user_name (COMP. Name), a pure user-entered field;
        # defaulting it to the scanned name makes the two indistinguishable
        # (recurring bug class - see docs/LESSONS_AND_PITFALLS.md #8, this was
        # its 6th recurrence). Blank means "user hasn't labeled this yet".
        set label ""
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
