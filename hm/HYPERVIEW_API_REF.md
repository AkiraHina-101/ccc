# HyperView Legacy Tcl Command API Reference (postHVCmd Layer)

Purpose: AI-readable reference for the classic HyperView "HVCmd" Tcl command
layer — the single-word dispatcher commands (`dis`, `crs`, `gro`, `opt`,
`rea`, `sty`, `ani`) that manage displacement/contour settings, cross
sections, groups, misc options, model/result loading, display style, and
animation control inside a HyperView session. This is TRACK 3 of a
multi-track HyperView/HyperWorks documentation effort; it complements the
render/view-class reference and the HvTrans conversion workflow reference
already in this folder.

Verification status:

```text
OFFICIAL:
  General Batch Mode / HWI Tcl object handle mechanism (`hwi OpenStack`,
  `hwi GetSessionHandle`, page/window/client/model/result/contour/animator
  handle chain) is confirmed by Altair help as documented in
  HYPERMESH_COLOR_RENDER_API_REF.md and HYPERWORKS_BATCH_API_REF.md.

LOCAL-INSTALL:
  The 7 dispatcher commands `dis`, `crs`, `gro`, `opt`, `rea`, `sty`, `ani`
  and their subcommands are read directly from installed Altair Tcl
  source under hw/tcl/post/HVCmd/. These are legacy top-level HyperView
  console commands (predate the itcl poI*Ctrl classes) but remain loaded
  and callable in this install.

RUNTIME-TESTED:
  `dis`, `crs`, `gro`, `opt`, `rea`, `sty`, `ani` were confirmed present as
  callable Tcl commands via `info commands` in a live hw.exe -b -tcl batch
  probe (see tests/probe_hyperview_track3.tcl /
  tests/probe_hyperview_track3_result.txt). Their internal subcommand
  behavior (e.g. actual contour/result changes) was NOT re-verified live in
  this probe because no model/result was loaded in batch mode — behavior
  documented below is read from the installed proc bodies
  (LOCAL-INSTALL), not independently confirmed against visual output.

UNVERIFIED:
  Broader ::post::* namespace procs outside the 7 HVCmd files (e.g.
  ::post::advtools::*, ::post::HvTrans::*Proc) were found by grep but are
  documented only at the "excluded as widget/callback noise" level, not as
  reusable API entries, per the scope rule for this track.
```

Sources inspected:

```text
<ALTAIR_INSTALL_DIR>/hw/tcl/post/HVCmd/postAnimateCommands.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/post/HVCmd/postCrsCommand.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/post/HVCmd/postDisCommand.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/post/HVCmd/postGroupCommand.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/post/HVCmd/postOptCommand.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/post/HVCmd/postReaCommand.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/post/HVCmd/postStyCommand.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/post/HVCmd/postGetHandles.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/post/HVCmd/postArgumentChecks.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransgui.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransSaveConfig.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransOpenConfig.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransOpenResult.tcl
tests/probe_hyperview_track3.tcl (this project, live probe script)
tests/probe_hyperview_track3_result.txt (this project, live probe output)
```

Cross-reference, do not duplicate:

```text
_clean/docs/HYPERMESH_COLOR_RENDER_API_REF.md
  poIRenderOptions, poIGraphicMaterial, poIContourCtrl, poIResultCtrl,
  poI3DViewCtrl, hwi CaptureScreen/CaptureScreenToSize, handle chain.

_clean/docs/HVTRANS_CONVERSION_WORKFLOW_REF.md
  hvtrans control/result/model/config command set for OP2/BDF -> H3D
  conversion. This file only adds a small gap note (see end of doc), it
  does not re-document HvTrans.

_clean/docs/OP2_BDF_MODESHAPE_CAPTURE_WORKFLOW.md
  End-to-end capture pipeline recommendation (HvTrans -> H3D -> HyperView
  capture). Not duplicated here.
```

Design note on this command layer: `dis`, `crs`, `gro`, `opt`, `rea`,
`sty`, `ani` are single global Tcl procs (not namespaced) that each parse
their own `args` list as a mini sub-command language, similar to a
shell-style CLI typed into the HyperView Tcl console. Internally each
delegates to a private namespace (`::nsHVCmdDis::*`, `::nsHVCmdCrs::*`,
etc.) that calls the underlying HWI handle-based object API
(`hwi OpenStack`, `::nsHVCmdHandles::prcGet*Handle`, then object method
calls such as `SetDataType`, `SetEnableState`, `Draw`). All 7 commands
follow the same defensive pattern: check model/result is loaded, validate
argument count/type, print a usage message on error, otherwise mutate
session state and force a redraw.

