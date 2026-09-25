# HyperMesh Native Python API Reference (`import hm`)

Purpose: AI-readable reference for the **native** Python package shipped at
`hw/python/hm/` in the local Altair install — i.e. classes/functions you
reach with `import hm`, `import hm.mdi`, `import hm.entities`, etc.,
independent of the Tcl/`Tclinter` bridge documented elsewhere.

This is explicitly NOT about "Python calling Tcl". For that, see:

```text
_clean/docs/HYPERMESH_PYTHON_EMBEDDING_API_REF.md
_clean/docs/HYPERWORKS_PYTHON_VIEW_CAPTURE_API_REF.md
```

Verification status:

```text
OFFICIAL:
  Not used in this file. Altair's public help does not document this
  native `hm` Python package as a supported/scripting-guide API; it appears
  to be internal plumbing for the MDI (Multi-Disciplinary/Unified Desktop)
  data model rather than a documented classic-HyperMesh scripting surface.

LOCAL-INSTALL:
  Everything below is read directly from the installed .py source files at
  <ALTAIR_INSTALL_DIR>/hw/python/hm/. Labeled as such
  throughout.

RUNTIME-TEST-NEEDED:
  No code here was executed. Behavior of anything whose implementation lives
  in `hw.mdi.core` (compiled .pyc, not inspectable) or in C++ (`hmmdi`,
  `hwmdiio` extension modules) is inferred from call sites only, not read
  directly. These items are explicitly flagged RUNTIME-TEST-NEEDED below.
```

Sources inspected (all files that exist under `hw/python/hm/`, confirmed
exhaustive via Glob — this is the entire package):

```text
<ALTAIR_INSTALL_DIR>/hw/python/hm/__init__.py
<ALTAIR_INSTALL_DIR>/hw/python/hm/entities.py
<ALTAIR_INSTALL_DIR>/hw/python/hm/mdi.py
<ALTAIR_INSTALL_DIR>/hw/python/hm/test.py
<ALTAIR_INSTALL_DIR>/hw/python/hm/tests/testWorkflows.py
<ALTAIR_INSTALL_DIR>/hw/python/hm/extensions/__init__.py   (empty, 0 bytes)
<ALTAIR_INSTALL_DIR>/hw/python/hm/extensions/hmmodularctrl.py
<ALTAIR_INSTALL_DIR>/hw/python/hm/extensions/hmmodularentities.py
```

Also checked for a comparable package under `hwx/` (the newer Unified
Desktop shell), see "hwx findings" section at the end.

---

## 0. Big picture: this package is thin — it is a bootstrap/re-export shim

Across all ~8 files there are **zero classes actually defined and implemented
in `hm/*.py` itself**. Every class used (`Session`, `MDIWorkflow`,
`Attribute`, `EntityAttribute`, `Occurrence`, `Part`, etc.) is imported from
`hw.mdi.*`, whose real implementation is either:

- compiled bytecode only (`hw/python/hw/mdi/*.pyc` — `core.pyc`,
  `isession.pyc`, `attribute.pyc`, `workflow.pyc`, `metaobject.pyc`,
  `entityattribute.pyc`, `value.pyc`, `base.pyc`, `standalone.pyc`), or
- native C++ extension modules (`hmmdi`, `hwmdiio`, `hmmdi.hmMDIMetaclassMgr`,
  `hmmdi.hmMDIModularControl_GetControl`, `hwcont`, `hwvos`).

So `hm/*.py` is **glue code**: it wires HyperMesh's entity-configuration
mapping (`Hypermesh.json`) into the generic MDI framework and re-exports the
resulting dynamically-generated entity classes as attributes of the `hm` and
`hm.mdi` modules. There is no independent, hand-written "HyperMesh API" here
to document beyond that wiring — padding this file with invented methods
would be inaccurate. What follows documents exactly what is readable.

---

## 1. `hm/__init__.py` — path bootstrap only

**Signature**: module-level script, no functions/classes.

```python
import os, sys, hwvos
altair_home = os.environ.get('ALTAIR_HOME')
unity_root = os.environ.get('HW_UNITY_ROOTDIR')
_hmdir = os.path.normpath(os.path.join(altair_home, 'hm', 'bin', hwvos.vosLibrary_GetPlatform()))
if _hmdir not in sys.path: sys.path.append(_hmdir)
_unity_python = os.path.normpath(os.path.join(unity_root, 'scripts', 'python'))
if _unity_python not in sys.path: sys.path.append(_unity_python)
import hwx.common.SwigPatches
```

