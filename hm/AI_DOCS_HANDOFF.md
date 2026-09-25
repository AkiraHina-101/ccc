# AI Docs Handoff

## Required Project Protocol

Any AI/session continuing this workspace must also read the root `HANDOFF.md`
first. The user explicitly requires every session to update the handoff trail and
to verify before claiming work is done.

Non-negotiable rules:

- Update `HANDOFF.md` and/or this file after making project changes. Record the
  changed files, intent, and verification commands/results.
- Always verify before the final answer. For UI/action changes, run Tcl source
  checks, a Tk/Tktable smoke when possible, `git diff --check`, and the forbidden
  preview safety scan.
- `_clean` is the active implementation target. `_ref` is reference material
  only unless the user explicitly asks to edit it.
- Do not clone the old `_ref` UI layout. Use only suitable documented Tk/Tktable
  and optional HM/HWT APIs, and redesign proactively for the user's workflow.
- In the current preview phase, do not call model-mutating/risky HM commands from
  UI paths. Keep New/Duplicate/Delete/Apply/Isolate/Capture staged/no-op until a
  later gated phase verifies mutation APIs on a test model.

Latest implementation status as of 2026-06-14:

- 2026-06-16 follow-up: `_clean/lib/ui_table.tcl` now has real preview-only
  handlers for View image/text sizing, `Action > Apply All Staged` is enabled
  for all-tab pending-label commits, and `Validate` checks all four tab caches
  instead of only visible rows. `_clean/tests/test_ui_table_logic.tcl` covers the
  new display helpers, validation, and all-tab pending sync. Checks run:
  `test_ui_table_logic.tcl` 11 PASS, `test_session.tcl` 25 PASS, source/parse
  checks for `ui_table.tcl` and `nastran_control.tcl`, `git diff --check` on
  touched files, and forbidden preview safety scan on `ui_table.tcl` with no
  matches.
- 2026-06-16 later follow-up: `Import Tab...` now performs real active-tab CSV
  import in preview memory. It maps headers by visible labels or raw field keys,
  merges by stable tab ID, syncs General/Component by `comp_id`, appends new
  preview rows for Property/Material IDs, skips unknown General/Component IDs,
  imports labels/material labels/notes/mass/image paths/card/numeric fields, and
  reports matched/new/changed/invalid counts. No HM mutation commands are called.
  `_clean/tests/test_ui_table_logic.tcl` now includes import merge/append smoke
  coverage and passes 20 checks; `test_session.tcl` still passes 25 checks.
- 2026-06-16 import-confirm follow-up: `Import Tab...` now opens an `Import
  Preview` dialog before changing the table. The dialog shows tab/file plus
  matched/new/changed/invalid counts and has `Apply Import` / `Cancel`; closing
  or canceling leaves table data untouched. The import logic is split into
  `_import_build_plan` and `_apply_import_plan`, while `_import_tab_csv` remains
  as direct apply for offline tests. `test_ui_table_logic.tcl` now passes 22
  checks; `test_session.tcl` still passes 25 checks.
- 2026-06-16 import-ID follow-up: Property/Material import now handles editing
  `Prop ID` / `Mat ID` in Excel during a full-tab round trip. When CSV row count
  matches the current tab row count, unmatched IDs are treated as row-position
  rekeys and update the existing preview row instead of appending a fake new
  material/property. Different row counts still append valid new Property or
  Material IDs. The Import Preview/status now reports `ID change(s)`.
  `test_ui_table_logic.tcl` now passes 27 checks; `test_session.tcl` still
  passes 25 checks.
- 2026-06-16 apply/worklist follow-up: `Action > Apply to HM...` now builds a
  gated action plan from dirty Component rows and, after confirmation, calls
  `::nc::mutations::apply_component_hm_changes` for verified component rename
  and property material assignment only. Unsupported staged fields remain
  preview-only and are counted as skipped/unsupported. `mutations.tcl` writes
  START/OK/FAIL audit rows for those verified HM actions. Worklist now accepts
  either `Comp ID` or `Component Label`, one per line, and filters Component by
  either value. `test_ui_table_logic.tcl` now passes 34 checks; `test_session.tcl`
  still passes 25 checks. HM visual/runtime verification of `Apply to HM...` is
  still required on a copy of a model.