## dis — Displacement/Contour Control

**Signature**: `dis <subcommand> ?args?`

Subcommands (from `::nsHVCmdDis::prcParseArgs`):

```text
dis inf | dis info                  - print min/max of current displacement contour
dis off <value> | dis offset <v>    - set displacement contour offset
dis nor | dis normalize             - normalize displacement contour to [0,1]
dis denor | dis denormalize         - remove normalization thresholds
dis sca <v> | dis scale <v>         - alias for multiplier (see mul)
dis mul <v> | dis multiply <v>      - set displacement contour multiplier
```

- **Return shape**: no return value; side effects only. `dis inf` writes
  "Minimum Displacement = X" / "Maximum Displacement = Y" to stdout via
  `puts`. All numeric args are validated with `string is double`; invalid
  input prints a usage message and does nothing.
- **Precondition/side-effect**: requires model + result loaded
  (`::nsHVCmdPostArgs::prcCheckModelResult`); if not loaded, prints
  "Model results not loaded" and returns. On success, it gets the current
  contour handle (`::nsHVCmdHandles::prcGetContourHandle`), forces
  `SetDataType "Displacement"`, `SetDataComponent node "Mag"`,
  `SetEnableState true` if not already so configured, applies the
  requested offset/multiplier/threshold change, then calls
  `SetDisplayOptions "contour" true` / `"legend" true` on the post handle
  and redraws (`hpost Draw`).
- **Confidence**: LOCAL-INSTALL (RUNTIME-TESTED for command
  existence/callability only; sub-behavior not visually re-verified).

## crs — Cross-Section Control

**Signature**: `crs <subcommand> ?args?`

Subcommands (from `::nsHVCmdCrs::prcParseArgs`):

```text
crs pos dir <x> <y> <z>   - set cross-section cutting-plane orientation (unit vector)
crs swi on | crs swi off  - show/hide the section cut ("switch")
crs cli on | crs cli off  - toggle clipped-geometry transparency (on = opaque, off = transparent)
crs geo on | crs geo off  - toggle "cross-section only" vs section + full geometry
crs rev                   - reverse the section plane normal of the currently applied section
```

- **Return shape**: no return value; side effects only.
- **Precondition/side-effect**: requires a model file loaded
  (`::nsHVCmdPostArgs::prcModelAvailable`); prints "Model File not Loaded"
  otherwise. `crs swi on` looks up the post handle's section list
  (`hpost GetSectionList`), adds a new section (`hpost AddSection`) if none
  exists yet, then configures the section handle: `SetOrientation`,
  `SetOrientationMethod "yaxis"`, `SetD` (midpoint of `GetDMin`/`GetDMax`),
  `SetBase`, `SetCrossSectionOnly`, `SetVisibility true`. `crs swi off`
  calls `SetVisibility false` on the last section instead. `crs pos dir`,
  `crs cli`, `crs geo` only update in-memory Tcl variables
  (`xOrient/yOrient/zOrient`, `transparent`, `cross_section`) and
  re-apply the section only if one is already visible (`isApplied` flag).
  `crs rev` calls `hsection Reverse` on the last section in the list, only
  if a section is currently applied.
- **Confidence**: LOCAL-INSTALL (RUNTIME-TESTED for command
  existence/callability only).

## gro — Selection Group Management

**Signature**: `gro <subcommand> ?args?`

Subcommands (from `gro` dispatcher / `::nsHVCmdGroup::*`):

```text
gro def                    - create a new group from currently displayed/visible elements
gro rde <oldname> <newname> - rename an existing group
gro del                    - delete all groups for the active page/window and free handles
gro lst                    - print (puts) the names of all groups for the active page/window
```

- **Return shape**: no return value; `gro lst` prints group names via
  `puts` to stdout, one per line. All other subcommands are side-effect
  only.
- **Precondition/side-effect**: requires a model loaded
  (`::nsHVCmdPostArgs::prcModelAvailable`), else prints "Model File not
  Loaded". Groups are tracked per `(activePage, activeWindow)` pair in the
  Tcl array `::nsHVCmdGroup::arrSelectionSetHandles`, so groups created in
  one page/window are invisible to `gro lst`/`gro def` run against a
  different active page/window. `gro def` calls
  `model AddSelectionSet element`, sets `SetSelectMode displayed`, then
  `Add all` — i.e. it captures whatever elements are currently displayed at
  the moment the command runs, not a live/dynamic filter. There is no
  documented `gro sho <name>` / `gro hid <name>` entry point in the public
  `gro` dispatcher switch, even though the private procs
  `::nsHVCmdGroup::prcShowGroup` / `prcHideGroup` exist and implement
  show/hide-by-selection-set-mask logic — these two procs appear to be
  dead/unreachable from the current `gro` switch statement in this
  build (only `def`/`rde`/`del`/`lst` are wired). Treat `prcShowGroup` /
  `prcHideGroup` as UNVERIFIED/internal-only, not a supported public
  command, unless invoked directly by fully-qualified name.
