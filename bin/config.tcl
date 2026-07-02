# ═══════════════════════════════════════════════════════════════════════════
# config.tcl — Edit paths here after copying the tool to a new machine.
# After editing, open HM and reload the button. No Python package install is required.
# ═══════════════════════════════════════════════════════════════════════════

namespace eval ::nc::config {}

# ─── 1. Tool root folder (this folder) ──────────────────────────────────────
# Auto-detected from config.tcl location. Change only if files are split apart.
set ::nc::config::tool_dir [file normalize [file dirname [info script]]]

# ─── 2. HyperMesh Python 3.5 (used for thumbnails and xlsx import/export) ───
# Candidate list. The first existing path is used.
set ::nc::config::python_candidates {
    {C:/Program Files/Altair/2022/common/python/python3.5/win64/python.exe}
    {C:/Program Files/Altair/2022.0/common/python/python3.5/win64/python.exe}
    {C:/Program Files/Altair/2023/common/python/python3.5/win64/python.exe}
}

# ─── 3. Bundled Python package folder (Pillow + openpyxl) ───────────────────
# Points to vendor/ in the deploy package. The tool adds it to PYTHONPATH.
# Set to "" if packages are already installed in Altair Python site-packages.
set ::nc::config::vendor_site_packages \
    [file join $::nc::config::tool_dir vendor python35_site-packages]

# ═══════════════════════════════════════════════════════════════════════════
# The logic below applies the config. No edits are normally needed.
# ═══════════════════════════════════════════════════════════════════════════

proc ::nc::config::resolve_python {} {
    variable ::nc::config::python_candidates
    foreach c $::nc::config::python_candidates {
        if {[file exists $c]} { return $c }
    }
    return ""
}

proc ::nc::config::apply {} {
    set vendor $::nc::config::vendor_site_packages
    if {$vendor ne "" && [file isdirectory $vendor]} {
        set native [file nativename $vendor]
        set current ""
        if {[info exists ::env(PYTHONPATH)]} { set current $::env(PYTHONPATH) }
        if {[string first $native $current] < 0} {
            if {$current eq ""} {
                set ::env(PYTHONPATH) $native
            } else {
                set ::env(PYTHONPATH) "$native;$current"
            }
        }
    }
}

::nc::config::apply
