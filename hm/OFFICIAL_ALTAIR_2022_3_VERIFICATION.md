# Official Altair 2022.3 Verification Matrix

Purpose: cross-check the local AI-readable documentation in this folder against
Altair's official HyperWorks Desktop 2022.3 help. This file records what is
confirmed by official docs, what is confirmed only by local installed scripts,
and what still needs target-machine testing.

Official entry page used:

```text
https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/chapter_heads/hyperworks_desktop_reference_guides_r.htm
```

Official pages inspected:

```text
HyperWorks Reference Guides
  Confirms the reference-guide categories: external readers/ABF, Generic ASCII
  Reader, Batch Mode, Tcl/Tk Commands, Translators, Result Math, Record and
  Playback, HyperWorks Report, HyperMesh.

Batch Mode
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/hwdref/batch_mode_intro.htm

Run HyperWorks in Batch Mode
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/hwdref/batch_mode_run_hw_t.htm

Tcl/Tk Commands syntax
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/tcl/tcl_tk_syntax_r.htm

Object Hierarchy
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/tcl/object_hierarchy_r.htm

Tcl/Tk command class index
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/chapter_heads/tcl_tk_commands_r.htm

HyperView class index
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/chapter_heads/hyperview_r.htm

poI3DViewCtrl class
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/chapter_heads/poi3dviewctrl_class_r.htm

HyperMesh reference index
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/chapter_heads/hypermesh_r.htm

HyperMesh Data Names
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/hm/data_names_r.htm

HyperMesh tables data names
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/hm/data_names-tables.htm

HyperMesh Scripts
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/chapter_heads/scripts_r.htm

Run Scripts
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/hm/running_scripts_r.htm

Commands and Functions
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/chapter_heads/commands_and_functions_scripts_r.htm

Tcl GUI Commands
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/chapter_heads/tcl_gui_commands.htm

Tcl Modify Commands
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/chapter_heads/tcl_modify_commands.htm

Tcl Query Commands
  https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/chapter_heads/tcl_query_command_names_r.htm
```

## Verification Pass Log

```text
Pass 1:
  Established the official Altair 2022.3 source tree and broad category
  support for Batch Mode, Tcl/Tk Commands, HyperView, HyperMesh, Translators,
  Data Names, and Scripts.

Pass 2:
  Checked narrower HyperMesh official pages for Run Scripts, Tcl GUI Commands,
  Tcl Modify Commands, Tcl Query Commands, Data Names, and table data names.
  This pass upgraded several HyperMesh GUI/model/edit/render items from
  local-only to official-supported at the mechanism/category level.

Pass 3:
  Rechecked HyperView/batch/capture/HvTrans claims. Official docs support the
  HWI Tcl handle model, `CaptureScreen` as an operation-command example,
  HyperView class/view-control APIs, no-GUI batch behavior, and the general
  translator category. Direct HvTrans Tcl command names, AVI/GIF animation
  capture commands, and exact filtered-H3D mode-selection behavior remain
  local-install or runtime-test items until a product command page or target
  session test confirms them.
```

## Official Baseline

The official docs confirm these high-level facts:

```text
1. HyperWorks Desktop has reference guides for Batch Mode, Tcl/Tk Commands,
   Translators, Result Math, Record/Playback, HyperWorks Report, and HyperMesh.

2. Batch mode is supported by `hw.exe -b`; the official docs say it runs without
   displaying the GUI and is typically used with `-tcl filename`.

3. `hw.exe -tcl tcl_file` launches the product and executes a Tcl script.

4. HyperWorks Tcl/Tk scripting is object-centric; commands are applied to object
   handles.

5. Official syntax docs show `hwi GetSessionHandle sess1`,
   `sess1 GetProjectHandle proj1`, and `sess1 CaptureScreen ...` as examples.

6. Object hierarchy docs confirm the HyperView / HyperGraph / HyperWorks Desktop
   command-object model and the HyperView animation client (`poIModel`).

7. HyperView official class index lists `poI3DViewCtrl`, `poIModel`,
   `poIPost`, `poIRenderOptions`, `poIResultCtrl`, `poIScaleCtrl`,
   `poISelectionSet`, `poISubcase`, and related classes.

8. `poI3DViewCtrl` official page confirms view/camera APIs such as Fit,
   FitAllFrames, GetOrientation, GetOrtho, GetPerspectiveMode, GetViewMatrix,
   SaveView, RestoreView, RotateX/Y/Z, SetLookAt, SetOrientation, SetOrtho,
   SetPerspectiveMode, SetViewMatrix, Translate, and Zoom.

9. HyperMesh official index confirms HyperMesh references for API Programmer's
   Guides, Data Names, Ext API, FE Input Readers, HMASCII, Scripts, and Solver
   Templates. The Scripts category is described as covering Tcl commands used to
   query/modify the database and GUI.

10. Official HyperMesh Scripts docs split commands into Tcl GUI Commands, Tcl
    Modify Commands, Tcl Query Commands, and Utility Menu Commands.

11. Official Run Scripts docs confirm Tcl/Tk scripts can be run from the GUI,
    Utility menu, command files, `-tcl <filename>`, and `hmbatch -tcl
    <filename>`. They also state HyperWorks Desktop batch mode does not launch a
    graphical display, so display-requiring commands are ignored or error.

12. Official Tcl Query Commands include `hm_getvalue`, described as querying
    data names, attributes, and metadata on entities.

13. Official Tcl Modify Commands confirm the HyperMesh modify-command category
    for database mutation and include `*createentity`, described as creating a
    new entity with specified data. In this matrix, `*setvalue` is kept as
    local-install verified until a direct official 2022.3 command page is
    captured.

14. Official Tcl GUI Commands include view/display/capture-related commands such
    as `hm_viewfit`, `hm_viewisometric`, `hm_viewshaded`,
    `hm_viewshadedfeatures`, `hm_viewshadedmesh`, `hm_viewwireframe`,
    `hm_windowtoclipboard`, and `hm_windowtofile`.

15. Official Data Names docs explain that template files and Tcl commands use
    data names to access HyperWorks Desktop database information. The same page
    gives `hm_getvalue nodes id=$id dataname=x` and pointer access such as
    `hm_getvalue elems id=$id dataname=node1.id`.

16. Official Data Names index explicitly lists entity groups used in the local
    docs, including components, elements, materials, properties, tables, nodes,
    results, resultsimulations, resultsubcases, sets, systems, and many more.

17. Official `tables` data names confirm table fields such as `cellvalue`,
    `columns`, `rows`, `color`, `color_rgb`, `cardimage`, `cardimagetype`,
    `columnlabel`, `columndatatype`, `id`, `name`, and solver/include fields.

18. Official HyperWorks batch docs state `-b` does not display the GUI and is
    typically used with `-tcl filename`; official HyperMesh Run Scripts docs
    separately warn `hmbatch -tcl` has no graphical display and display-needing
    commands can be ignored or error.

19. Official online pages inspected in this pass did not expose a direct HvTrans
    command reference, nor a direct `CaptureAnimation GIF` reference. Keep those
    entries local-install/runtime-test labeled.
```

## Verification Matrix By Local Doc

### `AI_DOCS_HANDOFF.md`

Status: verified as a local handoff file, not an API reference.

Official support:

```text
The file correctly points future agents to official categories that exist in
Altair help: Batch Mode, Tcl/Tk Commands, HyperView, HyperMesh, and Translators.
```

Local-only:

```text
The specific current-session conclusions about HvTrans, GIF/AVI, and large
OP2/BDF workflow are based on local installed scripts plus prior local research.
```

Action:

```text
Keep this file in `_clean/docs` only so it affects docs work, not unrelated
workspace tasks.
```

### `HYPERWORKS_BATCH_API_REF.md`

Status: partially official-verified, partially local-source verified.

Official support:

```text
Batch mode exists and is run with `hw.exe -b`.
`-b` means no GUI is displayed and the app exits after command-line processing.
`-tcl tcl_file` runs Tcl script on launch.
HyperMesh-specific docs also confirm `hmbatch -tcl <filename>`.
Official Run Scripts docs warn that HyperWorks Desktop batch mode does not
launch a graphical display, so commands requiring display may be ignored or
generate errors.
`-p mvw_file` can print/load session output paths described by official batch
docs.
Tcl/HWI handle syntax is official.
`CaptureScreen` appears in the official Tcl syntax example as a session
operation command.
```

Local-source support:

```text
`CaptureWindow`, `CaptureScreenToSize`, `CaptureAnimation AVI`,
`CaptureAnimationByAreaPercentage`, `GetAVIExportOptionsHandle`, report batch,
and exact HvTrans Tcl command names are confirmed from local installed scripts.
Direct GIF output is visible in GUI capability/workflow assumptions, but a
direct scripted `CaptureAnimation GIF` command has not been official-web
verified in this pass.
```