- **Confidence**: LOCAL-INSTALL for `def`/`rde`/`del`/`lst`
  (RUNTIME-TESTED for command existence/callability only). UNVERIFIED for
  the unreachable `prcShowGroup`/`prcHideGroup` procs.

## opt — Miscellaneous Session Options

**Signature**: `opt <subcommand> ?args?`

Subcommands (from `::nsHVCmdOpt::prcParseArgs`):

```text
opt cdi <dir>     - change HyperView's current working directory (Tcl `cd`)
opt fea <angle>   - set feature-line detection angle on render options
opt tim <value>   - set current simulation/timestep (by value, not index)
opt udg <mode>    - set undeformed-geometry display mode: none|edges|features|wireframe
opt vsf <factor>  - set vector-plot arrow scale factor
```

- **Return shape**: no return value; side effects only. `opt cdi` on an
  invalid directory prints "Could not change to $_dir" and does not raise
  a Tcl error.
- **Precondition/side-effect**:
  - `opt cdi` has no model/result precondition; it is a plain
    `file isdirectory` check + `cd`.
  - `opt fea`, `opt tim`, `opt vsf` require model+result loaded
    (`prcCheckModelResult`); `opt udg` requires only a model
    (`prcModelAvailable`).
  - `opt fea` calls `RenderOptions SetFeatureAngle <angle>` then redraws.
  - `opt tim` gets the result handle and calls
    `SetCurrentSimulation $_sim`, wrapped in `catch` — on failure it
    prints "Could not set the timestep to $_sim" but still forces a
    redraw afterward regardless of success/failure.
  - `opt udg` calls `RenderOptions SetUndeformedMeshMode $_mode` — the
    `$_mode` string is passed through unvalidated to the underlying API
    (no whitelist check against none/edges/features/wireframe in
    `prcParseArgs`, despite the usage text listing those 4 values).
  - `opt vsf` calls `Vector SetScale $_scale` then redraws.
- **Confidence**: LOCAL-INSTALL (RUNTIME-TESTED for command
  existence/callability only).

## rea — Model/Result File Loading

**Signature**: `rea <subcommand> ?args?`

Subcommands (from `::nsHVCmdRea::prcParseArgs`):

```text
rea geo <filename>                          - load a model/geometry file (AddModel)
rea res <filename>                          - load a result file into the active model (SetResult)
rea dis                                     - enable displacement magnitude contour on current model/result
rea fun <dataType> <dataComponent> ?layer?  - enable an arbitrary result-type contour by name
```

- **Return shape**: no return value. `rea geo`/`rea res` print an error
  message ("Error Loading Model" / "Error Loading Results") on failure but
  do not raise a Tcl exception; on success they force a client redraw.
- **Precondition/side-effect**:
  - `rea geo <file>` calls `post AddModel $filename` on the active
    client/post handle; returns early with an error message if the
    underlying `AddModel` call returns 0.
  - `rea res <file>` requires a model already loaded (checks
    `prcGetModelHandle` return code); calls `model SetResult $filename`;
    prints "Error Loading Results" if the return code is non-zero.
  - `rea dis` requires model+result loaded; sets the current contour to
    Displacement/node/Mag with corner-data disabled, but — unlike `dis`
    subcommands — does **not** itself call `SetEnableState true` nor
    force a redraw; it only stages the contour handle configuration.
  - `rea fun <dataType> <dataComponent> ?shellLayer?` requires
    model+result loaded; validates `dataType` against
    `result GetDataTypeList` and `dataComponent` against
    `result GetDataComponentList` for the current subcase, printing
    "Requested data type/component doesnot exist" [sic] and aborting if
    invalid. For node-bound data types it sets node dimension/component;
    for element/shell-bound types it resolves/validates the shell layer
    (falls back to the first available layer if the requested one is
    invalid) and sets shell/solid/line dimension+component together, then
    calls `SetEnableState true`. This is the most general-purpose contour
    activation entry point in the HVCmd layer — it can select any result
    data type by name, not just displacement.
