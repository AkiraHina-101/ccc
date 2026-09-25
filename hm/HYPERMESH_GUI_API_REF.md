# HyperMesh GUI Script API Reference

AI-readable notes for building HyperMesh Tcl GUI tools around Nastran
tables, model data, dialogs, and macro pages.

Verification status:

```text
OFFICIAL:
  HyperMesh Scripts, Tcl GUI Commands, Tcl Query Commands, Tcl Modify Commands,
  Data Names, `hm_getvalue`, view commands, `hm_windowtofile`, and
  `hm_windowtoclipboard` are confirmed at the category/command level by Altair
  Altair help.

LOCAL-INSTALL:
  `nastran.mac`, HWTK table/tree/button/checkbutton details, image-in-table
  behavior, and custom Nastran dialog flows are from local install/workspace
  scripts.

RUNTIME-TEST-NEEDED:
  Generated dialogs, callbacks, and image/table loading should be run in a real
  HyperMesh GUI session.
```

Sources inspected:

- Workspace macro entry:
  - `_clean/nastran_custom.mac`
  - `_clean/nastran_control.tcl`
  - `_clean/lib/ui_table.tcl`
  - `_clean/lib/scan.tcl`
  - `_clean/lib/session.tcl`
  - `_clean/lib/mutations.tcl`
  - `_clean/lib/csv_io.tcl`
  - `_clean/lib/csv_import.tcl`
  - `_clean/docs/API_VERIFIED.md`
- HyperMesh install:
  - `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/nastran.mac`
  - `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/Tabled1.tcl`
  - `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/tablemats.tcl`
  - `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/nast_prop_main.tcl`
  - `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/nast_comp_main.tcl`
  - `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/tablebase_nast_prop.tcl`
  - `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/bctable.tcl`

Broad install scan:

- Searched `<ALTAIR_INSTALL_DIR>` for Tcl/MAC files in the
  main HyperMesh/HyperWorks script areas.
- Count found in scan scope: about `4657` `.tcl` files and `39` `.mac` files.
- Grep-filtered for table/dialog/data patterns:
  `addDataName`, `table`, `hwtk::dialog`, `::hwt::AddEntry`,
  `::hwt::CanvasButton`, `tk_getOpenFile`, `tk_getSaveFile`,
  `tk_messageBox`, `hm_getvalue`, `hm_getentityvalue`, `hm_getmark`,
  `*attributeupdate`, `*setvalue`, `*materialupdate`.
- Highest-signal additional files outside direct `nastran.mac` path:
  `optistruct/Tabled1.tcl`, `optistruct/output/output_gui.tcl`,
  `nastran/output/output_gui.tcl`, `context/src/composites/laminatetable.tcl`,
  `EngineeringSolutions/aerospace/BCTableManager/advancedTable.tcl`,
  `entities/createTableDlgFuncs.tcl`, `entities/createTableDlgGui.tcl`,
  `connectors/ce_table.tcl`, `optistruct/table_of_mats.tcl`,
  `optistruct/table_of_comps.tcl`, `radioss/tablebase_radioss.tcl`,
  `dynakey/tablebase_dyna.tcl`, `ansys/ansysbrowser/component/tableBase.tcl`,
  `pamcrash2G/tableBase.tcl`, `madymo/table_base_madymo.tcl`.

Coverage note: this is a practical API reference, not a line-by-line digest of
all 4657 Tcl files. It covers the direct Nastran macro path in detail and uses
the broad scan to catch the main reusable GUI/table/data APIs.

Related Python embedding/HWX GUI notes are kept in:

```text
_clean/docs/HYPERMESH_PYTHON_EMBEDDING_API_REF.md
```

Related HyperMesh/HyperView batch automation notes are kept in:

```text
_clean/docs/HYPERWORKS_BATCH_API_REF.md
```

## Macro Page API

`nastran.mac` is mostly a launcher page. The actual GUI/data logic is in Tcl.

Important macro commands:

```text
*includemacrofile("globalpage.mac")
*includemacrofile("disppage.mac")
*includemacrofile("geommeshpage.mac")
*includemacrofile("qamodelpage.mac")
*includemacrofile("userpage.mac")

*createbuttongroup(page, group, "Name", row, col, width, BUTTON, "help", "macroName", arg)
*createtext(page, "Text", row, col)
*createbutton(page, "Label", row, col, width, COLOR, "help", "EvalTcl", "path/to/script.tcl")
*setactivepage(page)
*setactivegroup(group, row, col)

*beginmacro("EvalTcl")
    *evaltclscript($1,0)
*endmacro()

*beginmacro("tcl_string")
    *evaltclstring($1,0)
*endmacro()
```

