# HyperMesh Embedded Python API Reference

Purpose: AI-readable reference for using Python inside HyperMesh/HyperWorks
together with the Tcl macro/table/entity APIs used by this project.

This file focuses on what was found in the installed software, not on newer
HyperMesh Python APIs from later releases.

Verification status:

```text
OFFICIAL:
  The Tcl/HWI layer that Python drives is confirmed by Altair help.

LOCAL-INSTALL:
  Embedded Python, `Tclinter`, local Python paths/packages, and the practical
  Python-to-Tcl bridge details are from installed Altair files.

RUNTIME-TEST-NEEDED:
  Confirm active interpreter/imports under each launch mode: HyperMesh GUI,
  HyperView GUI, `hmbatch`, and `hw.exe` batch.
```

Detailed Python-driven capture/view API for HyperMesh and HyperView is kept in:

```text
_clean/docs/HYPERWORKS_PYTHON_VIEW_CAPTURE_API_REF.md
```

Batch-mode limits and Python usage in HyperMesh/HyperView batch are kept in:

```text
_clean/docs/HYPERWORKS_BATCH_API_REF.md
```

Sources inspected:

```text
<ALTAIR_INSTALL_DIR>/hw/tcl/tclpython/README
<ALTAIR_INSTALL_DIR>/hw/tcl/tclpython/init.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/tclpython/Tclinter.py
<ALTAIR_INSTALL_DIR>/hw/tcl/tclpython/test.tcl
<ALTAIR_INSTALL_DIR>/hw/tcl/tclpython/test.py
<ALTAIR_INSTALL_DIR>/hw/python/hm/__init__.py
<ALTAIR_INSTALL_DIR>/hw/python/hm/mdi.py
<ALTAIR_INSTALL_DIR>/hw/python/hm/entities.py
<ALTAIR_INSTALL_DIR>/hm/scripts/EngineeringSolutions/aerospace/Matrix/Includes/UserLibraries/mypython.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/EngineeringSolutions/aerospace/Matrix/Includes/UserLibraries/mypython.py
<ALTAIR_INSTALL_DIR>/hm/scripts/EngineeringSolutions/CFD/PythonModules/interface.py
<ALTAIR_INSTALL_DIR>/hwx/scripts/python/hwx/gui/demo/Widgets.py
<ALTAIR_INSTALL_DIR>/hwx/scripts/python/hwx/gui/demo/Containers.py
<ALTAIR_INSTALL_DIR>/hwx/plugins/hwd/scripts/python/hwpy/studio/examples/dialog.py
```

## Bottom Line

HyperMesh can embed Python in a Tcl-driven workflow.

The stable bridge observed in the install is:

```text
Tcl -> embedded Python:
  package require Python
  python::eval <python_expr>
  python::exec <python_script_string>
  python::execfile <filename>

Python -> same HyperWorks Tcl interpreter:
  import Tclinter
  Tclinter.tcl.call(...)
  Tclinter.tcl.eval(...)
```

For this Nastran Control Tool, the safest architecture is:

```text
Macro/userpage button
  -> Tcl GUI/table code
  -> Python only for heavy data work, CSV/Excel/math/report logic, or optional HWX GUI
  -> Python calls back Tcl procs or Tcl HyperMesh commands to read/edit the model
```

Do not replace proven HyperMesh database mutations with guessed Python entity
objects unless verified in the target HyperMesh version. In the inspected\ninstall, the Tcl APIs (`hm_getvalue`, `*setvalue`, `*materialupdate`,
`*propertyupdate`, `*colormark`, `hwi`) are the clearest and most directly
usable path for model editing.

## Enable And Load Python From Tcl

The Tcl package is named `Python` and is initialized from:

```text
<ALTAIR_INSTALL_DIR>/hw/tcl/tclpython/init.tcl
```

It loads a binary library named like:

```text
tclpython2x.dll
```

### `package require Python`

1. **Signature**: Tcl: `package require Python` (loads `tclpython2x.dll` via `init.tcl`).
2. **Return shape**: Tcl package version string on success; Tcl error if the binary library cannot be loaded.
3. **Precondition/side-effect**: Must be run once per Tcl interpreter before any `python::*` command is used. UNKNOWN — needs live-session verification which launch modes (HyperMesh GUI, HyperView GUI, `hmbatch`, `hw.exe` batch) successfully load this package; file's own RUNTIME-TEST-NEEDED note flags this explicitly.
4. **Confidence**: LOCAL-INSTALL.

### `python::eval <python_expr>`