- **Confidence**: LOCAL-INSTALL (RUNTIME-TESTED for command
  existence/callability only).

## sty — Display Style / Contour Shortcut Control

**Signature**: `sty <subcommand> ?args?` where the effective dispatch key
used internally is one of `pid` (also reached via `mid`), `int`, `fun`,
`crs`.

Subcommands (from `sty` dispatcher / `::nsHVCmdSty::prcParseArgs`):

```text
sty pid <edg|lin|bou|som|soe> <all|id-list|range>
  - set per-component polygon/mesh display mode by component ID or "all".
  - edg: wireframe + features   lin: wireframe + meshlines
  - bou: wireframe + edges      som: opaque   + meshlines
  - soe: opaque   + features
  (sty mid is accepted as a synonym dispatch key for the same "pid" parser)

sty int <uno|vno|wno|dno|off> [range]
  - contour displacement component: uno=X, vno=Y, wno=Z, dno=Magnitude
  - off: clears/disables the current contour

sty fun <nod|ele|off> [range]
  - contour an already-selected result by binding: nod=node_on_element
    (corner data enabled), ele=element (corner data disabled)
  - off: clears/disables the current contour

sty crs wid <thickness 1-6>
  - set the generated cross-section line thickness (render options)
```

ID-list/range argument format is parsed by
`::nsHVCmdSty::prcParseNumbers`/`::nsHVCmdPostArgs::prcRangeSplitter` and
accepts either the literal `all` or a space-separated list of individual
IDs and/or `first-last` ranges (expanded to individual IDs).

- **Return shape**: no return value; side effects only.
- **Precondition/side-effect**: `sty pid`/`sty mid` and `sty crs` require
  a model loaded (`prcModelAvailable`); `sty int` and `sty fun` require
  model+result loaded (`prcCheckModelResult`). `sty pid` resolves each
  target ID to a component handle (`model GetComponentHandle`) and calls
  `SetPolygonMode` + `SetMeshMode` on it, or iterates all children of
  component 0 (the top-level assembly) when `all` is given — components
  that fail to resolve are silently skipped. `sty int`/`sty fun ... off`
  both route through the shared `prcClearContour` (sets
  `SetEnableState false` on the contour handle) rather than a
  subcommand-specific clear. `sty fun` will refuse to apply if the
  contour's current data type is already "Displacement" (that combination
  is reserved for `sty int`). `sty crs wid` validates the thickness is a
  double in [1,6] before calling
  `RenderOptions SetGeneratedLineThickness`.
- **Confidence**: LOCAL-INSTALL (RUNTIME-TESTED for command
  existence/callability only).

## ani — Animation Playback Control

**Signature**: `ani <subcommand> ?args?`

Subcommands (from `ani` dispatcher):

```text
ani for              - start continuous forward animation
ani bac              - start continuous backward animation
ani fab              - start continuous forward-and-backward (bounce) animation
ani off              - stop animation
ani first            - jump to first simulation/step
ani last             - jump to last simulation/step
ani next             - advance one simulation/step
ani prev             - go back one simulation/step
ani fo1              - play exactly one forward cycle (loops Next until end reached)
ani ba1              - play exactly one backward cycle (loops Previous until start reached)
ani step <n>         - jump to 1-based step number n (converted to 0-based SetCurrentStep)
```

- **Return shape**: no return value; side effects only. Prints a usage
  block to stdout if called with no args or an unrecognized token.
- **Precondition/side-effect**: requires model+result loaded
  (`::nsHVCmdPostArgs::prcCheckModelResult`); prints "Result Files Not
  Loaded" and returns otherwise. Every branch first calls
  `::nsHVCmdAni::prcResetBeginEndSims`, which resets the animator's
  start/end time to `GetMinTime`/`GetMaxTime` — i.e. any previously
  narrowed animation range is cleared every time `ani` is invoked. The
  continuous modes (`for`/`bac`/`fab`) call `Animator SetDirection` +
  `SetBounce` + `Start` and return immediately (non-blocking; playback
  continues in the GUI event loop — meaningless in pure batch mode with no
  GUI). The discrete modes (`first`/`last`/`next`/`prev`/`fo1`/`ba1`/`off`/
  `step`) synchronously change `SetCurrentTime`/`SetCurrentStep` and then
  force one `post Draw` call. `ani step <n>` validates `n` is an integer
  and within `[1, GetNumberOfSteps]`; out-of-range or non-integer input
  prints an error and does not change state.
