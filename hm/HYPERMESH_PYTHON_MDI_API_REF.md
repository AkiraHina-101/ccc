# HyperWorks Unified Desktop MDI Plugin API Reference (`hwx/plugins/mdi/`)

Purpose: AI-readable reference for the **Unified Desktop (hwx) MDI plugin
layer** at `hwx/plugins/mdi/` in the local Altair install. This is the
plugin that registers an "MDI" document type (Client/ClientObject/Profile) in
the Unified Desktop shell (`hwfwg` framework) and bridges it to the same
underlying MDI data-model core (`hw.mdi.core`, `hw.mdi.isession`, etc.) that
`hw/python/hm/` also wraps.

This is explicitly a **different, separate layer** from:

```text
_clean/docs/HYPERMESH_PYTHON_NATIVE_API_REF.md   (hw/python/hm/* — classic HM's
                                                   thin glue onto hw.mdi.core)
_clean/docs/HYPERMESH_PYTHON_EMBEDDING_API_REF.md (Python-calls-Tcl bridge)
```

Where `hw/python/hm/` is HyperMesh's own glue onto the generic MDI framework,
`hwx/plugins/mdi/` is the **Unified Desktop shell's UI-integration plugin**
for that same MDI framework — it defines how an MDI session shows up as a
document/tab in the hwx GUI (Project Browser tree items, Property Editor
fields, ribbon pages, save/open/save-as file handling), not domain entity
semantics. It was flagged as a follow-up in
`HYPERMESH_PYTHON_NATIVE_API_REF.md` section 9 and is documented here per
`API_DOC_EXPANSION_TASKLIST.md` item 6.

Verification status:

```text
OFFICIAL:
  Not used in this file. This plugin layer (hwfwg Client/ClientObject/Profile
  framework) is internal Unified Desktop plumbing, not documented in Altair's
  public scripting help.

LOCAL-INSTALL:
  Everything below is read directly from the installed .py source files at
  <ALTAIR_INSTALL_DIR>/hwx/plugins/mdi/. Labeled as such
  throughout. Nothing here was executed — read from source only, same
  discipline as HYPERMESH_PYTHON_NATIVE_API_REF.md.

RUNTIME-TEST-NEEDED:
  Base classes (Client, ClientObject, Profile, Object, ClassInfo, Property,
  hwTListener, ClientManager, Application, hwLogger, hwString, hwUIntList,
  hwStringList) all come from compiled/native modules (hwfwg, hwtypes,
  hwapplication, hwlogging, hwutl, hwcont, hwsigslot, hwdescriptor) — not
  under hwx/plugins/mdi/ and not inspectable as Python source. Their exact
  signatures/behavior are inferred from call sites only and flagged
  RUNTIME-TEST-NEEDED. Likewise, `hw.mdi.core.Manager`, `hw.mdi.isession.Session`,
  and `hw.mdi.standalone.Session` are the same compiled MDI core described in
  HYPERMESH_PYTHON_NATIVE_API_REF.md — not re-documented here, only referenced.
```

Sources inspected (all 7 files named in the task, confirmed exhaustive for
this directory via the task list — no other `.py` files were found alongside
these in `hwx/plugins/mdi/`):

```text
<ALTAIR_INSTALL_DIR>/hwx/plugins/mdi/mdi_client.py
<ALTAIR_INSTALL_DIR>/hwx/plugins/mdi/mdi_clientobject.py
<ALTAIR_INSTALL_DIR>/hwx/plugins/mdi/mdi_object.py
<ALTAIR_INSTALL_DIR>/hwx/plugins/mdi/mdi_plugin_loader.py
<ALTAIR_INSTALL_DIR>/hwx/plugins/mdi/mdi_profile_assembly.py
<ALTAIR_INSTALL_DIR>/hwx/plugins/mdi/mdi_profile_default.py
<ALTAIR_INSTALL_DIR>/hwx/plugins/mdi/mdi_profile_smartclipboard.py
```

---

## 0. Big picture

This is a **thin but real** plugin — unlike `hw/python/hm/` (pure bootstrap/
re-export shim with one real class), this directory has several classes with
genuine, non-trivial logic: a `Client` subclass handling file open/save/
save-as, a `ClientObject` subclass that lazily wraps MDI entities into
Project-Browser tree nodes with caching, an `Object` subclass that maps MDI
entity attributes onto the Property Editor's generic `Property` protocol, a
loader script, and three `Profile` subclasses (default/assembly/smart-
clipboard) that wire ribbon UI and lifecycle-event routing.

All of it exists to answer one question: **"how does an MDI session/entity
tree get displayed and edited inside the Unified Desktop GUI shell"** — it is
UI plumbing, not a standalone scripting API meant to be called by an
automation script. There is no equivalent of "import this and drive HM
headlessly" here; everything assumes it is running inside the loaded hwx
plugin framework with an active `ClientManager`.

**Precondition that applies to essentially everything in this file**: must
run inside the Unified Desktop (`hwx`) shell process, after
`mdi_plugin_loader.py` has executed (i.e. the "MDI" plugin has been loaded by
the framework) and while a `ClientManager` singleton with a registered `'MDI'`
client exists. None of these classes are usable from a bare `python.exe` or
even from HyperMesh classic (non-hwx) Python.

---

## 1. `mdi_plugin_loader.py` — plugin entry point

```python
def load():
    import os, sys
    from hwutl import hwString
    thisdir = os.path.dirname(__file__)
    if( not thisdir in sys.path ):
        sys.path.append(thisdir)
    altair_home = os.environ.get('ALTAIR_HOME')
    if altair_home :
        hwpy = os.path.join(altair_home, 'hw','python')
        if( not hwpy in sys.path ):
            sys.path.append(hwpy)
    from mdi_client import MDIClient
    MDIClient(hwString('MDI'))

load()
del load
```

### `load()`
- **Signature**: `load() -> None`. Defined and immediately called at module
  scope; the name `load` is deleted from the module namespace right after
  (`del load`), so this is a run-once entry point, not a reusable function.
- **Return shape**: `None`. Side effects only: mutates `sys.path` (adds this
  plugin's own directory, plus `<ALTAIR_HOME>/hw/python` if `ALTAIR_HOME` is
  set), then imports and instantiates `MDIClient('MDI')` (see section 2). The
  constructed `MDIClient` instance is not bound to any name — it registers
  itself with the framework's `ClientManager` purely via side effects inside
  `Client.__init__`/`AddProfile` (native, `hwfwg`), not via a returned/stored
  reference in this file.
- **Precondition/side-effect**: Executed automatically when the Unified
  Desktop plugin framework loads this file as the `MDI` plugin module (the
  file's location and name convention — `mdi_plugin_loader.py` under
  `plugins/mdi/` — implies this is the designated plugin bootstrap, though
  the exact framework mechanism that finds/executes this file lives outside
  this file, RUNTIME-TEST-NEEDED). If `ALTAIR_HOME` is unset, the `hw/python`
  path addition is silently skipped (no error) — unlike `hm/__init__.py`
  (documented in the native API ref) which raises `TypeError` on a missing
  env var, this loader degrades gracefully instead.
- **Confidence**: LOCAL-INSTALL for the code as written; RUNTIME-TEST-NEEDED
  for how/when the hwx framework actually invokes this file.

---

## 2. `mdi_client.py` — `MDIClient(Client)`

Registers the "MDI" document type with the Unified Desktop: handles
open/new/close/save/save-as for MDI session files, and owns a single active
`MDIClientObject`.

### `MDIClient.__init__(self, plugin: hwString)`
- **Signature**: `MDIClient(plugin: hwString) -> MDIClient`. Calls
  `Client.__init__(self, 'MDI')` — the plugin's registered document-type name
  is hardcoded to `'MDI'` regardless of the `plugin` argument passed in (the
  argument is accepted but not forwarded to `Client.__init__`; only used
  implicitly via profile construction below).
- **Return shape**: constructs an `MDIClient` instance; calls
  `self.__disown__()` (a SWIG idiom transferring C++ ownership of `self` away
  from Python's GC, i.e. the framework/C++ side now owns the lifetime — do
  not expect Python refcounting alone to keep this alive or to destroy it
  predictably). Sets up a private logger
  (`Application.Get().GetLogger('plugins.mdi')`, level `LOG_ALL`, log file at
  `<SettingsDirectory>/logs/hwxMDI.<pid>.log` via `__getlogfile__`). Registers
  two `Profile` instances via `self.AddProfile(...)`:
  `MDIProfile(plugin, self)` (always) and `MDIAssembyProfile(plugin, self)`
  (always, imported lazily inside `__init__`). A third profile,
  `MDISCProfile` (`mdi_profile_smartclipboard.py`), is **commented out** —
  see "Source finding" below.
