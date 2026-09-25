# GUI Altair / HyperMesh Tcl Notes

## Scope

This note captures GUI patterns observed from Altair HyperMesh Nastran Tcl tools. Use it before changing `material_property_mapper.tcl` GUI behavior.

Verification status:

```text
LOCAL-INSTALL:
  GUI patterns here are from installed HyperMesh Nastran Tcl scripts and
  workspace macros.

OFFICIAL:
  Official help confirms the broader HyperMesh Tcl GUI Commands category, but
  this file's exact macro/table/dialog patterns are local-source notes.
```

Primary local references:

- `production_2/nastran_custom.mac`
- `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/nast_comp_main.tcl`
- `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/nast_prop_main.tcl`
- `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/tablemats.tcl`
- `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/tablebase_nast.tcl`
- `<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/tablebase_nast_prop.tcl`

## Macro Page Pattern

`nastran_custom.mac` builds the HyperMesh macro page, not the table GUI itself.

Observed pattern:

```tcl
*createbuttongroup(0, 0, "Nastran1", 0, 0, 5, BUTTON, "Nastran macros", "macroSetActivePage", 6)
*createbuttongroup(0, 0, "Nastran2", 0, 5, 5, BUTTON, "Nastran macros", "macroSetActivePage", 7)
*createbutton(6, "Component Table", 0, 0, 10, BUTTON, "Edit/Review/Create Comps", "EvalTcl", "nastran/nast_comp_main.tcl")
```

The page buttons call Tcl scripts. The table behavior is in those scripts and their shared `tablebase_*` files.

## Nastran Table Architecture

The Component Table is built like this:

- `nast_comp_main.tcl` creates namespace `::NastCompTable::`.
- It sources:
  - `tablebase_nast.tcl`
  - `postnastrancolor.tcl`
- Custom columns are declared with `addDataName`.
- Per-column read/write behavior is implemented via `tblGet_*` and `tblSet_*` procedures.
- `tableStart` calls `addDataNames`, parses lookup data, loads config, gets user/model data, then calls `buildTableWin`.

The Property Table mirrors this:

- `nast_prop_main.tcl`
- `tablebase_nast_prop.tcl`
- namespace `::NastPropTable::`

Material Table has its own implementation in `tablemats.tcl`, but uses the same HyperMesh Tcl UI family (`hwt`, `AddEntry`, `CanvasButton`, normal `frame`, `button`, `toplevel`).

## Column Definition Pattern

Nastran table columns are data-driven.

Example from Component Table:

```tcl
addDataName "name"     "Comp Name"     "ascii"   "left"   "normal"   15 ""                       0   1
addDataName "pid"      "Prop Id"       "integer" "right"  "normal"   10 ""                       0   1
addDataName "material" "Mat Name"      "ascii"   "left"   "disabled" 15 [getMaterials $matDbPath] 0   1
addDataName "matid"    "Mat id"        "integer" "center" "disabled" 10 ""                       0   1
```

Column metadata includes:

- internal name
- header text
- type
- alignment
- state
- width
- optional list source
- sum behavior
- visible flag

Design implication for `Nastran Model Control`:

- Keep schemas declarative.
- Each visible field should have one clear owner: column definition, read function, write function.
- Avoid ad hoc UI columns that are not tied to schema behavior unless they are explicit action/control columns.

## Table Widget Pattern

Nastran tables use the Tcl `table` widget:

```tcl
set table [table $tableFrame.table -highlightthickness 0 \
    -xscrollcommand "$tableFrame.sx set" \
    -yscrollcommand "$tableFrame.sy set"]
set scrollX [scrollbar $tableFrame.sx -orient h -command "$table xview"]
set scrollY [scrollbar $tableFrame.sy -orient v -command "$table yview"]
```

Typical configuration includes:

- `-variable` backing array
- `-browsecommand`
- `-cols`, `-rows`
- `-titlerows`
- `-selecttype row`
- `-selectmode extended`
- row/column resize support
- tags for active/selected/cell states

Design implication:

- The current tool using `table` is consistent with Nastran.
- Prefer stable table data + table tags over overlay widgets.
- If a control is needed, prefer a toolbar/dropdown workflow or a deliberate action column instead of floating widgets on top of cells.

## Toolbar / Top Control Pattern

Nastran Component Table builds a top toolbar with compact frames:

- `topFrame.subFrame1`: "New Comp:" selector and `Organize` button.
- `topFrame.subFrame2`: "Assign Values:" selector, value editor/list, and `Assign` button.

Dropdowns are built with `AddEntry`, not by embedding a combobox widget into every table cell.

Example:

```tcl
AddEntry $topFrame.subFrame2.dataName -listVar notyping fromPopDown ::dataNameList \
    -textvariable ::NastCompTable::tbl::compData(currentDataName) -iconname small_arrow \
    -withoutPacking -entrywidth 25 \
    -selectionFunc "::NastCompTable::tbl::updateValueField $topFrame.subFrame2.value"
```

Important detail:

```tcl
[::hwt::Ent $topFrame.subFrame2.dataName] config -exportselection 0
```

The comment says this prevents table selection from being cleared when the list button is pressed.

Design implication:

- For material assignment, the closest Nastran-style workflow is a top `Assign Values` control:
  - choose field, e.g. `Mat Label`
  - choose value from list
  - click `Assign`
  - apply to selected rows
- For per-row changes, a narrow action column can be acceptable, but it should be stable and table-native, not a transient overlay.
- Do not make a normal cell click open the list. Nastran list opening is done through the small arrow control.

## Dropdown / Box List Pattern

Nastran uses:

```tcl
AddEntry ... -listVar notyping fromPopDown ::list_var \
    -textvariable ... -iconname small_arrow \
    -withoutPacking -entrywidth 25
```

Meaning:

- `fromPopDown`: value comes from a popup/dropdown list.
- `notyping`: user cannot freely type arbitrary text.
- `small_arrow`: displays arrow button.
- `listVar`: variable holding list content.
- `textvariable`: target variable updated by selection.

Material selector source:

- Component/Property tables build material lists from current HyperMesh materials via `getMaterials`.
- The first list entry in examples may be a group name such as `HM-Mats`.

Design implication for Material Label:

- The list should show labels, not IDs.
- IDs should update through mapping after selection.
- A toolbar selector using `AddEntry` is closer to Altair/Nastran than per-cell embedded comboboxes.
- If per-row direct control is required, use a visible action column and keep the table cells as data.

## Button Pattern

Nastran uses both regular `button` and `hwt::CanvasButton`.

Examples:

```tcl
hwt::CanvasButton $createset [hwt::DluWidth 40 [hwt::AppFont]] [hwt::DluHeight 14 [hwt::AppFont]] \
    -command "::NastCompTable::tbl::organize_set" \
    -text "Organize" \
    -help "Click to Organize" \
    -state normal \
    -takefocus 0 \
    -font [hwt::AppFont]
```

Regular buttons are also used inside dynamic value editor frames:

```tcl
button $widgetName.value.btn -text "Assign" -bd 1 -command "::NastCompTable::tbl::selectionSetValue $name"
```

Design implication:

- Use `hwt::CanvasButton` where HyperMesh GUI style matters and it is available.
- Fall back to normal `button` for hmbatch/Tk compatibility.
- Keep buttons compact, low padding, and action-oriented.

## Progress Pattern

Nastran table startup uses a small progress window:

```tcl
pbStart "Status" "Creating table ..."
...
pbUpdate $cnt
...
pbClose
```

Progress implementation:

- Creates `.mainGuiForProgressBar`.
- Calls `hm_blockmessages 1`.
- Calls `hm_usermessage $message`.
- Creates a small top-level with:
  - label message
  - status frame
  - Cancel button
- `pbUpdate` adds small blue frame blocks into `statusFrame`.
- No numeric percent is shown.

The visible progress is the blue segmented bar itself.

Design implication:

- For our load dialog, avoid displaying numeric `%`.
- Show status text such as `Creating table ... Component` if useful.
- Use blue segmented blocks for progress.
- If ETA is added, keep it textual and secondary: e.g. `elapsed 00:08 - ETA 00:05`.
- Do not replace the bar with percent text.