Needs target-machine test:

```text
Whether viewport capture works reliably in `hw.exe -b -tcl` for HyperView on
this machine.
Whether direct `CaptureAnimation GIF` works in a real graphics session.
Whether `hvtrans.exe` has a clean documented command-line interface beyond the
local Tcl command layer.
```

### `HYPERWORKS_PYTHON_VIEW_CAPTURE_API_REF.md`

Status: official-verified for Tcl/HWI view/capture layer; local-source verified
for Python bridge details.

Official support:

```text
The object-centric Tcl/HWI handle model is official.
`CaptureScreen` is shown as an official operation-command example.
HyperMesh official GUI commands include `hm_windowtofile`, `hm_windowtoclipboard`,
view-fit/orientation commands, and shaded/wireframe display commands.
HyperView official class index confirms `poI3DViewCtrl`.
`poI3DViewCtrl` official docs confirm orientation, view matrix, ortho,
perspective, fit, rotate, translate, zoom, save/restore view APIs.
```

Local-source support:

```text
`Tclinter` and embedded Python bridge usage are from local install files.
AVI animation capture examples are from local scripts.
```

Needs target-machine test:

```text
Python-driven capture in the exact launch mode the tool will use.
Direct GIF capture from Python/Tcl bridge.
```

### `HYPERWORKS_PYTHON_EMBEDDING_API_REF.md`

Status: local-source verified.

Official support:

```text
Official Tcl/Tk docs confirm the Tcl/HWI layer that Python will drive.
```

Local-source support:

```text
Embedded Python commands, `Tclinter`, and exact Python package paths were found
in the local HyperWorks install.
```

Needs target-machine test:

```text
Which Python interpreter is active under each product launch mode.
Which imports are available when launched by HyperMesh, HyperView, hmbatch, or
hw.exe batch.
```

### `HVTRANS_CONVERSION_WORKFLOW_REF.md`

Status: mostly local-source verified; official docs support only the broader
translator concept.

Official support:

```text
The official Reference Guides list Translators and state that translators are
command-line utilities for converting files between formats.
Official HyperWorks reference categories also include external readers and ABF.
This supports the existence of translator workflows, not the exact HvTrans Tcl
API surface.
```

Local-source support:

```text
`hvtrans.exe`, `hvtranstcl.dll`, GUI command `::hw::RunHVTrans`, and the
`hvtrans control/result/model/config` command layer are confirmed from local
installed files.
`LoadResults` before `GetSubcases/GetSimulations/GetDataTypes` is confirmed
from local `hvtransOpenResult.tcl`.
`SetOutputFile` + `StartTranslation` is confirmed from local GUI code.
```

Needs target-machine test:

```text
Direct command-line use of `hvtrans.exe`.
Runtime behavior and filenames for `Output H3D for every step`.
Actual speed/size benefit for the user's large OP2/BDF files.
Whether mode/subcase filtering can be applied before full OP2 metadata load, or
only after `LoadResults`/GUI result inspection has populated subcase/simulation
lists.
```

### `OP2_BDF_MODESHAPE_CAPTURE_WORKFLOW.md`

Status: proposed workflow, supported by official architecture plus local-source
evidence; not fully production-validated.

Official support:

```text
Official docs confirm Batch Mode, Tcl/Tk object handles, HyperView class
structure, HyperView view-control APIs, and the translator category.
```

Local-source support:

```text
The exact HvTrans flow, AVI capture flow, and modal phase frame-control examples
come from local installed Tcl scripts.
```

Needs target-machine test:

```text
End-to-end run on small OP2/BDF:
  OP2+BDF -> filtered H3D -> HyperView MVW -> PNG/AVI/GIF

End-to-end run on real 1.5 GB BDF and 40-80 GB OP2.
```

### `HYPERMESH_GUI_API_REF.md`

Status: official-verified for the existence and broad scope of HyperMesh Tcl GUI
commands; local-source verified for the custom `nastran.mac`/HWTK/widget-table
details.

Official support:

```text
HyperMesh official index includes Scripts and says that section documents Tcl
commands used to query/modify the database and GUI.
Tcl/Tk official docs confirm object-centric command style.
Commands and Functions official page splits HyperMesh scripts into Tcl GUI,
Modify, Query, and Utility Menu commands.
Tcl GUI Commands official page confirms GUI/widget/display commands such as:
  hm_callcollectorpanel
  hm_callincludepanel
  hm_callspecialpanel
  hm_callviewpanel
  hm_callvispanel
  hm_editcard
  hm_edittextcard
  hm_enableitem / hm_enablepopup / hm_disablepopup
  hm_getcurrentmenu
  hm_getpanelitems
  hm_gettwoitemtoggle
  hm_getwindowarea / hm_getgraphicsarea
  hm_redraw
  hm_setpanelheight / hm_setpanelposition / hm_setpanelproc
  hm_usermessage
  hm_view*
  hm_windowtofile
```

