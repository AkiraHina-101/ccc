# HvTrans Conversion Workflow Reference

Purpose: practical reference for using HvTrans with large Nastran `.bdf` and
`.op2` files before HyperView mode-shape capture.

This is a workflow/reference note, not a complete API reference.

Verification status:

```text
OFFICIAL:
  Altair help confirms the broader Translators reference category and
  describes translators as command-line utilities for converting file formats.

LOCAL-INSTALL:
  `hvtrans.exe`, `hvtranstcl.dll`, `::hw::RunHVTrans`,
  `hvtrans control/result/model/config`, `LoadResults`, `SetOutputFile`, and
  `StartTranslation` are from installed Altair Tcl files.

RUNTIME-TEST-NEEDED:
  Direct CLI behavior of `hvtrans.exe`, exact mode-range filtering before/after
  metadata load, `Output H3D for every step` filenames, and speed/size gain on
  the user's real 1.5 GB BDF plus 40-80 GB OP2.

See:
  _clean/docs/OFFICIAL_ALTAIR_2022_3_VERIFICATION.md
```

Target context:

```text
BDF: around 1.5 GB
OP2: around 40-80 GB
Goal: convert/filter OP2+BDF into a smaller H3D for faster HyperView capture
```

## Key Conclusions

HvTrans helps before capture, but it does not capture images or GIFs.

```text
HvTrans:
  OP2/BDF -> filtered H3D
  can select subcases, simulations/modes, result data types, layers/components
  can include model in translated H3D

HyperView:
  H3D/MVW -> rendered PNG/JPEG/AVI/GIF capture
  owns viewport, camera, animation playback, and GIF/video capture
```

GUI vs code:

```text
Conversion engine speed:
  GUI and code use the same underlying HvTrans engine.
  Code usually does not make the heavy OP2 read/write much faster.

Workflow speed:
  Code helps when repeating many jobs, using saved configs, logging, retrying,
  and avoiding repeated manual setup.
```

Observed GUI launch points:

```text
HyperWorks Post profile menu:
  Run HvTrans -> tcl: ::hw::RunHVTrans

Installed executable/library:
  <ALTAIR_INSTALL_DIR>/io/result_readers/bin/win64/hvtrans.exe
  <ALTAIR_INSTALL_DIR>/io/result_readers/bin/win64/hvtranstcl.dll
```

The inspected menu XML exposes the GUI command, but the most useful automation
surface found in Tcl is the underlying `hvtrans control/result/model/config`
command set, not the GUI procedures themselves.

## When Can Modes Be Selected?

HvTrans must first load/index the result file enough to know what it contains.
Only after that can it list modal subcases and mode/simulation entries.

Observed flow in installed Tcl:

```tcl
hvtrans control SetResultFile $op2
hvtrans control LoadResults

set subcases [hvtrans result GetSubcases]
set label    [hvtrans result GetSubcaseLabel $subcase_id]
set modes    [hvtrans result GetSimulations $subcase_id]
set types    [hvtrans result GetDataTypes $subcase_id]
```

Practical meaning:

```text
You usually cannot choose mode numbers from the GUI before HvTrans has loaded
the OP2 metadata/index.

For a 40-80 GB OP2, this first LoadResults step can still be slow and may make
the GUI appear unresponsive.

This does not necessarily mean every result value for every mode has been fully
loaded into memory. It means HvTrans has loaded enough metadata to expose
subcases, modes/simulations, and data types for selection.
```

## Does HvTrans Re-import The Model For Every Mode?

No. In the normal GUI flow, the model is associated with the conversion job, not
reloaded once per selected mode.

Observed model options:

```text
Include model with translated results
  From result file
  From input deck
```

Observed save/config behavior:

```tcl
if {$::inModel} {
    if {[string match {From result file} $::modelOutputType] == 1} {
        hvtrans control SetModelReader $::resultReader
        hvtrans control SetModelFile $::post::HvTrans::previouslySelectedResultFName
    } else {
        hvtrans control SetModelFile $::previouslySelectedModelFName
    }
} else {
    hvtrans control SetModelFile ""
    hvtrans control SetModelReader ""
}
```

Meaning:

```text
Same OP2/BDF conversion:
  load/index result once
  load/associate model once
  translate selected modes

Different OP2/BDF pair:
  must load/index the new OP2
  must associate/load the new model source
```