## Table Startup Flow

Observed `tableStart` flow:

1. Disable mark selection/highlighting as needed.
2. If window exists and mode is not rebuild, deiconify it.
3. Start progress window with `pbStart`.
4. Store window geometry if rebuilding.
5. Clear old data/config arrays.
6. Call `addDataNames`.
7. Call lookup parsing/population.
8. Load table config.
9. Read user/model data.
10. Build table window.
11. Install user procedures and popup menu.
12. Close progress at end.

Design implication:

- Preload and GUI build should be a single clear startup flow.
- Avoid tab-triggered re-scan after startup unless user explicitly reloads or a mutation invalidates data.
- If preserving geometry/layout slows startup or causes confusion, keep it explicit through Arrange/Fit.

## Menus / Context Menu Pattern

Nastran builds menus with normal Tk `menu`.

Examples:

- Top menu categories:
  - `Table`
  - `Selection`
  - `Display`
  - `Action`
  - `User`
- Context menu:
  - created with `menu`
  - displayed via `tk_popup`
  - bound to mouse button events

Design implication:

- For many actions, prefer menu grouping over crowded toolbar buttons.
- Keep mutation actions under explicit action/menu groups.
- Use context menus for selection-dependent row actions.

## Cell Update Pattern

Nastran does not rebuild the whole table for small updates.

It uses procedures like:

- `setCellState`
- `setCellColor`
- `updateCell`
- `selectionSetValue`
- `updateCompsTable` / `updatepropsTable`

Examples in Nastran scripts update dependent cells after setting material:

- `updateCell $comp material`
- `updateCell $comp matid`
- then update table values/colors.

Design implication:

- Fast actions in our tool should update the changed row/cell and cache.
- Avoid full `ui_refresh` when only one material link changes.
- After material assignment:
  - update label cell
  - update Mat ID cell
  - update model/cache
  - verify model result
  - preserve image cells

## Recommended GUI Direction For Nastran Model Control

### Keep

- Use Tcl `table` widget.
- Keep component/properties/materials as role-specific tabs.
- Keep progress as small `Creating table ...` dialog with blue segmented blocks.
- Keep mutation actions guarded and explicit.

### Change Toward Nastran Pattern

- Add a top assignment strip for Component tab:
  - label `Assign Values:`
  - field selector or fixed `Mat Label`
  - `AddEntry` dropdown with `small_arrow` where available
  - `Assign` button
  - applies to selected rows
- Keep per-cell editing simple. Do not auto-open list on normal cell click.
- Replace floating per-cell overlay with either:
  - top assign strip, or
  - stable narrow action column, if the user still wants row-local access.
- Use `hwt::CanvasButton` for compact HyperMesh-looking buttons where available.
- Use normal Tk fallback if `hwt::CanvasButton`/`AddEntry` is unavailable.

### Avoid

- Floating controls that disappear/reposition badly during scroll/refresh.
- Rebuilding the full table after a single row assignment.
- Loading/refreshing all tabs on every tab click.
- Showing a numeric percent in the progress UI if the user asked for visual bars.

## Current Application Notes

Current `production_2/material_property_mapper.tcl` already uses a Tcl `table` widget. That is aligned with Nastran.

Recent Material Label picker work should be reviewed against this document. The Nastran-style long-term solution should favor a top assignment strip with `AddEntry` dropdown and selected-row `Assign`, while keeping direct row-local edits only if they remain stable and tested.

## Open Questions For Future GUI Work

- Can `AddEntry` be used directly in `production_2/material_property_mapper.tcl` in all HyperMesh contexts where this tool runs?
- Is `hwt::CanvasButton` available and stable in the same contexts as `::hwt::CreateWindow`?
- Should Component tab use:
  - top `Assign Mat Label` control only, or
  - top control plus a row-local narrow picker column?
- Should `GUI_ALTAIR.md` include copied snippets from `tablebase_nast_prop.tcl` after deeper comparison? Current findings show it mirrors `tablebase_nast.tcl` closely.