- **Confidence**: LOCAL-INSTALL (RUNTIME-TESTED for command
  existence/callability only — continuous animation modes cannot be
  meaningfully verified in headless batch mode).

## Common Handle-Acquisition Helper (postGetHandles.tcl)

All 7 commands above route through a shared private helper namespace,
`::nsHVCmdHandles::*`, to obtain HWI object handles:

```text
::nsHVCmdHandles::prcGetProjectHandle       -> hwi GetSessionHandle -> sess GetProjectHandle
::nsHVCmdHandles::prcGetPageHandle          -> proj GetPageHandle [proj GetActivePage]
::nsHVCmdHandles::prcGetPostHandle          -> client handle for the active window (the "post" object)
::nsHVCmdHandles::prcGetModelHandle         -> client GetModelHandle [client GetActiveModel]
::nsHVCmdHandles::prcGetResultHandle        -> model GetResultCtrlHandle
::nsHVCmdHandles::prcGetContourHandle       -> model's contour control handle
::nsHVCmdHandles::prcGetAnimatorHandle      -> page's animator handle
::nsHVCmdHandles::prcGetVectorHandle        -> model's vector plot control handle
::nsHVCmdHandles::prcGetRenderOptionsHandle -> model's render options handle
::nsHVCmdHandles::prcGetSectionHandle       -> model's section-cut handle, by section id
```

This mirrors the handle chain already documented under "HWI Session And
Graphics Capture" in `HYPERMESH_COLOR_RENDER_API_REF.md`. Every one of the
7 HVCmd dispatcher commands wraps its handle work in `hwi OpenStack` /
`hwi CloseStack`, following the same convention as the render/capture
helpers in that file — this is an OFFICIAL-confirmed pattern, not
specific to HVCmd.

**Confidence**: LOCAL-INSTALL for the specific helper proc names;
OFFICIAL for the underlying handle-chain mechanism itself.

## Gap Found In HVTRANS_CONVERSION_WORKFLOW_REF.md

While searching for additional real `::post::` procs, the installed
`hvtransSaveConfig.tcl` / `hvtransOpenConfig.tcl` also exercise these
`hvtrans control`/`hvtrans config` subcommands that are not explicitly
listed in `HVTRANS_CONVERSION_WORKFLOW_REF.md`:

```text
hvtrans control SaveConfig                  - write current config to the file set by SetConfigFile
hvtrans control LoadConfig                  - read a config file set by SetConfigFile back into memory
hvtrans control SetCompressionLevel <n>     - set H3D compression level (observed value: 7)
hvtrans control SetCompressionTolerance <t> - set compression tolerance (observed: 0.0 or 0.1)
hvtrans control SetCallback errormsg <proc> - register a Tcl error-message callback
hvtrans config ListItems ?path?             - list config item names/subpaths (used to walk saved config tree)
hvtrans config GetItemValue <path>          - read back a stored config item's value
```

These are LOCAL-INSTALL findings (not independently runtime-tested
here) and are a natural companion to the already-documented
`hvtrans config AddItem ...` calls. They matter for the "Code Route" in
`OP2_BDF_MODESHAPE_CAPTURE_WORKFLOW.md` because `LoadConfig` +
`ListItems`/`GetItemValue` is how a script can read back a GUI-saved
`.xml`/config file's selected subcases/simulations/data types
programmatically before adjusting paths and calling `StartTranslation` —
this closes a small gap where the workflow doc described saving a config
from the GUI but not how a script would parse it back.

## Excluded — Widget Instance Noise

The following patterns, encountered in the same install tree while
grepping for `::post::` procs, were deliberately excluded from this
reference because they are internal GUI callbacks/state wired to one
specific already-open dialog instance, not reusable session API:

```text
::post::HvTrans::CreateUI, CreateMenu, CreateSubcaseFrame,
CreateSimulationFrame, CreateOptionsFrame, ResultTypeFrame,
EntityWithLayersFrame, ResultComponentsFrame, ModelComponentsFrame,
GroupsFrame
  -> These build/populate specific Tk widgets inside the HvTrans dialog
     (frames, trees, listboxes). They take no reusable arguments and
     have no meaning without that exact dialog already constructed.

::post::HvTrans::subcaseButtonProc, subAllButtonProc, subNoneButtonProc,
subReverseButtonProc, closeButtonProc, a1Proc, OnSpin,
fromEntryProc/toEntryProc, byListByStepEntryProc
  -> Button/spinbox/entry event handlers bound to specific widget paths
     in the open HvTrans GUI; they read/write global Tcl variables the
     GUI itself defined (e.g. $::fromValue, $::byListByStep) and have no
     stable calling convention outside that dialog's lifecycle.

::post::advtools::cmcui::Tree, Treeimplementing, NotifyCollector
  -> Advanced-tools (Contour Measure Curve) UI tree-population and
     notification-collector callbacks tied to one open panel's widget
     tree, not general contour/measurement API.

Literal Tk widget paths such as .postPanel.iso.f4.avgType.frame and
namespaced singleton callbacks such as
::hwbr::widget::HWHeaderEditor::comparisons
  -> As called out in the original probe scope rule: these are
     implementation detail of one already-open dialog instance, never
     meant to be called from an external script, and are excluded on
     sight regardless of namespace.

::post::advtools::measure_interpolation::gui, main, selector
  -> Entry points that immediately build/show a modal Advanced Tools
     dialog rather than perform a reusable calculation; excluded even
     though other procs in the same file (e.g. vector_lib.tcl's
     ::post::advtools::vector::Add/Cross/Dot, maxtrix_lib.tcl's matrix
     helpers) are pure reusable math utilities. Those math-only helpers
     were considered but excluded from this doc as out of scope for a
     HyperView *display/session control* reference — they are generic
     vector/matrix math libraries used internally by the Advanced Tools
     panel, not HyperView view/result/session API.
```

## Practical Usage Notes

```text
1. All 7 commands are plain global Tcl procs, callable directly from any
   Tcl console/script running inside a HyperView-capable session (HWI
   available), including hw.exe -b -tcl batch mode, once a model/result is
   loaded as required by each subcommand.
2. None of them return a Tcl value useful for scripting logic; all
   feedback is via `puts` to stdout or silent success. Do not rely on
   return codes — wrap calls in `catch` and inspect side effects (e.g. via
   the handle-chain classes) if a script needs to confirm success.
3. `ani for`/`bac`/`fab` are fire-and-forget continuous-animation starters
   meant for interactive GUI use; they are not useful in headless batch
   automation. For scripted frame capture, prefer the discrete stepping
   commands (`ani step <n>`, `ani next`, `opt tim <value>`) or the
   lower-level animator/result handle calls described in
   OP2_BDF_MODESHAPE_CAPTURE_WORKFLOW.md.
4. `rea fun` is the most flexible contour-activation command in this
   layer — it can select any named result data type/component for the
   current subcase, not just displacement. Prefer it over `dis`/`sty int`
   when the required result is not a displacement magnitude.
5. `gro def` snapshots currently *displayed* elements at call time; it is
   not a saved/live selection rule. Re-running `gro def` after changing
   visibility creates a new, separately numbered group rather than
   updating an old one.
6. Every command internally wraps HWI handle access in
   `hwi OpenStack` / `hwi CloseStack`; scripts combining several of these
   commands in a tight loop do not need to add their own OpenStack/
   CloseStack pair around each call, but should still avoid leaving marks
   or half-applied state (e.g. an unfinished `crs pos dir` without a
   following `crs swi on`) between calls.
```

## AdvancedTools Layer (advtools)

Purpose of this section: a prior pass through this same source tree
excluded `::post::advtools::*` wholesale as "not verb-noun reusable API,
mostly dialog-callback/math-utility shaped" (see the "Excluded — Widget
Instance Noise" section above). Per a follow-up task, this section
revisits that exclusion honestly: it fully documents the small subset of
`advtools` procs that are genuinely pure, standalone, callable functions,
and separately lists (by name only) the much larger set that are
dialog-bound and not worth documenting individually.

Sources inspected (all under
`<ALTAIR_INSTALL_DIR>/hw/tcl/post/AdvancedTools/`):

```text
vector_lib.tcl            - ::post::advtools::vector::*      (7 procs)
maxtrix_lib.tcl           - ::post::advtools::matrix::*       (9 procs)  [sic — filename misspelled in the install]
ContourMeasureCurve_api.tcl - ::post::advtools::cmcapi::*     (5 procs)
ContourMeasureCurve_ui.tcl  - ::post::advtools::cmcui::*      (4 procs)
measureinterpolation.tcl    - ::post::advtools::measure_interpolation::* (24 procs)
postsyncresultstep.tcl      - ::post::advtools::synsresstep::* (10 procs)
```

Verification status for this section:

```text
LOCAL-INSTALL / UNVERIFIED:
  All content below is read directly from installed Tcl source. None
  of it was live-invoked in a batch probe or a running HyperView session
  for this pass — signatures and behavior descriptions come from reading
  proc bodies, not from `info commands`/`info args` introspection or
  observed return values. Treat every "Return shape" claim below as
  UNVERIFIED until someone runs it in a real session.
```