Standard Nastran buttons from install `nastran.mac`:

```text
TABLE Create       -> nastran/Tabled1.tcl
Material Table     -> nastran/tablemats.tcl
Property Table     -> nastran/nast_prop_main.tcl
Component Table    -> nastran/nast_comp_main.tcl
BCTABLE Manager    -> nastran/bctable.tcl
Load Steps Browser -> loadstepbrowser/loadstep_browser.tcl
```

Workspace custom entry:

```text
Nastran Control -> _clean/nastran_control.tcl
NC Save         -> _clean/nc_save.tcl
```

## Tcl GUI Widgets

HyperMesh embeds Tcl/Tk plus Altair widgets. Common low-level Tk widgets found:

```text
toplevel, frame, label, button, radiobutton, checkbutton, entry, listbox,
canvas, scrollbar, text, menu, bind, pack, grid, wm, focus, grab, tkwait
```

Common dialog APIs:

```tcl
tk_messageBox -message "..." -title "..." -icon warning -type ok
tk_getOpenFile -title "Import CSV" -filetypes {{"CSV files" .csv} {"All files" *}}
tk_getSaveFile -title "Export CSV" -defaultextension .csv
tk_popup $menu $X $Y
tk_dialog .path "Title" "Message" question 0 "Yes" "No"
```

Altair/HyperWorks widget APIs observed:

```text
::hwtk::dialog
::hwtk::button
::hwtk::buttonbar
::hwtk::checkbutton
::hwtk::combobox
::hwtk::datatable
::hwtk::entry
::hwtk::frame
::hwtk::gridview
::hwtk::label
::hwtk::labelframe
::hwtk::listbox
::hwtk::multiselectcombobox
::hwtk::notebook
::hwtk::openfileentry
::hwtk::progressbar

::hwt::AddEntry
::hwt::CanvasButton
::hwt::LabeledLine
::hwt::Notebook
::hwt::KeepOnTop
::hwt::SourceFile
::hwt::CacheImage
::hwt::CreateWindow
::hwt::WindowRecess
::hwt::DluWidth
::hwt::DluHeight
::hwt::AppFont
::hwt::EntryState
::hwt::BuildTable
::hwt::InitializeTktable
::hwt::CreateTktableCells
::hwt::CreateTktableColumnHeaders
::hwt::CreateTktableRowHeaders
::hwt::SortTktable
::hwt::FilterPanel
::hwt::GetOpenFile
::hwt::GetSaveFile
::hwt::Message
::hwt::Prompt
::hwt::PopupWorkingWindow
::hwt::PopdownWorkingWindow
::hwt::DisableCanvasButton
::hwt::EnableCanvasButton
```

## GUI Controls Checklist

This section is the quick "what control do I use?" map for AI-generated GUI
scripts. The reference does not enumerate every option of every widget, but it
does cover the control families and patterns found in the HyperMesh install.

Low-level Tk controls:

```text
button       -> command button
checkbutton  -> boolean on/off variable
radiobutton  -> mutually exclusive option group via shared variable
entry        -> text/numeric input
label        -> static text
listbox      -> list selection
text         -> multi-line log or text view
menu         -> menu bar / popup / context menu
canvas       -> drawing area, icon buttons, color swatches
scrollbar    -> x/y table/text/list scrolling
frame        -> layout container
toplevel     -> independent window/dialog
table        -> spreadsheet-like grid (Tktable)
```

Modern `hwtk` controls found by broad scan:

```text
::hwtk::button
::hwtk::buttonbar
::hwtk::checkbutton
::hwtk::radiobutton
::hwtk::combobox
::hwtk::multiselectcombobox
::hwtk::entry
::hwtk::openfileentry
::hwtk::choosedirentry
::hwtk::colorbutton
::hwtk::datetimeentry
::hwtk::label
::hwtk::labelframe
::hwtk::frame
::hwtk::listbox
::hwtk::notebook
::hwtk::datatable
::hwtk::gridview
::hwtk::tree
::hwtk::progressbar
::hwtk::inputdialog
::hwtk::preferencesdialog
::hwtk::entityselector
::hwtk::contextinspector
```

Older `hwt` helper controls/patterns:

```text
::hwt::AddEntry          -> labelled entry, often with popup/list/icon support
::hwt::CanvasButton      -> HyperMesh-style button, icon button, color swatch
::hwt::LabeledLine       -> section divider/title line
::hwt::Notebook          -> tabbed pages
::hwt::CreateWindow      -> helper window creation
::hwt::WindowRecess      -> recessed dialog body/frame
::hwt::BuildTable        -> helper table framework
::hwt::FilterPanel       -> table/filter UI helper
::hwt::ColorDialog       -> color selection
::hwt::GetOpenFile       -> file open wrapper
::hwt::GetSaveFile       -> file save wrapper
::hwt::Message           -> message wrapper
::hwt::Prompt            -> prompt wrapper
```

Button examples:

```tcl
button $w.apply -text "Apply" -command "::tool::apply"
pack $w.apply -side right -padx 4

set b $w.iconButton
hwt::CanvasButton $b [hwt::DluWidth 50 [hwt::AppFont]] [hwt::DluHeight 14 [hwt::AppFont]] \
    -text "Browse..." \
    -command "::tool::browse" \
    -takefocus 0 \
    -font [hwt::AppFont]
pack $b -side left
```

Checkbox/radio examples:

```tcl
checkbutton $w.chk -text "Editable" \
    -variable ::tool::editable \
    -onvalue 1 -offvalue 0 \
    -command "::tool::refresh"

radiobutton $w.r1 -text "Import" -value import -variable ::tool::mode
radiobutton $w.r2 -text "Create" -value create -variable ::tool::mode
```

Combobox/dropdown examples:

```tcl
ttk::combobox $w.cb \
    -textvariable ::tool::material_label \
    -values $material_labels \
    -state readonly \
    -width 24

AddEntry $w.combo \
    entryWidth 10 \
    label "Type:" \
    iconname small_arrow \
    listVar fromPopDown noTyping ::tool::typeList \
    textvariable ::tool::selectedType
```

State/event patterns:

```tcl
$widget configure -state normal
$widget configure -state disabled
bind $widget <Return> "::tool::commit; break"
bind $widget <Escape> "::tool::cancel; break"
bind $widget <Button-3> "::tool::popup %x %y %X %Y"
```

Example `hwtk::dialog` pattern from `Tabled1.tcl`:

```tcl
set dlg [::hwtk::dialog .mainWindow \
    -title "Create Table" \
    -destroyonunpost 1 \
    -minwidth 250 -minheight 250 \
    -modality none]

set mainFrame [$dlg recess]
frame $mainFrame.subFrame1 -bd 0 -relief flat
pack $mainFrame.subFrame1 -side top -fill x
$dlg post
```

Example modal Tk `toplevel` pattern:

```tcl
toplevel .filterTable
wm title .filterTable "Filter"
focus .filterTable
grab .filterTable
tkwait window .filterTable
```

## Tktable Widget API

The `table` widget is used heavily. It is array-backed or directly addressed by
cell coordinates.

Minimal pattern:

```tcl
set tbl [table $parent.t \
    -variable ::ns::tableData \
    -rows 1 \
    -cols 5 \
    -titlerows 1 \
    -titlecols 0 \
    -selecttype row \
    -selectmode extended \
    -resizeborders col \
    -xscrollcommand [list $parent.sx set] \
    -yscrollcommand [list $parent.sy set] \
    -browsecommand {::ns::on_browse %r %c}]

scrollbar $parent.sy -orient v -command [list $tbl yview]
scrollbar $parent.sx -orient h -command [list $tbl xview]
```

Common table operations:

```tcl
$tbl configure -rows $nrows
$tbl configure -cols $ncols
$tbl configure -state normal
$tbl configure -state disabled
$tbl reread
$tbl width $col $pixels

set tableData(0,0) "Header"
set tableData($row,$col) $value

$tbl set $row,$col $value
set value [$tbl get "$row,$col"]

$tbl index @$x,$y
$tbl index active
$tbl activate $row,$col
$tbl icursor end

$tbl curselection
$tbl selection clear all
$tbl selection set @$x,$y @$x,$y
$tbl selection includes @$x,$y

$tbl tag configure tag_header -background "#e0e0e0" -font {Arial 9 bold}
$tbl tag row tag_header 0
$tbl tag cell tag_warn $row,$col
$tbl tag col tag_name $col
$tbl tag celltag "" all
$tbl window configure 0,$col -window $headerWidget -sticky news
```

Typical bindings:

```tcl
bind $tbl <Control-c> {::ns::copy_selection_to_clipboard; break}
bind $tbl <ButtonRelease-1> {::ns::on_click %x %y}
bind $tbl <Double-ButtonPress-1> {::ns::on_double_click %x %y; break}
bind $tbl <Return> {::ns::on_edit_commit; break}
bind $tbl <Escape> {::ns::on_edit_cancel; break}
```