Local-source support:

```text
Specific `nastran.mac`, table/dialog/widget/button/checkbutton/image-in-table
APIs are from local HyperMesh scripts and macros.
HWTK table/tree/button/checkbutton implementation details remain local-source
verified unless an exact official HWTK widget page is found.
```

Needs target-machine test:

```text
Any generated GUI script should be tested in an actual HyperMesh session,
especially table image loading, callbacks, and long-running dialog workflows.
```

### `HYPERMESH_ENTITY_MODEL_API_REF.md`

Status: official-verified for the core read/write method (`hm_getvalue`,
Tcl Modify Commands category, `*createentity`) and for entity/data-name category
existence; local-install verified for heavy use of `*setvalue`;
local-source verified for solver-specific Nastran card field inventory.

Official support:

```text
HyperMesh official index confirms Data Names as core data that can be queried
and manipulated.
Solver Templates are official HyperMesh ASCII template files containing
template-language commands/functions.
Official Data Names docs state that Tcl commands and template files use data
names to access database information.
Official examples include:
  hm_getvalue nodes id=$id dataname=x
  hm_getvalue elems id=$id dataname=node1.id
Official Query Commands list `hm_getvalue`.
Official Modify Commands list `*createentity` and confirm the modify-command
category for database mutation.
Official Data Names index lists components, elements, materials, properties,
tables, nodes, results, resultsimulations, resultsubcases, sets, systems, and
many other entity types.
```

Local-source support:

```text
Installed Altair Tcl scripts use `*setvalue` extensively for entity/card field
mutation, including Nastran property/material/loadstep/card workflows.
Specific Nastran component/property/material entity types and field names were
extracted from local solver/card/template/config files.
```

Needs target-machine test:

```text
Mutating every card field should be validated on throwaway models before use on
production BDF data.
```

### `HYPERMESH_NASTRAN_CARD_FIELD_REF.md`

Status: official-verified for the mechanism of data names/query/modify and for
the existence of material/property/component entity data-name categories;
local-source verified for the detailed Nastran solver-card inventory.

Official support:

```text
Official HyperMesh Data Names and Solver Templates categories support the
general method of querying/manipulating core data and reading solver-specific
template definitions.
Official Query Commands confirm `hm_getvalue`.
Official Modify Commands confirm `*createentity` and the modify-command category.
Official Data Names index includes components, materials, properties, elements,
nodes, tables, and related model/result entity categories.
```

Local-source support:

```text
Installed Altair Tcl/Nastran scripts confirm practical `*setvalue` usage for
editing entity/card values.
The actual Nastran card/entity/field lists are from local HyperMesh Nastran
template/config sources.
```

Needs target-machine test:

```text
Spot-check important card edits by exporting a BDF and comparing the resulting
Nastran cards.
```

### `HYPERMESH_COLOR_RENDER_API_REF.md`

Status: official-verified for several display/view/color/capture primitives;
local-source verified for detailed HyperMesh toolbar/profile helper APIs.

Official support:

```text
Official HyperView class index confirms render/display-related classes:
`poIRenderOptions`, `poIGraphicMaterial`, `poIContourCtrl`, `poIResultCtrl`,
`poI3DViewCtrl`, and view-control APIs.
Official HyperMesh Tcl GUI Commands confirm:
  hm_viewshaded
  hm_viewshadedfeatures
  hm_viewshadedmesh
  hm_viewwireframe
  hm_viewfit
  hm_viewisometric
  hm_windowtofile
  hm_windowtoclipboard
Official Data Names for tables confirm `color` and `color_rgb`, and the general
Data Names mechanism applies to other entity pages where color fields exist.
```

Local-source support:

```text
HyperMesh-specific color/render commands and UI toolbar helpers are from local
scripts.
```

Needs target-machine test:

```text
Visual comparison screenshots for shaded/wireframe/contour/background settings.
```

### `API_VERIFIED.md`

Status: should be treated as local verified notes unless linked to official
pages.

Action:

```text
Add official source URLs when entries are confirmed by Altair help.
Keep local-only entries clearly marked as local-source verified.
```