### (a) Genuinely callable utility functions

These procs take only plain Tcl values (lists of numbers / lists of
lists) as arguments, do not reference any HWI handle, model, window, or
global GUI state, and do not build/show any widget. They are ordinary
math-library procs that happen to live under the Advanced Tools
namespace because that panel is their only current caller — nothing
prevents calling them directly from any Tcl script once the
`AdvancedTools` source is sourced (it is loaded as part of normal
HyperView/HyperMesh startup, so these are callable from an interactive
Tcl console or a batch script without opening any panel).

**Vector library — `::post::advtools::vector::*`** (namespace variable
`tolZero` = 1e-12, used only by `Normalize`)

```text
GetDimension { vector }              -> integer: llength of the vector list
Cross { vector1 vector2 }            -> 3-element list: 3D cross product; errors
                                         "wrong # components: should have dimension
                                         of 3" if either input is not length 3
Add { vector1 vector2 }              -> N-element list: elementwise sum; errors on
                                         dimension 0 or mismatched dimensions
Subtract { vector1 vector2 }         -> N-element list: vector1 + (-1 * vector2),
                                         implemented via Add + MultiplyByScalar
MultiplyByScalar { vector scalar }   -> N-element list: elementwise scale; errors
                                         if vector has dimension 0
Dot { vector1 vector2 }              -> single number: inner product; errors on
                                         dimension 0 or mismatched dimensions
Normalize { vector {length 1.0} }    -> N-element list: vector scaled to the given
                                         length (default 1.0); errors "wrong vector
                                         length: too small to be normalized" if
                                         GetLength is below tolZero (1e-12)
GetLength { vector }                 -> single number: sqrt(Dot(vector,vector)),
                                         i.e. Euclidean norm
```

- **Signature**: as listed above, one entry per proc; all take plain Tcl
  lists of numbers, no optional args except `Normalize`'s `length`.
- **Return shape**: as listed above (UNVERIFIED — read from proc body,
  not runtime-observed). All errors are raised via Tcl `error`/
  `return -code error`, so callers should wrap in `catch` if dimension
  mismatches are possible.
- **Precondition/side-effect**: none — pure functions, no model/session
  state touched. `Cross` is hard-restricted to 3-vectors; the others work
  for any positive dimension as long as both operands match.
- **Confidence**: LOCAL-INSTALL, UNVERIFIED for return shapes (not
  live-tested this pass).

**Matrix library — `::post::advtools::matrix::*`** (namespace variable
`tolZero` = 1e-12, used only by `Inverse`/`Inverse4X4`; matrices are
represented as a Tcl list-of-rows, e.g. `{{1 0} {0 1}}` for 2x2 identity)

```text
CountColumn { matrix }               -> integer: llength of the first row
CountRow { matrix }                  -> integer: llength of the matrix (row count)
GetElement { matrix row column }     -> single number: matrix[row][column]
                                         (0-based, via lindex)
CanBeMultiplied { matrix1 matrix2 }  -> boolean (0/1): true iff matrix1's column
                                         count equals matrix2's row count and both
                                         are > 0
Transpose { matrix }                 -> matrix (list-of-rows): standard transpose
Multiply { matrix1 matrix2 }         -> matrix (list-of-rows): standard matrix
                                         product; errors "wrong # dimension: should
                                         have same dimensions" if CanBeMultiplied
                                         is false
MultiplyByScalar { matrix scalar }   -> matrix (list-of-rows): every element times
                                         double(scalar)
ConvertToArray { matrix }            -> flat list suitable for `array set`, keys
                                         "row,column" -> value (internal-use helper
                                         per source comment, but plain/callable)
RetrieveFromArray { lst_vals }       -> matrix (list-of-rows): inverse of
                                         ConvertToArray; rebuilds a dense matrix
                                         from a flat "row,column"->value list,
                                         filling any missing cell with 0
Inverse4X4 { matrix {tol -1} }       -> matrix (list-of-rows): explicit cofactor-
                                         expansion inverse, HARD-CODED for exactly
                                         4x4 input (indices 0..3 assumed present via
                                         `array set a`); errors "wrong determinant
                                         '$det': unable to calculate the inverse
                                         matrix" if |det| < tol (default tolZero)
Inverse { matrix {tol -1} }          -> matrix (list-of-rows): checks the input is
                                         square, THEN UNCONDITIONALLY CALLS
                                         Inverse4X4 regardless of actual size —
                                         see caveat below
```