- **Return shape**: N/A (import side effects only).
- **Precondition/side-effect**: Requires environment variables `ALTAIR_HOME`
  and `HW_UNITY_ROOTDIR` to already be set (normally done by the HyperWorks
  launcher before Python starts). Mutates `sys.path` to add the platform HM
  bin dir (e.g. `.../hm/bin/win64d`) and the Unity `scripts/python` dir, then
  imports `hwx.common.SwigPatches` (a SWIG compatibility shim — not
  documented further here, out of scope of `hm`). Calling `import hm` outside
  an environment where these env vars are set (e.g. a bare `python.exe`
  outside HyperWorks) will raise, since `altair_home`/`unity_root` would be
  `None` and `os.path.join(None, ...)` throws `TypeError`.
- **Confidence**: LOCAL-INSTALL, directly read. The downstream behavior
  of `hwvos.vosLibrary_GetPlatform()` and `SwigPatches` is RUNTIME-TEST-NEEDED
  (native/compiled).

---

## 2. `hm/mdi.py` — MDI startup/registration for HyperMesh

**Signature**: module-level script, no functions/classes.

```python
import sys, os, hwcont
from hw.common import application
hmbin = os.path.normpath(os.path.join(application.getRootDir(), 'hm', 'bin', 'win64d'))
if not (hmbin in sys.path): sys.path.append(hmbin)
import hwmdiio
from hmmdi import hmMDIMetaclassMgr, hmHDF5Deserializer
from hw.mdi.core import *

Manager._mgr = hmMDIMetaclassMgr.GetInstance()

@Manager.on_add_vocabulary
def add_vocabulary(cls, filepath: str):
    ...
    hm_mapping = os.path.dirname(filepath) + '\\Hypermesh.json'
    if os.path.exists(hm_mapping) and os.path.isfile(hm_mapping):
        cls.instance().SetEntityConfigurationFile(hm_mapping)

from hw.mdi.isession import Session
Session._deserializer_class = hmHDF5Deserializer
```

Everything callable here (`Manager`, `Session`, `MDIWorkflow`, `Attribute`,
etc.) is `from hw.mdi.core import *` / `from hw.mdi.isession import Session`
— i.e. defined in `hw/python/hw/mdi/*.pyc`, not in this file. What this file
*adds* on top of the generic MDI framework, specific to HyperMesh:

### `add_vocabulary(cls, filepath: str)` (registered via `Manager.on_add_vocabulary`)
- **Signature**: `add_vocabulary(cls: type, filepath: str) -> None`. Decorated
  as a callback hook on the generic `Manager` class from `hw.mdi.core`.
- **Return shape**: `None`. Side effect only.
- **Precondition/side-effect**: Called by the MDI framework (not by user
  code) whenever a "vocabulary" (an MDI metaclass module/plugin file) is
  registered. It looks for a sibling file named `Hypermesh.json` next to that
  vocabulary's file, and if found calls
  `cls.instance().SetEntityConfigurationFile(hm_mapping)` — this is the
  mechanism that maps generic MDI entity classes onto concrete HyperMesh
  entity semantics (the actual field/type layout lives in that
  `Hypermesh.json`, not in Python). Requires `cls` to expose a class method
  `instance()` returning an object with `SetEntityConfigurationFile` (defined
  in the C++/`.pyc` layer).
- **Confidence**: LOCAL-INSTALL for the Python glue; RUNTIME-TEST-NEEDED
  for what `SetEntityConfigurationFile` actually does internally (native
  code, not inspectable from Python source).

### `Manager._mgr` assignment
- **Signature**: `Manager._mgr = hmMDIMetaclassMgr.GetInstance()`.
- **Return shape**: N/A — module-level singleton wiring.
- **Precondition/side-effect**: Binds the generic MDI `Manager` (from
  `hw.mdi.core`) to HyperMesh's concrete metaclass manager singleton
  (`hmmdi.hmMDIMetaclassMgr`, a C++ extension type). After this runs, any
  `Manager`/metaclass registry lookups from `hw.mdi.core` are backed by the
  HyperMesh-specific manager rather than a generic/other-app one. Must run
  before any `Session`/entity-class use in an `hm` context.