- **Precondition/side-effect**: Must run inside the hwx plugin-loading
  sequence (constructs framework objects `Client`, `Profile`, uses
  `Application.Get()`, which requires an initialized `Application` singleton).
- **Confidence**: LOCAL-INSTALL.

**Source finding (flag, not fixed)**: line 12 imports
`# from mdi_profile_smartclipboard import MDISCProfile` and line 27
`# self.AddProfile(MDISCProfile(plugin, self))` are both commented out in the
shipped file. The Smart Clipboard profile (`mdi_profile_smartclipboard.py`,
section 6 below) is fully implemented and imports/runs cleanly on its own
merits, but as shipped it is **never registered** — `MDIClient` only ever
activates `MDIProfile` and `MDIAssembyProfile`. This looks like a feature that
was deliberately disabled (not a copy/paste bug like the ones found in the
native `hm` package), but an AI agent should not assume Smart-Clipboard
ribbon actions (`Copy`/`Paste` in `mdi_profile_smartclipboard.py`) are
reachable in a live Unified Desktop session — they are dead code unless
this line is uncommented. RUNTIME-TEST-NEEDED to confirm no other file
re-enables it elsewhere (searched only within these 7 files, per task scope).

### `MDIClient.client_object` (property)
- **Signature**: `client_object -> MDIClientObject | None` (getter only, no
  setter — read-only property).
- **Return shape**: the current single active `MDIClientObject`, or `None` if
  none has been created yet (`self.__client_object` starts `None`).
- **Precondition/side-effect**: none; pure accessor.
- **Confidence**: LOCAL-INSTALL.

### `MDIClient.OpenFile(self, filename: hwString, filter=hwString()) -> bool`
- **Signature**: `OpenFile(filename: hwString, filter: hwString = hwString()) -> bool`.
- **Return shape**: `True` if the file existed and
  `client_object.session.read(filename)` returned an outcome whose
  `.returncode == STATUS_OK` (from `hwdescriptor`); `False` if the file does
  not exist/is not a regular file, or if the read did not report `STATUS_OK`.
- **Precondition/side-effect**: Validates `os.path.exists`/`os.path.isfile`
  first (returns `False` early with a `# TODO: warn user` — **no actual user
  warning is implemented**, just a silent `False`). On success, always
  creates a **brand-new** `MDIClientObject` via `__new_client_object__` (which
  itself closes/discards any existing one first — see below) before reading,
  named from `os.path.basename(filename)`. Sets both
  `self.__client_object.filepath` and `self.__filepath` to `filename` after
  a successful read. Requires `client_object.session` to expose a
  `.read(filename)` method returning an object with `.returncode`
  (RUNTIME-TEST-NEEDED, native `hw.mdi.standalone.Session`).
- **Confidence**: LOCAL-INSTALL for the wrapper logic; RUNTIME-TEST-NEEDED
  for `session.read()` internals.

### `MDIClient.New(self, *args) -> None`
- **Signature**: `New(*args) -> None`. Return type annotated `"void"` in the
  docstring (framework convention for `None`).
- **Return shape**: `None`.
- **Precondition/side-effect**: Creates a new empty `MDIClientObject` **only
  if** there is currently no client object *or* `args` is non-empty
  (`if not self.__client_object or not args:` — note the boolean logic: this
  condition is true whenever there's no existing client object, regardless of
  `args`, AND also true whenever `args` is empty, regardless of whether a
  client object exists; the only case that does *not* create a new object is
  "a client object already exists AND args was passed non-empty" — an
  unusual/asymmetric condition worth flagging as confusing, though not
  necessarily wrong, since the exact intended calling convention for `args`
  from the framework is not documented in this file). Always resets
  `self.__filepath = None` regardless of whether a new object was created.
- **Confidence**: LOCAL-INSTALL (logic read directly, semantics of the
  condition are ambiguous from source alone — RUNTIME-TEST-NEEDED to confirm
  intended behavior, since the framework's calling convention for `New`'s
  `*args` is not visible here).

### `MDIClient.Close(self, arg0: ClientObject) -> bool`
- **Signature**: `Close(arg0: ClientObject) -> bool`.
- **Return shape**: whatever `super().Close(arg0)` (native `Client.Close`)
  returns, unchanged.
- **Precondition/side-effect**: Calls the base `Close` first, then — **if**
  `self.__client_object` is currently set (note: not necessarily the *same*
  object as `arg0`; the method does not check `arg0 is self.__client_object`,
  it unconditionally tears down whatever `self.__client_object` currently is)
  — emits `EmitDeleted()`, calls `.clear()` (which calls
  `session.destroy()`, see `mdi_clientobject.py`), `del`s the reference, and
  resets `self.__client_object_id` to 0 and `self.__client_object` to `None`.
  Because this ignores `arg0`, calling `Close` with an `arg0` that is not the
  tracked client object still tears down the tracked one — a potential
  latent bug if the framework ever calls `Close` with a different
  `ClientObject` than the currently-tracked one (this client only supports
  one open document at a time in practice, so this may be intentional given
  that assumption, but it is not defensively checked). Flagging as a
  correctness caveat, not fixing.
- **Confidence**: LOCAL-INSTALL for logic; RUNTIME-TEST-NEEDED for
  whether the framework ever actually passes a mismatched `arg0`.

### `MDIClient.Save(self, arg0: ClientObject) -> "SAVE_RESULT"`
- **Signature**: `Save(arg0: ClientObject) -> Client.FAIL | Client.SAVE_AS | Client.SUCCESS`
  (constants presumably defined on the native `Client` base class;
  RUNTIME-TEST-NEEDED for their exact values/type, inferred to be an enum-like
  int).
- **Return shape**: `Client.FAIL` if there is no active client object;
  `Client.SAVE_AS` if there is a client object but no known filepath yet
  (i.e. "please prompt for Save As instead" signal back to the framework);
  otherwise writes to `self.__filepath` via `session.write(...)` and returns
  `Client.SUCCESS` if `outcome.returncode == STATUS_OK`, else `Client.FAIL`.
- **Precondition/side-effect**: Calls `super().Save(arg0)` first (return value
  discarded — only this method's own return value is used, another notable
  detail: the base class's save signal/return is not consulted for the final
  decision). Logs via `self.__logger.Trace(...)`. Requires
  `client_object.session.write(filepath)` to exist and return an object with
  `.returncode` (RUNTIME-TEST-NEEDED, native).
- **Confidence**: LOCAL-INSTALL for wrapper; RUNTIME-TEST-NEEDED for
  native `session.write` and `Client.FAIL/SAVE_AS/SUCCESS` constants.

### `MDIClient.SaveAs(self, client_object, filepath: str, fileext: str, filter: str = None) -> bool`
- **Signature**: `SaveAs(client_object: ClientObject, filepath: str, fileext: str, filter: str = None) -> bool`.
- **Return shape**: `True` and updates `self.__client_object.filepath` /
  `self.__filepath` to the new `filepath` if
  `session.write(filepath).returncode == STATUS_OK`; `False` if there is no
  active client object, or if the write did not report `STATUS_OK`.
- **Precondition/side-effect**: Calls `super().SaveAs(...)` first (return
  value discarded, same pattern as `Save`). Note `fileext` and `filter` are
  accepted as parameters but never actually used in the method body beyond
  the trace log message — they are logged but have no effect on the actual
  write call (`session.write(filepath)` takes only `filepath`). This may be
  intentional (extension/filter handled elsewhere by the framework before
  calling this) or a sign the parameters are vestigial — flagging as
  observed, not asserting which.
- **Confidence**: LOCAL-INSTALL for wrapper logic; RUNTIME-TEST-NEEDED
  for native write internals and whether `fileext`/`filter` matter upstream.

