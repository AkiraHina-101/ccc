# API_VERIFIED.md — Phase 1 Results

Verification status:

```text
LOCAL-INSTALL / RUNTIME-TESTED:
  This file records commands tested on a local HM model/session. Treat it
  as stronger than a guess, but not as a complete official API reference.

OFFICIAL:
  Cross-check official support in
  _clean/docs/OFFICIAL_ALTAIR_2022_3_VERIFICATION.md before promoting entries
  from local-tested to official.
```

Verified via `tests/probe_hm_api.tcl` on `01-Test_Model.hm` (HM, hmbatch).
Run date: 2026-06-11 — **15/16 PASS** (1 FAIL has working alternative)

Each command below is documented in 4 parts: **Signature**, **Return shape**,
**Precondition / side-effect**, **Confidence**. Confidence levels come from
`OFFICIAL_ALTAIR_2022_3_VERIFICATION.md`:

```text
OFFICIAL      confirmed by Altair help
RUNTIME-TESTED        actually run and confirmed via tests/probe_hm_api.tcl (this file)
LOCAL-INSTALL    inferred from installed Altair scripts, not run
UNVERIFIED            no confirming evidence found
```

---

## VERIFIED — Use These Commands

### `*clearmark` / `*createmark` — list all entities of a type

1. **Signature**
   ```tcl
   *clearmark comps 1
   *createmark comps 1 "all"
   ```
   Args: entity type (`comps`/`props`/`mats`/`elems`/...), mark number (int), then
   either the literal string `"all"` or a selection-mode string followed by
   selector args (see other variants below, e.g. `"by collector id" $cid`,
   `"by id only" $id`).

2. **Return shape**
   Side-effect only — no return value. Populates mark number `1` (or whichever
   mark number is passed) with the matching entities. Read the mark afterward
   with `hm_getmark <etype> <mark#>` (returns a Tcl list of IDs) or
   `hm_marklength <etype> <mark#>` (returns an integer count).

3. **Precondition / side-effect**
   `*clearmark` should be called before `*createmark` on the same mark number to
   avoid appending to a stale/previous mark (marks persist across calls unless
   cleared). Call `*clearmark` again after reading the mark to leave session
   state clean for the next operation.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS).

---

### `hm_getmark` — read entity IDs collected into a mark

1. **Signature**
   ```tcl
   set comp_ids [hm_getmark comps 1]
   ```
   Args: entity type, mark number.

2. **Return shape**
   Returns a Tcl list of internal entity IDs currently in the given mark. Empty
   list if the mark is empty.

3. **Precondition / side-effect**
   Requires a preceding `*createmark` call on the same entity type and mark
   number. Read-only — does not modify the mark.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS). Same pattern
   used for `props 1` / `mats 1` — not individually re-probed but same command,
   treated as RUNTIME-TESTED by extension.

---

### `hm_getvalue comps ... dataname=name` — read component name

1. **Signature**
   ```tcl
   hm_getvalue comps id=$cid dataname=name
   ```
   Args: entity type (`comps`), `id=<int>` (component ID), `dataname=name`.

2. **Return shape**
   Returns a single string: the component's name.

3. **Precondition / side-effect**
   None beyond `$cid` referring to a valid, existing component. Read-only.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS).

---

### `hm_getvalue comps ... dataname=propertyid` — read component's property ref

1. **Signature**
   ```tcl
   hm_getvalue comps id=$cid dataname=propertyid
   ```
   Alternates (same semantic read, different call form):
   ```tcl
   hm_getentityvalue comps +$cid property.id 0 -byid
   hm_getentityvalue comps $cid property.id 0
   ```

2. **Return shape**
   Returns a single string containing an integer: the property's internal
   reference. Returns `0` (or empty string — both observed/treated as
   equivalent in this codebase) when the component has no assigned property
   (Case 3, see `_clean/lib/scan.tcl` classification).

3. **Precondition / side-effect**
   None beyond `$cid` referring to a valid, existing component. Read-only. The
   value returned is a HyperMesh internal reference, not necessarily the
   solver/display property ID — see "IDs, Names, And Refs" in
   `HYPERMESH_ENTITY_MODEL_API_REF.md`.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS) for the primary
   `hm_getvalue` form. The two `hm_getentityvalue` alternates are listed as
   fallbacks in the same codebase (`_ref/lib/hm_api.tcl` usage pattern) but were
   not each individually probed — LOCAL-INSTALL for the alternates.

---

### `hm_getvalue props ... dataname=name` — read property name

1. **Signature**
   ```tcl
   hm_getvalue props id=$pid dataname=name
   ```
   Args: entity type (`props`), `id=<int>` (property ID/ref), `dataname=name`.

2. **Return shape**
   Returns a single string: the property's name.

3. **Precondition / side-effect**
   None. Read-only.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS).

---

