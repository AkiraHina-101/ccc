# =============================================================================
# xlsx_io.tcl  —  ::nc::xlsx
#
# XLSX read/write via a Python (openpyxl) subprocess. UI-independent, so core
# session I/O in session.tcl can call it directly without pulling in the UI
# layer. Preflight `python_ok` before any destructive write.
#
# Public API:
#   ::nc::xlsx::resolve_cae_python {}
#       -> path to python.exe, or "" if not found
#   ::nc::xlsx::python_ok {}
#       -> 1 if python + openpyxl usable, 0 otherwise
#   ::nc::xlsx::convert_multi_to_xlsx {jobs xlsx_path}
#       jobs = list of {sheet_name csv_path image_header_or_empty}
#       -> writes xlsx_path; returns 1 on success, 0 otherwise.
#          Includes in-script sanity verify: every listed sheet with a
#          non-empty CSV must land in the workbook with header + >=1 row,
#          else the script exits nonzero and the caller sees failure.
#   ::nc::xlsx::convert_xlsx_to_multi_csv {xlsx_path out_dir}
#       reads ALL sheets from xlsx_path, writes one CSV per sheet under
#       out_dir. Returns dict{sheet_name -> csv_path}. Empty dict on failure.
#       Numeric cells stringified stably: ints stay int, floats keep their
#       decimal repr — no spurious ".0" on integer IDs.
#   ::nc::xlsx::convert_xlsx_batch_to_multi_csv {jobs out_dir}
#       jobs = list of {xlsx_path sub_key}. Reads ALL sheets from EVERY
#       listed xlsx in ONE Python subprocess (Python startup ~300-500ms
#       dominates the cost of reading a small workbook; batching amortises
#       that startup across N files). Returns dict{sub_key -> dict{sheet
#       -> csv_path}}. Empty dict on failure. Used by load_table_session
#       to read combined.xlsx + library.xlsx together instead of one
#       subprocess each.
# =============================================================================

namespace eval ::nc::xlsx {
    # Resolved at source time: lib/ -> lib/ (this file's own dir). Python
    # scripts are hardcoded strings, identical across sessions, so we keep
    # ONE copy per tool install in a tool-local cache dir rather than
    # writing a copy into every session's edits/ or library/ folder
    # (which polluted user-visible dirs - "why is there a .py in my
    # library folder?"). Idempotent: _write_script_if_changed only
    # actually rewrites the file when its content differs.
    variable _lib_dir [file dirname [info script]]
    variable _script_cache_dir [file normalize [file join $_lib_dir .. cache py_scripts]]
}

# Returns the tool-local cache dir where generated Python helper scripts
# live. Created on demand. Callers pass this to _write_script_if_changed
# instead of a session folder, so session dirs stay clean of tool
# scaffolding.
proc ::nc::xlsx::_scripts_dir {} {
    variable _script_cache_dir
    if {![file isdirectory $_script_cache_dir]} {
        catch {file mkdir $_script_cache_dir}
    }
    return $_script_cache_dir
}

# -----------------------------------------------------------------------------
# Find a usable Python. Delegates entirely to config.tcl's
# ::nc::config::resolve_python (the single editable place for this path).
# -----------------------------------------------------------------------------
proc ::nc::xlsx::resolve_cae_python {} {
    if {[llength [info commands ::nc::config::resolve_python]] > 0} {
        set p [::nc::config::resolve_python]
        if {$p ne ""} { return $p }
    }
    return ""
}

# -----------------------------------------------------------------------------
# Cheap runtime check: python found AND openpyxl importable.
# Returns 0 for both "no python" and "python present but no openpyxl".
# -----------------------------------------------------------------------------
proc ::nc::xlsx::python_ok {} {
    set python [resolve_cae_python]
    if {$python eq ""} { return 0 }
    if {[catch {exec $python -c "import openpyxl"}]} { return 0 }
    return 1
}

# -----------------------------------------------------------------------------
# Human-readable diagnostic message for callers to include in errors when
# python_ok returns 0. Points at config.tcl so the user can fix the path.
# -----------------------------------------------------------------------------
proc ::nc::xlsx::python_unavailable_message {} {
    set python [resolve_cae_python]
    if {$python eq ""} {
        return "Python not found. Edit config.tcl (::nc::config::python_candidates)\
                and paste the full path to your Python executable."
    }
    return "Python found at [file nativename $python] but 'import openpyxl' failed.\
            Install openpyxl into that interpreter's site-packages."
}

# -----------------------------------------------------------------------------
# File-based cached script writer — same pattern the older ui_table procs use.
# Only rewrites the .py file if its content differs, so repeated calls are
# effectively free.
# -----------------------------------------------------------------------------
proc ::nc::xlsx::_write_script_if_changed {path body} {
    set existing ""
    if {[file exists $path]} {
        if {![catch {
            set fp [::open $path r]
            set existing [read $fp]
            close $fp
        }] && $existing eq "$body\n"} {
            return $path
        }
    }
    set fp [::open $path w]
    puts $fp $body
    close $fp
    return $path
}