### `MDIClient.__new_client_object__(self, name: str = None)` (private)
- **Signature**: `__new_client_object__(name: str = None) -> None`.
- **Return shape**: `None`. Side effect: closes any existing client object
  (`self.Close(self.__client_object)` — note this is called even when
  `self.__client_object` is `None`, i.e. `Close(None)`; per the `Close` logic
  above, `super().Close(None)` is invoked and the `if self.__client_object`
  guard then correctly no-ops the teardown branch, so this is safe but worth
  noting as an implicit reliance on `Close` tolerating a `None` argument —
  RUNTIME-TEST-NEEDED whether the native `Client.Close` also tolerates
  `None`), increments `self.__client_object_id`, defaults `name` to
  `'MDI Session {id}'` if not given, and constructs a fresh
  `MDIClientObject(self, name)`.
- **Precondition/side-effect**: none beyond being called from `OpenFile`/`New`.
- **Confidence**: LOCAL-INSTALL.

### `MDIClient.__getlogfile__(self) -> str` (private)
- **Signature**: `__getlogfile__() -> str`.
- **Return shape**: absolute path string
  `'<Application.GetSettingsDirectory()>/logs/hwxMDI.<os.getpid()>.log'`.
- **Precondition/side-effect**: creates the `logs` directory via
  `os.makedirs` if it doesn't exist yet (catches `OSError` and prints a
  message on failure — does not raise, so a permissions failure here is
  silently swallowed except for a `print()`, meaning the subsequent
  `SetLogFile` call in `__init__` could be pointed at a directory that
  doesn't actually exist if `makedirs` failed; RUNTIME-TEST-NEEDED for what
  `SetLogFile` does when given a path in a non-existent directory).
- **Confidence**: LOCAL-INSTALL.

---

## 3. `mdi_clientobject.py` — `MDIClientObject(ClientObject, hwTListener)`

Represents one open MDI document/session in the Unified Desktop. Owns the
actual `hw.mdi.standalone.Session`, and lazily wraps MDI entities into
`MDIObject` browser nodes, cached by a synthetic hash key.

### `MDIClientObject.__init__(self, client: Client, name: hwString)`
- **Signature**: `MDIClientObject(client: Client, name: hwString) -> MDIClientObject`.
- **Return shape**: constructs the object; creates
  `self.__session = mdi.Session(name)` where `mdi` is
  `hw.mdi.standalone` (imported locally inside `__init__`, **not** the
  `hw.mdi.isession.Session` used by `mdi_profile_default.py`'s
  `Activate`/`Deactivate` — two different `Session` classes from two
  different submodules are both in play across this plugin;
  RUNTIME-TEST-NEEDED whether `standalone.Session` and `isession.Session` are
  the same underlying object/session or genuinely distinct instances). Also
  initializes `self.__cache = dict()` (entity-hash → `MDIObject` cache),
  `self.__filepath = None`, `self.__callback = None` (the latter assigned but
  never read/written anywhere else in this file — dead attribute, flagging).
- **Precondition/side-effect**: Passing `name` (a session/document display
  name) as the constructor arg to `mdi.Session(name)` implies the standalone
  `Session` constructor takes a name string, consistent with
  `hm/test.py`'s `mdi.Session('hmmdi')` usage pattern documented in the
  native API ref (there, the string looked like a vocabulary name — here it
  looks like a document/session display name instead; RUNTIME-TEST-NEEDED to
  reconcile whether the constructor argument means the same thing in both
  call sites, or is overloaded).
- **Confidence**: LOCAL-INSTALL for the Python wiring; RUNTIME-TEST-NEEDED
  for `hw.mdi.standalone.Session` internals.

### `MDIClientObject.__del__(self)`
- **Signature**: `__del__(self) -> None`. Body is `pass` — an explicit no-op
  destructor. Its only purpose is presumably to suppress default `__del__`
  behavior from a base class, or to exist as a documented placeholder.
  RUNTIME-TEST-NEEDED / not otherwise explained in source.
- **Confidence**: LOCAL-INSTALL (read directly, intent unclear).

### `MDIClientObject.clear(self) -> None`
- **Signature**: `clear() -> None`.
- **Return shape**: `None`. Calls `self.__session.destroy()` then sets
  `self.__session = None`.
- **Precondition/side-effect**: After calling `clear()`, the `.session`
  property will return `None` — any subsequent code (e.g. `MDIClient.Save`)
  that tries to call `.session.write(...)` on a cleared client object will
  raise `AttributeError: 'NoneType' object has no attribute 'write'`. Called
  from `MDIClient.Close`, so this is only safe if nothing else retains a
  reference to a closed client object's `.session`.
- **Confidence**: LOCAL-INSTALL.

### `MDIClientObject.session` (property, read-only)
- **Return shape**: `hw.mdi.standalone.Session` instance, or `None` after
  `clear()` has run.
- **Confidence**: LOCAL-INSTALL.

### `MDIClientObject.filepath` (property, read/write)
- **Return shape**: `str | None`. Plain get/set wrapper around
  `self.__filepath`.
- **Confidence**: LOCAL-INSTALL.

### `MDIClientObject.GetProperty(self, p: Property) -> bool`
- **Signature**: `GetProperty(p: Property) -> bool`. Overrides
  `ClientObject.GetProperty`.
- **Return shape**: `True` and populates `p.valueList` if `p.name` is the
  special framework property `'@ProjectBrowserProperties'` (pushes
  `'Color'`, `'Style'`) or `'@ProjectBrowserActions'` (pushes
  `'Edit_Delete'`, `'Edit_Copy'`); otherwise delegates to
  `ClientObject.GetProperty(self, p)` and returns its result.
- **Precondition/side-effect**: These two `@...` property names are framework
  conventions (Unified Desktop Project Browser queries a client object for
  which generic properties/actions it supports at the top/root document
  level) — RUNTIME-TEST-NEEDED for the exact meaning/effect of `'Color'` and
  `'Style'` in `@ProjectBrowserProperties` (not explained further in source;
  likely controls which columns the Project Browser shows for this document
  type).
- **Confidence**: LOCAL-INSTALL for the code; RUNTIME-TEST-NEEDED for
  framework-side interpretation.

### `MDIClientObject.__getentityhash__(self, entity: Entity) -> str` (private)
- **Signature**: `__getentityhash__(entity: Entity) -> str`.
- **Return shape**: string of the form `"{class_qualname}{entity_id}"`, e.g.
  `"Part42"` — built from
  `mdi.Manager.getclass(entity.GetEntityFullType()).__qualname__` concatenated
  with `entity.GetId()`. Docstring explicitly states the reason: `Entity`
  objects are not hashable, so this string is used as a dict key instead.
- **Precondition/side-effect**: Requires `entity.GetEntityFullType()` and
  `entity.GetId()` (native `hwdescriptor.Entity` methods, RUNTIME-TEST-NEEDED)
  and `hw.mdi.standalone.Manager.getclass(fulltype)` to resolve to a
  registered MDI metaclass with `.__qualname__`.
- **Confidence**: LOCAL-INSTALL for logic; RUNTIME-TEST-NEEDED for the
  native calls it depends on.

### `MDIClientObject._on_entity_create_(self, entity: Entity) -> None`
- **Signature**: `_on_entity_create_(entity: Entity) -> None`. Just calls
  `self.get(entity)` (which lazily creates+caches the `MDIObject` wrapper —
  see below) and discards the return value; the trailing `pass` is dead/
  redundant after the `self.get(entity)` call.
- **Confidence**: LOCAL-INSTALL.

### `MDIClientObject._on_entity_delete_(self, entity: Entity) -> None`
- **Signature**: `_on_entity_delete_(entity: Entity) -> None`.
- **Return shape**: `None`. Looks up the cached `MDIObject` for `entity` by
  hash and calls `.Delete()` on it (a framework `Object` method,
  RUNTIME-TEST-NEEDED, presumably removes it from the Project Browser tree
  and/or triggers GC); silently no-ops (`except KeyError: pass`) if the
  entity was never cached (e.g. delete notification for an entity whose
  browser node was never lazily materialized).
- **Confidence**: LOCAL-INSTALL.

### `MDIClientObject._on_entity_update_(self, entity: Entity, identifier: Identifier) -> None`
- **Signature**: `_on_entity_update_(entity: Entity, identifier: Identifier) -> None`.
- **Return shape**: `None`. If the entity has a cached `MDIObject`
  (`self.get(entity)` — note this call will lazily **create** the wrapper if
  not already cached, since `get()` always materializes on cache miss; so an
  "update" notification for a never-before-seen entity will actually create
  a new browser node rather than being ignored), calls `brobj.EmitModified()`.
  The `identifier` argument (which attribute changed) is accepted but **not
  used** in this method — every update, regardless of which attribute
  changed, triggers a blanket `EmitModified()` on the whole node. Contrast
  with `mdi_profile_assembly.py`'s `_refresh_onpropchange_`, which *does*
  inspect the identifier for `children`/`representations`-specific handling
  — that extra logic lives one layer up (in the Profile, not here).