- **Confidence**: LOCAL-INSTALL (line read directly); internals of
  `hmMDIMetaclassMgr` are RUNTIME-TEST-NEEDED (native).

### `Session._deserializer_class = hmHDF5Deserializer`
- **Signature**: class-attribute assignment on `hw.mdi.isession.Session`.
- **Return shape**: N/A.
- **Precondition/side-effect**: Configures the generic MDI `Session` class
  (used for `session.create(...)`, `session.write(...)`, see `test.py` below)
  to deserialize/read files using HyperMesh's HDF5-based format
  (`hmmdi.hmHDF5Deserializer`). Implies MDI-based HyperMesh session files are
  HDF5 containers. There is a `# ELIA: TODO` comment in source noting the
  Session/Serializer API for read/write is still being fleshed out — read
  literally as an acknowledged rough edge by Altair's own developers, not
  a stable documented contract.
- **Confidence**: LOCAL-INSTALL (comment and assignment read directly).

**Important scope note**: `Session`, `Manager`, `MDIWorkflow`, `Attribute`,
`EntityAttribute`, `BoolAttribute`, `Action`, `MDIMetaclass`, `MDIMetaobject`
are all used throughout this package but their class bodies live in
`hw/python/hw/mdi/*.pyc` (compiled) — method signatures for those classes
could not be extracted from source. Everything documented about their
behavior below is inferred from call sites in `hm/*.py`, `hm/test.py`,
`hm/tests/testWorkflows.py`, and `hm/extensions/*.py`, and is
RUNTIME-TEST-NEEDED.

### Inferred `Session` usage contract (from `hm/test.py`, `hmmodularctrl.py`)
- `mdi.Session('hmmdi')` — constructor takes a string, apparently a vocabulary
  name (`'hmmdi'` matches the `hmmdi` C++ module name). RUNTIME-TEST-NEEDED.
- `session.create(cls, **kwargs)` — creates and returns an instance of an MDI
  entity class `cls` (e.g. `p.Task`, `p.Automation`, `PartPrototype`), with
  keyword args setting fields (e.g. `name=`, `isassembly=`, `parent=`,
  `child=`). RUNTIME-TEST-NEEDED.
- `session.write(filepath)` — serializes the session to disk (per
  `Session._deserializer_class` wiring, presumably HDF5-backed).
  RUNTIME-TEST-NEEDED.
- `occurrence.session._get_pointer()` — each MDI object instance exposes a
  back-reference `.session`, and `Session` exposes a private
  `_get_pointer()` used to hand the raw session pointer to native code (seen
  in `ModularControlHM.update_occurrence_tree`, see below).
  RUNTIME-TEST-NEEDED.
- `entity_instance.entity` — an MDI object instance exposes `.entity`, the
  underlying native entity handle, passed to native calls.
  RUNTIME-TEST-NEEDED.

---

## 3. `hm/entities.py` — collects and re-exports instantiable entity classes

```python
import hm.mdi as mdi
import hw.mdi.tests.pulse as p     # demo/test vocabulary, side effect: registers classes

classes = mdi.Manager.getclasses(True)

import sys
for cls in classes:
    if not cls.instantiable:
        continue
    sys.modules[__name__].__dict__[cls.__name__] = cls
```

### `hm.entities` module-level behavior
- **Signature**: no functions/classes defined; this file *populates* the
  `hm.entities` module namespace dynamically at import time.
- **Return shape**: After `import hm.entities`, the module object has one
  attribute per instantiable registered MDI entity class, named after the
  class (e.g. if a `Component` metaclass is registered and
  `Component.instantiable` is `True`, then `hm.entities.Component` becomes
  usable, equivalent to `from hw.mdi.cdm.<wherever> import Component`).
- **Precondition/side-effect**: Requires `mdi.Manager.getclasses(True)` to
  return the full list of registered MDI metaclasses (the `True` argument's
  meaning is not documented in source — likely "include non-instantiable" or
  "force refresh"; RUNTIME-TEST-NEEDED). Requires that whichever vocabulary
  modules define real HyperMesh entities have already been imported/
  registered (this file only additionally imports the **test/demo**
  vocabulary `hw.mdi.tests.pulse`, not a real HyperMesh entity vocabulary) —
  so in practice, `import hm.entities` on its own mainly exposes `pulse`'s
  demo classes (`Task`, `Automation`, per `test.py`), not full HyperMesh
  entities, unless something else already registered the real HM vocabulary
  earlier in the process. This looks like leftover/demo scaffolding rather
  than the production entity-access path.
