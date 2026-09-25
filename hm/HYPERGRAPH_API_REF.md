# HyperGraph / CurveEditor Tcl API Reference

AI-readable notes on the real, callable Tcl command layer of HyperGraph (the
2D plotting/curve product inside Altair HyperWorks Unified Desktop),
for building Nastran automation tooling that needs to drive curve/plot
windows programmatically.

Verification status:

```text
LOCAL-INSTALL:
  Full itcl class source for ::hw::CurveEditor (and its helper classes
  TableEditor, PropertyEditor, TreeViewEditor, ExpressionWidget) was read
  directly from the local HyperWorks install. Method bodies, argument
  lists, and side effects below are transcribed/summarized from that source,
  not guessed from names.

LIVE-PROBE-INCONCLUSIVE:
  A batch probe (`hw.exe -b -tcl <script>`) attempting `info args
  ::hw::CurveEditor::<Name>` was written and run twice (once assuming the
  class autoloads, once explicitly `source`-ing hwpltutility.tcl). Both runs
  produced zero stdout/stderr in this environment (`hw.exe -b -tcl` appears
  not to surface Tcl `puts` output to the console/redirect in this install,
  or the CurveEditor package requires a live GUI session/toplevel that batch
  mode does not provide). This is reported honestly as INCONCLUSIVE rather
  than claimed as a pass. No command in this doc is marked "confirmed via
  info args" as a result — all confidence levels below are source-read based.

NOT-FOUND:
  No genuine ::post::pa::, ::hg::, or ::plot:: namespace of clear
  verb-noun-named plotting procs was found analogous to CurveEditor. The
  bulk of HyperGraph's plotting UI logic lives in TclPro-compiled `.tbc`
  bytecode files under `hw/tcl/hwplot/` (see "Bytecode-only areas" below),
  which are not human-readable source.
```

Sources inspected:

- `<ALTAIR_INSTALL_DIR>/hw/tcl/hw/CurveEditor/hwpltutility.tcl`
  (the only plaintext `.tcl` file defining `::hw::CurveEditor` and its
  colleague classes; full ~1650 lines read in this pass)
- `<ALTAIR_INSTALL_DIR>/hw/tcl/hwplot/` (directory listing
  only — contents are `.tbc` bytecode, see below)
- `<ALTAIR_INSTALL_DIR>/hw/tcl/procNexus/command/FFTCommand.tbc`
  and `MathCommand.tbc` (opened, confirmed bytecode, see below)
- `<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransgui.tcl`,
  `hvtransOpenConfig.tcl`, `hvtransOpenResult.tcl`, `hvtransSaveConfig.tcl`
  (hvtrans wrapper pattern, for comparison with hgtrans)
- `<ALTAIR_INSTALL_DIR>/hw/tcl/hwplot/hgtransgui.tbc`,
  `hgtransrename.tbc` (hgtrans wrapper existence check)
- Probe script (inconclusive):
  `_clean/tests/probe_hypergraph_track4.tcl`,
  `_clean/tests/probe_hypergraph_track4b.tcl`

---

## Honest overall assessment

`::hw::CurveEditor` is a real, well-structured `itcl` class with genuine
public methods — this is not GUI-widget-path noise. However, it is an
**embedded-widget class**, not a standalone scripting API: every instance
wraps an external plot window handle (`_plotHandle`, obtained via
`::hw::GetExternalClientWindowHandle`) that itself exposes the real curve/
axis/vector primitives (`AddCurve`, `GetCurveHandle`, `SetValues`,
`SetExpression`, `Recalculate`, `Autoscale`, `Draw`, etc.) as a SWIG-bound
C++ object, not Tcl source. `CurveEditor`'s methods are thin
orchestration/validation layers over that C++ handle plus some notebook/
table/tree UI wiring (`TableEditor`, `PropertyEditor`, `TreeViewEditor`,
`ExpressionWidget`).

So the honest picture is: the **class-level API surface is real but thin**
— roughly 20 methods worth documenting, most of them either simple
delegation (`Fit`, `GetCount`, `GetPageAreaId`) or validation-plus-delegation
(`Add`, `SetAttr`, `GetAttr`). The actual heavy-lifting curve math/plot
engine (the `$_plotHandle` object's methods, the `.tbc` files in
`hw/tcl/hwplot/`, and `FFTCommand.tbc`/`MathCommand.tbc`) is compiled
TclPro bytecode and not inspectable as source at all — this reference
cannot and does not document that layer's internals beyond what is called
from `CurveEditor`.