- **Confidence**: LOCAL-INSTALL.

### `MDIClientObject.get(self, entity: Entity) -> MDIObject`
- **Signature**: `get(entity: Entity) -> MDIObject`.
- **Return shape**: the cached `MDIObject` wrapper for `entity` if present;
  otherwise builds one: fetches the underlying MDI metaobject via
  `self.__session.get(entity)`, resolves its owner via
  `self.__session.getowner(obj)`, and determines the browser-tree `parent` —
  if there's no MDI-level owner, `parent = self` (the `MDIClientObject`
  itself becomes the browser-tree root parent); otherwise looks up the
  *owner's* cached `MDIObject` by hash (**requires the owner to already be
  cached** — see bug note below). Constructs `MDIObject(parent, obj)`,
  calls `brobj.EmitCreated()`, `brobj.__disown__()` (SWIG ownership transfer,
  same idiom as `MDIClient.__init__`), stores it in `self.__cache`, and
  returns it.
- **Precondition/side-effect**: **Latent bug worth flagging**: if
  `self.__session.getowner(obj)` returns a parent entity whose hash is **not
  yet** in `self.__cache` (i.e. the parent's `MDIObject` was never
  materialized before the child's), the line
  `parent = self.__cache[parent_hash]` raises `KeyError` uncaught — there is
  no fallback/recursive `self.get(parent.entity)` call to materialize the
  parent first. This means entity-tree traversal order matters: `get()` is
  only safe to call on entities whose ancestor chain has already been
  visited (top-down), and any code path that calls `get()` on a
  "just-created, deeply-nested" entity before its ancestors have been
  wrapped will crash. Whether this can actually happen depends on whether
  the framework/profile code always processes creation events in
  parent-before-child order — not verifiable from this file alone,
  RUNTIME-TEST-NEEDED.
- **Confidence**: LOCAL-INSTALL for logic and the bug describe above
  (read directly from the unguarded dict index); RUNTIME-TEST-NEEDED for
  whether the bug is actually reachable in practice (depends on event
  ordering guarantees from the native MDI session signal, not visible here).

---

## 4. `mdi_object.py` — `MDIObject(Object)`

The Project-Browser / Property-Editor-facing wrapper around one MDI entity
metaobject. Maps MDI `Attribute` subclasses onto the generic `Property`
protocol used by the hwx property editor.

### `MDIObject._ci` (class attribute)
- **Signature**: `_ci = ClassInfo("MDIObject"); _ci.SetFilterString("MDIObjects")`.
- **Confidence**: LOCAL-INSTALL. RUNTIME-TEST-NEEDED for what
  `ClassInfo`/`SetFilterString` actually register with the framework (native
  `hwtypes.ClassInfo`) — presumably a type-registration/filter-string used by
  generic browser/search UI to group these objects.

### `MDIObject.__init__(self, parent, obj: MDIMetaobject)`
- **Signature**: `MDIObject(parent, obj: 'MDIMetaobject') -> MDIObject`.
  `parent` is either another `MDIObject` or the owning `MDIClientObject`
  (the browser-tree root case, per `mdi_clientobject.get()`'s
  `parent = self` fallback).
- **Return shape**: constructs the node. Calls `super().__init__(parent)`
  (native `Object.__init__`, wiring it into the browser tree under `parent`).
  Sets the node's display-name property to `obj.name_attribute` (an MDI
  metaobject's designated "name" attribute, string). Adds one read-only
  `Property('entity_type')` showing `type(obj).__qualname__`. Then, for every
  visible attribute name on `obj` (`obj.getattributenames(visible=True)`,
  skipping the name attribute itself), builds a `Property(attr.name)` via
  `self.updateProperty(prop, attr)` and adds it if `updateProperty` returned
  `True` (returns `False` for a couple of edge cases inside `updateProperty`
  — those attributes are silently skipped/not shown, see below).
- **Precondition/side-effect**: Requires `obj` to expose `.name_attribute`,
  `.getattributenames(visible: bool) -> Iterable[str]`, and
  `.getattribute(name) -> Attribute`-like objects — all from the compiled
  `hw.mdi.*` metaobject layer (RUNTIME-TEST-NEEDED, same as documented in the
  native API ref).
- **Confidence**: LOCAL-INSTALL for the wrapper; RUNTIME-TEST-NEEDED for
  the underlying metaobject/attribute API it depends on.

### `MDIObject.updateProperty(self, prop: Property, attr: Attribute, *args, **kwargs) -> bool`
- **Signature**: `updateProperty(prop: Property, attr: Attribute, *args, **kwargs) -> bool`
  (the `*args, **kwargs` are accepted but unused in the body).
- **Return shape**: `True` on success (property populated); `False` only in
  two specific failure branches inside the `Matrix44DoubleAttribute`/
  `ListAttribute` case, when reading `attr.value` raises `AttributeError` or
  `TypeError` (caught, logged via `print(...)`, and the property is left
  unadded by the caller). All other attribute-type branches always return
  `True` even if an inner `try/except` around `attr.value` catches an error
  in the generic fallback branch (the `else:` branch at the bottom) — in that
  branch, an `AttributeError`/`TypeError` on `attr.value` is caught and
  `print()`-logged but the function still falls through to `return True` at
  the end (the early `return False` only exists inside the
  `AttributeError` handler for that branch — re-reading the code: actually
  the fallback `else:` branch's `except AttributeError: ... return False`
  IS an early return, but the `except TypeError:` case in that same branch
  prints and then **falls through** to the `prop.allowedValues =
  hwlist`/`prop.readOnly = ...` lines below without returning early or
  re-raising — meaning a `TypeError` on `attr.value` here leaves `prop.value`
  unset from *this* call (whatever it was before) while still marking the
  property as successfully processed. This asymmetry between the
  `AttributeError` and `TypeError` handlers in the same `else` branch is a
  real inconsistency in the source, flagged here, not fixed.
- **Precondition/side-effect**: Dispatches on `type(attr)` across MDI
  attribute subclasses imported from `hw.mdi.attribute` /
  `hw.mdi.entityattribute` (`EntityListAttribute`, `EntityBagAttribute`,
  `EntityAttribute`, `UIntListAttribute`, `TripleDoubleListAttribute`,
  `BoolAttribute`, `Matrix44DoubleAttribute`, `ListAttribute`, and a generic
  fallback for everything else e.g. plain string/numeric/enum attributes).
  For each type it derives a **display-friendly summary value**, not the raw
  attribute value — e.g. entity lists/bags become a count (`len(attr_value)`),
  single entity refs become `.id`, numpy-array-like attributes become
  `.shape[0]` or a shape string, matrices/lists become a flattened
  comma-joined string, bools pass through directly, and generic/enum
  attributes either resolve through `attr.allowables` (an `OrderedDict`
  mapping raw value → display label) or pass `attr.value` straight through.
  Sets `prop.readOnly = not attr.enabled` for `BoolAttribute` and the generic
  fallback branch (all other branches leave `prop.readOnly = True`, set at
  the top of the function — meaning entity refs, lists, matrices are always
  shown read-only in the Property Editor regardless of the underlying
  attribute's actual mutability). Also always sets `prop.category = "General"`
  and `prop.required = attr.mandatory`.
- **Confidence**: LOCAL-INSTALL for all dispatch logic (read directly);
  RUNTIME-TEST-NEEDED for the MDI attribute classes' actual `.value`/
  `.enabled`/`.allowables`/`.mandatory` semantics (compiled).

### `MDIObject.GetName(self) -> str` / `SetName(self, arg2) -> None`
- **Signature**: `GetName() -> str`; `SetName(arg2: hwString) -> None`.
- **Return shape**: `GetName` returns `self.__obj.name`; `SetName` sets
  `self.__obj.name = str(arg2.c_str())` — writes straight through to the
  underlying MDI metaobject's `.name` attribute, no validation.
- **Confidence**: LOCAL-INSTALL.

### `MDIObject.ClassName(self) -> str`
- **Return shape**: literal string `"MDIObject"` always (not `type(self).__name__`
  — so a hypothetical subclass would still report `"MDIObject"` unless it
  overrides this too). Minor observation, not necessarily a bug since there
  are no subclasses of `MDIObject` in this codebase.
- **Confidence**: LOCAL-INSTALL.

### `MDIObject.tr(self, string, context="") -> str`
- **Signature**: `tr(string: str, context: str = "") -> str`. Thin wrapper
  around `Application.Get().TranslateMessage("MDIObject", string, context)` —
  i18n/localization lookup keyed under the `"MDIObject"` translation context.
- **Confidence**: LOCAL-INSTALL for wrapper; RUNTIME-TEST-NEEDED for
  `TranslateMessage` (native).

### `MDIObject.GetProperty(self, prop: Property) -> bool`
- **Signature**: `GetProperty(prop: Property) -> bool`. Overrides `Object.GetProperty`.
- **Return shape**: `True`/`False` depending on branch. Handles framework
  `@`-prefixed pseudo-properties: `@OkToDrag`, `@OkToDrop`, `@OkToDelete`,
  `@OkToRename` all unconditionally return `True` (every `MDIObject` is
  always draggable/droppable/deletable/renameable in the Project Browser —
  no entity-type-specific restriction here, even though `MDIAssembyProfile`
  elsewhere special-cases `PartRoot`/`PartInstance`/etc. for lifecycle
  events; there is no equivalent restriction here for those types being
  non-deletable, for example — worth noting as a possible UI/behavior gap,
  not asserted as wrong). `@Icon` resolves to `"entityFolderOpen-16.png"`
  **regardless of the computed `active` flag** — the code computes
  `active` from an `@IconState` sub-property lookup via
  `self.FillAndGetProperty(p)` but then both the `if active` and `else`
  branches assign the exact same filename
  (`"entityFolderOpen-16.png"`) — **dead/no-op branching, a real source
  inconsistency worth flagging**: whatever `active` evaluates to, the icon
  file is identical either way, so the icon never visually changes state.
  `@ClosedIcon` always resolves to `"browserPublishExternalObject-16.png"`.
  `@ContextMenu` delegates to `self.PopulateContextMenu(prop)`. Any other
  property name is looked up via `self.__obj.getattribute(prop.name)` and, if
  found, delegated to `self.updateProperty`; if not found, delegates to
  `super().GetProperty(prop)`.
- **Precondition/side-effect**: `Application.GetResource(file)` resolves an
  icon-file basename to a full resource path (native, RUNTIME-TEST-NEEDED).
- **Confidence**: LOCAL-INSTALL for all branch logic including the
  `@Icon` dead-branch finding above (read directly, not inferred).

### `MDIObject.SetProperty(self, prop: Property) -> bool`
- **Signature**: `SetProperty(prop: Property) -> bool`.
- **Return shape**: `True` if `prop.name` matches a visible attribute name on
  the wrapped MDI object and the attribute was found/set; else delegates to
  `super().SetProperty(prop)` and uses that result. Note: the trailing
  `if not validProp: validProp = False` is a no-op (assigns `False` to
  something already `False`) — dead code, flagging as a minor
  inconsistency/leftover, not a functional bug.
- **Precondition/side-effect**: For enum-style attributes (`attr.allowables`
  set), reverse-maps the display value back to the raw key via
  `list(od.keys())[list(od.values()).index(prop.value)]` before assignment —
  this will raise `ValueError` if `prop.value` (the display string set by the
  UI) is not exactly one of the display values in `attr.allowables`
  (RUNTIME-TEST-NEEDED whether the UI layer guarantees this, e.g. via a
  combo-box populated from the same `allowables`, which would make a mismatch
  unlikely but not impossible if allowables changed between GetProperty and
  SetProperty calls).
- **Confidence**: LOCAL-INSTALL.

### `MDIObject.PopulateContextMenu(self, prop: Property) -> None`
- **Signature**: `PopulateContextMenu(prop: Property) -> None`.
- **Return shape**: `None`. Pushes a fixed, static list of context-menu entry
  strings onto `prop.valueList`: `A:Edit`, `A:Rename`, `A:Delete`,
  `S:Separator`, `A:Hide`, `A:Show` (`A:` = Action, `S:` = Separator, per the
  format comment in source, which also documents `M:` = Menu and `P:` =
  Property as valid prefixes though none are used here).
- **Precondition/side-effect**: Static/unconditional — every `MDIObject`
  shows the exact same six-item context menu regardless of entity type or
  state (e.g. `Hide`/`Show` are both always present simultaneously, rather
  than toggling based on current visibility — RUNTIME-TEST-NEEDED whether
  `Hide`/`Show` actions themselves are no-ops if inapplicable, since nothing
  here wires them to actual handlers — no `Connect`/`onrun`-style callback
  registration is visible in this file for these actions at all, which
  implies the actual click handling for `Edit`/`Rename`/`Delete`/`Hide`/`Show`
  must be resolved generically by the framework based on the action-string
  name, not by any code in `MDIObject` — RUNTIME-TEST-NEEDED).
- **Confidence**: LOCAL-INSTALL for the static list; RUNTIME-TEST-NEEDED
  for how each menu action is actually wired to behavior.

---

## 5. `mdi_profile_default.py` — `MDIProfile(Profile)`

The always-active base UI profile for the MDI client: docks the Project
Browser / Property Editor / Python Window, and routes native MDI session
lifecycle signals into the `_on_entity_create_/_delete_/_update_` calls on
the active `MDIClientObject`.

### `MDIProfile.__init__(self, plugin: hwString, client: Client)`
- **Signature**: `MDIProfile(plugin: hwString, client: Client) -> MDIProfile`.
- **Return shape**: constructs the profile; calls
  `Profile.__init__(self, 'MDIProfile', 'BaseProfile', plugin)` (profile name
  `'MDIProfile'`, base-profile-name `'BaseProfile'` — presumably the parent
  UI layout this profile extends, native/framework concept,
  RUNTIME-TEST-NEEDED), `self.__disown__()` (same SWIG idiom as elsewhere),
  stores `client`, and forces three dock widgets
  (`'Project Browser'`, `'Property Editor'`, `'Python Window'`) visible via
  `SetDockWidgetVisible(name, True)`.
- **Confidence**: LOCAL-INSTALL for the wrapper; RUNTIME-TEST-NEEDED for
  `Profile`/`SetDockWidgetVisible` native internals.

### `MDIProfile.Activate(self) -> None`
- **Signature**: `Activate() -> None` (annotated `"void"`).
- **Return shape**: whatever `super().Activate()` (native `Profile.Activate`)
  returns, passed through.
- **Precondition/side-effect**: Prints `'ACTIVATE <name>'` (debug print left
  in shipped code, not removed for production — same pattern seen in
  `mdi_profile_assembly.py` and `mdi_profile_smartclipboard.py`, flagging as
  a shared pattern of leftover debug output across this plugin, not a
  functional bug but notable code-quality signal). Gets the (singleton)
  `hw.mdi.isession.Session()` — **constructed with no arguments here**,
  unlike `MDIClientObject`'s `hw.mdi.standalone.Session(name)` constructed
  with a name — and connects its `.signal` to
  `self._on_entity_lifecycle_change_` via `s.signal.Connect(...)`. This is
  the mechanism by which native MDI entity create/delete/update events reach
  Python at all.
- **Confidence**: LOCAL-INSTALL for the wiring; RUNTIME-TEST-NEEDED for
  whether `isession.Session()` (no-arg) and `standalone.Session(name)`
  resolve to the same underlying session object (see also the note under
  `MDIClientObject.__init__` above — this is the second half of that same
  open question).

### `MDIProfile.Deactivate(self) -> None`
- Mirror of `Activate`: disconnects the same signal
  (`s.signal.Disconnect(self._on_entity_lifecycle_change_)`), prints a debug
  line, calls `super().Deactivate()`. Same confidence notes as `Activate`.

### `MDIProfile._on_entity_lifecycle_change_(self, entityupdateinfo: EntityEventInfo) -> None`
- **Signature**: `_on_entity_lifecycle_change_(entityupdateinfo: EntityEventInfo) -> None`.
- **Return shape**: `None` always (every branch ends in a bare `return`).
- **Precondition/side-effect**: This is the raw signal-slot callback fired by
  the native MDI session. Extracts the affected entity ids
  (`entityupdateinfo.GetEntityIdList(idlist)`, populates an `hwUIntList`
  passed by reference — SWIG-style out-parameter, RUNTIME-TEST-NEEDED) and
  the entity type (`GetEntityType()`). Dispatches on
  `entityupdateinfo.GetEventType()`:
  `ENTITY_CREATE_EVENT` → calls `self._on_entity_create_(Entity(fulltype, aid))`
  once per id in the list; `ENTITY_DELETE_EVENT` → same but
  `_on_entity_delete_`; `ENTITY_UPDATE_EVENT` → additionally extracts
  `entityupdateinfo.GetIdentifier()` (which attribute changed) once (**note**:
  fetched once outside the per-id loop, and the same `identifier` is passed
  for every id in the batch — implying the framework batches update
  notifications only when they share one identifier/attribute-change, which
  is a reasonable assumption but not verifiable from this file alone,
  RUNTIME-TEST-NEEDED) and calls `self._on_entity_update_(Entity(fulltype, aid), identifier)`
  per id. Any other/unknown event type falls through to a bare `return`
  (silently ignored).
- **Confidence**: LOCAL-INSTALL for dispatch logic; RUNTIME-TEST-NEEDED
  for the native `EntityEventInfo` methods it depends on.

### `MDIProfile.clientobject` (property, read-only)
- **Signature**: `clientobject -> MDIClientObject`.
- **Return shape**: `ClientManager.Get().GetClient('MDI').client_object` — i.e.
  looks up the framework's global `ClientManager` singleton, fetches the
  registered `'MDI'` client (the `MDIClient` instance constructed by the
  plugin loader), and returns its `.client_object` property (which may itself
  be `None` if no document is currently open — not guarded here, callers must
  handle `None`, and indeed both `_on_entity_update_` below and
  `mdi_profile_assembly.py`'s override do check `if not brobj: return`).
- **Precondition/side-effect**: Requires the `'MDI'` client to already be
  registered with `ClientManager` (true after `mdi_plugin_loader.py` has run).
- **Confidence**: LOCAL-INSTALL for the lookup chain; RUNTIME-TEST-NEEDED
  for `ClientManager.Get()`/`GetClient()` native internals.

### `MDIProfile._on_entity_create_` / `_on_entity_delete_` (thin delegates)
- Both simply forward to the identically-named method on `self.clientobject`
  (`MDIClientObject._on_entity_create_`/`_on_entity_delete_`, documented in
  section 3). **Precondition**: if `self.clientobject` is `None` (no open
  document), these will raise `AttributeError: 'NoneType' object has no
  attribute '_on_entity_create_'` — **not guarded**, unlike
  `_on_entity_update_` immediately below, which does guard with
  `if not brobj: return`. This inconsistency (two of three delegate methods
  unguarded, one guarded) is a real latent bug worth flagging: if a
  create/delete lifecycle event fires while no MDI document is open (or
  during the brief window while one is being closed/replaced), these two
  methods will crash where `_on_entity_update_` would not.
- **Confidence**: LOCAL-INSTALL (read directly — the asymmetric guard is
  visible in source, not inferred); RUNTIME-TEST-NEEDED for whether this
  no-open-document race is actually reachable in the live event ordering.

### `MDIProfile._on_entity_update_(self, entity: Entity, identifier: Identifier) -> None`
- Calls `self.clientobject.get(entity)`; if falsy, returns early (guarded, as
  noted above); otherwise `brobj.EmitModified()`. Note this direct
  implementation on `MDIProfile` is a near-duplicate of
  `MDIClientObject._on_entity_update_` (section 3) — both end up calling
  `.get(entity)` then `.EmitModified()`; the difference is only that
  `MDIClientObject`'s version is called through this delegate chain
  (`_on_entity_lifecycle_change_` → `MDIClientObject._on_entity_update_`
  directly, when `MDIClientObject` itself is the signal target) vs. here
  (`MDIProfile._on_entity_lifecycle_change_` → `MDIProfile._on_entity_update_`,
  which re-fetches via `self.clientobject`) — in practice only one of these
  call paths is actually live per the wiring in `Activate` (the `Profile`'s
  own `_on_entity_lifecycle_change_` is the one connected to the session
  signal, so `MDIClientObject`'s identically-named methods are only reached
  indirectly, via `self.clientobject._on_entity_create_(...)` etc. — i.e.
  `MDIClientObject` never connects its own signal directly in this codebase;
  it is always invoked through `MDIProfile`). Documenting both because both
  exist and are independently readable, but noting the redundancy for anyone
  trying to trace the actual call path live.
- **Confidence**: LOCAL-INSTALL.

---

## 6. `mdi_profile_assembly.py` — `MDIAssembyProfile(MDIProfile)`

**Note**: class name is `MDIAssembyProfile` (missing the second `l` in
"Assembly") — read directly from source, not a transcription error in this
doc; flagging as a minor naming typo in the shipped file, harmless but worth
knowing if grepping for it.

Always-registered second profile (per `MDIClient.__init__`) that adds an
"Exchange" ribbon page and overrides lifecycle handling to skip certain
assembly-internal entity types, plus adds parent/child and representation
tree-refresh logic on specific attribute updates.

### `MDIAssembyProfile.__init__(self, plugin: hwString, client: Client)`
- Same pattern as `MDIProfile.__init__` but registers under profile name
  `'MDIAssembyProfile'` (base `'BaseProfile'`). Same three dock widgets forced
  visible.
- **Confidence**: LOCAL-INSTALL.

### `MDIAssembyProfile.Activate(self) -> None`
- **Signature**: `Activate() -> None`.
- **Return shape**: passthrough of `super().Activate()` (which is
  `MDIProfile.Activate`, i.e. **also** connects the session signal to
  `MDIAssembyProfile`'s own `_on_entity_lifecycle_change_` override — since
  both `MDIProfile` and `MDIAssembyProfile` are simultaneously active
  profiles on the same client per `MDIClient.__init__`, **both profiles'**
  `Activate()` methods run and **both** connect a (different, per-class)
  `_on_entity_lifecycle_change_` handler to the same session signal —
  meaning every entity lifecycle event is handled twice, once by each active
  profile independently. This is directly inferable from reading
  `MDIClient.__init__`'s `AddProfile` calls plus both profiles' `Activate`
  methods; RUNTIME-TEST-NEEDED to confirm both profiles are actually active
  concurrently rather than the framework only running one "current" profile's
  signal wiring at a time — but nothing in `Profile`/`AddProfile` visible
  here suggests exclusivity.
- **Precondition/side-effect**: additionally imports `hw.mdi.cdm.assembly`
  (registers the assembly vocabulary/entity classes — `PartRoot`,
  `PartInstance`, `SubsystemRoot`, `SubsystemInstance`, etc. become known to
  `Manager`) and calls `self.__activateExchangeExtension()` (adds a ribbon
  page `'exchange'` titled `'Exchange'` with one page-group `'Assembly'`,
  sized 180x80 — the actual ribbon buttons/frame for this page-group are not
  populated, `# frame = pagegroup.Frame()` is commented out, so this ribbon
  page is added but effectively **empty** as shipped, flagging as another
  incomplete/placeholder feature).
- **Confidence**: LOCAL-INSTALL for the code; RUNTIME-TEST-NEEDED for the
  dual-signal-handler inference above and for ribbon-page native behavior.

### `MDIAssembyProfile.Deactivate(self) -> None`
- Removes the `'exchange'` ribbon page (`self.RemoveRibbonPage('exchange')`,
  via `__deactivateExchangeExtension`, which also prints a debug line), then
  calls `super().Deactivate()`.
- **Confidence**: LOCAL-INSTALL.

### `MDIAssembyProfile._on_entity_lifecycle_change_(self, entityupdateinfo: EntityEventInfo) -> None`
- **Signature**: overrides `MDIProfile._on_entity_lifecycle_change_`.
- **Return shape**: `None`. If the entity's resolved class qualname
  (`Manager.getclass(fulltype).__qualname__`) is one of
  `['PartRoot', 'PartInstance', 'SubsystemRoot', 'SubsystemInstance']`, the
  event is **dropped entirely** (bare `return`, skipping the base-class
  create/delete/update dispatch for these types) — the comment block
  (`# for aid in idlist: # print(...)`) suggests this was previously a
  debug-print-then-skip and is now just skip. For all other entity types,
  delegates to `super()._on_entity_lifecycle_change_(entityupdateinfo)` (the
  full `MDIProfile` dispatch logic, section 5).
- **Precondition/side-effect**: This means Project Browser nodes/property
  updates are never created/refreshed directly for these four "root/instance"
  assembly bookkeeping types — implies they're intended to be invisible
  plumbing (e.g. internal to how `Part`/`Subsystem` occurrence trees are
  represented) with only the higher-level `Part`/`Subsystem` entities
  surfaced in the UI, consistent with the `children`/`representations`
  special-casing in `_refresh_onpropchange_` below which only acts on `Part`/
  `Subsystem`.
- **Confidence**: LOCAL-INSTALL for the filter list and behavior;
  RUNTIME-TEST-NEEDED for the design rationale (inferred, not stated
  explicitly in source beyond the type-name list itself).

### `MDIAssembyProfile._refresh_onpropchange_(self, entity: Entity, identifier: Identifier) -> None`
- **Signature**: `_refresh_onpropchange_(entity: Entity, identifier: Identifier) -> None`.
- **Return shape**: `None`. Looks up the cached browser node for `entity`
  (`self.clientobject.get(entity)`); if none, returns early. Resolves the
  entity's MDI metaclass qualname and the identifier's attribute name
  (`identifier.GetNameKey()`), **prints both unconditionally** (debug output
  again present in shipped code — every single property-change event prints
  a line, which could be a meaningful performance/log-noise concern on a
  large/busy model, flagging as an observation). If the changed attribute is
  `'children'` and the entity is a `Part` or `Subsystem`: re-fetches the live
  MDI object (`session.get(entity)`), reads its `.children` list, and for
  each child builds an `Entity(obj.fulltype, obj.id)`, looks up/creates its
  browser node via `self.clientobject.get(obj_ent)`, and re-parents it under
  the current node (`brchild.SetParent(brobj)`) then `EmitModified()`s it.
  Same pattern for attribute `'representations'`, using `.representation`
  (**note**: attribute name mismatch — the identifier check is against the
  string `'representations'` (plural) but the actual attribute read off the
  live object is `pobj.representation` (singular) — read directly from
  source, this is either intentional (different name for the getter vs. the
  change-identifier string) or a naming inconsistency; flagging rather than
  assuming which).
- **Precondition/side-effect**: Same latent-parent-not-cached risk as
  `MDIClientObject.get()` (section 3) applies here too, since this method
  calls `.get()` on potentially-new child entities.
- **Confidence**: LOCAL-INSTALL for all logic and the naming-mismatch
  finding (read directly); RUNTIME-TEST-NEEDED for `session.get(entity)`,
  `.children`/`.representation` semantics (compiled MDI layer).

### `MDIAssembyProfile._on_entity_update_(self, entity: Entity, identifier: Identifier) -> None`
- **Signature**: overrides `MDIProfile._on_entity_update_`.
- **Return shape**: `None`. If no cached browser node exists for `entity`,
  delegates straight to `super()._on_entity_update_(...)` (which — per
  section 5 — will call `self.clientobject.get(entity)` again, redundantly
  re-checking the same cache lookup that this override just did, then
  early-return again if still falsy; a harmless but slightly wasteful double
  lookup). If a node **does** exist, calls `self._refresh_onpropchange_(...)`
  (the assembly-specific children/representations handling above) **and
  then still calls** `super()._on_entity_update_(entity, identifier)`
  afterward unconditionally — meaning `EmitModified()` on the top-level
  changed entity's own node always fires via the base-class call, in
  addition to whatever child re-parenting `_refresh_onpropchange_` already
  did.
- **Confidence**: LOCAL-INSTALL.

---

## 7. `mdi_profile_smartclipboard.py` — `MDISCProfile(MDIProfile)`

**Fully implemented but not registered/reachable** — see the "Source
finding" under section 2 (`mdi_client.py`). Documented here in full since the
code itself is real and complete; an AI agent that wants to *re-enable* this
feature would need to uncomment two lines in `mdi_client.py` and could then
rely on the description below.

### `MDISCProfile.__init__(self, plugin: hwString, client: Client)`
- Same pattern as the other two profiles: `Profile.__init__(self, 'MDISCProfile', 'BaseProfile', plugin)`,
  `__disown__()`, forces the same three dock widgets visible. Note the
  ribbon-extension activation call (`self.__activateExchangeExtension()`) is
  **commented out** in `__init__` itself (`# self.__activateExchangeExtension()`)
  — it only actually runs from `Activate()` below, so this commented line in
  `__init__` is dead/redundant, not a functional gap (just leftover).
- **Confidence**: LOCAL-INSTALL.

### `MDISCProfile.Activate(self) -> None`
- Imports `hw.mdi.cdm.geometry` (registers the geometry vocabulary — note,
  different vocabulary than `MDIAssembyProfile`'s `hw.mdi.cdm.assembly`),
  calls `self.__activateExchangeExtension()` (builds the actual ribbon UI,
  see below), then `super().Activate()` (connects the lifecycle signal, per
  `MDIProfile.Activate`, section 5 — **however**, see the override just
  below: this class's own `_on_entity_lifecycle_change_` is a no-op, so
  connecting it has no real effect beyond a debug print).
- **Confidence**: LOCAL-INSTALL.

### `MDISCProfile.Deactivate(self) -> None`
- Removes the `'exchange'` ribbon page, then `super().Deactivate()`.
- **Confidence**: LOCAL-INSTALL.

### `MDISCProfile._on_entity_lifecycle_change_(self, entityupdateinfo: EntityEventInfo) -> None`
- **Signature**: overrides `MDIProfile._on_entity_lifecycle_change_`.
- **Return shape**: `None`. Body is just
  `print('OVERLOADED', self.GetName())` — **entirely discards the event**,
  no create/delete/update dispatch happens at all when this profile's
  handler runs. If this profile were active simultaneously with `MDIProfile`/
  `MDIAssembyProfile` (per the same "profiles run concurrently" inference
  from section 6), this would just be a silent no-op parallel to the other
  two profiles' real handling — i.e. re-enabling this profile would not
  break existing behavior, it would just add an inert third signal
  subscriber. Flagging as confirmed-inert-if-reachable, consistent with it
  being disabled.
- **Confidence**: LOCAL-INSTALL (read directly — this really is the
  entire method body).

### `MDISCProfile.__activateExchangeExtension(self)` (private)
- **Signature**: `__activateExchangeExtension() -> None`.
- **Return shape**: `None`. Builds a ribbon page `'exchange'` / `'Exchange'`
  with a page-group `'Smart Clipboard'` (180x80), containing two exclusive
  sprite-action-groups: `'CopyActionGroup'` (button `'clipboard_copy'`,
  labeled `'Copy'`, tooltip `'Open model from clipboard'`, icon
  `ribbonFileExportStrip-80.png` — **note: tooltip text says "Open" but the
  button is the Copy button; the Paste button below has the semantically
  swapped-sounding tooltip "Run IStudio in batch to update geometry
  representations" — these two tooltip strings look like they may be
  reversed from what a user would expect Copy vs. Paste to say; flagging as
  a possible copy/paste (pun intended) documentation error in the source
  itself, not fixed**) wired to `self._clipboard_copy` via
  `uiaction.GetUiAction().OnActivate().Connect(...)`, and `'PasteActionGroup'`
  (button `'clipboard_paste'`, labeled `'Paste'`, icon
  `ribbonFileImportStrip-80.png`) wired to `self._clipboard_paste`.
- **Confidence**: LOCAL-INSTALL for the UI wiring and the tooltip
  inconsistency (read directly); RUNTIME-TEST-NEEDED for ribbon/sprite-action
  native behavior.

### `MDISCProfile._clipboard_paste(self, *args, **kwargs) -> None`
- **Signature**: `_clipboard_paste(*args, **kwargs) -> None` (accepts, but
  ignores, whatever the `OnActivate` signal passes).
- **Return shape**: `None`. Builds a fixed path
  `~/Documents/SmartClipboard/clipboard.hdf5`, then fetches the registered
  `'MDI'` client via `hwfwg.ClientManager.Get().GetClient('MDI')` and calls
  `client.OpenFile(fl)` (section 2's `MDIClient.OpenFile`) — i.e. "Paste"
  means "open the fixed clipboard HDF5 file as if it were a normal MDI
  session file", **replacing** whatever is currently open (per `OpenFile`'s
  always-create-new-client-object behavior).
- **Precondition/side-effect**: The existence check for the clipboard file is
  **commented out** in source (`# if not os.path.exists(fl) or not
  os.path.isfile(fl): ... return False`) — as shipped, if the clipboard file
  does not exist yet, this calls `client.OpenFile(fl)` anyway, and
  `OpenFile`'s own existence check (section 2) will then catch it and return
  `False` silently — so functionally it's still safe (no crash), just a
  redundant/duplicated check that was disabled here specifically, not a real
  bug, but worth noting as another commented-out guard in this file's
  pattern.
- **Confidence**: LOCAL-INSTALL.

### `MDISCProfile._clipboard_copy(self, *args, **kwargs) -> None`
- **Signature**: `_clipboard_copy(*args, **kwargs) -> None`.
- **Return shape**: `None`. Sequence: (1) saves the *first* client object in
  the framework's client-objects list
  (`client.Save(client.GetClientObjectsList()[0])` — **note**: this indexes
  `[0]` unconditionally; if `GetClientObjectsList()` is empty (no document
  open at all when Copy is clicked), this raises `IndexError` — unguarded,
  flagging as a real latent crash-on-empty-state bug); (2) opens a **new**
  `hw.mdi.standalone.Session()` (yet another bare/no-name `Session()`
  construction, third distinct pattern seen across this plugin alongside
  `isession.Session()` no-arg and `standalone.Session(name)` with a name —
  RUNTIME-TEST-NEEDED whether these are safely independent or interact);
  (3) collects all `PhysicalPrototype` entities in that session
  (`s.collect(PhysicalPrototype)`, imported from `hw.mdi.cdm.geometry`); (4)
  if any exist, imports `StudioBatchUpdater` from
  `hw.mdi.extensions.inspirestudio` and creates one bound to the fixed
  clipboard path (`s.create(StudioBatchUpdater, hdf5=fl)`), then runs it via
  `ctrl.ok.run()` (an `Action`-style `.run()` call, consistent with the
  `Action`/`.onrun` pattern documented in the native API ref). The comment
  `# Should not run IStudio for HM use case` directly above the `Session()`
  construction is a **developer note left in shipped code** flagging that
  this Inspire-Studio-specific code path (`PhysicalPrototype` /
  `StudioBatchUpdater`, both Inspire/geometry-domain concepts) is
  acknowledged by Altair's own developers as **not applicable to the
  HyperMesh use case** — i.e. even when reachable, this branch is explicitly
  documented (by the original author, in-line) as dead weight for a
  HyperMesh-focused workflow like this project's. Worth surfacing prominently
  since it directly answers "is this relevant to Nastran Control Tool" — the
  answer, per Altair's own comment, is no.
- **Confidence**: LOCAL-INSTALL for all of the above, including the
  `IndexError`-on-empty-list finding and the in-source developer comment
  (both read directly, not inferred); RUNTIME-TEST-NEEDED for
  `StudioBatchUpdater`/`PhysicalPrototype`/`s.collect()` native internals.

---

## 8. Summary table

| Item | Kind | File | Confidence |
|---|---|---|---|
| `load()` | function | `mdi_plugin_loader.py` | LOCAL-INSTALL |
| `MDIClient` (`__init__`, `client_object`, `OpenFile`, `New`, `Close`, `Save`, `SaveAs`, `__new_client_object__`, `__getlogfile__`) | class, 9 members | `mdi_client.py` | LOCAL-INSTALL / RUNTIME-TEST-NEEDED for native session read/write |
| `MDIClientObject` (`__init__`, `__del__`, `clear`, `session`, `filepath`, `GetProperty`, `__getentityhash__`, `_on_entity_create_`, `_on_entity_delete_`, `_on_entity_update_`, `get`) | class, 11 members | `mdi_clientobject.py` | LOCAL-INSTALL / RUNTIME-TEST-NEEDED for compiled MDI layer |
| `MDIObject` (`_ci`, `__init__`, `updateProperty`, `GetName`, `SetName`, `ClassName`, `tr`, `GetProperty`, `SetProperty`, `PopulateContextMenu`) | class, 10 members | `mdi_object.py` | LOCAL-INSTALL / RUNTIME-TEST-NEEDED for attribute-type internals |
| `MDIProfile` (`__init__`, `Activate`, `Deactivate`, `_on_entity_lifecycle_change_`, `clientobject`, `_on_entity_create_`, `_on_entity_delete_`, `_on_entity_update_`) | class, 8 members | `mdi_profile_default.py` | LOCAL-INSTALL / RUNTIME-TEST-NEEDED for signal internals |
| `MDIAssembyProfile` (`__init__`, `Activate`, `Deactivate`, `_on_entity_lifecycle_change_`, `_refresh_onpropchange_`, `_on_entity_update_`, plus 2 private ribbon helpers) | class, 8 members | `mdi_profile_assembly.py` | LOCAL-INSTALL |
| `MDISCProfile` (`__init__`, `Activate`, `Deactivate`, `_on_entity_lifecycle_change_`, `__activateExchangeExtension`, `_clipboard_paste`, `_clipboard_copy`, plus deactivate helper) | class, 8 members | `mdi_profile_smartclipboard.py` | LOCAL-INSTALL — **not registered, unreachable as shipped** |

**Total documented items: 1 loader function, 6 classes, 54 methods/properties
across those classes (9 + 11 + 10 + 8 + 8 + 8) — all 7 files fully read and
covered, nothing omitted.**

### Real source bugs/inconsistencies found (flagged, not fixed)

1. **`mdi_client.py`**: `MDISCProfile` (Smart Clipboard profile) is fully
   implemented but its import and `AddProfile` registration are both
   commented out — the feature is dead code as shipped (section 2).
2. **`mdi_clientobject.py` `get()`**: unguarded `self.__cache[parent_hash]`
   lookup assumes the parent entity's browser node was already materialized;
   raises `KeyError` if a child entity is looked up before its ancestor
   chain (section 3).
3. **`mdi_object.py` `updateProperty()`**: asymmetric error handling in the
   generic fallback branch — an `AttributeError` on `attr.value` returns
   `False` early, but a `TypeError` on the same access falls through and
   still returns `True` (section 4).
4. **`mdi_object.py` `GetProperty()`**: the `@Icon` handler computes an
   `active` boolean but both branches of the resulting `if active` assign
   the identical icon filename (`"entityFolderOpen-16.png"`) — the icon
   never actually changes based on state (section 4).
5. **`mdi_profile_default.py`**: `_on_entity_create_`/`_on_entity_delete_`
   are unguarded against `self.clientobject` being `None`, while
   `_on_entity_update_` is guarded — inconsistent null-safety across three
   sibling delegate methods (section 5).
6. **`mdi_profile_assembly.py` `_refresh_onpropchange_`**: checks the change
   identifier against string `'representations'` (plural) but reads the
   live attribute as `pobj.representation` (singular) — naming mismatch,
   intent unclear from source alone (section 6).
7. **`mdi_profile_smartclipboard.py` `_clipboard_copy`**: unguarded
   `client.GetClientObjectsList()[0]` raises `IndexError` if no document is
   open when "Copy" is invoked (section 7) — moot while the profile stays
   unregistered (bug 1), but would be live if someone re-enables it.
8. **`mdi_profile_smartclipboard.py` `__activateExchangeExtension`**: the
   Copy button's tooltip text ("Open model from clipboard") and the Paste
   button's tooltip text ("Run IStudio in batch to update geometry
   representations") read as though they may be swapped from what a user
   would expect for Copy vs. Paste (section 7).
9. **Cross-file**: three different `Session()` construction patterns appear
   across this plugin — `hw.mdi.standalone.Session(name)` (in
   `MDIClientObject.__init__`), `hw.mdi.isession.Session()` no-arg (in
   `MDIProfile.Activate`/`Deactivate`), and `hw.mdi.standalone.Session()`
   no-arg (in `MDISCProfile._clipboard_copy`) — whether these all resolve to
   "the same session" or are independent objects could not be determined
   from Python source alone; flagged as RUNTIME-TEST-NEEDED, not asserted
   either way.

### Explicit "thin or not" assessment

Unlike `hw/python/hm/` (confirmed thin — zero real classes, pure re-export
glue), **this package is not thin**: six real classes with genuine, mostly
non-trivial logic (caching, event routing, UI property mapping, ribbon
wiring) live directly in these seven files. It is UI/plugin-integration code
rather than a general scripting API, but it is substantive, readable Python,
not a bootstrap shim.