- 2026-06-16 apply-baseline follow-up: `Apply to HM...` now compares staged
  values against HM baseline fields before creating actions. Component rows keep
  `hm_comp_name`, `hm_prop_id`, `hm_mat_id`, and `hm_material_label`; dirty
  markers alone are insufficient. Rename only applies if the preview component
  label differs from `hm_comp_name`; material assignment only applies if preview
  `mat_id` differs from `hm_mat_id`. Successful apply updates the baseline so
  repeat apply skips unchanged rows. `test_ui_table_logic.tcl` now passes 37
  checks; `test_session.tcl` still passes 25 checks.
- 2026-06-16 import-sort/reorder follow-up: Property/Material CSV export now
  includes an `NC Original ID` metadata column. Import uses it to rekey the
  original preview row even when the table was sorted before export or the Excel
  sheet was reordered before re-import. Legacy CSVs without metadata no longer
  blindly rekey by row position after reorder; they only use the fallback when
  the case is not ambiguous, such as a one-row file or when secondary identity
  fields still match. Ambiguous reordered legacy rows are skipped/invalid rather
  than mapped to the wrong material/property. `test_ui_table_logic.tcl` now
  passes 42 checks, including sorted import with original ID and legacy sorted
  import safety; `test_session.tcl` still passes 25 checks.
- `_clean/lib/ui_table.tcl` has a compact grouped command band (`Data`, `Rows`,
  `Focus`, `View`), context Property/PBUSH controls, a compact Find group, and
  light Tktable borders/alternating rows. Active/selected/edit/dirty cell colors
  were tuned to keep dark readable text; edit cancel/unchanged commit restores
  cell tags so a double-clicked cell does not lose its normal style. Menus now
  carry secondary/config commands, including Display checkbuttons for toolbar,
  context filter, status log, image/note columns, compact rows, and alternate
  rows. Toolbar groups are context-aware by tab: General hides Edit; Component
  shows Assign/Apply but not New/Duplicate/Delete; Property and Material show
  full Edit; View is shown only for General/Component by default. Table headers
  are real Tk button widgets embedded into Tktable header cells: click sorts,
  drag reorders columns per tab, and `Table > Reset Columns` restores default
  order/widths for the active tab. Tktable resize borders are enabled again, and
  embedded header buttons handle right-edge drag resize plus right-edge
  double-click autofit. Header drag uses a
  6 px threshold: source header turns blue/sunken, the target header is not
  recolored, and a 3 px Tk frame is placed as a vertical insertion marker in the
  gap where the column will be inserted. The release logic is slot-based
  before/after the hovered header, and dragging never triggers sort on release.
  Each top tab button also has a right-click context menu with tab-level actions
  only: open tab, copy tab TSV, export tab CSV, reset columns, show all columns,
  and per-column checkbuttons. Hidden columns are tracked per tab via
  `_hidden_cols($tab)`, while the Display menu Image/Note toggles remain global
  filters. Header-drag reorder no longer crashes when the new sort column has
  mixed integer and blank values: `_sort_rows` validates `_sort_col`/`_sort_dir`
  and uses `lsort -integer` only when every sort value is a valid integer.
  `Component Label` (`comp_user_name`) and `Material Label` (`mat_user_name`)
  cells now route to a separate Label Palette popup instead of relying on the
  incomplete embedded `ttk::combobox` experiment. The palette opens from
  `Selection > Label Palette...`, the toolbar `Labels...` button, or
  double-clicking label cells. It provides Find, listbox selection,
  `Assign Cell`, `Fill Selection`, `Assign Sequence`, `Paste List...`,
  `Apply Pending`, and `Cancel Pending`. Palette assignment writes only
  `_pending_values` / `_pending_fields` first, so the table displays the chosen
  label immediately with the yellow `tag_dirty` highlight, but the committed row
  data is unchanged. Known Material Label choices also set pending `mat_id`.
  `Apply Pending` or the main `Apply` action commits those pending labels into
  preview row data and clears yellow; `Cancel Pending` clears pending values and
  reverts the display. Normal edited dirty fields are still tracked in
  `_dirty_fields`, but yellow highlight is now reserved for pending palette
  choices only. No HM mutation commands are called. A HyperMesh repeated
  double-click error, `window name "nc_label_palette" already exists in parent`,
  is fixed by reusing an existing `.nc_label_palette` widget even if the
  namespace variable was reset, and by mapping the palette close button to
  `wm withdraw`.
  The palette's original combined `Auto Next` has been split into two
  independent toggles: `Next Row` advances the active table row/cell after
  `Assign Cell`, and `Next Label` advances the selected palette item. Both
  default on to preserve the initial palette behavior, but they can be toggled
  independently for repeated-label or one-label-per-row workflows.