- **Confidence**: LOCAL-INSTALL for the code as written;
  RUNTIME-TEST-NEEDED for what classes actually end up populated in a live
  HyperMesh session (depends on load order and which vocabularies are
  registered by the running application, not shown in this file).

### `Manager.getclasses(include_noninstantiable: bool = ...)` (inferred)
- **Signature**: classmethod/staticmethod on `hw.mdi.core.Manager`, called as
  `mdi.Manager.getclasses(True)`. Exact parameter name/default unknown (body
  is compiled).
- **Return shape**: iterable of MDI metaclass objects, each exposing at least
  `.instantiable: bool` and `.__name__`.
- **Precondition/side-effect**: Presumably requires `Manager._mgr` to already
  be set (done in `hm/mdi.py`, which `entities.py` imports first via
  `import hm.mdi as mdi`).
- **Confidence**: RUNTIME-TEST-NEEDED (compiled implementation).

---

## 4. `hm/test.py` — smoke-test / usage example (not a library API)

```python
import hm.mdi as mdi
import hw.mdi.tests.pulse as p

def main(fp: str):
    session = mdi.Session('hmmdi')
    t = session.create(p.Task)
    a = session.create(p.Automation)
    a.tasks = [t]
    session.write(fp)

if __name__ == "__main__":
    import sys, os
    fp = sys.argv[1]
    main(os.path.abspath(fp))
```

### `main(fp: str)`
- **Signature**: `main(fp: str) -> None`.
- **Return shape**: `None`. Writes a session file to path `fp`.
- **Precondition/side-effect**: Demonstrates the minimal MDI round-trip:
  open/create a `Session('hmmdi')`, create two demo entities (`Task`,
  `Automation` from the `pulse` **test/demo** vocabulary — not real
  HyperMesh domain entities), link them (`a.tasks = [t]`, showing entity
  attributes support plain list assignment), then `session.write(fp)`.
  Intended to be run as a script (`python test.py <output-path>`) inside an
  HM-embedded Python interpreter — not meant to be imported as a library
  function. Requires an initialized MDI environment (i.e. must run after
  `hm`/`hm.mdi` have successfully bootstrapped, so realistically only inside
  HyperMesh/HyperWorks Python, not standalone CPython).
- **Confidence**: LOCAL-INSTALL for the code; RUNTIME-TEST-NEEDED for
  whether it actually executes successfully (depends on compiled `Session`/
  `pulse` module behavior).

---

## 5. `hm/tests/testWorkflows.py` — demo `MDIWorkflow` subclasses

```python
from hw.mdi.workflow import *
__version__ = '0.0.1'

class AWorkflow(MDIWorkflow):
    dummy = Attribute(displayname='Dummy')
    flag = BoolAttribute(displayname='Flag')
    ok = Action(displayname='Ok', enabled=False)

    @flag.onupdate
    def flag_onupdate(self) -> None:
        enabled_ = True if self.flag else False
        self.getattribute('dummy').enabled = enabled_
        self.ok.enabled = enabled_

    @ok.onrun
    def commit(self):
        print(self.dummy)
        print('OK')

class AnotherWorkflow(MDIWorkflow):
    dummy = Attribute(displayname='Dummy2')
    ok = Action(displayname='Ok2', enabled=False)

    @ok.onrun
    def commit(self):
        print(self.dummy)
        print('OK')
```

### `class AWorkflow(MDIWorkflow)`
- **Signature**: subclass of `hw.mdi.workflow.MDIWorkflow` (compiled, not
  inspectable). Declares three class-level descriptors: `dummy = Attribute(...)`,
  `flag = BoolAttribute(...)`, `ok = Action(...)`.
- **Return shape**: N/A — a workflow definition, not a data structure. When
  instantiated/run by the MDI workflow engine, presumably drives a GUI
  form/dialog with a text field (`dummy`), a checkbox (`flag`), and a button
  (`ok`), based on the `displayname=` kwargs (this is a UI-form pattern:
  `Attribute`/`BoolAttribute` are form fields, `Action` is a button).
