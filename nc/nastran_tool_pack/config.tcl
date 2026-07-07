# ═══════════════════════════════════════════════════════════════════════════
# config.tcl — edit the paths below when copying this tool to a new machine.
# This is the ONLY file that needs real machine paths filled in. No other
# .tcl file in this pack hardcodes an install path — they all read the
# variables set here. After editing, reload the buttons in the CAE tool.
# ═══════════════════════════════════════════════════════════════════════════

namespace eval ::nc::config {}

# ─── 1. Tool root folder (this folder) ─────────────────────────────────────
# Auto-detected from this file's own location. Nothing to edit here.
set ::nc::config::tool_dir [file normalize [file dirname [info script]]]

# ─── 2. REQUIRED: Python executable ────────────────────────────────────────
# Used to read/write .xlsx session files and generate component thumbnails.
# Without this set correctly, Save/Load and thumbnails will not work.
# Paste the full path to a python.exe on the target machine below (checked
# in order, first one that exists on disk wins). That Python must already
# have the "pillow" and "openpyxl" packages installed — if not, run:
#   <path-to-python.exe> -m pip install pillow openpyxl
set ::nc::config::python_candidates [list \
    {<PASTE_PYTHON_EXE_PATH_HERE>} \
]

# ─── 3. OPTIONAL: extra Python package folder ──────────────────────────────
# Leave as "" (empty string) if the Python from step 2 already has pillow/
# openpyxl installed in its own site-packages. Only set this if you're
# pointing at a separate folder with those packages vendored in.
set ::nc::config::vendor_site_packages ""

# ─── 4. OPTIONAL: toolbar icon folder ──────────────────────────────────────
# Purely cosmetic. Points at the CAE tool's own installed icon images
# folder (Save/Isolate/Find/View icons etc.) so buttons show a picture
# instead of plain text. If you leave the placeholder as-is or the path
# doesn't exist, every button still works — it just shows text only.
set ::nc::config::icon_dir_candidates [list \
    {<PASTE_TOOLBAR_ICON_DIR_HERE>} \
]

# ─── 5. OPTIONAL: Nastran output template path ─────────────────────────────
# Only matters if you open a fresh session in the CAE tool with NO solver
# template already loaded — scan.tcl uses this to auto-load a Nastran bulk
# data output template so it can read property/material cards. If a
# template is already active in your session (the common case), this is
# never used. If you leave the placeholder as-is or the path doesn't
# exist, scan.tcl just falls back to whatever template is already active.
set ::nc::config::template_candidates [list \
    {<PASTE_NASTRAN_TEMPLATE_PATH_HERE>} \
]

# ═══════════════════════════════════════════════════════════════════════════
# Everything below is the apply logic — no need to edit.
# ═══════════════════════════════════════════════════════════════════════════

proc ::nc::config::resolve_python {} {
    variable ::nc::config::python_candidates
    foreach c $::nc::config::python_candidates {
        if {[file exists $c]} { return $c }
    }
    return ""
}

proc ::nc::config::resolve_icon_dir {} {
    variable ::nc::config::icon_dir_candidates
    foreach d $::nc::config::icon_dir_candidates {
        if {[file isdirectory $d]} { return $d }
    }
    return ""
}

proc ::nc::config::resolve_template {} {
    variable ::nc::config::template_candidates
    foreach t $::nc::config::template_candidates {
        if {[file exists $t]} { return $t }
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