- `_clean/nastran_control.tcl` builds hybrid preview data for General,
  Component, Property, and Material tabs.
- `_clean/lib/session.tcl` includes Altair Tcl path handling fixes and
  table-only session persistence. A session folder stores the current UI table
  cache in `edits/matprop_general.csv`, `edits/matprop_component.csv`,
  `edits/matprop_properties.csv`, and `edits/matprop_materials.csv`.
  `Session > Save Session` writes the 4 tabs, `Open Session...` loads them back
  without FEM/HM scan, and closing the table asks whether to save first. Pending
  palette `_pending_*` fields and other internal keys are not written; this is
  CSV table data only, not model mutation.
  Table-related popups now use `_place_companion_window` so they do not hide the
  main table: Label Palette, Paste Labels, and Worklist are positioned beside
  the table window, preferring the right side, falling back left, and clamping to
  the screen. Label Palette no longer follows the active cell bbox because that
  placement covered table rows.
  In the save-before-close confirmation, `Cancel` explicitly restores/raises the
  table window and aborts closing; canceling the Save Session folder selection
  after choosing `Yes` also restores the table. `No` closes without saving.
  Component tab now includes only a lazy total `Mass` column; startup/scan
  leaves it blank. The Component toolbar has a `Calculate Mass` button; only
  that action calls `::nc::app::calculate_component_masses`, which uses the
  visible component ID with `*createmark comps 1 "by id" $comp_id` and
  `hm_getmass comps 1 0 0` when that HyperMesh API exists. Only `lindex 0`
  total mass is displayed; Structural/NS breakdown columns were removed.
  Results update General/Component rows and mark the table session dirty so they
  can be saved to CSV. Right-click the Mass header to switch display unit
  between `kg` and `ton`; values are shown in scientific notation with at most 3
  decimal places, with `ton` = raw mass / 1000.
  Column resizing is re-enabled: Tktable resize borders are configured again,
  and embedded header buttons support right-edge drag to resize plus
  right-edge double-click to autofit to visible data. Double-clicking a raw
  table header cell also autofits the column.

Checks already run after the latest UI redesign:

```text
UI_TABLE_SOURCE_OK
CONTROL_AREA_BUILD_OK
FULL_UI_BUILD_OK
FULL_UI_VISUAL_STATE_OK
MENU_DISPLAY_SMOKE_OK
CONTEXT_TOOLBAR_SMOKE_OK
COLUMN_REORDER_SMOKE_OK
HEADER_BUTTON_REORDER_SMOKE_OK
HEADER_DRAG_FEEDBACK_SMOKE_OK
HEADER_INSERT_INDICATOR_LOGIC_OK
TAB_COLUMN_VISIBILITY_LOGIC_OK
SORT_MIXED_INTEGER_EMPTY_OK
COLUMN_REORDER_SORT_GUARD_OK
CELL_DROPDOWN_STAGE_LOGIC_OK
COMPONENT_PICKER_COLUMN_REMOVED_OK
LABEL_PALETTE_STAGE_LOGIC_OK
LABEL_NEXT_TOGGLES_LOGIC_OK
LABEL_PENDING_CANCEL_APPLY_LOGIC_OK
LABEL_PALETTE_REOPEN_EXISTING_OK
TABLE_SESSION_SAVE_LOAD_OK
COMPANION_POPUP_GEOMETRY_OK
CLOSE_CANCEL_RESTORE_OK
COMPONENT_MASS_COLUMNS_OK
LAZY_COMPONENT_MASS_OK
TOTAL_MASS_UNIT_FORMAT_OK
HEADER_RESIZE_AUTOFIT_OK
Known gap: HM visual verification says in-cell dropdown still does not appear;
old embedded-combobox feature not complete. New Label Palette pending workflow
still needs HM visual verification for placement/focus and yellow-clear behavior.
NASTRAN_CONTROL_BUILD_OK
git diff --check: clean except Git CRLF warnings on Windows
Forbidden preview safety scan on `_clean/lib/ui_table.tcl` and
`_clean/nastran_control.tcl`: no matches
Full `_clean` scan still sees legacy `*materialupdate` in
`_clean/lib/mutations.tcl`; current preview UI paths do not call it.
```

Purpose: read this first when continuing the documentation-building work in this
workspace. The goal is to help any AI quickly understand the latest context and
continue the HyperMesh/HyperView/HyperWorks API/reference research without
restarting from zero.

## Current Objective

Build and maintain AI-readable Markdown references for scripting GUI automation
around Altair HyperMesh, HyperView, and HyperWorks, especially for:

- HyperMesh Tcl GUI APIs from `nastran.mac` and installed Altair scripts.
- Dialog/table/widget APIs, including buttons, checkbox, tables, images in
  tables, and related GUI controls.
- Nastran component/property/material/card structures and editable fields.
- Color, display, render, 3D FEM model view, and capture APIs.
- Embedded Python support and how Python can drive Tcl/HWI commands.
- HyperMesh/HyperView batch capability and its practical limits.
- Large Nastran BDF/OP2 mode-shape capture workflow using HvTrans and
  HyperView.

The user wants deep, careful local research. Do not optimize for speed over
coverage.

## User Context

Main practical scenario:

```text
Model:  Nastran BDF around 1.5 GB
Result: OP2 around 40-80 GB
Goal:   load selected mode shapes faster and capture images/GIFs without waiting
        for HyperView to repeatedly parse huge raw OP2/BDF files
```

Current recommended direction:

```text
OP2 + BDF
  -> HvTrans GUI or hvtrans Tcl command layer
  -> filtered H3D with only needed modal subcase/modes/results
  -> HyperView MVW/template for view/style
  -> script capture PNG frames or AVI
  -> external GIF build if needed
```

Do not describe this as a fully proven production pipeline yet. It is a proposed
workflow based on local source/script inspection and should be validated on a
small real OP2/BDF sample.

## Read These Docs First

Primary workflow docs:

```text
_clean/docs/OFFICIAL_ALTAIR_2022_3_VERIFICATION.md
_clean/docs/OP2_BDF_MODESHAPE_CAPTURE_WORKFLOW.md
_clean/docs/HVTRANS_CONVERSION_WORKFLOW_REF.md
_clean/docs/HYPERWORKS_BATCH_API_REF.md
_clean/docs/HYPERWORKS_PYTHON_VIEW_CAPTURE_API_REF.md
```

Core API refs:

```text
_clean/docs/HYPERMESH_GUI_API_REF.md
_clean/docs/HYPERMESH_ENTITY_MODEL_API_REF.md
_clean/docs/HYPERMESH_NASTRAN_CARD_FIELD_REF.md
_clean/docs/HYPERMESH_COLOR_RENDER_API_REF.md
_clean/docs/HYPERMESH_PYTHON_EMBEDDING_API_REF.md
```

Supporting project notes:

```text
_clean/docs/API_VERIFIED.md
_clean/docs/GUI_VERIFY_CHECKLIST.md
_clean/docs/SPEC.md
_clean/docs/MUTATION_PRIMITIVES.md
```

## Important Local Install Paths

Altair install inspected so far:

```text
<ALTAIR_INSTALL_DIR>
<ALTAIR_INSTALL_DIR>/hm
<ALTAIR_INSTALL_DIR>/hw
<ALTAIR_INSTALL_DIR>/hwx
<ALTAIR_INSTALL_DIR>/io/result_readers
```

Important files already inspected:

```text
<ALTAIR_INSTALL_DIR>/utility/scripts/function_keys.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/postquery/hwpGet_functions.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/hw/tests/framework/ImageTestCommon.tst.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/preferences/xml/imagecapture.xml
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransgui.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransOpenResult.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransSaveConfig.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransOpenConfig.tcl
```

## Current Verified Findings

HvTrans:

```text
HvTrans converts/filter OP2/BDF/result content to H3D.
HvTrans does not capture viewport images or GIFs.
HvTrans GUI is a wrapper around the hvtrans command layer.
GUI menu entry observed: tcl: ::hw::RunHVTrans
Executable/library observed:
  io/result_readers/bin/win64/hvtrans.exe
  io/result_readers/bin/win64/hvtranstcl.dll
```

Important HvTrans command flow:

```tcl
hvtrans control SetResultFile $op2
hvtrans control LoadResults
set subcases [hvtrans result GetSubcases]
set modes    [hvtrans result GetSimulations $subcase_id]
set types    [hvtrans result GetDataTypes $subcase_id]

hvtrans control SetModelFile $bdf
hvtrans control LoadModel

hvtrans config Reset
hvtrans config AddItem Parts
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/(All)

hvtrans control SetOutputFile $h3d
hvtrans control StartTranslation
```

Key practical implication: mode selection in HvTrans happens after
`LoadResults`, because the OP2 metadata must be read/indexed before subcases and
simulations/modes are known. Code does not remove this first scan cost.

HyperView capture:

```text
AVI animation capture is locally confirmed in installed scripts:
  CaptureAnimation AVI
  CaptureAnimationByAreaPercentage AVI
  GetAVIExportOptionsHandle

GIF appears in GUI/report/test metadata, but local production-style Tcl examples
mainly use AVI. Treat direct CaptureAnimation GIF as target-machine experiment.

Safest automation path:
  PNG frames -> external GIF
or:
  AVI -> external GIF
```

Draw/wait rule:

```text
After changing mode/frame/view/scale/contour, force Draw before capture.
Installed scripts use after idle before area animation capture because immediate
capture can interfere with drawing.
```

Modal phase control:

```tcl
page SetAnimationMode modal
page GetAnimatorHandle anim
anim SetIncrementBy angle
anim SetNumberOfFrames $n
anim SetIncrement $angle_increment
anim SetCurrentFrame $frame
client Draw
```

Python:

```text
Most reliable view/capture APIs are Tcl/HWI.
Embedded Python should drive Tcl through Tclinter.tcl.eval/call.
Python is useful as orchestration glue, not as a replacement for Tcl/HWI handles.
```

## How To Continue Research

Use local search first:

```powershell
rg -n "pattern" "<ALTAIR_INSTALL_DIR>"
rg --files "<ALTAIR_INSTALL_DIR>" | rg "name"
```

Prefer narrow searches after a broad hit. Good keyword clusters:

```text
HvTrans:
  RunHVTrans
  StartTranslation
  LoadResults
  GetSubcases
  GetSimulations
  GetDataTypes
  SetOutputFile
  SaveConfig
  Config<H3D>

Capture:
  CaptureAnimation
  CaptureAnimationByAreaPercentage
  CaptureScreen
  CaptureScreenToSize
  CaptureWindow
  GetAVIExportOptionsHandle
  GIF
  AVI

Animation/view:
  SetAnimationMode
  SetCurrentFrame
  SetIncrementBy
  SetNumberOfFrames
  GetAnimatorHandle
  GetViewControlHandle
  SetOrientation
  SetOrtho
  SetFrustum
  Draw
  after idle
```

When adding information, include:

```text
What command/API is called.
Where it was found locally.
What it can do.
What it cannot do.
How confident the finding is.
Whether GUI, Tcl/HWI, Python bridge, hmbatch, hw.exe batch, or external tool is
the right layer.
```

## Documentation Style

Keep docs AI-readable and practical:

- Prefer explicit command snippets over prose-only descriptions.
- Mark uncertain items as "needs target-machine verification".
- Distinguish GUI capability from script capability.
- Distinguish HvTrans conversion from HyperView viewport/capture.
- For large OP2/BDF workflow, always discuss performance in terms of avoiding
  repeated raw OP2/BDF loads.
- Do not claim batch/headless rendering is reliable unless tested.
- Do not remove existing findings unless they are proven wrong.

## Known Open Questions

These are useful next research targets:

```text
1. Does direct `CaptureAnimation GIF` work in this exact install when run in a
   real HyperView graphics session?
2. Can `hvtrans.exe` be driven directly with command-line options, or is the
   reliable route a Tcl wrapper that loads `hvtranstcl.dll`/runs inside the
   expected Altair environment?
3. What is the exact best script launch command for non-interactive HyperView
   capture on this machine: `hw.exe /clientconfig hwpost.dat -b -tcl`, `hw.exe
   -tcl`, or an HWX profile launch?
4. How much faster is a filtered H3D versus raw OP2+BDF for the user's actual
   1.5 GB / 40-80 GB files?
5. Does `Output H3D for every step` create a useful file-per-mode layout for
   parallel capture, and what filenames does it produce?
```

## Latest Session State

Last completed task: researched deeper into HvTrans, HyperView capture, GIF/AVI,
batch capability, and Python capture support; then cross-checked the docs
against Altair HyperWorks Desktop official help and added
`OFFICIAL_ALTAIR_2022_3_VERIFICATION.md`. A later verification pass tightened
the labels: HyperMesh Data Names/GUI/view/capture-to-file categories are
official-supported; exact HvTrans Tcl command names, scripted AVI/GIF capture,
and filtered-H3D mode-selection behavior remain local-install/runtime-test
items; `*setvalue` is heavily local-install verified, while the online official
page checked so far verifies the broader Modify Commands mechanism and
`*createentity` directly. The main docs now have a `Verification status` block
near the top; read that block before treating any command/workflow as official.

Next natural task: validate the proposed pipeline on a small real OP2/BDF pair,
continue official-doc cross-check for narrower command pages, or continue local
source research around HvTrans CLI/script launch and direct GIF capture.