- **Precondition/side-effect**: `@flag.onupdate`-decorated `flag_onupdate`
  fires when the `flag` attribute's value changes in the running workflow;
  it toggles `.enabled` on the `dummy` attribute descriptor instance
  (`self.getattribute('dummy')`) and on the `ok` Action, i.e. a live
  enable/disable UI dependency. `@ok.onrun`-decorated `commit` fires when the
  `ok` Action is invoked (e.g. button click) and prints `self.dummy`'s
  current value. This is a **test/demo fixture**, not used by production
  code paths documented elsewhere in this project.
- **Confidence**: LOCAL-INSTALL for the code as written;
  RUNTIME-TEST-NEEDED for exact runtime UI behavior (depends on the MDI
  workflow engine, compiled).

### `class AnotherWorkflow(MDIWorkflow)`
- Same pattern as `AWorkflow`, minus the `flag`/enable-toggle logic — a
  simpler one-field-one-button demo workflow. Same confidence caveats.

### Descriptor API surface used (all imported from `hw.mdi.workflow`, compiled)
- `Attribute(displayname: str = ...)` — generic text/value form field.
  RUNTIME-TEST-NEEDED for full signature/behavior.
- `BoolAttribute(displayname: str = ...)` — checkbox-style boolean field.
  RUNTIME-TEST-NEEDED.
- `Action(displayname: str = ..., enabled: bool = ...)` — button-like
  workflow action; supports `.onrun` decorator to register the callback fired
  on invocation, and `.enabled` is a settable property. RUNTIME-TEST-NEEDED.
- `EntityAttribute(entity_types: list, displayname: str = ...)` (seen in
  `hmmodularentities.py`, e.g. `EntityAttribute([Occurrence], displayname='Start From')`)
  — form field constrained to entities of the given MDI type(s).
  RUNTIME-TEST-NEEDED.
- Descriptor instance methods observed: `.onupdate` (decorator, fires on
  value change), `.onrun` (decorator, fires on action invocation),
  `self.getattribute(name: str)` (workflow instance method returning the
  live descriptor/field object by name, exposing `.enabled` at minimum).
  RUNTIME-TEST-NEEDED.

---

## 6. `hm/extensions/hmmodularctrl.py` — `ModularControlHM`

```python
from hw.mdi.core import *
from hw.mdi.cdm.assembly import *
from hmmdi import hmMDIModularControl_GetControl

class ModularControlHM(object):
    def __init__(self,
        root_class: MDIMetaclass,
        prototype_class: MDIMetaclass,
        instance_class: MDIMetaclass,
        occurrence_class: MDIMetaclass,
        representation_definition_class: MDIMetaclass,
        representation_realization_class: MDIMetaclass):
        self.__cppobj = hmMDIModularControl_GetControl(
            root_class.fulltype, prototype_class.fulltype,
            instance_class.fulltype, occurrence_class.fulltype,
            representation_definition_class.fulltype,
            representation_realization_class.fulltype)

    def update_occurrence_tree(self, occurrence: MDIMetaobject):
        self.__cppobj.UpdateOccurrenceTree(
            occurrence.session._get_pointer(), occurrence.entity)
```

This is the one class in the whole `hm` package with real (if thin) Python
logic of its own — it is a wrapper around a native controller object.

### `ModularControlHM.__init__(self, root_class, prototype_class, instance_class, occurrence_class, representation_definition_class, representation_realization_class)`
- **Signature**:
  `ModularControlHM(root_class: MDIMetaclass, prototype_class: MDIMetaclass, instance_class: MDIMetaclass, occurrence_class: MDIMetaclass, representation_definition_class: MDIMetaclass, representation_realization_class: MDIMetaclass) -> ModularControlHM`.
  All six params are MDI metaclasses (types), e.g. from
  `hw.mdi.cdm.assembly`: `PartRoot, PartPrototype, PartInstance, Part, PartRepresentationDefinition, PartRealizationFacets`.
- **Return shape**: constructs an instance whose private `_ModularControlHM__cppobj`
  attribute holds a native control object obtained via
  `hmmdi.hmMDIModularControl_GetControl(...)`, called with each class's
  `.fulltype` string (an MDI metaclass property giving its fully-qualified
  type name — not otherwise documented in this package).
- **Precondition/side-effect**: Each argument must be a real, already
  registered MDI metaclass exposing `.fulltype`; calling with arbitrary
  classes that lack `.fulltype` raises `AttributeError`. Must run inside an
  environment where `hmmdi` (the native module) and the MDI assembly
  vocabulary (`hw.mdi.cdm.assembly`) are loaded — i.e. inside HyperMesh's
  Python, with the Part/Occurrence data model registered (implies an active
  HM/MDI session context, not a bare interpreter).