For capture workflows, prefer output H3D with included model if it avoids
reloading the original 1.5 GB BDF later.

## Mode Selection In GUI

HvTrans GUI has two selection styles for simulations/modes:

```text
By List:
  select individual modes/simulations
  GUI has All / None / Reverse controls

By Step:
  choose From, To, and By Step
  useful for ranges such as modes 1-50 step 1, or 1-100 step 5
```

Observed GUI variables/controls:

```tcl
variable byListByStepList { {By List} {By Step} }
variable byListByStep [lindex $byListByStepList 0]

set ::fromValue ...
set ::toValue ...
set ::stepValue ...
```

When saving config, selected simulations are written as config paths:

```tcl
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/(All)
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/$dataType
```

More detailed config paths are also used when the user selects layers,
components, or corner output:

```tcl
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/{$dataType}
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/{$dataType$separator(corners)}
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/"$dataType$separator$shellLayer"
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/"$dataType$separator$component"
```

In modal OP2 files, mode shapes usually appear as simulations under the modal
subcase.

The GUI also has `Output H3D for every step`. Internally this is saved as:

```tcl
hvtrans config AddItem "Config<H3D>/options<1>"
```

Treat this as a split-output option to test on a small job first. It can help
debugging or parallel capture, but one filtered H3D with selected modes is
usually simpler.

## Does Convert Become Fast?

Not necessarily. HvTrans still has to:

```text
read/index a large OP2
read/associate model information
filter selected subcases/modes/data types
write a new H3D
```

So the conversion step may still take a long time. Its value is that the cost is
paid once before capture:

```text
slow once:
  OP2+BDF -> filtered H3D

faster repeatedly:
  H3D/MVW -> mode switching/capture
```

For large OP2 files, this is usually better than repeatedly opening/capturing
directly from raw OP2+BDF.

## What Actually Makes Conversion Faster

GUI vs code is less important than reducing what is translated.

Most important filters:

```text
Select only needed modal subcase.
Select only needed mode range.
Select only displacement/eigenvector/mode-shape data needed for deformation.
Avoid stress/strain/force/contact data if capture does not need them.
Avoid unnecessary layer/component/corner result data.
Include only needed model parts if part selection is practical.
Use local SSD/NVMe, not network storage.
Split very large jobs into mode chunks.
```

Example chunks:

```text
modes 1-20
modes 21-40
modes 41-60
```

Chunking makes failures cheaper to rerun and can keep H3D files smaller.

## GUI First, Code Later

Recommended first-time workflow:

```text
1. Open HvTrans GUI.
2. Load OP2.
3. Wait for LoadResults/indexing.
4. Confirm modal subcase and mode list.
5. Choose BDF as input deck if result file does not contain sufficient model.
6. Select mode range with By Step.
7. Select only needed result data.
8. Include model if capture H3D should be self-contained.
9. Translate to H3D.
10. Open H3D in HyperView and verify visual result.
```

Recommended repeat workflow:

```text
1. Save HvTrans config from GUI.
2. Use script to load config.
3. Replace input/output paths.
4. Run StartTranslation.
5. Log conversion status.
```

Code does not remove the need to load/index the OP2, but it removes repetitive
manual choices after the conversion recipe is proven.

## What The Translate Button Actually Does

The installed GUI's `Translate...` button is a thin wrapper around the same
command layer:

```tcl
::post::HvTrans::saveProc
hvtrans control SetOutputFile $saveH3DFName
hvtrans control StartTranslation
```

`saveProc` resets and rebuilds the config, applies model/result readers,
compression, selected parts, selected subcases, selected simulations, result
data types, layers/components, and optional H3D-per-step output. Then
`StartTranslation` runs the conversion.

Practical meaning:

```text
GUI is enough for one-off conversion and first validation.
Code is better for repeated OP2/BDF pairs, chunked mode ranges, logging, retry,
and running the same selection recipe overnight.
The heavy conversion engine is the same path, so code mainly reduces manual
time and mistakes rather than making OP2 I/O magically fast.
```

## HvTrans And GIF Capture

HvTrans does not capture GIF.

Correct split:

```text
HvTrans:
  create filtered H3D

HyperView:
  open H3D/MVW
  set mode-shape animation
  capture PNG/JPEG/AVI/GIF
```