1. **Signature**: Tcl: `python::eval "<python_expr>"`. Example: `set value [python::eval "2.0 / 3.0"]`.
2. **Return shape**: Returns the Python expression's result coerced to a Tcl string (e.g. `set pyver [python::eval "sys.version"]`).
3. **Precondition/side-effect**: Requires `package require Python` already run. Evaluates a single Python expression, not a full script block.
4. **Confidence**: LOCAL-INSTALL (per package README).

### `python::exec <python script>`

1. **Signature**: Tcl: `python::exec "<python statement(s)>"`. Example: `python::exec "import sys"`.
2. **Return shape**: UNKNOWN — needs live-session verification (README does not document a return value; treated as executed for side effect).
3. **Precondition/side-effect**: Requires `package require Python` already run. Executes Python statements (not just expressions) in the embedded interpreter's global namespace.
4. **Confidence**: LOCAL-INSTALL (per package README, which documents `::python::exec <python script>`).

### `python::execfile <filename>`

1. **Signature**: Tcl: `python::execfile <filename>`.
2. **Return shape**: UNKNOWN — needs live-session verification (not shown invoked directly in inspected examples; README lists it as implemented).
3. **Precondition/side-effect**: Requires `package require Python` already run. `<filename>` must be a valid path to a `.py` file.
4. **Confidence**: LOCAL-INSTALL (per package README).

Manual test path documented in the same README:

```text
set HW_ENABLE_PYTHON=1
start hw.exe
go to MotionView
File -> Python File
run a .py file
```

Treat `HW_ENABLE_PYTHON` as a useful diagnostic/enable flag when the Python file
runner is hidden or unavailable.

## Execute A Python File From Tcl

### Old-style `execfile()` call (Python 2 style)

1. **Signature**: Tcl: `python::exec "execfile ('$InterfacePyFile')"` followed by `python::exec "DoSum ($arr,$rho,$mu,$Len)"`, where `$InterfacePyFile` comes from `[file join $mypath "mypython.py"]`.
2. **Return shape**: UNKNOWN — needs live-session verification (aerospace example does not capture a Tcl-side return value from this call).
3. **Precondition/side-effect**: Requires `package require Python`. Uses Python 2-only `execfile()` builtin — will fail under a Python 3 interpreter. File path must not contain characters that break the double-quoted Tcl string.
4. **Confidence**: LOCAL-INSTALL (observed in `mypython.tcl`/`mypython.py` aerospace example).

### Python 3-compatible `exec(compile(open(...)))` call