- **Confidence**: LOCAL-INSTALL for the Python signature/wiring;
  RUNTIME-TEST-NEEDED for what `hmMDIModularControl_GetControl` does
  internally (native code).

### `ModularControlHM.update_occurrence_tree(self, occurrence: MDIMetaobject) -> None`
- **Signature**: `update_occurrence_tree(self, occurrence: MDIMetaobject) -> None`.
- **Return shape**: `None` (return value of the native call is not captured/
  returned by the Python wrapper).
- **Precondition/side-effect**: `occurrence` must be a live MDI entity
  instance exposing `.session` (with a private `._get_pointer()` method) and
  `.entity` (native entity handle) — i.e. must be an entity that was created
  or read via an active `Session`, not a bare Python object. Calls the native
  `UpdateOccurrenceTree(session_pointer, entity)` — from usage in
  `testWorkflows`-adjacent code (`UpdateOccurrenceWorkflow`,
  `CreateOccurrenceWorkflow` in `hmmodularentities.py`), this recomputes/
  refreshes the occurrence (assembly instance) tree in the HM/MDI model after
  structural edits (e.g. after creating a new `Part`/`Occurrence` pairing).
  Precondition: must be called with a session-backed entity; calling it with
  a detached/unsaved object will likely raise inside the native call
  (RUNTIME-TEST-NEEDED — not verifiable from Python source alone).
- **Confidence**: LOCAL-INSTALL for signature and call pattern;
  RUNTIME-TEST-NEEDED for exact semantics of "update occurrence tree" (native
  implementation, and the inferred "recompute assembly tree" meaning is
  interpretive, drawn only from the class/method names and call sites).

### Module-level side effect on import
```python
ModularControlHM(PartRoot, PartPrototype, PartInstance, Part, PartRepresentationDefinition, PartRealizationFacets)
```
- Note: `hmmodularctrl.py` constructs a `ModularControlHM` instance for the
  `Part`/`PartRoot`/... assembly classes **at module import time** and
  discards the result (not assigned to anything). This is very likely dead/
  leftover debug code, since the constructed object is never bound to a
  name and has no other side effect beyond calling
  `hmMDIModularControl_GetControl` once. Flagging as-is rather than omitting,
  since it is genuinely present in the shipped file and executes on
  `import hm.extensions.hmmodularctrl`. RUNTIME-TEST-NEEDED whether this
  import-time call has any global side effect inside the native layer (e.g.
  registering a control singleton) beyond what's visible in Python.

---

## 7. `hm/extensions/hmmodularentities.py` — example `MDIWorkflow` usage of `ModularControlHM`

```python
from hw.mdi.workflow import *
from hw.mdi.cdm.assembly import Occurrence, PartRoot, PartPrototype, PartInstance, Part, PartRepresentationDefinition, PartRealizationFacets
from hm.extensions.hmmodularentities import ModularControlHM   # NOTE: see below

__version__ = '0.0.1'

class UpdateOccurrenceWorkflow(MDIWorkflow):
    occurrence = EntityAttribute([Occurrence], displayname='Start From')
    ok = Action(displayname='Ok', enabled=True)

    @ok.onrun
    def commit(self):
        if isinstance(self.occurrence, Part):
            mc = ModularControlHM(PartRoot, PartPrototype, PartInstance, Part,
                                   PartRepresentationDefinition, PartRealizationFacets)
        mc.update_occurrence_tree(self.occurrence)

class CreateOccurrenceWorkflow(MDIWorkflow):
    parent = EntityAttribute([Occurrence], displayname='Parent')
    aname = Attribute(displayname='Name')
    isassembly = BoolAttribute(displayname='Assembly')
    ok = Action(displayname='Ok', enabled=True)

    @ok.onrun
    def commit(self):
        if isinstance(self.occurrence, Part):
            mc = ModularControlHM(PartRoot, PartPrototype, PartInstance, Part,
                                   PartRepresentationDefinition, PartRealizationFacets)
            proto_cls, inst_cls = PartPrototype, PartInstance
        proto = self.session.create(proto_cls, name=self.aname, isassembly=self.isassembly)
        parent_instance = self.parent.instance
        parent_proto = parent_instance.child
        instance = self.session.create(inst_cls, name=self.aname, parent=parent_proto, child=proto)
        mc.update_occurrence_tree(self.parent)
```