### `GUI_VERIFY_CHECKLIST.md`

Status: process checklist; official verification is not required for every item.

Action:

```text
Use it to validate GUI behavior on real sessions.
```

### `GUI_ALTAIR.md`

Status: local-source GUI pattern notes, with official support for the broader
HyperMesh Tcl GUI Commands category.

Official support:

```text
Official HyperMesh Scripts and Tcl GUI Commands pages confirm that Tcl commands
exist for HyperMesh GUI/widget/display workflows.
```

Local-source support:

```text
Exact macro page, Nastran table/dialog, and installed Tcl patterns are from
local HyperMesh 2022 scripts and workspace macros.
```

### `SPEC.md`

Status: project specification.

Action:

```text
Keep it aligned with this verification matrix.
```

### `MUTATION_PRIMITIVES.md`

Status: local workflow/tooling reference.

Official support:

```text
Official HyperMesh Data Names and Scripts categories support the idea of Tcl
commands for database mutation, but exact primitives need local or runtime
validation.
```

Needs target-machine test:

```text
Run mutation primitives only on throwaway models until behavior is proven.
```

## Confidence Labels To Use In Docs

Use these labels when updating individual refs:

```text
OFFICIAL
  Confirmed directly by Altair 2022.3 help.

LOCAL-INSTALL
  Confirmed by installed scripts/configs in <ALTAIR_INSTALL_DIR>.

RUNTIME-TEST-NEEDED
  Plausible API/workflow, but must be tested in a real HyperWorks session.

PROPOSED-WORKFLOW
  Recommended operating strategy, not an API guarantee.
```

### Files added after this matrix was written (2026-07-03 addendum)

The following doc files were added in later sessions and were never run
through the official-cross-check pass above. Each already carries its own
`Verification status` block at the top using the same confidence-label
vocabulary defined in this file ("Confidence Labels To Use In Docs" below),
so they are internally self-describing even though no dedicated entry exists
for them here. Listed for completeness rather than leaving them silently
unreferenced:

```text
HYPERMESH_ENTITY_TYPE_INDEX.md
  RUNTIME-TESTED (LOCAL-INSTALL) — generated by live hm_getentitytypes
  calls, not from Altair help text. No official page enumerating the full
  174-type list was found/checked in this pass.

HYPERMESH_DATANAME_INDEX.md
  RUNTIME-TESTED (LOCAL-INSTALL) — generated by live probe against a
  real model plus synthetic-entity fallback for 11 zero-instance types.
  Official Data Names docs (item 15/16 above) confirm the general
  dataname= mechanism and entity-group existence, not this file's specific
  per-type key enumeration.

HYPERVIEW_API_REF.md
  Mix of RUNTIME-TESTED (command existence, via live info commands probe)
  and LOCAL-INSTALL (subcommand behavior, read from proc bodies, not
  visually re-verified). The underlying HWI handle-chain mechanism it
  builds on is OFFICIAL per items 5/6 above.

HYPERGRAPH_API_REF.md
  LOCAL-INSTALL (full itcl source read) with an honestly-reported
  LIVE-PROBE-INCONCLUSIVE result — a batch probe was attempted but
  produced no usable output in this environment. No official page for
  ::hw::CurveEditor was found/checked.

HYPERMESH_PYTHON_NATIVE_API_REF.md / HYPERMESH_PYTHON_MDI_API_REF.md
  LOCAL-INSTALL for all Python source read directly; RUNTIME-TEST-NEEDED
  for anything backed by compiled .pyc/native C++ modules. Both files state
  explicitly that Altair's public 2022.3 help does not document the native
  `hm`/MDI Python package as a supported scripting surface — i.e. these two
  files are LOCAL-INSTALL-only by design, not pending an official
  upgrade.
```

## Main Corrections From Official Cross-Check

```text
1. Keep `hw.exe -b -tcl` as officially supported batch syntax.
2. Keep capture/render warnings: official batch mode is no-GUI, so viewport
   capture reliability still needs runtime verification.
3. Treat HyperView view/camera APIs as official through `poI3DViewCtrl`.
4. Treat HvTrans command-layer details as local-source verified, not official web
    verified, until an official HvTrans command reference is found.
5. Treat direct scripted GIF capture as runtime-test-needed.
6. Treat `*setvalue` as local-install verified in this matrix unless a direct
   official 2022.3 command page is captured; the official docs do verify the
   surrounding HyperMesh modify-command/data-name mutation mechanism.
```
