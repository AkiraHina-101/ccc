# nc_save.tcl  —  Save current session state
#
# If the Nastran Control tool is loaded (::nc::app namespace exists),
# saves comps + assignments to session folder and confirms.
# Otherwise opens the full tool.

if {[namespace exists ::nc::app]} {
    set _rows {}
    catch {set _rows $::nc::ui_table::_rows}

    if {[llength $_rows] > 0} {
        catch {::nc::session::save_comps $_rows}

        set _asgn [dict create]
        foreach _r $_rows {
            if {[dict exists $_r material_label] && [dict get $_r material_label] ne ""} {
                dict set _asgn [dict get $_r comp_id] [dict get $_r material_label]
            }
        }
        catch {::nc::session::save_assignments $_asgn}
        ::nc::mutations::log_add "Session saved to [::nc::session::dir]"
        catch {
            tk_messageBox -message "Session saved.\n[::nc::session::dir]" \
                -title "Nastran Control" -icon info -type ok
        }
    } else {
        catch {
            tk_messageBox -message "Nothing to save — table is empty." \
                -title "Nastran Control" -icon warning -type ok
        }
    }
    unset -nocomplain _rows _asgn _r
} else {
    # Tool not loaded yet — launch it
    set _here [file dirname [file normalize [info script]]]
    source [file join $_here nastran_control.tcl]
    unset _here
}