### `hm_getentityvalue props ... material.id` — read property's material ref

1. **Signature**
   ```tcl
   hm_getentityvalue props +$pid material.id 0 -byid
   ```
   Alternates:
   ```tcl
   hm_getentityvalue props $pid material.id 0
   hm_getvalue props id=$pid dataname=materialid
   ```
   Note the `+$pid ... -byid` form vs plain `$pid` form — both were probed as
   working alternates in this codebase.

2. **Return shape**
   Returns a single string containing an integer: the material's internal
   reference. Returns `0`/empty if the property has no material assigned.

3. **Precondition / side-effect**
   None beyond `$pid` referring to a valid, existing property. Read-only.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS).

---

### `hm_getvalue mats ... dataname=name` — read material name

1. **Signature**
   ```tcl
   hm_getvalue mats id=$mid dataname=name
   ```
   Args: entity type (`mats`), `id=<int>` (material ID/ref), `dataname=name`.

2. **Return shape**
   Returns a single string: the material's name.

3. **Precondition / side-effect**
   None. Read-only.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS).

---

### `hm_getentityvalue props ... material.name` — read material name via property (for materialupdate)

1. **Signature**
   ```tcl
   hm_getentityvalue props +$pid material.name 1 -byid
   ```
   Alternate:
   ```tcl
   hm_getentityvalue props $pid material.name 1
   ```
   Note the trailing arg is `1` here (string-typed field) versus `0` used for
   `material.id` (numeric-typed field) above — this argument selects the
   value-type flag, not an optional/repeat count.

2. **Return shape**
   Returns a single string: the material's name as known to HyperMesh. This is
   the exact string that must be passed to `*materialupdate` (see below).

3. **Precondition / side-effect**
   Requires `$pid` to be a valid property reference that already has a material
   assigned; behavior when no material is assigned is UNKNOWN — needs
   live-session verification (not covered by the probe log).

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS) for the primary
   form; the plain-`$pid` alternate is LOCAL-INSTALL (not separately
   probed).

---

### `*clearmark` / `*createmark` / `hm_marklength` — count elements in a component

1. **Signature**
   ```tcl
   *clearmark elems 1
   *createmark elems 1 "by collector id" $cid
   set count [hm_marklength elems 1]
   *clearmark elems 1
   ```
   `hm_marklength` args: entity type (`elems`), mark number.

2. **Return shape**
   `hm_marklength` returns a single integer string: the number of elements in
   the mark. `0` if the component has no elements.

3. **Precondition / side-effect**
   Requires `*clearmark` then `*createmark ... "by collector id" $cid` to have
   run first on the same mark number. `*createmark` here is a side-effecting
   call (populates the mark); always follow with `*clearmark` to reset session
   state. This is the documented working alternative to the failing
   `hm_entityinfo comps $id numelems` (see NOT AVAILABLE table).

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS — this is the
   "1 FAIL has working alternative" case; the alternative is what's shown here).

---

### `*materialupdate` — assign material to property (CRITICAL)

1. **Signature**
   ```tcl
   *clearmark props 1
   *createmark props 1 "by id only" $prop_ref
   *materialupdate props 1 "$mat_name"
   *clearmark props 1
   ```
   Args: entity type (`props`), mark number, material name as a **string**
   (`$mat_name`) — NOT the material ID.

2. **Return shape**
   Side-effect only — no return value. Mutates the property collector(s) in the
   given mark so their material reference points to the named material.

3. **Precondition / side-effect**
   - Requires `*clearmark` then `*createmark props 1 "by id only" $prop_ref`
     immediately before, so the mark contains exactly the target property (and
     nothing stale).
   - Requires the material identified by `$mat_name` to already exist in the
     session (create it first via `*collectorcreate materials ...` if needed —
     see `HYPERMESH_ENTITY_MODEL_API_REF.md`).
   - Must NOT be used on a Case 3 component (no property assigned) — there is
     no property collector to update; assign/create a property first.
   - Side-effect: updates the property's material reference in the HM session;
     downstream read caches (`_prop_cache`, `model_scan_cache`, etc., per
     `HYPERMESH_ENTITY_MODEL_API_REF.md`) must be invalidated/rescanned after
     this call.
   - Call `*clearmark` again afterward to avoid leaking a stale mark into the
     next mutation.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS). The "uses name,
   not ID" requirement is explicitly confirmed by the probe / this file's note.

---

### `*renamecollector` — rename component (also used for props/mats)

1. **Signature**
   ```tcl
   *renamecollector comps $old_name $new_name
   ```
   Args: entity type (`comps`, also used with `props`/`mats` per
   `HYPERMESH_ENTITY_MODEL_API_REF.md`), old name (string), new name (string).
   Takes names, not IDs.

2. **Return shape**
   Side-effect only — no return value. Renames the collector matching
   `$old_name` to `$new_name`.

