# =============================================================================
# csv_io.tcl  —  ::nc::csv
#
# CSV read/write utilities. No HM dependency — pure Tcl file I/O.
#
# Public API:
#   ::nc::csv::quote {value}              -> escaped value string
#   ::nc::csv::puts_row {fp row}          -> write one row to open file handle
#   ::nc::csv::parse_line {line}          -> list of field strings
#   ::nc::csv::to_dict {header raw}       -> dict keyed by trimmed header names
#   ::nc::csv::read_file {path}           -> list of row-lists (header + data)
#   ::nc::csv::read_dicts {path}          -> list of dicts (header consumed)
#   ::nc::csv::write_file {path hdr rows} -> write header + rows to file
# =============================================================================

namespace eval ::nc::csv {}

# -----------------------------------------------------------------------------
# Quote a single value for CSV output.
# Wraps in double-quotes if the value contains commas or quotes.
# Normalises embedded newlines to a space.
# -----------------------------------------------------------------------------

proc ::nc::csv::quote {value} {
    set value [string map [list \r " " \n " "] $value]
    if {[regexp {[",]} $value]} {
        return "\"[string map [list \" \"\"] $value]\""
    }
    return $value
}

# -----------------------------------------------------------------------------
# Write one list as a CSV row to an open file handle.
# -----------------------------------------------------------------------------

proc ::nc::csv::puts_row {fp row} {
    set out {}
    foreach value $row {
        lappend out [quote $value]
    }
    puts $fp [join $out ","]
}

# -----------------------------------------------------------------------------
# Parse one CSV line into a list of field strings.
# Handles double-quoted fields and escaped quotes ("").
# -----------------------------------------------------------------------------

proc ::nc::csv::parse_line {line} {
    set result {}
    set field ""
    set in_quotes 0
    set n [string length $line]
    for {set i 0} {$i < $n} {incr i} {
        set ch [string index $line $i]
        if {$in_quotes} {
            if {$ch eq "\""} {
                if {$i + 1 < $n && [string index $line [expr {$i + 1}]] eq "\""} {
                    append field "\""
                    incr i
                } else {
                    set in_quotes 0
                }
            } else {
                append field $ch
            }
        } else {
            if {$ch eq ","} {
                lappend result $field
                set field ""
            } elseif {$ch eq "\""} {
                set in_quotes 1
            } else {
                append field $ch
            }
        }
    }
    lappend result $field
    return $result
}

# -----------------------------------------------------------------------------
# Convert a header row-list and a data row-list into a dict.
# Header names are trimmed of whitespace. Missing data fields become "".
# -----------------------------------------------------------------------------

proc ::nc::csv::to_dict {header raw} {
    set d [dict create]
    set i 0
    foreach key $header {
        set key [string trim $key]
        set val ""
        if {$i < [llength $raw]} {
            set val [string trim [lindex $raw $i]]
        }
        dict set d $key $val
        incr i
    }
    return $d
}

# -----------------------------------------------------------------------------
# Read an entire CSV file. Returns a list of row-lists including the header.
# Blank lines are skipped. Returns {} if the file cannot be read.
# -----------------------------------------------------------------------------

proc ::nc::csv::read_file {path} {
    if {![file exists $path]} {
        return {}
    }
    set fp [open $path r]
    fconfigure $fp -encoding utf-8
    set rows {}
    while {[gets $fp line] >= 0} {
        if {[string trim $line] eq ""} continue
        lappend rows [parse_line $line]
    }
    close $fp
    return $rows
}

# -----------------------------------------------------------------------------
# Read a CSV file and return a list of dicts (first row = header, consumed).
# Returns {} if file is missing or has only a header row.
# -----------------------------------------------------------------------------

proc ::nc::csv::read_dicts {path} {
    set rows [read_file $path]
    if {[llength $rows] < 2} {
        return {}
    }
    set header [lindex $rows 0]
    set result {}
    foreach raw [lrange $rows 1 end] {
        lappend result [to_dict $header $raw]
    }
    return $result
}

# -----------------------------------------------------------------------------
# Write a CSV file: header list + list of value-lists.
# Creates parent directories if needed. Overwrites if file exists.
# Atomic: writes to a same-directory temp file first, then renames over the
# target, so a crash mid-write can never leave a truncated/corrupt CSV.
# -----------------------------------------------------------------------------

proc ::nc::csv::write_file {path header rows} {
    set dir [file dirname $path]
    if {$dir ne "" && $dir ne "." && ![file isdirectory $dir]} {
        file mkdir $dir
    }
    set tmp "$path.nc_tmp_[pid]"
    set fp ""
    if {[catch {
        set fp [open $tmp w]
        fconfigure $fp -encoding utf-8
        puts_row $fp $header
        foreach row $rows {
            puts_row $fp $row
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