# -----------------------------------------------------------------------------
# Multi-CSV -> multi-sheet XLSX writer. Manifest file (tab-separated) format:
#   sheet_name\tcsv_path\timage_header_or_empty
# per line. The Python script iterates the manifest, creates one sheet per
# job, embeds images from image_header column if present, and — this is new
# vs. the older ui_table version — REOPENS the just-written xlsx to verify
# that every listed sheet with a non-empty CSV actually made it in with
# header + >=1 data row; exits nonzero if not.
# -----------------------------------------------------------------------------
proc ::nc::xlsx::_write_multi_csv_to_xlsx_script {dir} {
    set script_path [file join $dir nc_xlsx_write_multi.py]
    set py {
import csv
import os
import sys

from openpyxl import Workbook, load_workbook
from openpyxl.drawing.image import Image as XLImage
from openpyxl.utils import get_column_letter

def to_cell_value(val):
    # Numeric-looking cells must be written as real numbers so Excel sorts
    # them by value, not alphabetically ("10" before "2").
    if val == "":
        return val
    try:
        return int(val)
    except ValueError:
        pass
    try:
        return float(val)
    except ValueError:
        return val

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
expect_nonempty = []  # sheet names that should verify with >=1 data row

for sheet_name, csv_path, image_header in jobs:
    if not os.path.isfile(csv_path):
        continue
    title = (sheet_name[:31] if sheet_name else "Sheet")
    ws = wb.create_sheet(title=title)
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
    data_written = False
    for r, data_row in enumerate(rows[1:], start=2):
        for c, val in enumerate(data_row, start=1):
            if img_col_idx is not None and c == img_col_idx:
                continue
            ws.cell(row=r, column=c, value=to_cell_value(val))
        data_written = True
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
    if data_written:
        expect_nonempty.append(title)

if not default_removed:
    default_sheet.title = "Sheet1"

wb.save(xlsx_path)

# --- verify step: reopen and confirm expected sheets landed with data ---
try:
    vb = load_workbook(xlsx_path, read_only=True)
    have = set(vb.sheetnames)
    missing = [s for s in expect_nonempty if s not in have]
    if missing:
        sys.stderr.write("xlsx verify: missing sheets: %s\n" % ",".join(missing))
        sys.exit(2)
    for s in expect_nonempty:
        ws = vb[s]
        n = 0
        for _ in ws.iter_rows(values_only=True, max_row=2):
            n += 1
        if n < 2:
            sys.stderr.write("xlsx verify: sheet %s has <2 rows\n" % s)
            sys.exit(3)
    vb.close()
except SystemExit:
    raise
except Exception as e:
    sys.stderr.write("xlsx verify failed: %s\n" % e)
    sys.exit(4)
}
    return [_write_script_if_changed $script_path $py]
}

# -----------------------------------------------------------------------------
# Convert a list of {sheet csv_path image_header} jobs to one multi-sheet xlsx.
# Returns 1 on verified success, 0 otherwise. Never raises. Caller decides
# whether to hard-error (Save/Load) or degrade (best-effort mirrors).
# -----------------------------------------------------------------------------
proc ::nc::xlsx::convert_multi_to_xlsx {jobs xlsx_path} {
    set python [resolve_cae_python]
    if {$python eq ""} { return 0 }
    set script [_write_multi_csv_to_xlsx_script [_scripts_dir]]
    set manifest "[file rootname $xlsx_path].nc_manifest.txt"
    if {[catch {
        set fp [::open $manifest w]
        fconfigure $fp -encoding utf-8 -translation lf
        foreach job $jobs {
            lassign $job sheet csv_path image_header
            puts $fp "$sheet\t$csv_path\t$image_header"
        }
        close $fp
    } err]} {
        catch {file delete -force -- $manifest}
        return 0
    }
    set rc [catch {exec $python $script $manifest $xlsx_path} err]
    catch {file delete -force -- $manifest}
    if {$rc} { return 0 }
    return [file exists $xlsx_path]
}