**Source bug worth flagging** (do not silently "fix" when documenting): line 4
does `from hm.extensions.hmmodularentities import ModularControlHM` — i.e.
this file imports `ModularControlHM` **from itself**, which is almost
certainly a copy-paste error; it should read
`from hm.extensions.hmmodularctrl import ModularControlHM` (the file that
actually defines that class, see section 6). As shipped, importing this
module will raise `ImportError: cannot import name 'ModularControlHM' from
partially initialized module 'hm.extensions.hmmodularentities' (most likely
due to a circular import)` — meaning **this module is broken as-is and
cannot be imported successfully**. Any AI agent should NOT rely on
`hm.extensions.hmmodularentities` working out of the box; if functionality
like `UpdateOccurrenceWorkflow`/`CreateOccurrenceWorkflow` is needed, either
patch the import locally or reimplement using `ModularControlHM` from
`hm.extensions.hmmodularctrl` directly.

### `class UpdateOccurrenceWorkflow(MDIWorkflow)`
- **Signature**: workflow with one `EntityAttribute([Occurrence], displayname='Start From')`
  field (`occurrence`) and one `Action` (`ok`).
- **Return shape**: N/A (workflow form). On `ok` run: if the selected
  `occurrence` is a `Part` instance, builds a `ModularControlHM` bound to the
  Part assembly class set and calls `update_occurrence_tree(self.occurrence)`.
- **Precondition/side-effect**: Requires `self.occurrence` to be set (user
  picked an entity in the form) and, per the `isinstance(self.occurrence, Part)`
  check, only proceeds for `Part`-typed occurrences (the `Subsystem` branch
  is commented out in source — **not implemented**, despite being
  conceptually parallel). If `self.occurrence` is not a `Part`, `mc` is never
  assigned and the subsequent `mc.update_occurrence_tree(...)` call raises
  `UnboundLocalError` — another latent bug worth flagging, not silently
  fixed.
- **Confidence**: LOCAL-INSTALL for code; RUNTIME-TEST-NEEDED for
  whether this workflow is even reachable/registered in a real HM session
  (no evidence in this package of it being registered into any menu/UI).

### `class CreateOccurrenceWorkflow(MDIWorkflow)`
- **Signature**: workflow with fields `parent` (`EntityAttribute([Occurrence])`),
  `aname` (`Attribute`, a name string), `isassembly` (`BoolAttribute`), and
  `ok` (`Action`).
- **Return shape**: N/A (workflow form). On `ok` run, for a `Part`-typed
  `self.occurrence` (**note**: the code checks `self.occurrence` but this
  class never declares an `occurrence` attribute — only `parent` is declared;
  this looks like another copy/paste artifact from `UpdateOccurrenceWorkflow`
  and would raise `AttributeError: 'CreateOccurrenceWorkflow' object has no
  attribute 'occurrence'` at runtime), creates a new `PartPrototype` (via
  `self.session.create(proto_cls, name=self.aname, isassembly=self.isassembly)`)
  and a new `PartInstance` linking it under the parent's prototype
  (`parent_instance = self.parent.instance; parent_proto = parent_instance.child`),
  then calls `mc.update_occurrence_tree(self.parent)`.
- **Precondition/side-effect**: Same `Part`-only limitation as above (the
  `Subsystem` branch is commented out/unimplemented). Requires `self.parent`
  to be a valid `Occurrence` whose `.instance.child` resolves to a
  `PartPrototype`. As noted, the `self.occurrence` reference is dead code /
  a bug — this workflow as shipped will not run successfully past that line.
- **Confidence**: LOCAL-INSTALL for code as written (including the bugs
  called out above, which are read directly, not inferred);
  RUNTIME-TEST-NEEDED for whether any variant of this workflow can actually
  execute in a live session.

**Overall assessment of section 7**: this file reads as an unfinished/
example extension (assembly modular-control workflows), not production API.
Two independent bugs (self-import, undefined `self.occurrence` in
`CreateOccurrenceWorkflow`) mean it cannot run as shipped. Document its
intent, not its correctness.

---

## 8. Summary table