- **Signature**: as listed above; matrices are plain nested Tcl lists,
  not a custom object type.
- **Return shape**: as listed above (UNVERIFIED — read from proc body).
- **Precondition/side-effect**: none — pure functions, no model/session
  state touched.
- **Confidence**: LOCAL-INSTALL, UNVERIFIED for return shapes (not
  live-tested this pass).
- **Caveat — likely bug, do not rely on `Inverse` for non-4x4 matrices**:
  `Inverse` validates that the matrix is square (`row == column`) and
  then unconditionally calls `Inverse4X4` on it — there is no dispatch by
  size. `Inverse4X4` itself unpacks the matrix into array indices `a(0,0)`
  through `a(3,3)` with no bounds checking. For a 2x2 or 3x3 square
  matrix this means `Inverse` will hit undefined-array-element Tcl errors
  (reading `a(2,2)`, `a(3,3)`, etc. that were never set), not a correct
  smaller-matrix inverse. Only call `Inverse` (or `Inverse4X4` directly)
  on genuinely 4x4 matrices; for other square sizes this library has no
  working implementation despite `Inverse`'s generic-looking signature.
  This is read from source, not confirmed by running it — but the code
  path is unambiguous (no size branch exists).

### (b) Not independently callable — dialog-bound/callback-only

The remaining ~43 procs across `ContourMeasureCurve_api.tcl`,
`ContourMeasureCurve_ui.tcl`, `measureinterpolation.tcl`, and
`postsyncresultstep.tcl` all fall into one or more of: (1) build or
mutate a specific Tk widget tree that must already exist
(`Tree`, `Treeimplementing`, `ui`, `gui`, `CreateaTable`), (2) read/write
module-global Tcl variables set up by that widget tree
(`entrycheck`, `framestatechange`, `Updateactiveloadcase`, `SetLoadcase`,
`SetSimulation`, `Stepmaxsize`, `selectwind`, `ToggleWindowSync`,
`Stepsizevalidation`, `windowsselect`, `formatandprec`, `clear`,
`selector`, `UpdateTable`, `UpdateMeasureVisibility`, `MeasureHandle`),
(3) act as event/notification callbacks wired to one open panel instance
(`NotifyCollector` in both `cmcui` and `measure_interpolation`), or
(4) depend on the currently active HyperView window/model/pointer state
in a way that only makes sense mid-interaction with an open panel
(`EntitySelection`, `ListofHypergraph2Dwindowsandpages`, `returnhome`,
`refreshcheck`, `OrphanNodes`, `contourmeasurecurves`, `main`,
`ModelandContourData`, `WriteToFile`, `Export`, `QueryElement`,
`QueryNodes`, `ParamNodes`, `ApplyViewMatrix`, `GetDepth`,
`GetPointerCoordinates`, `GetTriaFaces`, `GetSubset`, `GetCoordinates`,
`GetNormal`, `CalculateLineTriaIntersection`,
`CalculateLinePlaneIntersection`, `CalculateInterpolationParameters`,
`GetDistance`, `CreateMeasure`, `Contourmeasurecurve`). These are listed
by name only, per the task's scope rule — they are not documented with
the 4-part format because they require a specific already-open Advanced
Tools panel (Contour Measure Curve or Measure/Interpolation or Sync
Result Step) to have any meaning, matching the same exclusion rationale
used for `::post::HvTrans::*` dialog callbacks earlier in this file.

Note: a handful of these (`GetNormal`, `GetDistance`,
`CalculateLineTriaIntersection`, `CalculateLinePlaneIntersection`,
`CalculateInterpolationParameters`) are themselves small pure-geometry
helpers internally, but they are written to consume the specific
data shapes (`view`/`config`/`pol`/`pom` structures) produced elsewhere
in `measureinterpolation.tcl`'s panel-driven pipeline, not general
point/vector arguments — unlike the `vector`/`matrix` libraries above,
calling them standalone would require reverse-engineering those
undocumented internal data shapes, so they stay in the "not
independently callable" bucket rather than being promoted to (a).

### Summary

```text
Genuinely callable, fully documented above: 16 procs
  (7 in ::post::advtools::vector::*, 9 in ::post::advtools::matrix::*)
Dialog-bound/callback-only, listed by name only: ~43 procs
  (cmcapi, cmcui, measure_interpolation, synsresstep namespaces)
```

This confirms the prior pass's exclusion was directionally correct for
the majority of the layer (dialog callbacks dominate), but the vector and
matrix math libraries are true general-purpose utilities incorrectly
swept into the same exclusion — they are documented properly above.