# -----------------------------------------------------------------------------
# Reader: iterate ALL sheets in xlsx (not just wb.active) and write one CSV
# per sheet. Emits its own tab-separated manifest so Tcl doesn't have to
# guess the sanitized filenames.
#
# Numeric cells stringify as follows (matters for round-trip of the
# authoritative session format — IDs must stay int, not gain ".0"):
#   None                                -> ""
#   int                                 -> str(int)
#   float where float(v).is_integer()   -> str(int(v))    e.g. 42.0 -> "42"
#   other float                         -> repr(v).rstrip("0").rstrip(".")
#                                          normalized so 3.14 -> "3.14",
#                                          not "3.14000000000000012"
#   other                               -> str(v)
# -----------------------------------------------------------------------------
proc ::nc::xlsx::_write_xlsx_to_multi_csv_script {dir} {
    set script_path [file join $dir nc_xlsx_read_multi.py]
    set py {
import csv
import os
import re
import sys

from openpyxl import load_workbook

_safe_re = re.compile(r'[\\/:*?"<>|\r\n\t]')

def safe_name(name):
    s = _safe_re.sub("_", name or "sheet")
    s = s.strip().strip(".")
    return s or "sheet"

def stringify(v):
    if v is None:
        return ""
    if isinstance(v, bool):
        return "1" if v else "0"
    if isinstance(v, int):
        return str(v)
    if isinstance(v, float):
        # int-valued floats: no ".0" tail
        if v == int(v):
            return str(int(v))
        # non-int: default repr, but strip pointless trailing zeros/dot
        s = repr(v)
        if "." in s and "e" not in s and "E" not in s:
            s = s.rstrip("0").rstrip(".")
            if s == "" or s == "-":
                s = "0"
        return s
    return str(v)

xlsx_path, out_dir, manifest_out = sys.argv[1], sys.argv[2], sys.argv[3]
os.makedirs(out_dir, exist_ok=True)

wb = load_workbook(xlsx_path, data_only=True, read_only=True)

manifest_lines = []
used = set()
for sheet_name in wb.sheetnames:
    base = safe_name(sheet_name)
    fname = base + ".csv"
    i = 1
    while fname.lower() in used:
        i += 1
        fname = "{0}_{1}.csv".format(base, i)
    used.add(fname.lower())
    csv_path = os.path.join(out_dir, fname)
    ws = wb[sheet_name]
    with open(csv_path, "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        for row in ws.iter_rows(values_only=True):
            w.writerow([stringify(v) for v in row])
    manifest_lines.append("{0}\t{1}".format(sheet_name, csv_path))

wb.close()

with open(manifest_out, "w", encoding="utf-8", newline="\n") as f:
    for line in manifest_lines:
        f.write(line + "\n")
}
    return [_write_script_if_changed $script_path $py]
}

# -----------------------------------------------------------------------------
# Batched reader script. Manifest_in format (tab-separated, one line per
# workbook):
#   xlsx_path\tsub_key
# For each line: creates out_dir/<sub_key>/, dumps one CSV per sheet inside.
# Emits manifest_out (tab-separated):
#   sub_key\tsheet_name\tcsv_path
# One Python process handles every workbook in the manifest, so
# interpreter startup (the dominant cost) is paid ONCE regardless of N.
# -----------------------------------------------------------------------------
proc ::nc::xlsx::_write_xlsx_batch_to_multi_csv_script {dir} {
    set script_path [file join $dir nc_xlsx_read_batch.py]
    set py {
import csv
import os
import re
import sys

from openpyxl import load_workbook

_safe_re = re.compile(r'[\\/:*?"<>|\r\n\t]')

def safe_name(name):
    s = _safe_re.sub("_", name or "sheet")
    s = s.strip().strip(".")
    return s or "sheet"

def stringify(v):
    if v is None:
        return ""
    if isinstance(v, bool):
        return "1" if v else "0"
    if isinstance(v, int):
        return str(v)
    if isinstance(v, float):
        if v == int(v):
            return str(int(v))
        s = repr(v)
        if "." in s and "e" not in s and "E" not in s:
            s = s.rstrip("0").rstrip(".")
            if s == "" or s == "-":
                s = "0"
        return s
    return str(v)

manifest_in, out_root, manifest_out = sys.argv[1], sys.argv[2], sys.argv[3]

jobs = []
with open(manifest_in, encoding="utf-8") as f:
    for line in f:
        line = line.rstrip("\n").rstrip("\r")
        if not line:
            continue
        parts = line.split("\t")
        while len(parts) < 2:
            parts.append("")
        jobs.append((parts[0], parts[1]))

os.makedirs(out_root, exist_ok=True)
out_lines = []
for xlsx_path, sub_key in jobs:
    if not os.path.isfile(xlsx_path):
        continue
    sub_dir = os.path.join(out_root, safe_name(sub_key))
    os.makedirs(sub_dir, exist_ok=True)
    try:
        wb = load_workbook(xlsx_path, data_only=True, read_only=True)
    except Exception as e:
        sys.stderr.write("xlsx batch: failed to load %s: %s\n" % (xlsx_path, e))
        continue
    used = set()
    for sheet_name in wb.sheetnames:
        base = safe_name(sheet_name)
        fname = base + ".csv"
        i = 1
        while fname.lower() in used:
            i += 1
            fname = "{0}_{1}.csv".format(base, i)
        used.add(fname.lower())
        csv_path = os.path.join(sub_dir, fname)
        ws = wb[sheet_name]
        with open(csv_path, "w", newline="", encoding="utf-8") as f:
            w = csv.writer(f)
            for row in ws.iter_rows(values_only=True):
                w.writerow([stringify(v) for v in row])
        out_lines.append("{0}\t{1}\t{2}".format(sub_key, sheet_name, csv_path))
    wb.close()

with open(manifest_out, "w", encoding="utf-8", newline="\n") as f:
    for line in out_lines:
        f.write(line + "\n")
}
    return [_write_script_if_changed $script_path $py]
}

# Batched read: one Python subprocess reads every xlsx listed in `jobs`.
# jobs = list of {xlsx_path sub_key}. Returns dict{sub_key -> dict{sheet
# -> csv_path}}, or empty dict on failure. sub_key is caller-defined so
# results can be routed back to the right consumer (e.g. "combined",
# "library").
proc ::nc::xlsx::convert_xlsx_batch_to_multi_csv {jobs out_dir} {
    set python [resolve_cae_python]
    if {$python eq ""} { return [dict create] }
    if {[llength $jobs] == 0} { return [dict create] }
    if {![file isdirectory $out_dir]} {
        if {[catch {file mkdir $out_dir}]} { return [dict create] }
    }
    set script [_write_xlsx_batch_to_multi_csv_script [_scripts_dir]]
    set manifest_in [file join $out_dir nc_xlsx_batch_in.txt]
    set manifest_out [file join $out_dir nc_xlsx_batch_out.txt]
    catch {file delete -force -- $manifest_in}
    catch {file delete -force -- $manifest_out}
    if {[catch {
        set fp [::open $manifest_in w]
        fconfigure $fp -encoding utf-8 -translation lf
        foreach job $jobs {
            lassign $job xlsx_path sub_key
            puts $fp "$xlsx_path\t$sub_key"
        }
        close $fp
    } err]} {
        catch {file delete -force -- $manifest_in}
        return [dict create]
    }
    set rc [catch {exec $python $script $manifest_in $out_dir $manifest_out} err]
    catch {file delete -force -- $manifest_in}
    if {$rc || ![file exists $manifest_out]} {
        catch {file delete -force -- $manifest_out}
        return [dict create]
    }
    set result [dict create]
    if {[catch {
        set fp [::open $manifest_out r]
        fconfigure $fp -encoding utf-8
        while {[gets $fp line] >= 0} {
            if {$line eq ""} { continue }
            set parts [split $line "\t"]
            if {[llength $parts] < 3} { continue }
            lassign $parts sub_key sheet path
            if {![dict exists $result $sub_key]} { dict set result $sub_key [dict create] }
            set inner [dict get $result $sub_key]
            dict set inner $sheet $path
            dict set result $sub_key $inner
        }
        close $fp
    }]} {
        catch {file delete -force -- $manifest_out}
        return [dict create]
    }
    catch {file delete -force -- $manifest_out}
    return $result
}

# -----------------------------------------------------------------------------
# Read all sheets of xlsx_path into per-sheet CSVs under out_dir.
# Returns dict{sheet_name -> csv_path}, or empty dict on failure.
# Caller is responsible for cleaning up out_dir when done.
# -----------------------------------------------------------------------------
proc ::nc::xlsx::convert_xlsx_to_multi_csv {xlsx_path out_dir} {
    set python [resolve_cae_python]
    if {$python eq ""} { return [dict create] }
    if {![file exists $xlsx_path]} { return [dict create] }
    if {![file isdirectory $out_dir]} {
        if {[catch {file mkdir $out_dir}]} { return [dict create] }
    }
    set script [_write_xlsx_to_multi_csv_script [_scripts_dir]]
    set manifest [file join $out_dir nc_xlsx_read_manifest.txt]
    catch {file delete -force -- $manifest}
    set rc [catch {exec $python $script $xlsx_path $out_dir $manifest} err]
    if {$rc || ![file exists $manifest]} {
        catch {file delete -force -- $manifest}
        return [dict create]
    }
    set result [dict create]
    if {[catch {
        set fp [::open $manifest r]
        fconfigure $fp -encoding utf-8
        while {[gets $fp line] >= 0} {
            if {$line eq ""} { continue }
            set idx [string first "\t" $line]
            if {$idx < 0} { continue }
            set sheet [string range $line 0 [expr {$idx - 1}]]
            set path [string range $line [expr {$idx + 1}] end]
            dict set result $sheet $path
        }
        close $fp
    }]} {
        catch {file delete -force -- $manifest}
        return [dict create]
    }
    catch {file delete -force -- $manifest}
    return $result
}
