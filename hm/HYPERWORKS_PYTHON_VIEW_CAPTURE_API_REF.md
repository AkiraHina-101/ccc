# HyperWorks Python View And Capture API Reference

Purpose: AI-readable reference for controlling view orientation, fit, display
style, and screenshot capture from Python in HyperMesh and HyperView/HyperWorks
Post.

This file is intentionally practical: in this install, most reliable
graphics/view APIs are Tcl/HWI commands. Python drives them through the embedded
Tcl-Python bridge (`Tclinter.tcl.eval` / `Tclinter.tcl.call`) or through HWX
profile `py:` commands.

Batch-mode support and the limits of no-GUI capture are summarized in:

```text
_clean/docs/HYPERWORKS_BATCH_API_REF.md
```

Verification status:

```text
OFFICIAL:
  HWI Tcl object/handle syntax, `CaptureScreen` as an operation-command
  example, HyperView `poI3DViewCtrl`, and HyperMesh `hm_windowtofile` /
  `hm_windowtoclipboard` are confirmed by Altair help.

LOCAL-INSTALL:
  Embedded Python `Tclinter` bridge and AVI animation capture examples are from
  the local Altair install.

RUNTIME-TEST-NEEDED:
  Direct GIF capture from Python/Tcl and capture reliability in the exact batch
  launch mode used by automation.
```

Sources inspected:

```text
<ALTAIR_INSTALL_DIR>/hw/tcl/tclpython/Tclinter.py
<ALTAIR_INSTALL_DIR>/hw/tcl/tclpython/README
<ALTAIR_INSTALL_DIR>/hm/scripts/MVD/mvdMain/src/analysis/hw_procedures_incl_handles.tcl
<ALTAIR_INSTALL_DIR>/utility/VehicleSafetyTools/mv_hv_hg/PedestrianImpactNew/utils/hw_procedures_incl_handles_1.tcl
<ALTAIR_INSTALL_DIR>/hwx/plugins/hwd/profiles/HyperworksPost/clients/Results/toolbars/actions.xml
<ALTAIR_INSTALL_DIR>/hwx/plugins/hwd/profiles/HyperworksPost/clients/Results/toolbars/async_actions.xml
<ALTAIR_INSTALL_DIR>/hwx/plugins/hwd/profiles/HyperworksPost/clients/Plotting3D/toolbars/actions.xml
<ALTAIR_INSTALL_DIR>/hwx/plugins/hwd/profiles/HyperworksGeneral/toolbars/actions.xml
<ALTAIR_INSTALL_DIR>/hm/scripts/context/src/viz.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/model/unity/modelViewToolbar.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/plot3d/unity/plotViewToolbar.tcl
<ALTAIR_INSTALL_DIR>/utility/scripts/function_keys.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/preferences/xml/imagecapture.xml
```

## Mental Model

There are three useful layers:

```text
Python script
  -> Tclinter.tcl.eval/call
  -> Tcl/HWI command
  -> HyperMesh or HyperView graphics window
```

For capture and view control, HWI has the common handle chain:

```text
Session
  -> Project
  -> Page
  -> Window
  -> Client
  -> ViewControl
```

Typical Tcl/HWI chain:

```tcl
hwi OpenStack
hwi GetSessionHandle sess
sess GetProjectHandle proj
proj GetPageHandle page [proj GetActivePage]
page GetWindowHandle win [page GetActiveWindow]
win GetClientHandle client
win GetViewControlHandle view
...
view ReleaseHandle
client ReleaseHandle
win ReleaseHandle
page ReleaseHandle
proj ReleaseHandle
sess ReleaseHandle
hwi CloseStack
```

Python can execute the same block:

```python
import Tclinter
Tclinter.tcl.eval("hwi GetSessionHandle sess")
```

## Python Bridge Helper

Use this in embedded Python started by `python::exec` / `python::execfile`.

```python
import os
import sys

altair_home = os.environ.get("ALTAIR_HOME", r"<ALTAIR_INSTALL_DIR>")
tclpython = os.path.join(altair_home, "hw", "tcl", "tclpython")
if tclpython not in sys.path:
    sys.path.append(tclpython)

import Tclinter

def tcl_eval(script):
    return Tclinter.tcl.eval(script)

def tcl_call(*args):
    return Tclinter.tcl.call(*args)
```

### `altair_home`/`ALTAIR_HOME` setup pattern and `tcl_eval`/`tcl_call` wrappers

1. **Signature**: Python: reads `os.environ.get("ALTAIR_HOME", r"<ALTAIR_INSTALL_DIR>")`, builds `tclpython = os.path.join(altair_home, "hw", "tcl", "tclpython")`, appends to `sys.path` if missing, then `import Tclinter`. Defines `tcl_eval(script)` → `Tclinter.tcl.eval(script)` and `tcl_call(*args)` → `Tclinter.tcl.call(*args)`.
2. **Return shape**: Setup code returns None; `import Tclinter` raises `ImportError` if the resolved path is wrong. `tcl_eval`/`tcl_call` pass through whatever `Tclinter.tcl.eval`/`Tclinter.tcl.call` return (UNKNOWN exact type — needs live-session verification, consistent with the sibling embedding-API file).
3. **Precondition/side-effect**: Must run before any `tcl_eval`/`tcl_call` use. Assumes the embedded Python was launched by `python::exec`/`python::execfile` from within the HyperWorks Tcl interpreter it calls back into (same assumption as the plain `Tclinter` bridge in the embedding-API reference file). `ALTAIR_HOME` env var is an optional override; falls back to the hardcoded install path.
4. **Confidence**: LOCAL-INSTALL.