`tablebase_nast_prop.tcl` builds generic tables from a "dataname" schema:

```tcl
addDataName name text type justify state width list sum visible
checkDataName name
setDataName name option value
getDataName name option
updateCell entityId dataName
setCellColor entityId dataName color
setCellState entityId dataName state
```

Then the table engine calls per-column procs:

```tcl
tblGet_<name> {entity_id}
tblSet_<name> {entity_id value}
```

Example schema entries:

```tcl
addDataName "name"     "Prop Name" "ascii"   "left"   "normal"   15 "" 0 1
addDataName "pid"      "Prop Id"   "integer" "right"  "normal"   10 "" 0 1
addDataName "type"     "Prop Type" "ascii"   "right"  "disabled" 15 "" 0 1
addDataName "material" "Mat Name"  "ascii"   "left"   "normal"   15 [getMaterials $matDbPath] 0 1
```

## Images In Table Cells

Sources:

```text
_ref/lib/images.tcl
_clean/tools/capture_component_images.tcl
_ref/_archive/Nastran_Control_Tool/material_property_mapper.tcl
```

The working pattern is not "put an image path into a text cell". The table row
stores an `image_path`, then UI code creates a Tk `photo`, wraps it in a child
widget such as `frame/label`, and attaches that widget to a `tktable` cell with
`$table window configure`.

Core table/window API:

```tcl
image create photo $image_name -file $path
image width $photo
image height $photo
image delete $photo

label $cell_widget.image -image $photo
pack $cell_widget.image -fill both -expand 1

$table window configure $row,$image_col -window $cell_widget -sticky news
$table window configure $row,$image_col -window ""     ;# detach before destroy/resize
```

Folder load API and convention:

```tcl
tk_chooseDirectory -title "Select Component Image Folder" -initialdir $dir
glob -nocomplain [file join $folder *]
file extension $path
file rootname [file tail $path]
```

Observed convention:

```text
123.png, 123.jpg, 123.jpeg, 123.bmp, 123.gif -> component ID 123
non-integer filename stems are ignored
image_path_by_comp($comp_id) = absolute/path/to/image
image_paths_by_order = sorted image paths
last_image_dir = selected folder
```

Reference flow:

```tcl
proc load_image_folder {folder} {
    variable image_path_by_comp
    variable image_paths_by_order
    variable last_image_dir

    if {$folder eq "" || ![file isdirectory $folder]} {
        error "Image folder not found: $folder"
    }

    clear_image_cells
    catch {array unset image_path_by_comp}
    set image_paths_by_order {}

    set keyed_paths {}
    foreach path [glob -nocomplain [file join $folder *]] {
        set ext [string tolower [file extension $path]]
        if {$ext ni {.png .jpg .jpeg .bmp .gif}} {
            continue
        }
        set stem [file rootname [file tail $path]]
        if {![string is integer -strict $stem]} {
            continue
        }
        set image_path_by_comp($stem) $path
        lappend keyed_paths [list $stem $path]
    }

    foreach item [lsort -dictionary -index 0 $keyed_paths] {
        lappend image_paths_by_order [lindex $item 1]
    }
    set last_image_dir $folder
}
```

Minimal render pattern:

```tcl
variable ui_table
variable ui_columns
variable ui_images
variable ui_image_widgets

set img_col [lsearch -exact $ui_columns image_path]
set display_row 5
set img_path "C:/tmp/Component_Images/123.png"

set img_name "::tool::ui_images(img_$display_row)"
catch {image delete $img_name}
set img [image create photo $img_name -file $img_path]

set cell_widget "$ui_table.img_$display_row"
catch {destroy $cell_widget}
frame $cell_widget -borderwidth 0
label $cell_widget.image -image $img -borderwidth 0
pack $cell_widget.image -fill both -expand 1

set ui_images(img_$display_row) $img
lappend ui_image_widgets $cell_widget
$ui_table window configure $display_row,$img_col -window $cell_widget -sticky news
```

Important: Tk image objects can disappear when there is no Tcl reference held by
the application. Keep every returned photo name in a namespace variable or array
such as `ui_images(...)`.

Cleanup pattern:

```tcl
proc clear_image_cells {} {
    variable ui_table
    variable ui_columns
    variable ui_image_widgets
    variable ui_images

    set img_col [lsearch -exact $ui_columns image_path]
    if {$ui_table ne "" && [winfo exists $ui_table] && $img_col >= 0} {
        foreach widget $ui_image_widgets {
            if {[regexp {img_([0-9]+)$} $widget -> row]} {
                catch {$ui_table window configure $row,$img_col -window ""}
            }
        }
    }

    foreach widget $ui_image_widgets {
        catch {destroy $widget}
    }
    set ui_image_widgets {}

    if {[array exists ui_images]} {
        foreach key [array names ui_images] {
            catch {image delete $ui_images($key)}
        }
        catch {array unset ui_images}
    }
}
```