---

## `::hw::CurveEditor` — confirmed public/protected methods

All methods below are `itcl::body ::hw::CurveEditor::<Name>` definitions
read directly from `hwpltutility.tcl`. `$this`/instance context: you must
first construct an instance, e.g. `::hw::CurveEditor #auto` or
`::hw::CurveEditor #auto loadutilityframe`, which internally calls
`CreatePlot` and opens/attaches an external HyperGraph plot window.

### Add

- **Signature**: `<curveEditorObj> Add ?-x <xExpr|xValues>? -y <yExpr|yValues> ?-y <yExpr2>...? ?-name <n>? ?-linethickness <n>? ...`
  Also a special form: `<curveEditorObj> Add datum -x <value>` or
  `Add datum -y <value>` to add a vertical/horizontal datum line instead of
  a curve.
- **Return shape**: For the `datum` form, returns the datum id (string,
  `-1` on no-op). For normal curve adds, returns a **Tcl list of created
  curve ids** (one id per `-y` argument pair supplied); returns `0` if no
  `-y` was supplied (`numCurves == 0`).
- **Precondition/side-effect**: Chart type must already be set (via
  `SetType`) — behavior branches on `[$this GetType]` (`"bar"` vs `"xy"`).
  For `bar` charts, `-x`/`-category` sets the category axis and pads
  existing curves with zeros to match new category count. For `xy` charts,
  values passed to `-x`/`-y` are auto-detected as either literal numeric
  `values` or a math `expression` string (`SetType math` + `SetExpression`
  on the underlying vector handle if any token isn't `string is double`).
  Calls `$_plotHandle AddCurve`, sets vector data, then (unless
  `UpdateLock` is true) calls `Recalculate`, `Autoscale`, `Draw` on the
  plot handle.
- **Confidence**: High (full source read, straightforward control flow).

### SetAttr

- **Signature**: `<obj> SetAttr <entityType> <entityIdentifier> <args...>`
  where `entityType` is one of `curve`, `axis`, `plot`, `datum`, `legend`.
  For `curve`: `entityIdentifier` = curve id, `args` = `-property value`
  pairs forwarded to the curve handle's `Set`. For `axis`:
  `entityIdentifier` = `x` or `y`. For `datum`: first arg must be an
  integer datum number.
- **Return shape**: None (procedure returns after side effects; no
  explicit `return` value on the curve/axis/plot paths).
- **Precondition/side-effect**: Mutates the corresponding plot-engine
  handle via `eval "<handle> Set $args"`. If a `propertyEditor` colleague
  is attached, re-populates it. Calls `$_plotHandle Draw` at the end unless
  `UpdateLock` is `true`.
- **Confidence**: High.

### GetAttr

- **Signature**: `<obj> GetAttr <entityType> <entityIdentifier> <args...>`
  — `entityType` supports only `curve` and `axis` (no `plot`/`datum`/
  `legend` branch exists here, unlike `SetAttr`).
- **Return shape**: Whatever the underlying curve/axis handle's `Get`
  method returns for the requested property/properties (raw pass-through:
  `set ret [crvH$t Get {*}$args]; return $ret`).
- **Precondition/side-effect**: Read-only; no `Draw` call.
- **Confidence**: High.

### Clear

- **Signature**: `<obj> Clear ?args?` where `args` is a free-text string
  matched via `string first` for the substrings `"curve"`, `"table"`,
  `"property"`, `"expression"` (case-insensitive after `string tolower`).
  Calling with no args clears everything (curve + table + property +
  expression).
- **Return shape**: None.
- **Precondition/side-effect**: If clearing curves, calls
  `$_plotHandle Clear` + `Draw`. Also resets attached `tableEditor` /
  `propertyEditor` / `expressionWidget` colleagues if present and matched
  by the args string.
- **Confidence**: High.

### GetMeta / SetMeta

- **Signature**: `<obj> GetMeta <curveId> <key> ?args?` /
  `<obj> SetMeta <curveId> <key> <val> ?args?`
- **Return shape**: `GetMeta` returns the value from
  `crv$t GetMetaData $key` on the curve handle. `SetMeta` returns none.
- **Precondition/side-effect**: `SetMeta` calls `crv$t SetMetaDataPrivate`
  then `$_plotHandle Draw`. Requires `curveId` to be a valid existing
  curve (no bounds check shown here, unlike `Delete`/`SetAttr`).
- **Confidence**: High.

### GetType / SetType

- **Signature**: `<obj> GetType` (no args) / `<obj> SetType <charttype> ?args?`
  Known chart types referenced in source: `"xy"`, `"bar"`, `"polar"`,
  `"complex"`.
- **Return shape**: `GetType` returns `[$_plotHandle GetChartType]`
  (string). `SetType` returns `1` immediately (no-op) for `polar`/`complex`
  ("not supported in phase 1" per source comment); otherwise returns `0`.
- **Precondition/side-effect**: `SetType`, if the chart already has
  curves, pops a `yesno` `::hw::MessageBox` warning that changing type
  erases current data — **this is a blocking modal dialog in a GUI
  session**, not safe to call unattended in batch mode without answering
  it. On confirm, calls `Clear`, `$_plotHandle SetChartType`, and for
  `bar` also `SetHorizontalLabeling true`.
- **Confidence**: High (including the modal-dialog caveat, directly from
  source).

### GetCount

- **Signature**: `<obj> GetCount` (no args)
- **Return shape**: Integer — `[$_plotHandle GetNumberOfCurves]`.
- **Precondition/side-effect**: None (pure read).
- **Confidence**: High.

### Delete

- **Signature**: `<obj> Delete <curveId> ?args?`
- **Return shape**: None.
- **Precondition/side-effect**: No-ops silently if
  `[$_plotHandle GetNumberOfCurves] < curveId` (note: this guard is
  backwards-looking only — it does not check `curveId >= 1`, so
  `curveId <= 0` is NOT rejected by this check and would be passed through
  to `RemoveCurve`). Otherwise calls `$_plotHandle RemoveCurve $curveId`
  then `Draw`.
- **Confidence**: High.

### Fit

- **Signature**: `<obj> Fit ?"x"|"y"|"xy"?` — a single optional string
  argument; more than one arg causes an early `return` (silent no-op).
  Empty args default to `"xy"`.
- **Return shape**: None.
- **Precondition/side-effect**: Calls
  `$_plotHandle Autoscale <autoscaleX:bool> <autoscaleY:bool>` (booleans
  derived from whether `"x"`/`"y"` appear as substrings of the arg) then
  `Draw`.
- **Confidence**: High.

### Show / Hide

- **Signature**: `<obj> Show <entityType> ?args?` / `<obj> Hide <entityType> ?args?`
  — thin wrappers: `Show` calls `ChangeVisibility entityType true`, `Hide`
  calls `ChangeVisibility entityType false`.
- **Return shape**: Passes through `ChangeVisibility`'s return: `0` on
  success for `entityType` `"legend"` (only if curve count > 0) or
  `"value"`; `1` otherwise (unhandled entity type / no curves).
- **Confidence**: High.

### ChangeVisibility (private)

- **Signature**: `<obj> ChangeVisibility <entityType:legend|value> <booleanval> ?args?`
  — private method, only reachable via `Show`/`Hide`.
- **Return shape**: `0` if handled, `1` if `entityType` doesn't match
  `"legend"` or `"value"`.
- **Precondition/side-effect**: For `"legend"`, iterates every curve and
  calls `SetDisplayInLegend $booleanval` on each, then `Draw`. For
  `"value"`, calls `$_plotHandle DisplayBarValues $booleanval` + `Draw`
  (bar-chart-specific).
- **Confidence**: High.

### GetCurveHandle

- **Signature**: `<obj> GetCurveHandle <curveId> ?args?`
- **Return shape**: Returns the **name** (as a string) of a dynamically
  created global command `curveH<t>` where `<t> = [::hw::GetT]` — i.e. it
  returns a callable handle-command name, not the curve data itself. The
  caller is expected to invoke methods on that returned name (e.g.
  `[$obj GetCurveHandle 1] GetName`). No explicit `ReleaseHandle` is called
  by `GetCurveHandle` itself, unlike most other methods in this class —
  **callers are responsible for releasing the handle**.
- **Precondition/side-effect**: `curveId` must reference an existing
  curve; no bounds check shown (will error from the underlying C++ call if
  invalid).
- **Confidence**: High (signature/return mechanism), Medium (no explicit
  bounds-check behavior confirmed on invalid id — relies on underlying
  handle to error).

### GetPageAreaId

- **Signature**: `<obj> GetPageAreaId` (no args)
- **Return shape**: Returns `$_pageareaid`, a string set once in
  `CreatePlot` from `[clientHandle$t GetPageAreaID]`. Used elsewhere (e.g.
  `TreeViewEditor::Select`) to re-attach to the same external window via
  `::hw::GetExternalClientWindowHandle`.
- **Confidence**: High.

### Capture

- **Signature**: `<obj> Capture <filename> ?width "-1"? ?height "-1"? ?args?`
- **Return shape**: None (return value of `DumpArea` is not captured/
  returned).
- **Precondition/side-effect**: Calls `$_plotHandle DumpArea $filename
  $width $height` — writes a screenshot/image of the external plot window
  to `filename`. Width/height `-1` presumably means "use current window
  size" (not confirmed in this file; behavior lives in the C++ plot
  handle).