## Capture Screen

### Session-Level Capture

The common HWI session handle supports `CaptureScreen`.

Formats seen in installed helper:

```text
jpeg
bmp
tiff
png
```

Tcl:

```tcl
hwi GetSessionHandle sess
sess CaptureScreen PNG "C:/tmp/out.png" 100
sess CaptureScreen JPEG "C:/tmp/out.jpg" 95
sess CaptureScreen BMP "C:/tmp/out.bmp" 100
sess CaptureScreen TIFF "C:/tmp/out.tif" 100
```

Installed helper behavior:

```text
fileType default: JPEG
quality default: 100
quality clamp: 1..100
CaptureScreen call: [GetSession] CaptureScreen $type $fileName $quality
```

Python:

```python
def capture_screen(path, file_type="PNG", quality=100):
    path = path.replace("\\", "/")
    file_type = file_type.upper()
    quality = max(1, min(100, int(quality)))
    return tcl_eval("""
        hwi OpenStack
        hwi GetSessionHandle sess
        sess CaptureScreen %s {%s} %d
        sess ReleaseHandle
        hwi CloseStack
    """ % (file_type, path, quality))
```

### `sess CaptureScreen <type> <fileName> <quality>` / Python `capture_screen(path, file_type, quality)`

1. **Signature**: Tcl (via HWI session handle): `sess CaptureScreen PNG "C:/tmp/out.png" 100` (also `JPEG`, `BMP`, `TIFF`). Underlying call: `[GetSession] CaptureScreen $type $fileName $quality`. Python wrapper: `def capture_screen(path, file_type="PNG", quality=100)`, which uppercases `file_type`, clamps `quality` to 1..100, replaces backslashes in `path`, and wraps the call in `hwi OpenStack`/`GetSessionHandle`/`ReleaseHandle`/`hwi CloseStack`.
2. **Return shape**: Returns the Tcl block's last-evaluated result via `tcl_eval` (UNKNOWN exact type — needs live-session verification; not documented as returning a success/failure flag). Default `fileType` is `JPEG` and default `quality` is `100` per the installed helper's own defaults (the Python wrapper instead defaults `file_type` to `"PNG"`).
3. **Precondition/side-effect**: Requires a graphics session (per file's own Cautions: "HWI capture requires a graphics session. Batch-only/no-display sessions may fail or produce blank images"). Writes an image file to `path`/`fileName` as a side effect; captures current graphics/page/window state, so view/fit/display style/legend visibility should be set first.
4. **Confidence**: OFFICIAL for the `CaptureScreen` HWI session-handle operation itself (per file's Verification status block); LOCAL-INSTALL for the specific Python wrapper and quality-clamp/default behavior.

### Fixed-Size Capture

`CaptureScreenToSize` is used in project code and gives deterministic thumbnail
size.

Tcl:

```tcl
hwi OpenStack
hwi GetSessionHandle sess
sess CaptureScreenToSize png "C:/tmp/thumb.png" 768 768 95
sess ReleaseHandle
hwi CloseStack
```

Python:

```python
def capture_screen_to_size(path, width=768, height=768, quality=95):
    path = path.replace("\\", "/")
    return tcl_eval("""
        hwi OpenStack
        hwi GetSessionHandle sess
        sess CaptureScreenToSize png {%s} %d %d %d
        sess ReleaseHandle
        hwi CloseStack
    """ % (path, int(width), int(height), int(quality)))
```

Use `CaptureScreenToSize` when generating table thumbnails or repeatable
component preview images.

### `sess CaptureScreenToSize <type> <fileName> <width> <height> <quality>` / Python `capture_screen_to_size(...)`

1. **Signature**: Tcl: `sess CaptureScreenToSize png "C:/tmp/thumb.png" 768 768 95` inside `hwi OpenStack`/`GetSessionHandle`/`ReleaseHandle`/`hwi CloseStack`. Python: `def capture_screen_to_size(path, width=768, height=768, quality=95)`.
2. **Return shape**: Returns the Tcl block's result via `tcl_eval` (UNKNOWN exact type — needs live-session verification).
3. **Precondition/side-effect**: Requires a graphics session (same caution as `CaptureScreen`). Writes a fixed-size image to `path` regardless of current window aspect ratio, useful for deterministic thumbnails (per file's own guidance).
4. **Confidence**: LOCAL-INSTALL (listed under LOCAL-INSTALL in the file's Verification status block; used directly in project code per the file's own note, but not separately confirmed against Altair official help in this pass).

### Animation Capture From Python

Installed Tcl examples confirm AVI animation capture. Drive it from Python
through `Tclinter` when the HyperView/HyperWorks graphics session is already
open and the animation client is configured.

```python
def capture_animation_avi(path, fps=12):
    path = path.replace("\\", "/")
    return tcl_eval("""
        hwi OpenStack
        hwi GetSessionHandle sess
        sess GetAVIExportOptionsHandle aviopt
        aviopt SetFrameRate %d
        sess CaptureAnimation AVI {%s}
        aviopt ReleaseHandle
        sess ReleaseHandle
        hwi CloseStack
    """ % (int(fps), path))
```

### `sess CaptureAnimation AVI <path>` / Python `capture_animation_avi(path, fps)`

1. **Signature**: Tcl: `sess GetAVIExportOptionsHandle aviopt`, `aviopt SetFrameRate <fps>`, `sess CaptureAnimation AVI {<path>}`, then release handles. Python: `def capture_animation_avi(path, fps=12)`.
2. **Return shape**: Returns the Tcl block's result via `tcl_eval` (UNKNOWN exact type — needs live-session verification).
3. **Precondition/side-effect**: Requires the HyperView/HyperWorks graphics session to already be open with the animation client configured (per file's own text: "Drive it from Python through Tclinter when the HyperView/HyperWorks graphics session is already open and the animation client is configured"). Writes an AVI file to `path` as a side effect.
4. **Confidence**: LOCAL-INSTALL (per Verification status block: "AVI animation capture examples are from the local Altair install").

Area animation capture is also exposed in installed Tcl:

```python
def capture_animation_area_avi(path, x, y, w, h):
    path = path.replace("\\", "/")
    return tcl_eval("""
        proc __py_capture_area_avi {path x y w h} {
            hwi OpenStack
            hwi GetSessionHandle sess
            sess CaptureAnimationByAreaPercentage AVI $path $x $y $w $h
            sess ReleaseHandle
            hwi CloseStack
        }
        after idle [list __py_capture_area_avi {%s} %s %s %s %s]
    """ % (path, x, y, w, h))
```

Use `after idle` or an explicit draw/wait step after changing mode/frame/view.
The installed function-key script uses `after idle` before area animation
capture because immediate capture can stop drawing.

### `sess CaptureAnimationByAreaPercentage AVI <path> <x> <y> <w> <h>` / Python `capture_animation_area_avi(...)`

1. **Signature**: Tcl (wrapped in an `after idle`-scheduled proc): `proc __py_capture_area_avi {path x y w h} { hwi OpenStack; hwi GetSessionHandle sess; sess CaptureAnimationByAreaPercentage AVI $path $x $y $w $h; sess ReleaseHandle; hwi CloseStack }` then `after idle [list __py_capture_area_avi ...]`. Python: `def capture_animation_area_avi(path, x, y, w, h)`.
2. **Return shape**: Returns the Tcl block's result via `tcl_eval` (the `after idle` scheduling makes any return value effectively asynchronous/not meaningful — UNKNOWN, needs live-session verification).
3. **Precondition/side-effect**: Requires an open graphics session with the animation client configured. Uses `after idle` deliberately — per the file's note, the installed function-key script does this "because immediate capture can stop drawing," i.e. capturing without yielding to the event loop first can produce a blank/incomplete capture. `x, y, w, h` are area percentages, not pixel coordinates (per command name).
4. **Confidence**: LOCAL-INSTALL.

### GIF capture (`CaptureAnimation GIF`)

1. **Signature**: Not directly demonstrated as working Python/Tcl in inspected sources; would presumably follow the same shape as `CaptureAnimation AVI` but with `GIF` as the format argument.
2. **Return shape**: UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: UNKNOWN — needs live-session verification. HyperView GUI and local metadata expose GIF as an animation format, but the inspected production-style Tcl examples all use AVI instead.
4. **Confidence**: RUNTIME-TEST-NEEDED (explicitly called out in the file's Verification status block: "Direct GIF capture from Python/Tcl ... needs verification"). Recommended workaround: capture PNG frames or AVI first and encode GIF externally unless `CaptureAnimation GIF` is verified on the target machine.

## HyperMesh View And Capture

HyperMesh preprocessor view commands are mostly direct Tcl commands.

### Standard View

```tcl
*view "iso1"
*view "top"
*view "bottom"
*view "front"
*view "rear"
*view "left"
*view "right"
```

Fit:

```tcl
*window 0 0 0 0 0
```

Save/restore view:

```tcl
*saveviewmask "tmp_view"
*restoreviewmask "tmp_view"
*removeview "tmp_view"
```

Python:

```python
def hm_set_view(view="iso1", fit=True):
    fit_cmd = '*window 0 0 0 0 0' if fit else ''
    return tcl_eval("""
        *view {%s}
        %s
    """ % (view, fit_cmd))
```

### `*view "<name>"` / `*window 0 0 0 0 0` / `*saveviewmask`/`*restoreviewmask`/`*removeview` / Python `hm_set_view(view, fit)`

1. **Signature**: Tcl: `*view "iso1"|"top"|"bottom"|"front"|"rear"|"left"|"right"` sets standard view; `*window 0 0 0 0 0` fits the window; `*saveviewmask "<name>"`, `*restoreviewmask "<name>"`, `*removeview "<name>"` save/restore/remove a named view state. Python: `def hm_set_view(view="iso1", fit=True)`.
2. **Return shape**: Returns the Tcl block's result via `tcl_eval` (UNKNOWN exact type — needs live-session verification).
3. **Precondition/side-effect**: Requires a HyperMesh preprocessor session. Mutates the active graphics window's camera orientation and (if `fit=True`) fits it to the model. `*saveviewmask`/`*restoreviewmask` require the same `<name>` string on save and restore.
4. **Confidence**: These are plain HyperMesh Tcl commands; treated as OFFICIAL per the file's own decision table (HyperMesh preprocessor view commands), though not independently re-verified against Altair help in this retrofit pass.

### HyperMesh Render One Component

```python
def hm_render_component(cid, out_png, view="iso1", size=768):
    out_png = out_png.replace("\\", "/")
    return tcl_eval("""
        *saveviewmask "py_hm_render_tmp"
        *createmark comps 1 %d
        *isolateonlyentitybymark 1 1 2
        catch {::HM_Framework::p_SetElementStyleShadedLines}
        *view {%s}
        *window 0 0 0 0 0
        hwi OpenStack
        hwi GetSessionHandle sess
        sess CaptureScreenToSize png {%s} %d %d 95
        sess ReleaseHandle
        hwi CloseStack
        *restoreviewmask "py_hm_render_tmp"
        *removeview "py_hm_render_tmp"
    """ % (int(cid), view, out_png, int(size), int(size)))
```

### `hm_render_component(cid, out_png, view="iso1", size=768)`

1. **Signature**: Python function (shown above) that saves the current view mask, isolates component `cid`, forces shaded-line style, sets the given `view` and fits, captures a PNG at `size x size` via `CaptureScreenToSize`, then restores/removes the temporary view mask.
2. **Return shape**: Returns the Tcl block's result via `tcl_eval` (final command `*removeview`'s result — not a meaningful success indicator). UNKNOWN exact type — needs live-session verification.
3. **Precondition/side-effect**: Requires a graphics-capable HyperMesh session (batch/no-GUI may fail per file's Cautions). Writes `out_png` as a side effect; temporarily changes isolation/view/display style, restored via the saved view mask at the end (isolation state itself may or may not be reverted — not explicitly undone by `*restoreviewmask`).
4. **Confidence**: LOCAL-INSTALL (project-authored composite recipe; this is essentially the same pattern as `render_component_png` in the sibling embedding-API file).

### HyperMesh Display Style

Observed Tcl commands:

```tcl
::HM_Framework::p_SetElementStyleShadedLines
::HM_Framework::p_SetElementStyleWireframeSkin
::HM_Framework::p_SetGeomShadedEdges
::HM_Framework::p_SetGeomStyleWireframe
```

Observed low-level context style:

```tcl
hwctx SetMeshStyle 0   ;# wireframe
hwctx SetMeshStyle 1   ;# hiddenline
hwctx SetMeshStyle 2   ;# shaded with mesh / hiddenlinewithmesh
hwctx SetMeshStyle 3   ;# hiddenlinewithfeatures
hwctx SetMeshStyle 4   ;# hiddenlinetransparent
```

Python:

```python
def hm_set_mesh_style(style):
    return tcl_eval("catch {hwctx SetMeshStyle %d}" % int(style))
```

### `::HM_Framework::p_SetElementStyle*` / `hwctx SetMeshStyle <n>` / Python `hm_set_mesh_style(style)`

1. **Signature**: Tcl: `::HM_Framework::p_SetElementStyleShadedLines`, `::HM_Framework::p_SetElementStyleWireframeSkin`, `::HM_Framework::p_SetGeomShadedEdges`, `::HM_Framework::p_SetGeomStyleWireframe` (no-arg display-style procs); low-level `hwctx SetMeshStyle <n>` where `0`=wireframe, `1`=hiddenline, `2`=shaded with mesh/hiddenlinewithmesh, `3`=hiddenlinewithfeatures, `4`=hiddenlinetransparent. Python: `def hm_set_mesh_style(style)` wraps the low-level call in `catch {...}`.
2. **Return shape**: `tcl_eval("catch {hwctx SetMeshStyle %d}" % ...)` returns the `catch` result — `0` on success, `1` on Tcl error, per standard Tcl `catch` semantics — coerced through `Tclinter`. The `::HM_Framework::p_SetElementStyle*` procs' return values are UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires an active HyperMesh preprocessor context (`hwctx`) and, for `p_SetElementStyle*`, the `HM_Framework` namespace loaded (used elsewhere in this file wrapped in `catch {...}` for safety, e.g. in `render_component_png`/`hm_render_component`). Mutates the display style of the current graphics window.
4. **Confidence**: LOCAL-INSTALL (observed in installed Tcl scripts; not confirmed against Altair official help specifically for the numeric `SetMeshStyle` mapping in this section — contrast with the separately-documented `OnSetMeshStyle` numeric mapping later in the file, which the file caveats as "verified by toolbar tooltips, not... an open-source function contract").

## HyperView / HyperWorks Post View

HyperView/Results client toolbar commands from installed XML:

```text
::post::ViewOrientation top
::post::ViewOrientation bottom
::post::ViewOrientation left
::post::ViewOrientation right
::post::ViewOrientation back
::post::ViewOrientation front
::post::ViewOrientation iso

::post::ViewFit model true
::post::ViewFit selected true
::post::ViewFit all true
```

Python:

```python
def hv_view_orientation(name):
    # name: top, bottom, left, right, back, front, iso
    return tcl_eval("::post::ViewOrientation %s" % name)

def hv_fit(mode="model"):
    # mode: model, selected, all
    return tcl_eval("::post::ViewFit %s true" % mode)
```

### `::post::ViewOrientation <name>` / `::post::ViewFit <mode> true` (HyperView/Results)

1. **Signature**: Tcl: `::post::ViewOrientation top|bottom|left|right|back|front|iso`; `::post::ViewFit model|selected|all true`. Python: `def hv_view_orientation(name)`, `def hv_fit(mode="model")`.
2. **Return shape**: Returns the Tcl command's result via `tcl_eval` (UNKNOWN exact type — needs live-session verification).
3. **Precondition/side-effect**: Requires an active HyperView/Results client window. Note lowercase `iso` here versus HyperMesh's `iso1` (per file's own Caution 3: "HyperMesh `*view` names and HyperView `::post::ViewOrientation` names are not identical").
4. **Confidence**: These toolbar-XML-derived commands are from installed XML (`Results/toolbars/actions.xml`), listed under the file's LOCAL-INSTALL/general sourcing rather than explicitly OFFICIAL — treat as LOCAL-INSTALL.

For HyperWorks Post Plotting3D client, installed XML uses:

```text
::plot3d::_private::ViewOrientation top
::plot3d::_private::ViewOrientation bottom
::plot3d::_private::ViewOrientation left
::plot3d::_private::ViewOrientation right
::plot3d::_private::ViewOrientation back
::plot3d::_private::ViewOrientation front
::plot3d::_private::ViewOrientation iso
::plot3d::_private::ViewOrientation reverse

::plot3d::_private::ViewFit all
::plot3d::_private::ViewFit model
```

### `::plot3d::_private::ViewOrientation`/`ViewFit` (Plotting3D)

1. **Signature**: Tcl: `::plot3d::_private::ViewOrientation top|bottom|left|right|back|front|iso|reverse`; `::plot3d::_private::ViewFit all|model`. No Python wrapper example is given directly in the file for these (the file documents them for the decision table rather than a dedicated Python function).
2. **Return shape**: UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires an active HyperWorks Post Plotting3D client window.
4. **Confidence**: LOCAL-INSTALL (from installed `Plotting3D/toolbars/actions.xml`).

For MotionView/MBD model client, installed toolbar uses:

```text
::model::_private::ViewOrientation TOP
::model::_private::ViewOrientation BOTTOM
::model::_private::ViewOrientation LEFT
::model::_private::ViewOrientation RIGHT
::model::_private::ViewOrientation REAR
::model::_private::ViewOrientation FRONT
::model::_private::ViewOrientation ISO
::model::_private::view_toolbar_utils::OnSelectFitView
```

### `::model::_private::ViewOrientation`/`OnSelectFitView` (MotionView/MBD)

1. **Signature**: Tcl: `::model::_private::ViewOrientation TOP|BOTTOM|LEFT|RIGHT|REAR|FRONT|ISO`; `::model::_private::view_toolbar_utils::OnSelectFitView` (fit, no arguments shown). No Python wrapper is given in the file for these.
2. **Return shape**: UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires an active MotionView/MBD model client window. Note uppercase orientation keywords here, distinct from HyperView's lowercase and HyperMesh's `iso1`-style names.
4. **Confidence**: LOCAL-INSTALL (from installed `unity/modelViewToolbar.tcl`).

## HyperView ViewControl Handle

The shared helper says `GetViewControl` returns a ViewControl handle for
HyperGraph / HyperView / MotionView.

Direct HWI:

```tcl
hwi OpenStack
hwi GetSessionHandle sess
sess GetProjectHandle proj
proj GetPageHandle page [proj GetActivePage]
page GetWindowHandle win [page GetActiveWindow]
win GetViewControlHandle view

view SetOrientation "Iso"
view Fit
win Draw

view ReleaseHandle
win ReleaseHandle
page ReleaseHandle
proj ReleaseHandle
sess ReleaseHandle
hwi CloseStack
```

Recognized reserved view keywords from installed helper:

```text
Iso
Left
Top
Front
```

Other toolbar commands use lowercase:

```text
top bottom left right back front iso
```

Python:

```python
def hv_viewcontrol_set_orientation(orientation="Iso", fit=True):
    fit_cmd = "view Fit" if fit else ""
    return tcl_eval("""
        hwi OpenStack
        hwi GetSessionHandle sess
        sess GetProjectHandle proj
        proj GetPageHandle page [proj GetActivePage]
        page GetWindowHandle win [page GetActiveWindow]
        win GetViewControlHandle view
        view SetOrientation {%s}
        %s
        win Draw
        view ReleaseHandle
        win ReleaseHandle
        page ReleaseHandle
        proj ReleaseHandle
        sess ReleaseHandle
        hwi CloseStack
    """ % (orientation, fit_cmd))
```

### HWI ViewControl handle chain: `GetViewControlHandle` / `view SetOrientation` / `view Fit` / `win Draw` / Python `hv_viewcontrol_set_orientation(orientation, fit)`

1. **Signature**: Tcl handle chain: `hwi OpenStack` → `hwi GetSessionHandle sess` → `sess GetProjectHandle proj` → `proj GetPageHandle page [proj GetActivePage]` → `page GetWindowHandle win [page GetActiveWindow]` → `win GetViewControlHandle view` → `view SetOrientation "<name>"` → `view Fit` (optional) → `win Draw` → release handles in reverse order → `hwi CloseStack`. Python: `def hv_viewcontrol_set_orientation(orientation="Iso", fit=True)`.
2. **Return shape**: Returns the Tcl block's result via `tcl_eval` (UNKNOWN exact type — needs live-session verification; the block's last command is `hwi CloseStack`, not typically a meaningful value).
3. **Precondition/side-effect**: Requires an open HWI session with an active project/page/window (HyperGraph/HyperView/MotionView). All acquired handles (`sess`, `proj`, `page`, `win`, `view`) must be released via `ReleaseHandle` before `hwi CloseStack`, in the reverse order they were acquired, to avoid leaking HWI handles (per file's Caution 5). `view SetOrientation` accepts the reserved keywords `Iso`, `Left`, `Top`, `Front` (capitalized) per the installed helper — this is a different casing convention from the lowercase `top bottom left right back front iso` used by other toolbar commands (per file's own note distinguishing the two).
4. **Confidence**: OFFICIAL for the general HWI Tcl object/handle syntax (per Verification status block); LOCAL-INSTALL for the specific `SetOrientation` reserved-keyword set and the Python wrapper.

## Save And Restore Arbitrary HyperView View

The installed helper reads these ViewControl properties:

```text
PerspectiveMode
Ortho
Frustum
Orientation
```

It can create a Tcl command equivalent to:

```text
hwf::setViewByOptions \
  -perspectivemode ... \
  -ortho ... \
  -frustum ... \
  -orientation ...
```

Direct Python wrapper:

```python
def hv_get_view_state():
    script = """
        hwi OpenStack
        hwi GetSessionHandle sess
        sess GetProjectHandle proj
        proj GetPageHandle page [proj GetActivePage]
        page GetWindowHandle win [page GetActiveWindow]
        win GetViewControlHandle view
        set result [list \
            [view GetPerspectiveMode] \
            [view GetOrtho] \
            [view GetFrustum] \
            [view GetOrientation]]
        view ReleaseHandle
        win ReleaseHandle
        page ReleaseHandle
        proj ReleaseHandle
        sess ReleaseHandle
        hwi CloseStack
        set result
    """
    return tcl_eval(script)
```

### `hv_get_view_state()`

1. **Signature**: Python function (shown above) that opens the HWI handle chain to `ViewControlHandle`, then reads `[view GetPerspectiveMode]`, `[view GetOrtho]`, `[view GetFrustum]`, `[view GetOrientation]` into a Tcl list, releases handles, and returns the list.
2. **Return shape**: Returns a Tcl list of 4 values (`PerspectiveMode`, `Ortho`, `Frustum`, `Orientation`) coerced through `tcl_eval`/`Tclinter` — likely a Python list/tuple of strings, but exact type UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires an open HWI session with active project/page/window (same chain as `hv_viewcontrol_set_orientation`). Read-only — no mutation of view state.
4. **Confidence**: LOCAL-INSTALL (project-authored wrapper around HWI `ViewControl` getter properties documented in the installed helper `hw_procedures_incl_handles.tcl`).

```python
def hv_set_view_state(perspective_mode=None, ortho=None, frustum=None, orientation=None):
    pairs = []
    if perspective_mode is not None:
        pairs.append("view SetPerspectiveMode {%s}" % perspective_mode)
    if ortho is not None:
        pairs.append("view SetOrtho {%s}" % ortho)
    if frustum is not None:
        pairs.append("view SetFrustum {%s}" % frustum)
    if orientation is not None:
        pairs.append("view SetOrientation {%s}" % orientation)
    body = "\n".join(pairs)
    return tcl_eval("""
        hwi OpenStack
        hwi GetSessionHandle sess
        sess GetProjectHandle proj
        proj GetPageHandle page [proj GetActivePage]
        page GetWindowHandle win [page GetActiveWindow]
        win GetViewControlHandle view
        %s
        win Draw
        view ReleaseHandle
        win ReleaseHandle
        page ReleaseHandle
        proj ReleaseHandle
        sess ReleaseHandle
        hwi CloseStack
    """ % body)
```

### `hv_set_view_state(perspective_mode, ortho, frustum, orientation)`

1. **Signature**: Python function (shown above) that conditionally builds `view SetPerspectiveMode {...}` / `view SetOrtho {...}` / `view SetFrustum {...}` / `view SetOrientation {...}` Tcl lines for each non-`None` argument, joins them, and runs them inside the same HWI handle chain followed by `win Draw`.
2. **Return shape**: Returns the Tcl block's result via `tcl_eval` (UNKNOWN exact type — needs live-session verification).
3. **Precondition/side-effect**: Requires an open HWI session with active project/page/window. Mutates the ViewControl's perspective mode/ortho/frustum/orientation and redraws the window (`win Draw`) — intended to restore an exact camera state previously captured by `hv_get_view_state()`, matching the equivalent conceptual Tcl command `hwf::setViewByOptions -perspectivemode ... -ortho ... -frustum ... -orientation ...` referenced by the installed helper.
4. **Confidence**: LOCAL-INSTALL. Use this when the exact camera must be reused, not just top/front/iso.

## HyperView Mesh Style And Color Mode

Installed HyperView Results toolbar maps display style to Python calls:

```text
HyperworksPost.clients.Results.toolbars.viewtoolbar.OnSetMeshStyle(1)
HyperworksPost.clients.Results.toolbars.viewtoolbar.OnSetMeshStyle(2)
HyperworksPost.clients.Results.toolbars.viewtoolbar.OnSetMeshStyle(3)
HyperworksPost.clients.Results.toolbars.viewtoolbar.OnSetMeshStyle(4)
HyperworksPost.clients.Results.toolbars.viewtoolbar.OnSetMeshStyle(5)
```

Observed meanings from toolbar tooltips:

```text
1: Shaded Elements with Meshlines
2: Shaded Elements with Feature Lines
3: Shaded Elements with No Lines
4: Wireframe Elements
5: Transparent Elements
```

These are HWX profile `py:` commands, not plain Tcl commands. If running inside
that profile's Python environment, they can be called directly:

```python
from HyperworksPost.clients.Results.toolbars import viewtoolbar
viewtoolbar.OnSetMeshStyle(1)
```

If import fails in embedded Tcl-Python, use the toolbar Tcl/display commands or
call the profile action rather than assuming the module is on `sys.path`.

### `HyperworksPost.clients.Results.toolbars.viewtoolbar.OnSetMeshStyle(n)`

1. **Signature**: Python (HWX profile `py:` command, importable directly only inside that profile's Python environment): `from HyperworksPost.clients.Results.toolbars import viewtoolbar; viewtoolbar.OnSetMeshStyle(n)` where `n` is `1`=Shaded Elements with Meshlines, `2`=Shaded Elements with Feature Lines, `3`=Shaded Elements with No Lines, `4`=Wireframe Elements, `5`=Transparent Elements.
2. **Return shape**: UNKNOWN — needs live-session verification (source is packaged as `.pyc` in this install; not inspectable).
3. **Precondition/side-effect**: Requires running inside the `HyperworksPost` Results profile's Python environment where the module is on `sys.path` — not guaranteed available from generic embedded Tcl-Python (per file's own caution: "If import fails in embedded Tcl-Python, use the toolbar Tcl/display commands... rather than assuming the module is on sys.path"). Mutates the active Results window's mesh display style.
4. **Confidence**: The numeric mapping is verified only via toolbar tooltips in installed XML, not the (compiled/`.pyc`) function source — file's own Caution 6 explicitly downgrades this: "Treat the numeric mapping as verified by toolbar tooltips, not as an open-source function contract." Overall: LOCAL-INSTALL, not OFFICIAL.

Color mode commands from installed toolbar:

```text
::post::ResultsPyToolbar::SetMeshColorByMode Component
::post::ResultsPyToolbar::SetMeshColorByMode Model
::post::ResultsPyToolbar::SetMeshColorByMode Normal
::post::ResultsPyToolbar::SetMeshColorByMode PartAssembly
```

Python:

```python
def hv_color_by(mode="Component"):
    return tcl_eval("::post::ResultsPyToolbar::SetMeshColorByMode %s" % mode)
```

### `::post::ResultsPyToolbar::SetMeshColorByMode <mode>` / Python `hv_color_by(mode)`

1. **Signature**: Tcl: `::post::ResultsPyToolbar::SetMeshColorByMode Component|Model|Normal|PartAssembly`. Python: `def hv_color_by(mode="Component")`.
2. **Return shape**: Returns the Tcl command's result via `tcl_eval` (UNKNOWN exact type — needs live-session verification).
3. **Precondition/side-effect**: Requires an active HyperView Results client window. Mutates the mesh coloring mode of the current window.
4. **Confidence**: LOCAL-INSTALL (from installed toolbar Tcl/XML).

## HyperView Capture Recipe

```python
def hv_capture_view(out_png, orientation="iso", fit_mode="model",
                    width=1280, height=900, quality=95):
    out_png = out_png.replace("\\", "/")
    return tcl_eval("""
        catch {::post::ViewOrientation %s}
        catch {::post::ViewFit %s true}
        hwi OpenStack
        hwi GetSessionHandle sess
        sess CaptureScreenToSize png {%s} %d %d %d
        sess ReleaseHandle
        hwi CloseStack
    """ % (orientation, fit_mode, out_png, int(width), int(height), int(quality)))
```

For exact camera state:

```python
def hv_capture_exact(out_png, orientation_state, width=1280, height=900):
    hv_set_view_state(orientation=orientation_state)
    capture_screen_to_size(out_png, width, height, 95)
```

### `hv_capture_view(...)` / `hv_capture_exact(...)`

1. **Signature**: Python: `def hv_capture_view(out_png, orientation="iso", fit_mode="model", width=1280, height=900, quality=95)` — sets orientation/fit via `catch {::post::ViewOrientation ...}`/`catch {::post::ViewFit ... true}` then captures via `sess CaptureScreenToSize`. `def hv_capture_exact(out_png, orientation_state, width=1280, height=900)` — calls `hv_set_view_state(orientation=orientation_state)` then `capture_screen_to_size(out_png, width, height, 95)`.
2. **Return shape**: `hv_capture_view` returns the Tcl block's result via `tcl_eval` (UNKNOWN exact type). `hv_capture_exact` returns whatever `capture_screen_to_size` returns (its own `return` is implicit `None` in Python since the two calls aren't chained with `return` — note: as written, `hv_capture_exact` does not `return` the result of `capture_screen_to_size`, so it always yields `None` to its caller; this is a literal reading of the shown source, not an inferred bug annotation beyond what's written).
3. **Precondition/side-effect**: Requires an active HyperView Results/graphics window and a graphics-capable session (capture requires a graphics session per Caution 4). `orientation`/`fit_mode` failures are swallowed by `catch {...}` in `hv_capture_view`, so a bad orientation name will not raise — it silently skips that step.
4. **Confidence**: LOCAL-INSTALL (project-authored composite recipes).

## HyperMesh Capture Recipe

```python
def hm_capture_view(out_png, view="iso1", width=1280, height=900):
    out_png = out_png.replace("\\", "/")
    return tcl_eval("""
        *view {%s}
        *window 0 0 0 0 0
        hwi OpenStack
        hwi GetSessionHandle sess
        sess CaptureScreenToSize png {%s} %d %d 95
        sess ReleaseHandle
        hwi CloseStack
    """ % (view, out_png, int(width), int(height)))
```

### `hm_capture_view(out_png, view, width, height)`

1. **Signature**: Python (shown above) — sets `*view {<view>}`, fits with `*window 0 0 0 0 0`, then captures via `sess CaptureScreenToSize png {<out_png>} <width> <height> 95` (quality hardcoded to 95).
2. **Return shape**: Returns the Tcl block's result via `tcl_eval` (UNKNOWN exact type — needs live-session verification).
3. **Precondition/side-effect**: Requires a graphics-capable HyperMesh preprocessor session. Mutates the current view/fit state (not restored afterward, unlike `hm_render_component`/`render_component_png` which save/restore a view mask).
4. **Confidence**: LOCAL-INSTALL (project-authored composite recipe).

## Client Detection

Use `GetClientType` to know which client is active.

```python
def get_active_client_type():
    return tcl_eval("""
        hwi OpenStack
        hwi GetSessionHandle sess
        sess GetProjectHandle proj
        proj GetPageHandle page [proj GetActivePage]
        page GetWindowHandle win [page GetActiveWindow]
        set ctype [win GetClientType]
        win ReleaseHandle
        page ReleaseHandle
        proj ReleaseHandle
        sess ReleaseHandle
        hwi CloseStack
        set ctype
    """)
```

Observed code checks client type such as:

```text
Animation
Plot
```

HyperView results windows usually behave as animation/results clients. Plot
windows use plot view-control commands such as `::hwplot::ViewControlAction Fit`.

### `win GetClientType` / Python `get_active_client_type()`

1. **Signature**: Tcl handle chain: `hwi OpenStack` → `hwi GetSessionHandle sess` → `sess GetProjectHandle proj` → `proj GetPageHandle page [proj GetActivePage]` → `page GetWindowHandle win [page GetActiveWindow]` → `set ctype [win GetClientType]` → release handles → `hwi CloseStack` → `set ctype`. Python: `def get_active_client_type()`.
2. **Return shape**: Returns a client-type string (observed values include `Animation`, `Plot`) coerced through `tcl_eval`/`Tclinter`. Exact Python type UNKNOWN — needs live-session verification; full enumeration of possible client-type strings is UNKNOWN beyond the two observed values.
3. **Precondition/side-effect**: Requires an open HWI session with active project/page/window. Read-only.
4. **Confidence**: LOCAL-INSTALL (project-authored wrapper; underlying `GetClientType` observed in installed context/viz Tcl scripts).

### `::hwplot::ViewControlAction <action>` (Plot/HyperGraph windows)

1. **Signature**: Tcl: `::hwplot::ViewControlAction Fit|FitX|FitY|ZoomIn|ZoomOut|ZoomX|ZoomY`. No Python wrapper is shown directly in the file.
2. **Return shape**: UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires an active Plot/HyperGraph window (client type `Plot`, per `GetClientType` above).
4. **Confidence**: LOCAL-INSTALL (from installed plot toolbar Tcl).

## Choosing API By Client

Use this decision table:

```text
HyperMesh preprocessor:
  view: *view "iso1/top/front/..."
  fit: *window 0 0 0 0 0
  capture: hwi session CaptureScreen/CaptureScreenToSize
  display: ::HM_Framework::* or hwctx SetMeshStyle

HyperView Results:
  view: ::post::ViewOrientation top/bottom/left/right/back/front/iso
  fit: ::post::ViewFit model|selected|all true
  exact camera: Window GetViewControlHandle -> SetOrientation/SetOrtho/SetFrustum
  capture: hwi session CaptureScreen/CaptureScreenToSize
  mesh style: HyperworksPost.clients.Results.toolbars.viewtoolbar.OnSetMeshStyle(n)

HyperWorks Post Plotting3D:
  view: ::plot3d::_private::ViewOrientation top/bottom/left/right/back/front/iso/reverse
  fit: ::plot3d::_private::ViewFit all|model
  capture: hwi session CaptureScreen/CaptureScreenToSize

HyperGraph/Plot windows:
  fit: ::hwplot::ViewControlAction Fit|FitX|FitY|ZoomIn|ZoomOut|ZoomX|ZoomY
  capture: hwi session CaptureScreen/CaptureScreenToSize
```

## Cautions

1. `CaptureScreen` captures the current graphics/page/window state. Set view,
   fit, display style, contour/legend visibility, and active window first.
2. `CaptureScreenToSize` is best for deterministic thumbnails.
3. HyperMesh `*view` names and HyperView `::post::ViewOrientation` names are
   not identical: `iso1` for HM, `iso`/`Iso` for HV.
4. HWI capture requires a graphics session. Batch-only/no-display sessions may
   fail or produce blank images.
5. Release HWI handles or use `hwi OpenStack` / `hwi CloseStack` around blocks.
6. The HyperView `OnSetMeshStyle` function is verified from profile XML, but its
   source is packaged as `.pyc` in this install. Treat the numeric mapping as
   verified by toolbar tooltips, not as an open-source function contract.
7. For a reusable AI tool, wrap all Tcl/HWI operations in Tcl procs and let
   Python call those procs with arguments. This avoids quoting bugs.