Thumbnail APIs:

```tcl
catch {package require Img}
image create photo $name -file $path
image create photo $thumb
$thumb copy $img -zoom $best_zoom $best_zoom -subsample $best_subsample $best_subsample
$thumb write $tmp_path -format png
```

Observed helper functions:

```text
thumbnail_width_bucket
thumbnail_cache_path
thumbnail_exact_cache_path
altair_python_executable
write_pillow_thumbnail_script
ensure_pillow_thumbnails
write_bilinear_thumbnail
make_smooth_display_thumbnail
make_table_thumbnail
image_cell_size
clear_image_cells
```

Recommended thumbnail strategy:

```text
1. Prefer a precomputed PNG thumbnail cache.
2. Use Altair-bundled Python/Pillow if available for smooth downscale.
3. Fall back to pure Tcl bilinear resize.
4. Last fallback: Tk photo copy -zoom/-subsample.
```

Capture component images from HyperMesh graphics:

```tcl
hwi CloseStack
hwi OpenStack
hwi GetSessionHandle sess1

set saved_view "Capture_View_[clock clicks]"
catch {*saveviewmask $saved_view 0}

foreach comp_id $comp_ids {
    *createmark comps 1 $comp_id
    *createmark component 2 comp_id = $comp_id
    *createstringarray 2 "elements_on" "geometry_on"
    *isolateonlyentitybymark 2 1 2
    *view "iso1"
    *window 0 0 0 0 0

    set png_path [file join $img_dir "$comp_id.png"]
    set jpg_path [file join $img_dir "$comp_id.jpg"]

    if {![catch {sess1 CaptureScreenToSize png "$png_path" 768 768 95}] \
            && [file exists $png_path]} {
        dict set image_map $comp_id $png_path
    } elseif {![catch {*jpegfilenamed $jpg_path}] && [file exists $jpg_path]} {
        dict set image_map $comp_id $jpg_path
    }
}

catch {*createmark comps 1 "all"}
catch {*showentity comps 1}
catch {*restoreviewmask $saved_view 0}
catch {*removeview $saved_view}
hwi CloseStack
```

Session persistence pattern:

```text
save_image_session:
  write key,id,path rows to image_session_file
  rows include image_folder and image_path records

load_image_session:
  clear existing widgets/photos
  restore folder or per-component image paths
  call load_image_folder when the folder still exists

ui_render_session_images_if_available:
  check ui_table, ui_columns, ui_rows, last_image_dir
  call ui_render_image_cells 1
```

Resize/refresh cautions:

```text
Detach image windows before table resize or full redraw:
  $table window configure row,col -window ""

Destroy old cell widgets before creating new ones.
Delete old Tk photo objects with image delete.
Reattach windows after the table has settled.
Keep image cell width/height stable to avoid row jitter.
```

## 3D FEM Render And Color

Detailed API reference for entity colors, show/hide/isolate, FEM display style,
view orientation, transparency, and screenshot capture:

```text
_clean/docs/HYPERMESH_COLOR_RENDER_API_REF.md
```

## Workspace Nastran Control Table

Entry: `::nc::app::run` in `_clean/nastran_control.tcl`.

Flow:

```text
source lib modules
hm_info modelfile
::nc::session::init model_path
::nc::scan::scan_model
::nc::session::merge_labels
::nc::session::load_materials
::nc::ui_table::open model_path rows
```

Public procs:

```text
::nc::app::run
::nc::app::scan
::nc::scan::ensure_template
::nc::scan::scan_model
::nc::scan::elem_count
::nc::session::init
::nc::session::dir
::nc::session::load_comps
::nc::session::load_materials
::nc::session::load_assignments
::nc::session::save_comps
::nc::session::save_materials
::nc::session::save_assignments
::nc::session::append_audit
::nc::session::merge_labels
::nc::ui_table::open
::nc::ui_table::populate
::nc::ui_table::set_mat_rows
::nc::ui_table::get_selected_rows
::nc::ui_table::copy_selection_to_clipboard
::nc::mutations::assign_material
::nc::mutations::rename_comp
::nc::csv_import::import_table_csv
::nc::csv_import::import_materials_csv
```

Row dict schema used by `::nc::scan::scan_model`:

```tcl
dict create \
    comp_id    $cid \
    comp_name  $comp_name \
    prop_id    $prop_id \
    prop_name  $prop_name \
    prop_card  $prop_card \
    mat_id     $mat_id \
    mat_name   $mat_name \
    mat_card   $mat_card \
    case_type  $case_type \
    elem_count -1
```

After `merge_labels`, rows also carry:

```text
label
material_label
```

Displayed columns:

```text
Comp Label | ID | Prop Type | Mat Label | Mat ID
```

Case semantics:

```text
case_type 1 = normal component with property
case_type 2 = PBUSH property shared by more than one component
case_type 3 = component has no property
```

## HyperMesh Read APIs

Verified/read from workspace probes and Nastran scripts.

Current model/template:

```tcl
set model_path [hm_info modelfile]
set template [hm_info templatefilename]
set code [hm_info templatecodename]
set type [hm_info templatetype]
set altair_home [hm_info -appinfo ALTAIR_HOME]
set current_dir [hm_info -appinfo CURRENTWORKINGDIR]
```

Load template before card-image reads in batch:

```tcl
*templatefileset "<ALTAIR_INSTALL_DIR>/templates/feoutput/nastran/general"
```

List entities by mark:

```tcl
*clearmark comps 1
*createmark comps 1 "all"
set comp_ids [hm_getmark comps 1]
*clearmark comps 1
```

Useful mark APIs:

```text
*createmark <etype> <mark_id> "all"
*createmark <etype> <mark_id> "displayed"
*createmark <etype> <mark_id> "by collector id" id
*createmark <etype> <mark_id> "by property id" id
*createmark <etype> <mark_id> "by id only" id
*createmarkpanel <etype> <mark_id> "prompt"
hm_createmark <etype> <mark_id> ...
hm_getmark <etype> <mark_id>
hm_marklength <etype> <mark_id>
hm_markclear <etype> <mark_id>
*clearmark <etype> <mark_id>
*markintersection <etype1> m1 <etype2> m2
```

Read entity fields:

```tcl
hm_getvalue comps id=$cid dataname=name
hm_getvalue comps id=$cid dataname=propertyid
hm_getvalue props id=$pid dataname=name
hm_getvalue props id=$pid dataname=materialid
hm_getvalue mats  id=$mid dataname=name

hm_getentityvalue comps +$cid property.id 0 -byid
hm_getentityvalue props +$pid material.id 0 -byid
hm_getentityvalue props +$pid material.name 1 -byid
hm_getentityvalue mats  $mid name 1

hm_entityinfo name props $pid
hm_entityinfo id materials $mat_name
hm_getcollectorname materials $mid
hm_entitylist materials name
```

Card image and attribute lookup:

```tcl
hm_getcardimagename props +$pid -byid
hm_getcardimagename mats  +$mid -byid
hm_getentitycardimagedictionary mats ALL
hm_attributeindexidentifier MATERIALS $mid 1 -byid
hm_attributeindexidentifier PROPERTIES $pid 1 -byid
hm_defaultstatus $entity_type $id $attr
hm_realint_val $entity_type $id $attr $num_type
hm_string $entity_type $id $attr
hm_1darrayDouble_entval $entity_type $id $attr $row
hm_attributearrayvalue curves +$curve_id "$TABLED4_X" $row
```

Element/node counts:

```tcl
*clearmark elems 1
*createmark elems 1 "by collector id" $cid
set n [hm_marklength elems 1]
*clearmark elems 1

*createmark elements 1 "by property" $pid
set elem_count [llength [hm_getmark elements 1]]

*createmark nodes 1 "by props" $pid
set node_count [llength [hm_getmark nodes 1]]
```

Curve/table data:

```tcl
set numPoints [hm_getvalue curves id=$curve_id dataname=numberofpoints]
foreach point [hm_curve_getpointcords $curve_id] {
    set x [lindex $point 0]
    set y [lindex $point 1]
}
```

## HyperMesh Write APIs

Rename collectors:

```tcl
*renamecollector comps $old_name $new_name
*renamecollector props $old_name $new_name
```

Create collectors/entities:

```tcl
*collectorcreate materials $matName "" 7
*createentity curves name=$newcompName color=$color_id
*dictionaryload materials 1 $template_path $card_type
```

Renumber:

```tcl
*createmark props 1 "by id only" +$new_id
*createmark props 1 $old_name
*renumber props 1 $new_id 1 0 0
*renumbersolverid properties 1 $new_solver_id 1 0 0 0 0 0
```

Color:

```tcl
*createmark props 1 $pid
*colormark props 1 $color_id

*createmark mats 1 $mid
*colormark mats 1 $color_id
```

Material assignment:

```tcl
*clearmark props 1
*createmark props 1 "by id only" $prop_id
*materialupdate props 1 "$mat_name"
*clearmark props 1
```

Important: `*materialupdate` expects material name, not material ID.

Set values/datanames:

```tcl
*setvalue curves id=$curve_id STATUS=2 12300=1
*setvalue curves id=$curve_id points=$points STATUS=2
*setvalue curves id=$curve_id STATUS=2 12301=2
```

Attribute update families:

```text
*attributeupdateint
*attributeupdatedouble
*attributeupdatestring
*attributeupdateintarray
*attributeupdatedoublearray
*attributeupdatestringarray
*attributeupdateentitymark
*attributeupdateentityidarray
*attributeupdateentitymark
```

Examples:

```tcl
*attributeupdateint props $pid 3065 2 2 0 1
*attributeupdatestring props $pid 3066 2 2 0 $long_name
*attributeupdatedouble properties $pid 431 9 2 0 $thickness

eval *createdoublearray $arraylength $listx
eval *attributeupdatedoublearray curves $curve_id 3311 1 2 0 1 $arraylength
```

Delete/mask/display:

```text
*deletemark
*maskmark
*unmaskmark
*entityhighlighting 0|1
*retainmarkselections 0|1
hm_callpanel
hm_setpanelproc
hm_editcard
hm_usermessage
```

## Table Data Patterns

### Direct Tcl Dict Rows

Workspace `Nastran Control` prefers pure Tcl row dicts, then maps them to
Tktable cells:

```tcl
set tableData(0,0) "Comp Label"
set tableData($r,0) [dict get $row label]
set tableData($r,1) [dict get $row comp_id]
set tableData($r,2) [dict get $row prop_card]
set tableData($r,3) [dict get $row material_label]
set tableData($r,4) [dict get $row mat_id]
```

This is easy for AI-generated scripts: scan HM once, store list-of-dicts, sort
or filter in memory, then redraw table.

### Generic DataName Table

Altair standard Material/Property/Component tables use a schema and callbacks.

Required pieces:

```tcl
proc ::Tool::addDataNames {} {
    clearDataNames
    addDataName "name" "Name" "ascii" "left" "normal" 20 "" 0 1
}

proc ::Tool::tblGet_name {id} {
    return [hm_getentityvalue props $id name 1 -byid]
}

proc ::Tool::tblSet_name {id value} {
    *renamecollector props [hm_entityinfo name props $id] $value
    return $value
}

::Tool::tbl::tableStart edit all
```

Use this when you want a large editable spreadsheet-like browser with menu,
filtering, CSV/HTML save, column config, and per-cell validation.

## Higher Level Table APIs

The broad install scan also found a higher level app-menu table helper under
`::hw::appmenu::apptable::*`. It appears in HyperWorks app/run/register solver
panels rather than the older Nastran table scripts. Use it when an existing
app-menu panel already uses this framework.

Observed commands:

```text
::hw::appmenu::apptable::CreateTable
::hw::appmenu::apptable::DeleteTable
::hw::appmenu::apptable::DefineTableColumn
::hw::appmenu::apptable::AlterTableColumn
::hw::appmenu::apptable::LoadTableData
::hw::appmenu::apptable::AppendTableData
::hw::appmenu::apptable::AppendEmptyRow
::hw::appmenu::apptable::DisplayTable
::hw::appmenu::apptable::CommitTable
::hw::appmenu::apptable::ClearTable
::hw::appmenu::apptable::RetrieveTableData
::hw::appmenu::apptable::RetrieveRowData
::hw::appmenu::apptable::RetrieveColumnData
::hw::appmenu::apptable::GetTableCellValue
::hw::appmenu::apptable::SetTableCellValue
::hw::appmenu::apptable::GetTableActiveCellValue
::hw::appmenu::apptable::SetTableActiveCellValue
::hw::appmenu::apptable::DeleteRowData
::hw::appmenu::apptable::DeleteTableData
::hw::appmenu::apptable::ActivateCell
```

Decision rule:

```text
Need simple custom GUI     -> raw Tk + Tktable, like _clean/lib/ui_table.tcl.
Need Nastran-like browser  -> DataNameTable pattern from tablebase_nast_prop.tcl.
Already inside appmenu UI  -> ::hw::appmenu::apptable.
Need modern hwtk controls  -> hwtk::dialog + hwtk widgets.
```

## CSV/File APIs

Workspace CSV helpers:

```text
::nc::csv::quote
::nc::csv::puts_row
::nc::csv::parse_line
::nc::csv::to_dict
::nc::csv::read_file
::nc::csv::read_dicts
::nc::csv::write_file
```

Session CSV files:

```text
materials.csv   -> mat_id,label,type,e,nu,rho,note
comps.csv       -> comp_id,comp_name_hm,label,prop_id,prop_type,case
assignments.csv -> comp_id,material_label
audit.csv       -> timestamp,action,comp_id,comp_label,prop_id,mat_before,mat_after,status,note
```

Standard HyperMesh tables also export CSV/HTML via `tk_getSaveFile` and then
loop visible datanames/rows.

## Useful Recipes

Scan components, properties, materials:

```tcl
proc scan_components {} {
    *clearmark comps 1
    *createmark comps 1 all
    set ids [hm_getmark comps 1]
    *clearmark comps 1

    set rows {}
    foreach cid [lsort -integer $ids] {
        set cname [hm_getvalue comps id=$cid dataname=name]
        set pid 0
        catch {set pid [hm_getvalue comps id=$cid dataname=propertyid]}

        set pcard ""
        set mid 0
        set mname ""
        if {$pid > 0} {
            catch {set pcard [hm_getcardimagename props +$pid -byid]}
            catch {set mid [hm_getentityvalue props +$pid material.id 0 -byid]}
            if {$mid > 0} {
                catch {set mname [hm_getentityvalue props +$pid material.name 1 -byid]}
            }
        }

        lappend rows [dict create comp_id $cid comp_name $cname prop_id $pid prop_card $pcard mat_id $mid mat_name $mname]
    }
    return $rows
}
```

Build a compact editable table:

```tcl
namespace eval ::mygui {
    variable win .mygui
    variable tbl ""
    variable tableData
    variable rows {}
}

proc ::mygui::open {rows} {
    variable win
    variable tbl
    variable tableData
    variable rows

    set ::mygui::rows $rows
    catch {destroy $win}
    toplevel $win
    wm title $win "Model Table"

    frame $win.tf
    pack $win.tf -fill both -expand 1

    set tbl [table $win.tf.t \
        -variable ::mygui::tableData \
        -titlerows 1 \
        -rows [expr {[llength $rows] + 1}] \
        -cols 3 \
        -selecttype row \
        -selectmode extended]
    pack $tbl -fill both -expand 1

    set tableData(0,0) "Comp"
    set tableData(0,1) "Prop"
    set tableData(0,2) "Mat"
    set r 1
    foreach row $rows {
        set tableData($r,0) [dict get $row comp_name]
        set tableData($r,1) [dict get $row prop_card]
        set tableData($r,2) [dict get $row mat_name]
        incr r
    }
    $tbl reread
}
```

Rename a component safely:

```tcl
set old_name [hm_getvalue comps id=$cid dataname=name]
if {$new_name ne "" && $new_name ne $old_name} {
    *renamecollector comps $old_name $new_name
}
```

Assign material to component's property:

```tcl
set pid [hm_getvalue comps id=$cid dataname=propertyid]
set mat_name [hm_getvalue mats id=$mid dataname=name]
if {$pid > 0 && $mat_name ne ""} {
    *clearmark props 1
    *createmark props 1 "by id only" $pid
    *materialupdate props 1 "$mat_name"
    *clearmark props 1
}
```

Export selected Tktable rows to TSV clipboard:

```tcl
set sel {}
foreach cell [$tbl curselection] {
    set r [lindex [split $cell ,] 0]
    if {$r >= 1} { lappend sel $r }
}
set lines {}
foreach r [lsort -unique -integer $sel] {
    lappend lines [join [list $tableData($r,0) $tableData($r,1) $tableData($r,2)] "\t"]
}
clipboard clear
clipboard append [join $lines "\n"]
```

## Cautions

- Load/verify the Nastran solver template before relying on card image names.
- `hm_getvalue` and `hm_getentityvalue` overlap; keep fallbacks because older
  HM scripts mix both styles.
- `*materialupdate props 1 "$mat_name"` uses material name, not ID.
- Property/material relationships are often card/template dependent; test
  datanames in the loaded profile.
- Shared properties affect all components that reference them. In this project,
  shared PBUSH is tagged as `case_type 2` and assignments warn but proceed.
- Case 3 components have no property; skip material assignment unless a property
  is created first.
- Tktable table state must be temporarily normal for inline edit, then disabled
  again to avoid accidental edits.
- Dialogs using `grab` + `tkwait window` block until destroyed; use carefully.