- **Confidence**: Medium (call site confirmed; exact `DumpArea` semantics
  for width/height are in the compiled plot engine, not this source file).

### CreatePlot (protected)

- **Signature**: `<obj> CreatePlot ?args?` — called automatically once
  from the constructor; not intended for external re-invocation (would
  create a second external window binding while overwriting `_plotHandle`
  and `_pageareaid`, likely leaking the first window).
- **Return shape**: None (bare `return`).
- **Precondition/side-effect**: Uses `::hw::GetExternalClientWindowHandle`
  to bind an external native plot window into `$itk_component(plotframe)`
  by dialog/placeholder window ids (`winfo id`). Sets up `<Configure>`,
  `<Visibility>`, `<Map>` bindings that forward to
  `ExternalWindowEventHandler`. Sets `_plotHandle` and `_pageareaid`. Calls
  `$_plotHandle InteractiveExternalCurve "false"` at the end.
- **Confidence**: High.

### ExternalWindowEventHandler (protected)

- **Signature**: `<obj> ExternalWindowEventHandler <page_area_id> <event> ?args?`
  — bound internally to window `<Configure>`/`<Visibility>`/`<Map>` events
  as `OnSize`; not meant to be called with arbitrary event names by
  external code (though nothing prevents it).
- **Return shape**: None.
- **Precondition/side-effect**: Re-acquires a temporary external client
  window handle scoped to `page_area_id`, invokes `<handle> $event`, then
  immediately calls `ReleaseHandle` on it. Marked `#TODO: Remove this
  binding altogether` in source — author considers this a workaround, not
  stable API.