| Item | Kind | File | Real implementation location | Confidence |
|---|---|---|---|---|
| path bootstrap | script | `hm/__init__.py` | inline | LOCAL-INSTALL |
| MDI/HM registration | script | `hm/mdi.py` | inline + `hw.mdi.core` (.pyc) + `hmmdi` (native) | LOCAL-INSTALL / RUNTIME-TEST-NEEDED |
| `add_vocabulary` hook | function | `hm/mdi.py` | inline | LOCAL-INSTALL |
| dynamic entity re-export | script | `hm/entities.py` | `hw.mdi.core.Manager` (.pyc) | RUNTIME-TEST-NEEDED |
| `main(fp)` | function | `hm/test.py` | demo script | LOCAL-INSTALL |
| `AWorkflow`, `AnotherWorkflow` | classes | `hm/tests/testWorkflows.py` | `hw.mdi.workflow` (.pyc) | RUNTIME-TEST-NEEDED |
| `ModularControlHM` | class | `hm/extensions/hmmodularctrl.py` | wraps native `hmmdi.hmMDIModularControl_GetControl` | LOCAL-INSTALL (wrapper) / RUNTIME-TEST-NEEDED (native) |
| `UpdateOccurrenceWorkflow`, `CreateOccurrenceWorkflow` | classes | `hm/extensions/hmmodularentities.py` | BROKEN as shipped (import + attribute bugs) | LOCAL-INSTALL (bugs confirmed by reading) |

**Total documented items: 1 module-level bootstrap script, 3 module-level
registration/wiring scripts, 1 callback function (`add_vocabulary`), 1 real
class with 2 methods (`ModularControlHM.__init__`,
`.update_occurrence_tree`), and 4 demo/example `MDIWorkflow` subclasses
(`AWorkflow`, `AnotherWorkflow`, `UpdateOccurrenceWorkflow`,
`CreateOccurrenceWorkflow`) — 8 files total, all covered, nothing omitted.**

No large, hand-written "HyperMesh Python API" class hierarchy exists in this
package. The real per-entity API (create/get/set fields on `Component`,
`Property`, etc.) is generated dynamically at runtime from
`Hypermesh.json` + the compiled `hw.mdi.core`/`hmmdi` layer, and is not
present as readable Python source anywhere under `hw/python/hm/`.

---

## 9. hwx/ findings (comparable native package search)

Checked `<ALTAIR_INSTALL_DIR>/hwx/` for an equivalent
native `hm`/`hw` Python package (hwx being the newer Unified Desktop shell).

Findings:

- No `hm` or `hwx.hm`-style package mirroring `hw/python/hm/` exists under
  `hwx/`.
- `hwx/scripts/python/hwx/` contains only **demo/gallery** content
  (`hwx/common/demo/*.py`, `hwx/gui/demo/*.py` — math helpers, widget/layout/
  plot demos, an `ExtensionManager.py`) — sample code for the Unity/Unified
  Desktop GUI framework, not a HyperMesh entity API.
- `hwx/plugins/mdi/*.py` (`mdi_client.py`, `mdi_clientobject.py`,
  `mdi_object.py`, `mdi_plugin_loader.py`, `mdi_profile_assembly.py`,
  `mdi_profile_default.py`, `mdi_profile_smartclipboard.py`) — these are real
  source files and directly relevant to MDI, but they are a **plugin/profile
  layer** for the Unified Desktop's MDI client (registering MDI profiles,
  clipboard behavior, etc.), not a `hw.mdi.core`-equivalent entity API and
  not inside a `hm` namespace. They were out of scope for this task (task
  scope was `hw/python/hm/*.py` specifically) but are flagged here as a
  concrete, worthwhile follow-up target if future work needs the Unified
  Desktop MDI plugin surface.
- The actual generic MDI framework core (`hw.mdi.core`, `.isession`,
  `.workflow`, etc., which both `hw/python/hm/` and presumably `hwx/plugins/mdi/`
  ultimately depend on) is shared/compiled (`hw/python/hw/mdi/*.pyc`) and not
  duplicated under `hwx/` — `hwx` builds on the same core rather than
  replacing it.

**Recommendation**: A follow-up pass on `hwx/plugins/mdi/*.py` (7 files, real
`.py` source, not yet read in depth here) would be worthwhile if the project
ever needs Unified-Desktop-side MDI scripting, but it is a different layer
from classic HyperMesh's `hm` package and should be a separate doc, not
merged into this one.