1. **Signature**: Tcl: `python::exec "exec(compile(open('$testPyFile', 'rb').read(), '$testPyFile', 'exec'))"`, where `$testPyFile` is `[file join [file dirname [info script]] test.py]`.
2. **Return shape**: UNKNOWN — needs live-session verification (Altair's own `test.tcl` does not show a captured return value).
3. **Precondition/side-effect**: Requires `package require Python`. Works under both Python 2 and Python 3 (avoids `execfile`).
4. **Confidence**: LOCAL-INSTALL (from Altair's own `test.tcl`/`test.py`).

### Project helper `py_execfile {pyfile}`

1. **Signature**: Tcl proc:
   ```tcl
   proc py_execfile {pyfile} {
       package require Python
       set pyfile [file normalize $pyfile]
       set pyfile [string map {\\ /} $pyfile]
       python::exec "exec(compile(open(r'''$pyfile''', 'rb').read(), r'''$pyfile''', 'exec'))"
   }
   ```
   Called as `py_execfile {C:/path/to/tool.py}`, including from a macro button via `*evaltclstring("py_execfile {C:/path/to/tool.py}",0)` inside `*beginmacro(...)`/`*endmacro()`.
2. **Return shape**: Returns whatever `python::exec` returns (UNKNOWN — needs live-session verification of the underlying `python::exec` return value; see above).
3. **Precondition/side-effect**: Requires `package require Python` (called internally). Normalizes the path and converts backslashes to forward slashes before building the Python `exec(compile(...))` call, avoiding path-quoting bugs.
4. **Confidence**: LOCAL-INSTALL (project-authored wrapper combining the two patterns above; not an Altair-shipped API).

## Python Calling Back Tcl

Python module:

```text
<ALTAIR_INSTALL_DIR>/hw/tcl/tclpython/Tclinter.py
```

### `altairroot`/`sys.path.append` setup pattern

1. **Signature**: Python:
   ```python
   import os
   import sys

   altairroot = "<ALTAIR_INSTALL_DIR>"
   sys.path.append(os.path.join(altairroot, "hw", "tcl", "tclpython"))

   import Tclinter
   ```
2. **Return shape**: None — this is setup code; `import Tclinter` raises `ImportError` if the path is wrong or the module cannot be loaded.
3. **Precondition/side-effect**: Must run before any `Tclinter.tcl.*` call. Adds `hw/tcl/tclpython` (containing `Tclinter.py`) to `sys.path` so `import Tclinter` succeeds. Assumes the embedded Python was launched by `python::exec`/`python::execfile` from within the same Tcl interpreter it will call back into.
4. **Confidence**: LOCAL-INSTALL (observed in Altair's aerospace example).

### `Tclinter.tcl.call(proc, *args)`

1. **Signature**: Python: `Tclinter.tcl.call("::myPython::ExtractResults", 1.0, 2.0, 3.0)` — maps to invoking the named Tcl proc/command with positional arguments (no Tcl-side string interpolation needed).
2. **Return shape**: Returns the Tcl command's result value, coerced into a Python type by `Tclinter`; exact type coercion rules are UNKNOWN — needs live-session verification. Raises a Python exception (via `Tclinter`) if the Tcl command errors.
3. **Precondition/side-effect**: Requires `import Tclinter` to have already succeeded (see setup pattern above), which requires the embedded Python session to be running inside the HyperWorks Tcl interpreter (launched via `python::exec`/`python::execfile`). Preferred over `tcl.eval` when calling a known Tcl proc name, since arguments are passed positionally and avoid quoting issues.
4. **Confidence**: LOCAL-INSTALL.

### `Tclinter.tcl.eval(script)`

1. **Signature**: Python: `Tclinter.tcl.eval('hm_getvalue comps id=%d dataname=name' % cid)` — evaluates a raw Tcl script string (single or multi-command block) in the same interpreter.
2. **Return shape**: Returns the Tcl script's final result as a Tcl-to-Python coerced value (e.g. a string for `hm_getvalue` results). Raises a Python exception on Tcl error. Exact coercion/exception type is UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires `import Tclinter` to have already succeeded, running inside the HyperWorks Tcl interpreter. Used for multi-command HyperMesh command blocks (e.g. `tcl_eval('*createmark comps 1 10')` then `tcl_eval('*colormark comps 1 7')`), where `call` is less convenient than `eval`.
4. **Confidence**: LOCAL-INSTALL.

### Project wrappers `tcl_call`/`tcl_eval`

1. **Signature**: Python:
   ```python
   import Tclinter

   def tcl_call(*args):
       return Tclinter.tcl.call(*args)

   def tcl_eval(script):
       return Tclinter.tcl.eval(script)
   ```
2. **Return shape**: Passthrough of whatever `Tclinter.tcl.call`/`Tclinter.tcl.eval` return (see above — UNKNOWN exact type without live verification).
3. **Precondition/side-effect**: Same preconditions as the underlying `Tclinter.tcl.call`/`Tclinter.tcl.eval` calls.
4. **Confidence**: LOCAL-INSTALL (project-authored convenience wrappers, not a separate Altair API).

## Callback Return Pattern

The installed aerospace example uses this shape:

Tcl:

```tcl
namespace eval ::myPython {
    variable sum
}

proc ::myPython::Main {} {
    package require Python
    set pyfile [file join $::myPython::mypath "mypython.py"]
    python::exec "execfile ('$pyfile')"
    python::exec "DoSum ($arr,$rho,$mu,$Len)"
}

proc ::myPython::ExtractResults {args} {
    variable sum
    set sum $args
    return $sum
}
```

Python:

```python
import Tclinter

def DoSum(a, b, c, d):
    result = map(sum, zip(a, b, c, d))
    Tclinter.tcl.call("::myPython::ExtractResults", *result)
```

This is the cleanest way to let Python compute values and return them to the
existing Tcl GUI/table state.

### Callback proc pattern (`::myPython::Main` / `::myPython::ExtractResults`)

1. **Signature**: Tcl side: `proc ::myPython::Main {}` calls `python::exec "execfile ('$pyfile')"` then `python::exec "DoSum ($arr,$rho,$mu,$Len)"`; `proc ::myPython::ExtractResults {args} { variable sum; set sum $args; return $sum }`. Python side: `def DoSum(a, b, c, d)` computes a result and calls back `Tclinter.tcl.call("::myPython::ExtractResults", *result)`.
2. **Return shape**: `::myPython::ExtractResults` returns its `$args` list (whatever Python passed) back into Tcl's `sum` namespace variable, and as the proc's return value. `DoSum` itself returns None to Python's call stack (the value transfer happens through the Tcl callback, not a Python return).
3. **Precondition/side-effect**: Requires `package require Python` and the `Tclinter` bridge already set up (see above). `Main` must be invoked first so `DoSum` is defined in the Python namespace before Python tries to call it. Mutates the Tcl `::myPython::sum` namespace variable as a side effect.
4. **Confidence**: LOCAL-INSTALL (installed aerospace example, `mypython.tcl`/`mypython.py`).

## Where Python Fits This Tool

Good Python use cases:

```text
1. Heavy table transformations:
   grouping, filtering, validation, merging CSV/Excel-like data.

2. Numeric calculations:
   numpy is used in installed examples, e.g. porosity/Darcy coefficient code.

3. Report/output generation:
   the install contains report Python examples under demos/report/python/api
   and hw/python/hw/eds/hstreports.

4. Image/file bookkeeping:
   mapping component IDs to image paths, generating JSON/cache files, choosing
   output filenames.

5. Optional HWX-native GUI:
   dialogs, buttons, checkboxes, combo boxes, sliders, ribbon actions.

6. Calling existing Tcl model-edit procs:
   Python can call back into `::NastranControl::*` or helper Tcl procs after
   doing validation/calculation.
```

Use Tcl directly for:

```text
1. Macro page/userpage integration.
2. Existing tktable UI in this project.
3. HyperMesh entity edit commands already verified:
   hm_getvalue, hm_getentityvalue, *setvalue, *propertyupdate,
   *materialupdate, *colormark, *createmark, hwi.
4. Graphics/display/capture commands already written as Tcl/HWI command blocks.
```

## Reading Model Data From Python

Use Tcl commands through `Tclinter`.

### Python `hm_getvalue()` wrapper (via `tcl_eval`)

1. **Signature**: Python:
   ```python
   def hm_getvalue(entity_type, entity_id, dataname):
       return tcl_eval("hm_getvalue %s id=%s dataname=%s" %
                       (entity_type, entity_id, dataname))
   ```
   Maps to Tcl: `hm_getvalue <entity_type> id=<entity_id> dataname=<dataname>`. Example usage: `hm_getvalue("comps", cid, "name")`, `hm_getvalue("comps", cid, "property.id")`, `hm_getvalue("comps", cid, "color")`.
2. **Return shape**: String result of the underlying `hm_getvalue` Tcl command, coerced by `tcl_eval`/`Tclinter`. Exact Python type (str vs numeric) is UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires the `Tclinter` bridge already set up. String-interpolates `entity_id`/`dataname` directly into the Tcl command — unsafe if those values contain spaces or special Tcl characters (see helper-proc alternative below).
4. **Confidence**: OFFICIAL for the underlying `hm_getvalue` Tcl command itself (per file's Bottom Line section); LOCAL-INSTALL for this specific Python wrapping pattern.

### Tcl helper proc `::pyhm::getvalue` (safe-argument variant)

1. **Signature**: Tcl:
   ```tcl
   proc ::pyhm::getvalue {etype id dataname} {
       return [hm_getvalue $etype id=$id dataname=$dataname]
   }
   ```
   Called from Python as `Tclinter.tcl.call("::pyhm::getvalue", "comps", cid, "name")`.
2. **Return shape**: Same string as `hm_getvalue`, passed back to Python via `Tclinter.tcl.call`'s return coercion.
3. **Precondition/side-effect**: Requires the `::pyhm` namespace/proc to be defined in the Tcl interpreter before calling (i.e. sourced or defined earlier in session). Avoids the string-interpolation/quoting risk of the raw `tcl_eval` wrapper above by passing `id`/`dataname` as separate positional arguments.
4. **Confidence**: LOCAL-INSTALL (project-authored helper, not a shipped Altair API; underlying `hm_getvalue` is OFFICIAL).

## Editing Model Data From Python

Use Python to decide what should change, then call Tcl mutation procs.

Recommended Tcl helper layer:

```tcl
namespace eval ::pyhm {}

proc ::pyhm::set_comp_color {cid color_id} {
    *createmark comps 1 $cid
    *colormark comps 1 $color_id
}

proc ::pyhm::assign_prop_to_comp {cid prop_name} {
    *createmark comps 1 $cid
    *propertyupdate comps 1 "$prop_name"
}

proc ::pyhm::assign_mat_to_prop {prop_id mat_name} {
    *createmark props 1 $prop_id
    *materialupdate props 1 "$mat_name"
}
```

Python:

```python
Tclinter.tcl.call("::pyhm::set_comp_color", cid, color_id)
Tclinter.tcl.call("::pyhm::assign_prop_to_comp", cid, prop_name)
Tclinter.tcl.call("::pyhm::assign_mat_to_prop", prop_id, mat_name)
```

This avoids fragile quoting and keeps HyperMesh mutation behavior in Tcl, where
the project already has working commands.

### `::pyhm::set_comp_color` / `::pyhm::assign_prop_to_comp` / `::pyhm::assign_mat_to_prop`

1. **Signature**: Tcl:
   ```tcl
   proc ::pyhm::set_comp_color {cid color_id} {
       *createmark comps 1 $cid
       *colormark comps 1 $color_id
   }
   proc ::pyhm::assign_prop_to_comp {cid prop_name} {
       *createmark comps 1 $cid
       *propertyupdate comps 1 "$prop_name"
   }
   proc ::pyhm::assign_mat_to_prop {prop_id mat_name} {
       *createmark props 1 $prop_id
       *materialupdate props 1 "$mat_name"
   }
   ```
   Called from Python via `Tclinter.tcl.call("::pyhm::set_comp_color", cid, color_id)` (and analogous calls for the other two procs).
2. **Return shape**: Tcl proc return value is the return of the last command (`*colormark`/`*propertyupdate`/`*materialupdate`), typically not used by the caller; effect is the model mutation itself, not a return value. Exact Python-side coercion is UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires the `::pyhm` namespace procs to be defined in the Tcl interpreter first. Mutates the HyperMesh model database: creates a mark (mark id `1`) on the given entity, then applies color/property/material. Underlying `*createmark`, `*colormark`, `*propertyupdate`, `*materialupdate` are the project's already-verified Tcl mutation commands (per file's Bottom Line section).
4. **Confidence**: LOCAL-INSTALL for this Tcl helper-layer pattern; the underlying HyperMesh commands (`*createmark`, `*colormark`, `*propertyupdate`, `*materialupdate`) are treated as OFFICIAL per the file's own framing, though not independently re-verified in this pass.

## Color And Render From Python

All color/render APIs from `HYPERMESH_COLOR_RENDER_API_REF.md` can be driven
from Python by evaluating Tcl command blocks.

Example:

```python
def render_component_png(cid, png_path, size=768):
    script = r'''
        *saveviewmask "py_render_tmp"
        *createmark comps 1 %d
        *isolateonlyentitybymark 1 1 2
        catch {::HM_Framework::p_SetElementStyleShadedLines}
        *view "iso1"
        *window 0 0 0 0 0
        hwi OpenStack
        hwi GetSessionHandle sess1
        sess1 CaptureScreenToSize png {%s} %d %d 95
        sess1 ReleaseHandle
        hwi CloseStack
        *restoreviewmask "py_render_tmp"
        *removeview "py_render_tmp"
    ''' % (cid, png_path.replace("\\", "/"), size, size)
    return Tclinter.tcl.eval(script)
```

Use this pattern only inside a graphics-capable HyperMesh session. Batch/no-GUI
sessions may not support screen capture.

### `render_component_png(cid, png_path, size=768)`

1. **Signature**: Python:
   ```python
   def render_component_png(cid, png_path, size=768):
       script = r'''
           *saveviewmask "py_render_tmp"
           *createmark comps 1 %d
           *isolateonlyentitybymark 1 1 2
           catch {::HM_Framework::p_SetElementStyleShadedLines}
           *view "iso1"
           *window 0 0 0 0 0
           hwi OpenStack
           hwi GetSessionHandle sess1
           sess1 CaptureScreenToSize png {%s} %d %d 95
           sess1 ReleaseHandle
           hwi CloseStack
           *restoreviewmask "py_render_tmp"
           *removeview "py_render_tmp"
       ''' % (cid, png_path.replace("\\", "/"), size, size)
       return Tclinter.tcl.eval(script)
   ```
2. **Return shape**: Returns whatever `Tclinter.tcl.eval` returns for the final Tcl command in the block (`*removeview`) — not a meaningful capture-success indicator. Raises a Python exception if any Tcl command in the block errors and is not caught. Exact type is UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires the `Tclinter` bridge already set up and a graphics-capable HyperMesh session (per file's own caution: "Batch/no-GUI sessions may not support screen capture"). Side effects: saves current view mask, isolates the given component, forces shaded-line style, sets iso1 view and fits window, captures a PNG to `png_path` at `size x size`, then restores/removes the temporary view mask. Leaves the model's isolation/view state changed unless the caller restores it (the view mask save/restore only affects the named view mask, not necessarily full display state).
4. **Confidence**: LOCAL-INSTALL (project-authored composite pattern combining OFFICIAL HWI capture and Tcl view commands).

## Python GUI Options

There are two Python GUI families visible in the install.

### HWX GUI

Examples import:

```python
from hwx import gui
```

Observed widgets/containers from installed demos:

```text
gui.Label
gui.IconLabel
gui.PushButton
gui.Button
gui.CheckBox
gui.RadioButton
gui.VRadioButtons
gui.HRadioButtons
gui.ComboBox
gui.SpinBox
gui.LineEdit
gui.IntEdit
gui.DoubleEdit
gui.Slider
gui.ToggleButton
gui.PopupMenu
gui.Legend
gui.TextEdit
gui.Splitter
gui.VFrame
gui.HFrame
gui.GridFrame
gui.CollapsibleFrame
gui.NoteBook
gui.Dialog
gui.MicroDialog
gui.FileDialog
gui.WidgetStack
gui.RibbonPage
gui.SpriteActionGroup
gui.SpriteAction
gui.SpriteCommand
gui.AnimationToolbar
```

Example:

```python
from hwx import gui

def on_click(event):
    gui.tellUser("Hello World")

dialog = gui.Dialog(
    caption="Python Tool",
    children=(
        gui.GridFrame(
            ("Component ID", 5, gui.IntEdit(1)),
            ("Color ID", 5, gui.IntEdit(7)),
        ),
        gui.Button("Apply", command=on_click),
    ),
)
dialog.show()
```

The demos also show:

```python
gui.getOpenFileName(...)
gui.getSaveFileName(...)
gui.tellUser(...)
gui.addResourcePath(...)
```

### `hwx.gui` widget classes and `gui.Dialog(...)` construction

1. **Signature**: Python: `from hwx import gui`, then constructing widgets such as `gui.Label`, `gui.PushButton`, `gui.CheckBox`, `gui.ComboBox`, `gui.IntEdit`, `gui.Slider`, `gui.Dialog(caption=..., children=(...))`, `gui.GridFrame(...)`, `gui.Button("Apply", command=on_click)`, plus module-level helpers `gui.getOpenFileName(...)`, `gui.getSaveFileName(...)`, `gui.tellUser(...)`, `gui.addResourcePath(...)`. Full observed widget/container list: `Label, IconLabel, PushButton, Button, CheckBox, RadioButton, VRadioButtons, HRadioButtons, ComboBox, SpinBox, LineEdit, IntEdit, DoubleEdit, Slider, ToggleButton, PopupMenu, Legend, TextEdit, Splitter, VFrame, HFrame, GridFrame, CollapsibleFrame, NoteBook, Dialog, MicroDialog, FileDialog, WidgetStack, RibbonPage, SpriteActionGroup, SpriteAction, SpriteCommand, AnimationToolbar`.
2. **Return shape**: Widget constructors return widget object instances; `dialog.show()` displays the dialog (return value UNKNOWN — needs live-session verification); `gui.getOpenFileName`/`getSaveFileName` presumably return a path string or None on cancel (UNKNOWN — needs live-session verification, not exercised in inspected demo source beyond the call itself).
3. **Precondition/side-effect**: Requires the HWX profile's Python environment (this is a separate GUI stack from `hwtk::dialog`/Tk `tktable`, per file's own note). Not confirmed to be importable from arbitrary embedded-Tcl-launched Python — only from demo scripts under `hwx/scripts/python/hwx/gui/demo/`. `dialog.show()` presumably opens a modal/non-modal window as a side effect.
4. **Confidence**: LOCAL-INSTALL (observed in `Widgets.py`/`Containers.py` demos, not independently exercised for this project's tool).

### HWPy XML Factory GUI

Example import:

```python
from hwpy import gui, factory, utils, ldom
```

Observed pattern:

```python
import os
from hwpy import gui, factory, ldom

def run():
    xml = os.path.join(os.path.dirname(__file__), "dialog.xml")
    dom = ldom.parse(xml)
    rootobj = factory.create(dom, pyobj={"controller": "testing"})
```

Use this when reusing HWX/HWPy XML dialog definitions. For the current Tcl
table tool, this is optional; it is a separate GUI stack from `hwtk::dialog` and
Tk `tktable`.

### `hwpy.ldom.parse` / `hwpy.factory.create`

1. **Signature**: Python: `from hwpy import gui, factory, utils, ldom`; then `dom = ldom.parse(xml_path)` and `rootobj = factory.create(dom, pyobj={"controller": "testing"})`.
2. **Return shape**: `ldom.parse` returns a DOM-like object representing the parsed XML dialog definition; `factory.create` returns a constructed root GUI object bound to the given `pyobj` controller mapping. Exact class/type is UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires an XML dialog definition file (e.g. `dialog.xml`) alongside the script and the `hwpy` package available in the active Python environment. Side effect is constructing (not necessarily showing) the GUI object tree.
4. **Confidence**: LOCAL-INSTALL (observed in `hwpy/studio/examples/dialog.py`).

## Tkinter/Tcl Widget Bridge

`Tclinter.py` also defines a `Widget` class that maps a Tcl/Tk widget path to a
Python Tkinter widget-like object.

Intent from source comments:

```text
Widget - make a HyperWorks Tcl widget work with tkinter
```

Use this only when necessary. Mixing Tkinter event loops with HyperMesh Tcl/HWTK
can become fragile. For project tables, prefer the existing Tcl/HWTK/tktable
widgets.

### `Tclinter.Widget` class

1. **Signature**: Python: `Widget` class defined in `Tclinter.py`, mapping a Tcl/Tk widget path string to a Tkinter-widget-like Python object. Exact constructor signature is UNKNOWN — needs live-session verification (only the source comment "Widget - make a HyperWorks Tcl widget work with tkinter" was inspected, not the full class body/usage example).
2. **Return shape**: UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires `import Tclinter` in an embedded Python session with an existing Tcl/Tk widget path to wrap. File's own guidance: avoid unless necessary, since mixing Tkinter event loops with HyperMesh Tcl/HWTK can become fragile.
4. **Confidence**: LOCAL-INSTALL (class existence and stated intent confirmed from `Tclinter.py` source comment; behavior UNKNOWN).

## HyperMesh Python `hm` Package

Found package:

```text
<ALTAIR_INSTALL_DIR>/hw/python/hm
```

Files:

```text
hm/__init__.py
hm/mdi.py
hm/entities.py
hm/extensions/hmmodularctrl.py
hm/extensions/hmmodularentities.py
```

Observed behavior:

```python
import hm.mdi as mdi

classes = mdi.Manager.getclasses(True)
for cls in classes:
    if cls.instantiable:
        globals()[cls.__name__] = cls
```

`hm.mdi` configures an MDI metaclass manager and HDF5 deserializer. In this
install, source examples do not show a simple, verified Python replacement for
Tcl commands such as:

```text
hm_getvalue
*setvalue
*materialupdate
*propertyupdate
*colormark
hwi CaptureScreen
```

Therefore, for HyperMesh scripts in this project, treat `hm` Python as
available but not the primary model-editing API unless tested with a concrete
entity/card operation.

### `hm.mdi.Manager.getclasses(True)`

1. **Signature**: Python: `import hm.mdi as mdi`; `classes = mdi.Manager.getclasses(True)`; then iterating `classes` and binding instantiable ones into `globals()` by `cls.__name__`.
2. **Return shape**: Returns a list/iterable of class objects, each with at least an `instantiable` attribute and a `__name__`. Exact container type and full attribute set are UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires the `hm` package (`hw/python/hm`) to be importable in the active Python environment (embedded or standalone — launch-mode applicability is UNKNOWN, needs live-session verification). `hm.mdi` configures an MDI metaclass manager and HDF5 deserializer as an import-time side effect. No verified equivalent was found in this install for `hm_getvalue`, `*setvalue`, `*materialupdate`, `*propertyupdate`, `*colormark`, or `hwi CaptureScreen` — do not assume this package replaces those Tcl commands.
4. **Confidence**: LOCAL-INSTALL (from `hm/__init__.py`/`hm/mdi.py` source; not tested against a concrete entity/card operation).

## Bridge Recipes

### Python validates table rows, Tcl applies edits

Tcl:

```tcl
proc ::NCT::ApplyRowsViaPython {json_path} {
    package require Python
    py_execfile [file join $::NCT::root "python" "validate_rows.py"]
    python::exec "validate_and_apply(r'''$json_path''')"
}

proc ::NCT::ApplyOneRow {cid prop_name mat_name color_id} {
    if {$prop_name ne ""} {
        *createmark comps 1 $cid
        *propertyupdate comps 1 "$prop_name"
    }
    if {$color_id ne ""} {
        *createmark comps 1 $cid
        *colormark comps 1 $color_id
    }
}
```

Python:

```python
import json
import Tclinter

def validate_and_apply(json_path):
    rows = json.load(open(json_path, "r"))
    for row in rows:
        cid = int(row["comp_id"])
        prop = row.get("prop_name", "")
        mat = row.get("mat_name", "")
        color = row.get("color_id", "")
        Tclinter.tcl.call("::NCT::ApplyOneRow", cid, prop, mat, color)
```

### `::NCT::ApplyRowsViaPython` / `::NCT::ApplyOneRow` / `validate_and_apply`

1. **Signature**: Tcl: `proc ::NCT::ApplyRowsViaPython {json_path}` runs `py_execfile [file join $::NCT::root "python" "validate_rows.py"]` then `python::exec "validate_and_apply(r'''$json_path''')"`; `proc ::NCT::ApplyOneRow {cid prop_name mat_name color_id}` applies `*propertyupdate`/`*colormark` conditionally. Python: `def validate_and_apply(json_path)` loads JSON rows and calls back `Tclinter.tcl.call("::NCT::ApplyOneRow", cid, prop, mat, color)` per row.
2. **Return shape**: `::NCT::ApplyRowsViaPython` returns whatever `python::exec` returns (UNKNOWN, see earlier note). `::NCT::ApplyOneRow` returns the last Tcl command's result (not meaningful to the caller). `validate_and_apply` returns None to Python's own call stack (loop side effect only).
3. **Precondition/side-effect**: Requires `py_execfile` and `Tclinter` bridge already available, plus `validate_rows.py` present under `$::NCT::root/python/`. `json_path` must point to a valid JSON array of objects with `comp_id` (required) and optional `prop_name`/`mat_name`/`color_id` keys. Mutates HyperMesh component property/color per row as a side effect.
4. **Confidence**: LOCAL-INSTALL (project-authored recipe combining previously covered primitives; not an Altair-shipped API).

### Python computes values for Tcl table display

Tcl:

```tcl
proc ::NCT::ReceiveComputedColumns {args} {
    variable computed_columns
    set computed_columns $args
}
```

Python:

```python
def compute_columns(rows):
    values = []
    for row in rows:
        values.append(float(row["area"]) * float(row["thickness"]))
    Tclinter.tcl.call("::NCT::ReceiveComputedColumns", *values)
```

### `::NCT::ReceiveComputedColumns` / `compute_columns`

1. **Signature**: Tcl: `proc ::NCT::ReceiveComputedColumns {args} { variable computed_columns; set computed_columns $args }`. Python: `def compute_columns(rows)` computes `area * thickness` per row and calls `Tclinter.tcl.call("::NCT::ReceiveComputedColumns", *values)`.
2. **Return shape**: `::NCT::ReceiveComputedColumns` returns the stored `$args` list (also stored into the `computed_columns` namespace variable for later Tcl table use). `compute_columns` returns None to Python (values are transferred via the Tcl callback, not a Python return).
3. **Precondition/side-effect**: Requires the `::NCT::ReceiveComputedColumns` proc defined in Tcl and rows containing numeric-parseable `area`/`thickness` keys. Mutates the `::NCT::computed_columns` namespace variable as its side effect; does not directly touch the HyperMesh model.
4. **Confidence**: LOCAL-INSTALL (project-authored recipe).

### Python drives color/render

Python:

```python
def set_color_and_fit(cid, color_id):
    Tclinter.tcl.eval("""
        *createmark comps 1 %d
        *colormark comps 1 %d
        *isolateonlyentitybymark 1 1 2
        catch {::HM_Framework::p_SetElementStyleShadedLines}
        *view "iso1"
        *window 0 0 0 0 0
    """ % (cid, color_id))
```

### `set_color_and_fit(cid, color_id)`

1. **Signature**: Python: `def set_color_and_fit(cid, color_id)` calling `Tclinter.tcl.eval(...)` with a multi-line Tcl block (shown above) parameterized by `%d` substitution.
2. **Return shape**: Returns whatever `Tclinter.tcl.eval` returns for the block's last command (`*window 0 0 0 0 0`) — not a meaningful indicator of success. Exact type UNKNOWN — needs live-session verification.
3. **Precondition/side-effect**: Requires the `Tclinter` bridge already set up and a graphics-capable HyperMesh session. Mutates model color mark for `cid`, isolates it in the view, forces shaded-line display, and sets/fits the iso1 view — persistent view/isolation state changes, not reverted by this recipe (unlike `render_component_png`, which restores its view mask).
4. **Confidence**: LOCAL-INSTALL (project-authored recipe combining previously covered primitives).

## Cautions

1. HyperMesh command language remains Tcl-centric; Python embedding is
   real, but many FE database operations are still safest through Tcl commands.
2. Installed examples mix Python 2 style (`Tkinter`, `execfile`) and Python 3
   compatible patterns (`exec(compile(open(...)))`). Test the target
   interpreter before relying on syntax.
3. Quote paths carefully. Prefer normalized forward-slash paths or raw triple
   quoted strings inside `python::exec`.
4. Do not pass untrusted table text directly into `python::exec` or Tcl `eval`.
   Use callback procs with positional arguments when values can contain spaces.
5. Keep Tcl as the owner of existing tktable widgets. Use Python for data work
   or a separate HWX GUI, not for mutating Tcl widget internals unless needed.
6. HWI screenshot/render commands require a graphics session.
7. If Python changes model state through Tcl calls, refresh Tcl-side caches and
   table rows after the callback.
8. For Nastran card fields, continue using the template-derived field reference
   and Tcl `hm_getvalue`/`*setvalue` APIs until a Python card API is proven.