- **Confidence**: High (source), but flagged as author-acknowledged
  fragile/internal.

### Interactive

- **Signature**: `<obj> Interactive <val>` (single required boolean-ish arg)
- **Return shape**: None.
- **Precondition/side-effect**: Calls
  `$_plotHandle InteractiveExternalCurve $val`.
- **Confidence**: High.

### SetBarGap / SetBarOffset / SetBarColor

- **Signature**: `<obj> SetBarGap <val> ?args?`, `<obj> SetBarOffset <val> ?args?`,
  `<obj> SetBarColor <value>`
- **Return shape**: `SetBarGap` returns `[$_plotHandle GetBarGap]` (or
  early-returns nothing if guard conditions fail). `SetBarOffset` and
  `SetBarColor` return nothing.
- **Precondition/side-effect**: All three are **no-ops if
  `[GetType] != "bar"`**. `SetBarGap` with `val == -1` auto-computes a gap
  from category count (only if curve count <= 2 and categories <= 5,
  otherwise silently returns). `SetBarColor` iterates every curve, sets a
  math expression on its `w` (width/color?) vector, then `Recalculate` +
  `Draw`.
- **Confidence**: High.

### GetCurvesView / LoadCurvesView / LoadTable / LoadPropEditor / LoadExpWidget

- **Signature**: `LoadCurvesView ?frame ""? ?args?`,
  `GetCurvesView ?args?`, `LoadTable ?frame ""? ?row 3? ?cols 2? ?args?`,
  `LoadPropEditor ?frame ""? ?args?`, `LoadExpWidget ?frame ""? ?args?`