Local evidence:

```text
HyperWorks scripts use session CaptureAnimation AVI.
HyperView GUI appears to support GIF capture.
Direct GIF capture from code should be tested on the target machine.
Safe fallback is PNG frames -> GIF with ffmpeg/ImageMagick/Python.
```

Possible experiment:

```tcl
hwi OpenStack
hwi GetSessionHandle sess
set ok [catch {sess CaptureAnimation GIF "C:/tmp/modes.gif"} err]
hwi CloseStack
```

If this fails or produces poor output, capture PNG frames and build GIF outside
HyperView.

## Practical Decision Table

```text
Question                                      Answer
--------------------------------------------  ------------------------------------
Can I pick modes before loading OP2?          No, HvTrans needs result metadata.
Does GUI load all OP2 data into memory?       Not necessarily, but indexing is slow.
Does code convert much faster than GUI?       Usually no; same engine.
Does code help anyway?                        Yes, for repeatability and batching.
Does HvTrans capture GIF?                     No.
Does HyperView capture GIF?                   GUI yes; code should be tested.
Best GIF-safe path?                           Capture PNG frames, then build GIF.
Best way to speed capture?                    Convert once to filtered H3D first.
```

## Recommended Path For This Project

Use this as the working direction:

```text
Phase 1:
  Use HvTrans GUI on a small mode range.
  Prove OP2+BDF -> H3D.

Phase 2:
  Save HvTrans config.
  Use same recipe for larger mode ranges or chunks.

Phase 3:
  Build HyperView MVW template from H3D.

Phase 4:
  Use HWI script to capture PNG frames or AVI.

Phase 5:
  Generate GIF from PNG frames unless direct GIF capture is verified.
```

The main performance win is not "code instead of GUI"; it is "filtered H3D
instead of repeatedly using raw OP2+BDF during capture".

## Config Persistence Commands (`hvtrans config` / `hvtrans control`)

Gap-fill: an earlier draft of this file documented `hvtrans config AddItem`
extensively but omitted the save/load/list/read-back commands used around it.
Sourced by reading the installed Tcl directly:

```text
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransSaveConfig.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransOpenConfig.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransgui.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransOpenResult.tcl
```

Note: the task backlog referred to one of these as `SetTolerance`. The real
command found in source is `SetCompressionTolerance` (paired with
`GetCompressionTolerance`); there is no bare `SetTolerance` command anywhere
in these files. Documented below under its real name.

### `hvtrans control SaveConfig`

```text
Signature:
  hvtrans control SetConfigFile <path.cfg>
  hvtrans control SaveConfig

Return shape:
  Not captured/checked by caller in observed usage (fileSaveCProc calls it
  bare, no catch/return handling shown).

Precondition/side-effect:
  Requires SetConfigFile to have been called first with the destination path.
  Writes the current in-memory config (built via repeated
  `hvtrans config AddItem ...` calls, typically from ::post::HvTrans::saveProc)
  to that .cfg file. Observed call order in hvtransSaveConfig.tcl
  fileSaveCProc: SetCallback errormsg -> SetResultReader "" ->
  SetModelReader "" -> [optional SetCompressionLevel/Tolerance] ->
  saveProc (builds config via AddItem) -> SetConfigFile <path> -> SaveConfig.

Confidence: LOCAL-INSTALL
```

### `hvtrans control LoadConfig`

```text
Signature:
  hvtrans control SetConfigFile <path.cfg>
  hvtrans control LoadConfig

Return shape:
  Not checked for a return value in observed usage; caller proceeds directly
  to `hvtrans config ListItems` afterward to read the loaded config back.

Precondition/side-effect:
  Requires SetConfigFile to point at an existing .cfg file first (in
  configProc: `hvtrans control SetConfigFile
  $::post::HvTrans::previouslySelectedConfigFName` then `LoadConfig`).
  Populates the in-memory config tree so `hvtrans config ListItems` /
  `GetItemValue` can walk it. Must run before any `ListItems`/`GetItemValue`
  calls that expect the loaded config's content, not the default/empty one.

Confidence: LOCAL-INSTALL
```

### `hvtrans control SetCompressionLevel`