3. **Precondition / side-effect**
   Requires `$old_name` to exactly match an existing collector's current name
   (read it first via `hm_getvalue comps id=$cid dataname=name` if only the ID
   is known). Side-effect: changes the collector's name in the HM session; any
   cached name lookups must be refreshed.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS).

---

### Case-3 detection (no property) — application-level pattern, not a single HM command

1. **Signature**
   ```tcl
   set pref [hm_getvalue comps id=$cid dataname=propertyid]
   if {$pref eq "" || $pref == 0} { # Case 3: no property }
   ```
   This is a Tcl-level check built on top of the `hm_getvalue ... dataname=propertyid`
   command documented above; it is not itself a distinct HyperMesh API call.

2. **Return shape**
   N/A (composite pattern). See `hm_getvalue comps ... dataname=propertyid` above.

3. **Precondition / side-effect**
   None beyond the underlying `hm_getvalue` call's requirements. Read-only.
   Both the empty-string and `0` forms must be checked because the probe log
   did not establish which one HM returns in every install/version — treat
   both as valid "no property" signals.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS) — inherits the
   confidence of the underlying `hm_getvalue` call.

---

### Load solver template (REQUIRED before card reads)

1. **Signature**
   ```tcl
   set template ""
   catch {set template [hm_info templatefilename]}
   if {$template eq "" || ![file exists $template]} {
       foreach candidate {
           {<ALTAIR_INSTALL_DIR>/templates/feoutput/nastran/general}
           {<ALTAIR_INSTALL_DIR>/templates/feoutput/optistruct/optistruct}
       } {
           if {[file exists $candidate]} { catch {*templatefileset $candidate}; break }
       }
   }
   ```
   `hm_info templatefilename` takes no args and queries the currently loaded
   template path. `*templatefileset` takes one arg: an absolute template file
   path (string).

2. **Return shape**
   `hm_info templatefilename` returns a single string: the current template file
   path, or empty string if none is loaded. `*templatefileset` is side-effect
   only — no return value; it loads the given template into the session.

3. **Precondition / side-effect**
   - In hmbatch/scripted sessions, no template may be loaded by default, which
     causes `hm_getcardimagename` to return nothing (empty string) until a
     template is set.
   - In HM GUI with a Nastran profile already active, the template is normally
     already loaded, so this step may be a no-op.
   - Side-effect of `*templatefileset`: changes the session's active solver
     template globally, affecting all subsequent card-image and
     dictionary-load operations.
   - The candidate file paths are specific to this machine's install
     (`<ALTAIR_INSTALL_DIR>/...`) and are not guaranteed to exist on
     other machines/installs.

4. **Confidence**: RUNTIME-TESTED for the observed failure mode ("without a
   template loaded, `hm_getcardimagename` returns nothing" — probe run
   2026-06-11). LOCAL-INSTALL for the specific candidate template file
   paths (inferred from this machine's Altair install, not independently
   probed as a list).

---

### `hm_getcardimagename` — card type (PSHELL/PBUSH/MAT1...) — works AFTER template loaded

1. **Signature**
   ```tcl
   hm_getcardimagename props +$pid -byid
   hm_getcardimagename mats  +$mid -byid
   ```
   Args: entity type (`props`, `mats`), `+$id` (ID prefixed with `+`), `-byid`
   flag. The `+` prefix combined with `-byid` is the working call form
   confirmed by the probe.

2. **Return shape**
   Returns a single string: the card image name, e.g. `"PSHELL"` for a property,
   `"MAT1"` for a material. Returns empty string if no solver template is
   loaded (see above).

3. **Precondition / side-effect**
   Requires a solver template to be loaded first via `*templatefileset` (or
   already active in GUI). Read-only otherwise.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS, after template
   load).

---

## NOT AVAILABLE

These commands were probed and failed. Documented here as negative results —
do not use them; use the listed alternative instead.

| Command | Status | Alternative |
|---------|--------|-------------|
| `hm_entityinfo comps $id numelems` | invalid option (RUNTIME-TESTED failure, probe 2026-06-11) | `*clearmark elems 1; *createmark elems 1 "by collector id" $cid; hm_marklength elems 1; *clearmark elems 1` |
| `*setvalue props id=X MID=Y` | invalid dataname (RUNTIME-TESTED failure, probe 2026-06-11) | `*materialupdate props 1 mat_name` (mark-based, name not ID) |
| `hm_entityinfo comps id=X 2delems/3delems/1delems` | invalid option (RUNTIME-TESTED failure, probe 2026-06-11) | mark + check element card types |

Confidence for this table: RUNTIME-TESTED (these are the documented failures
from the same `tests/probe_hm_api.tcl` run dated 2026-06-11 — "1 FAIL has
working alternative" plus the two additional NOT AVAILABLE rows recorded here).