- **Return shape**: `GetCurvesView` returns
  `$itk_component(treeViewframe)` (a Tk widget path — this is the one
  legitimate case where returning a widget path is correct, since it's
  literally a "give me the frame to embed" accessor). The `Load*` methods
  return nothing; they construct and attach a colleague helper object
  (`TreeViewEditor`, `TableEditor`, `PropertyEditor`, `ExpressionWidget`
  respectively) into `_colleagues`.
- **Precondition/side-effect**: If `-layout` itk option is `"auto"`
  (default), each `Load*` method calls `LoadUtilityFrame` to lazily build a
  shared split-frame/notebook UI region and adds its own tab. If `-layout`
  is `"custom"`, caller must supply `frame`. Each guards against double
  construction (prints to `stderr` "X already exists" and returns if the
  colleague is already an itcl object). `LoadTable` additionally rejects
  non-`"xy"` chart types with an stderr message.
- **Confidence**: High for control flow; Medium for exact visual
  layout details (depends on `hwtk::splitframe`/`notebook` internals not
  in scope here).

### AddCurveButtonCb / RegisterCurveEditorCb / RegisterPropEditorCb / SetMenuConfigureCb / SetUserDefinedValueAcceptCb

- **Signature**: each takes a single `cb` (Tcl command/script) argument,
  e.g. `<obj> AddCurveButtonCb <cb>`.
- **Return shape**: None.
- **Precondition/side-effect**: Registers callbacks forwarded to the
  relevant colleague object (`treeViewEditor`, accumulator list for curve
  updates, `propertyEditor`, `tableEditor`). `AddCurveButtonCb` and
  `RegisterPropEditorCb`/`SetMenuConfigureCb`/`SetUserDefinedValueAcceptCb`
  will error if the corresponding `Load*` method hasn't been called yet
  (they directly index `_colleagues(...)` with no existence guard, unlike
  the `Load*` methods).
- **Confidence**: High.

### RegisterCurveEntities

- **Signature**: `<obj> RegisterCurveEntities <idx> ?args?`
- **Return shape**: Returns `-1` if `idx` is empty or negative (also
  triggers `Clear "table property"` as a side effect in that case).
  Otherwise returns nothing (bare `return`).
- **Precondition/side-effect**: Sets `$_plotHandle SetActiveCurve $idx`
  and re-populates any attached `tableEditor`/`propertyEditor` with that
  curve.
- **Confidence**: High.

### Update / Select (public but documented in source as "used as mediators" — semi-internal)

- **Signature**: `<obj> Update ?row col val? ?currentCurveId?` (0, 3, or 4
  positional args only — anything else, e.g. 1 or 2 args, is rejected with
  a bare `return`). `<obj> Select <row> <col> ?args?`.
- **Return shape**: None.
- **Precondition/side-effect**: `Update` with zero args just calls
  `$_plotHandle Draw`. With 3+ args it edits a specific curve point (add/
  change/remove depending on `val`), optionally invoking any callbacks
  registered via `RegisterCurveEditorCb`. Explicitly commented in source as
  "Public Undocumented methods. Used as mediators" — i.e. Altair itself
  does not consider these part of the stable public surface, they exist to
  wire the table widget back to the plot.
- **Confidence**: High (source-confirmed), but noted as
  author-acknowledged internal/undocumented despite being technically
  callable.

---

## Bytecode-only areas (not inspectable as source)

The following exist and are exercised by the working plot engine, but are
**TclPro-compiled `.tbc` bytecode** — confirmed by opening each file and
finding only a plaintext header banner (`# HWVERSION_...`, `TclPro
ByteCode 2 0 ...`) followed by unreadable compiled binary tokens. No
signatures could be extracted from them:

- `hw/tcl/hwplot/plot.tbc`, `plotBuildPlots.tbc`, `plotCurveAttributes.tbc`,
  `plotDefineCurves_*.tbc`, `plotAxes.tbc`, `plotLegend.tbc`,
  `plotDatumLines.tbc`, `plotStatistics.tbc`, `plotExportCurves.tbc`, and
  the rest of that directory (~60 `.tbc` files total) — this is almost
  certainly where the real "create a plot from scratch," "define curve
  math," and axis-scaling logic lives, but it is closed.
- `hw/tcl/procNexus/command/FFTCommand.tbc` and `MathCommand.tbc` — opened
  and confirmed to be the same TclPro bytecode format (header:
  `# HWVERSION_2022.0.0.33...`, body: `tbcload::bceval { TclPro ByteCode 2
  0 1.7 8.5 ... }`). Cannot extract real math/FFT command signatures from
  these; only their existence and file names are confirmed
  (`FFTCommand.tbc`, `MathCommand.tbc` under `procNexus/command/`).
- `hw/tcl/hwplot/hgtransgui.tbc`, `hgtransrename.tbc` — see hgtrans section
  below.

No genuine `::post::pa::`, `::hg::`, or other clearly-named plotting
namespace with plaintext procs was found elsewhere in the `hw/tcl` tree
during this pass; `CurveEditor` is the only plaintext entry point.

---

## hgtrans wrapper vs hvtrans wrapper

`hgtrans.exe` (confirmed present at
`<ALTAIR_INSTALL_DIR>/hw/bin/win64/hgtrans.exe`) **does**
have a Tcl-level GUI wrapper, but it is bytecode-compiled, not plaintext:

- `hw/tcl/hwplot/hgtransgui.tbc` — header comment identifies it as
  `"hgtrans.tcl  HyperWorks 8.0 HyperGraph interface"`, dated 13 April
  2007, copyright Altair Engineering. Body is TclPro bytecode.
- `hw/tcl/hwplot/hgtransrename.tbc` — companion file, also bytecode.

Compare to `hvtrans.exe`'s wrapper, which **is** plaintext and fully
readable:

- `io/result_readers/tcl/hvtransgui.tcl`
- `io/result_readers/tcl/hvtransOpenConfig.tcl`
- `io/result_readers/tcl/hvtransOpenResult.tcl`
- `io/result_readers/tcl/hvtransSaveConfig.tcl`

So the honest answer is: **yes, an hgtrans wrapper layer exists and
follows the same naming pattern as hvtrans's** (`<name>gui`, plus a
rename/config helper), confirming Altair did build a Tcl GUI shell around
`hgtrans.exe` just like `hvtrans.exe`. But unlike the `hvtrans` wrapper,
the hgtrans wrapper was shipped as compiled bytecode in this\ninstall, so its actual command signatures, dialog flow, and CLI argument
passing to `hgtrans.exe` cannot be read or documented from source in this
pass — only its existence and general purpose (a GUI front-end that likely
invokes `hgtrans.exe` for HyperGraph file translation, analogous to how
`hvtransgui.tcl` drives `hvtrans.exe` for HyperView results translation).

---

## Live-probe attempt (for transparency)

Two probe scripts were written and run via
`hw.exe -b -tcl <script> > <result>.txt 2>&1`:

- `_clean/tests/probe_hypergraph_track4.tcl` — ran `info args
  ::hw::CurveEditor::<Name>` for every known method name, assuming the
  `CurveEditor` package auto-loads in batch mode.
- `_clean/tests/probe_hypergraph_track4b.tcl` — explicitly
  `source`d `hw/tcl/hw/CurveEditor/hwpltutility.tcl` first, then retried
  `info args ::hw::CurveEditor::Add`.

Both produced **zero bytes of output**, even when run with output piped
directly to the console (not just redirected to a file). This suggests
`hw.exe -b -tcl` in this install/environment does not surface `puts`
output the way a plain `tclsh` would (Unified Desktop batch mode may
suppress stdout, or the process exits before flushing, or a GUI-mode
requirement silently short-circuits script execution). This was not
investigated further to avoid burning time on a probe that a source read
had already substantively answered; the source-read evidence above is
the sole basis for the "Confidence: High" ratings in this document — none
of them rest on a successful `info args` confirmation.