```text
Signature:
  hvtrans control SetCompressionLevel <int>

Return shape:
  Not checked for a return value in observed usage (called bare).

Precondition/side-effect:
  Observed always called with literal 7 in both the compressed and
  uncompressed branches of saveProc/fileSaveCProc — compression on/off in
  this GUI is actually controlled by SetCompressionTolerance's value (0 vs
  non-zero), not by varying this level. Must be set before SaveConfig for the
  value to be captured in the saved .cfg.

Confidence: LOCAL-INSTALL
```

### `hvtrans control SetCompressionTolerance` (real name for backlog's "SetTolerance")

```text
Signature:
  hvtrans control SetCompressionTolerance <float>
  hvtrans control GetCompressionTolerance   ;# read-back counterpart

Return shape:
  SetCompressionTolerance's return value IS checked in one call site:
  `if {[hvtrans control SetCompressionTolerance $::per]} { ... } else {
  hvtrans control SetCompressionTolerance 0.100000 }` — implies it returns a
  boolean-ish success/failure value, used to fall back to a default 0.100000
  when setting the user's requested tolerance ($::per) fails/rejects.
  GetCompressionTolerance returns a float, compared with `> 0.000000` to
  decide whether to re-enable the compression checkbox on config reload.

Precondition/side-effect:
  0.000000 means no lossy compression (used when $::compress is false).
  Non-zero (default fallback 0.100000) enables lossy compression at that
  tolerance. Must be set before SaveConfig to persist.

Confidence: LOCAL-INSTALL
```

### `hvtrans control SetCallback errormsg`

```text
Signature:
  hvtrans control SetCallback errormsg <procName>
  hvtrans control SetCallback progress <procName>   ;# sibling variant, also observed

Return shape:
  Not checked for a return value in observed usage (called bare).

Precondition/side-effect:
  Registers a Tcl proc name (e.g. `MyErrormsg`) as the callback HvTrans
  invokes on error conditions during config/result operations. The `progress`
  variant (seen in hvtransOpenResult.tcl paired with
  `::post::HvTrans::CallbackFunction1`) registers a progress callback for
  long-running load operations. Both observed set once near the start of a
  load/save flow, before the actual LoadResults/LoadConfig/SaveConfig call.

Confidence: LOCAL-INSTALL
```

### `hvtrans config ListItems`

```text
Signature:
  hvtrans config ListItems                 ;# top-level keys
  hvtrans config ListItems <path>          ;# children of a config path node

Return shape:
  A Tcl list of item name strings. Observed used both to get all top-level
  keys (`set listVal [hvtrans config ListItems]`, then scanned for prefixes
  like "DerivedSubcase", "ExtendedInfo:", "EnableCompression", "Config<H3D>",
  "Parts", "Subcase") and scoped to a sub-path, e.g.
  `hvtrans config ListItems Parts` returns part names under Parts, and
  `hvtrans config ListItems $item$sep$sim` (e.g.
  "Subcase<1>/Simulation<2>") returns the data-type leaf names under that
  simulation node.

Precondition/side-effect:
  Requires a config to already be populated in memory — either loaded via
  LoadConfig or built in the current session via AddItem. Read-only, no
  side-effect. This is the primary walk/enumerate primitive paired with
  GetItemValue for reading back what SaveConfig/AddItem produced.

Confidence: LOCAL-INSTALL
```

### `hvtrans config GetItemValue`

```text
Signature:
  hvtrans config GetItemValue <path>

Return shape:
  A single value (string, or -1 as a sentinel meaning "not set/all"). Observed
  examples: `hvtrans config GetItemValue Parts/$part` returns a pool name
  string, compared case-insensitively against "(All)". `hvtrans config
  GetItemValue $item` for a Subcase<id> node returns either -1, "(all)"/"all"
  (case-insensitive), or an explicit subcase-id list — caller branches on
  which case it is to decide whether to use every subcase from
  `hvtrans result GetSubcases` or just the listed ones. Same -1/"(All)"/"all"
  sentinel pattern is reused for `GetItemValue $item$sep$sim` (per-simulation
  selection).

Precondition/side-effect:
  Read-only. Requires the path to exist in the currently loaded/built config
  (check with ListItems first, or guard with the -1/"(all)" sentinel
  convention rather than assuming the path exists).

Confidence: LOCAL-INSTALL
```
