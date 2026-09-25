# HyperMesh -> HyperStudy Integration Bridge

## Verification status

- Real Tcl source read in full: `hsmain.tcl`, `hsutilities.tcl`, `hsnastran.tcl`,
  `hsimportvariables.tcl`, `hswritesolverinputdeck.tcl` from
  `<ALTAIR_INSTALL_DIR>/hm/scripts/HyperStudy/` (15 files in
  that folder total; the remaining 10 are solver-profile variants of the same
  `GetHSModelParametersFromHM`/`UpdateDV`/`SetValue` pattern for
  abaqus/ansys/lsdyna/radioss/radioss_hf/dyna_hf/pamcrash2g/hxsolver/mfsolver —
  read via `proc ` grep across all 15, not opened line-by-line since they
  duplicate the Nastran-file structure with different attribute-index tables).
- Live probe run against `hmbatch.exe -tcl` with `01-Test_Model.hm` loaded
  under the real `nastran/general` template
  (`_clean/tests/probe_hyperstudy_domain.tcl`,
  `_clean/tests/probe_hyperstudy_domain_result.txt`):
  - Confirmed **no** `*hs*`/`*HyperStudy*`/`*hmhs*`/`*DesignVar*` native Tcl
    commands exist in a stock HyperMesh Tcl interpreter — this entire layer is
    plain-text `.tcl`/`.tbc` source that HyperStudy's task runner sources into
    a fresh `hw.exe`/`hmbatch.exe` process, not a compiled command family.
  - Confirmed `*desvar*`/`*parameter*` native commands that DO exist are a
    **different, unrelated** API: the OptiStruct/RADIOSS topology-optimization
    design-variable commands (`*sizedesvarcreate`, `*topologydesvarcreate`,
    `*desvarlinkcreate`, etc.) and the generic HyperMesh "Parameters" entity
    API (`*setparameter`, `*unsetparameter`, `hm_isentitydatanameparameterized`).
    These are real and callable, but they are **not** what
    `hsmain.tcl`/`hsnastran.tcl` use to talk to HyperStudy — see "Two separate
    meanings of 'design variable'" below.
  - Confirmed `source`-ing `hsmain.tcl` + `hsutilities.tcl` + `hsnastran.tcl`
    directly in a live session works and defines `::HyperStudy::*` procs
    (this is exactly what `hsimportvariables.tcl`/`hswritesolverinputdeck.tcl`
    do internally via `::hwt::SourceFile`).
  - Confirmed live, in order, on a real `PSHELL` property (`props id=1`) from
    `01-Test_Model.hm`: `hm_isentitydatanameparameterized props 1 95 -1 -1 0`
    returns `0` (not parameterized) -> `*createentity parameter
    name=probedvtest` + `*setvalue parameter name=probedvtest
    valuedouble=1.5` succeed -> `*setparameter probedvtest props 1 95 -1 -1 0`
    succeeds -> `hm_isentitydatanameparameterized props 1 95 -1 -1 0` now
    returns `1`. This is the real, minimal, live-verified version of what
    `::HyperStudy::createandsetparameter` (`hsmain.tcl:2133`) automates.
  - `::HyperStudy::GetPropType 1` returned `PSHELL` correctly against the real
    model (confirms the attribute-index tables in `hsnastran.tcl` are wired to
    real card types, not placeholders).
  - `*createentity parameter name=probe_dv_test` (with an underscore) fails
    live with `Error: The parameter name can have only alphanumeric
    characters` — parameter names are alphanumeric-only, underscores/hyphens
    rejected. Not documented anywhere else in this repo's docs; noted here
    since a naive agent generating parameter names from entity labels
    (which often contain underscores) will hit this.
  - `hm_getparameterinfo`, `hm_getparametervalue`, `hm_parameterinfo` do
    **not** exist as native commands (checked, all return 0 command matches).
- **Tier: mixed LOCAL-INSTALL (source-read of all HyperStudy task
  scripts) + RUNTIME-TESTED (the `*createentity parameter` /
  `*setvalue parameter` / `*setparameter` /
  `hm_isentitydatanameparameterized` chain, and the `*hs*`/`*desvar*`/
  `*parameter*` command-existence survey, both live-verified against
  `01-Test_Model.hm`).** No official Altair public help page for this
  specific task-script layer was found; it is documented only via the
  installed source and the in-file comment banners (which are themselves
  Altair's own developer comments, quoted below).

## Big picture: this is a file/task bridge, not a live in-process API

There is no persistent "HyperMesh <-> HyperStudy" IPC channel and no set of
native Tcl commands an agent can call from an already-running HyperMesh
session to push values into HyperStudy or pull design variables back. Instead,
HyperStudy launches **one-shot batch HyperMesh/hw processes**, each running a
single task script end-to-end, communicating entirely through files:

```
HyperStudy                          HyperMesh/hw batch process
-----------                          ---------------------------
writes task__imp_input.xml   ----->  hw.exe -tcl hsimportvariables.tcl
  (points at the .hm file,             reads task__imp_input.xml
   where to write the .hstp)           loads the .hm file (*readfile)
                                        shows the HM<->HSt parameter picker
                                          dialog (::HyperStudy::BuildDialog)
                                        user selects entities/attributes to
                                          expose as design variables
                              <-----  writes <model>.hstp  (parameter defs +
                                        solver/analysis metadata)

writes hst_input.hstp        ----->  hmbatch.exe -tcl hswritesolverinputdeck.tcl
  (one row per design var,             reads hst_input.hstp (via tdom XML
   this run's actual value)             parsing of ModelParameter/Value pairs)
                                        *readfile the .hm model
                                        ::HyperStudy::SetParameterValue for
                                          each row -> dispatches into the
                                          per-solver-profile UpdateDV/Update*
                                          procs (hsnastran.tcl etc.), which
                                          call real mutating Tcl commands
                                          (*attributeupdatedouble, etc.)
                              <-----  *feoutputwithdata writes the solver
                                        deck (.fem/.bdf/...) with the design
                                        variable's value baked in
```

This means:

- **Import phase** (`hsimportvariables.tcl`, task type `Import`): a
  human-interactive dialog inside a batch `hw.exe` process, not something an
  automation script can drive headlessly without also faking the dialog
  callbacks. Produces a `.hstp` (HyperStudy Parameter Definition, schema
  `hstp_v_5`) file.
- **Write phase** (`hswritesolverinputdeck.tcl`, task type `Write`): fully
  scriptable/headless — reads a `.hstp` with concrete values, applies them to
  the loaded model via real mutating commands, then writes a solver deck. This
  is the phase relevant to an agent that already knows which properties/
  materials/loads it wants to sweep and just needs the write-back mechanism.
- Every task script is invoked as **a brand-new `hw.exe`/`hmbatch.exe`
  process** per run (see file header comments in both scripts, quoted
  verbatim below), communicating only via the environment variable
  `HST_TASK_INPUT` (path to the task's input XML) and the files it points to.
  There is no long-lived shared state between HyperStudy runs beyond what is
  written to disk.

Source comment banner from `hsimportvariables.tcl` (verbatim, confirms the
contract above):

```
#      `hw.exe -clientconfig hwfepre.dat -nouserprofiledialog -tcl <installDir>/hm/scripts/HyperStudy/hsimportvariables.tcl/.tbc`
#     1) This script is to reference the environment variable ${::env(HST_TASK_INPUT)} which points to the file task__imp_input.xml
#        1.1) <Varname>PathResource</Varname>  The value associated with this is the .hm file to be loaded
#        1.2) <Varname>PathImportHstp</Varname> The value associated with this argument is the .hstp file to be written later
```

Source comment banner from `hswritesolverinputdeck.tcl` (verbatim):

```
# This script is being invoked to drive hmbatch to:
#     - set user profile    ( *templatefileset "..." )
#     - load a .hm file     ( *readfile "....hm"  )
#     - update variables    ( *attributeupdatedouble properties x x x x )
#     - write a solverdeck  ( *feoutputmergeincludefiles 0 )
#                           ( *feoutputwithdata "<installdir>/templates/feoutput/<properTemplate>" "<studyDir>/approaches/<location_xxx>/run__00xxx/m_1/beam.fem" 0 0 1 1 0
#   hmbatch -tcl <altair_home>\hm\scripts\HyperStudy\hswritesolverinputdeck.tcl/tcb
```

## Two separate meanings of "design variable" (do not conflate)

This repo already documents (`HYPERMESH_ENTITY_TYPE_INDEX.md`,
`HYPERMESH_DATANAME_INDEX.md` Track 4) the entity types `designvars`,
`desvarlinks`, `dequations`, `optiresponses`, `dvprels`. Those, and the native
`*sizedesvarcreate`/`*topologydesvarcreate`/`*desvarlinkcreate`/
`*compositesizedesvarcreate`/etc. commands confirmed live in this probe, are
the **OptiStruct/RADIOSS structural-optimization** design variable system
(size/shape/topology/gauge/free-size/composite optimization DVs written as
`DESVAR`/`DVPRELx`/`DEQUATION`/`DRESPx` Nastran-format bulk data cards). That
system is entirely separate from HyperStudy.

The HyperStudy bridge documented in this file uses a **different, generic**
mechanism: HyperMesh's "Parameters" entity type (`*createentity parameter`,
`*setvalue parameter ... valuedouble=...`, `*setparameter <name> <entity_type>
<entity_id> <attribute_id> <row> <col> <array_index>`,
`hm_isentitydatanameparameterized`). A HyperStudy "design variable" is
implemented as one of these generic `parameter` entities linked by
`*setparameter` to a specific attribute on a specific entity (a property's
thickness field, a material's `E`/`RHO`, a load's magnitude, etc.) — it has
nothing to do with the `DESVAR` bulk-data-card optimization system and does
not create/require `designvars`/`dvprels`/`dequations` entities at all. An
agent should not assume OptiStruct DV entities and HyperStudy parameters are
interchangeable, and should not try to feed one system's IDs into the other.

## Command reference

### 1. `*createentity parameter name=<name>`

- **Signature:** `*createentity parameter name=<alphanumeric_name>` — creates
  a new HyperMesh `parameter` entity. Optional immediate ID assignment via a
  follow-up `*setvalue parameter name=<name> id=<id>`.
- **Return shape:** none (Tcl command, no return value); check success via
  `hm_entityinfo exist parameter <name> -byname`.
- **Precondition/side-effect:** requires a solver template already loaded
  (`*templatefileset`) — same precondition as most create/mutate commands in
  this repo's other docs. Name must be **alphanumeric only**; live-tested
  underscore in the name (`probe_dv_test`) fails with `Error: The parameter
  name can have only alphanumeric characters`. Live-tested plain alphanumeric
  name (`probedvtest`) succeeds. `hm_entitymaxid parameters` / auto-name
  helpers exist in `hsmain.tcl:createandsetparameter` (auto-generates
  `param<maxid+1>`, then `hm_getincrementalname` if that collides) — reuse
  that pattern rather than deriving names from entity labels, which often
  contain underscores/spaces that this command rejects.
- **Confidence: RUNTIME-TESTED** (live, `01-Test_Model.hm`).

### 2. `*setvalue parameter name=<name> valuedouble=<value>`

- **Signature:** sets the scalar double value carried by a `parameter`
  entity.
- **Return shape:** none; read back via
  `hm_getvalue parameter name=<name> dataname=valuedouble`.
- **Precondition/side-effect:** the named `parameter` entity must already
  exist (created via `*createentity parameter` above). Live-verified round
  trip: set `1.5`, read back `1.5`.
- **Confidence: RUNTIME-TESTED.**

### 3. `*setparameter <paramName> <entityType> <entityId> <attrId> <row> <col> <arrayIndex>`

- **Signature:** links a `parameter` entity to a specific attribute slot on a
  specific entity, so that entity's attribute value is driven by the
  parameter. `<row>`/`<col>` are `-1`/`-1` for a plain scalar attribute (as in
  the live probe against `props id=1` attribute `95` = PSHELL thickness
  field, per `hsnastran.tcl:UpdateThickness`'s own `95` constant for PSHELL);
  non-`-1` row/col select one entry in an array attribute (see PCOMP handling
  below).
- **Return shape:** none; check success via
  `hm_isentitydatanameparameterized <entityType> <entityId> <attrId> <row>
  <col> <arrayIndex>`, which flips from `0` to `1`.
- **Precondition/side-effect:** the parameter must already exist. Live probe:
  before linking, `hm_isentitydatanameparameterized props 1 95 -1 -1 0` = `0`;
  after `*setparameter probedvtest props 1 95 -1 -1 0`, the same call returns
  `1`. Errors with `Error: Parameters specified not found in model.` if the
  named parameter does not exist yet — order matters (create/setvalue before
  setparameter).
- **Sibling commands** (source-confirmed, not independently live-tested):
  `*setparametermark` (mark-based batch variant), `*unsetparameter` /
  `*unsetparametermark` (remove the link).
- **Confidence: RUNTIME-TESTED** (link + existence-flag flip); sibling
  mark/unset variants **LOCAL-INSTALL** (source-confirmed to exist, not
  independently exercised).

### 4. `hm_isentitydatanameparameterized <entityType> <entityId> <attrId> <row> <col> <arrayIndex>`

- **Signature:** query — returns `1` if the given attribute slot currently has
  a parameter linked via `*setparameter`, else `0`.
- **Return shape:** integer `0`/`1`.
- **Precondition/side-effect:** read-only, no precondition beyond the entity
  existing. Live-verified both states (before/after link) on a real PSHELL
  property.
- **Confidence: RUNTIME-TESTED.**

### 5. `::HyperStudy::createandsetparameter {entitytype entityid attrid row col paramValue {paraName ""} {paraId 0}}`

- **Signature:** (`hsmain.tcl:2133`) the actual proc HyperStudy's parameter
  dialog uses to wrap commands 1-3 above into one call: auto-generates a name
  if `paraName` is empty (colliding names get `hm_getincrementalname`'d),
  handles the LS-DYNA `PARAMETER` card-image special case
  (`*createentity parameter name=$paraName cardimage=PARAMETER` when the
  loaded template is `dyna.key`/`dyna.lrg`/`dyna.seq`), sets the value, then
  calls `*setparameter`.
- **Return shape:** returns the final `paraName` string used (which may differ
  from the requested one if it collided).
- **Precondition/side-effect:** same as commands 1-3 combined; requires
  `hsmain.tcl` to be sourced into the session (not present in a stock
  HyperMesh Tcl interpreter — see "Big picture" above).
- **Confidence: LOCAL-INSTALL** (source-read; not independently
  re-implemented/tested beyond confirming its constituent primitive calls
  work — see items 1-4).

### 6. `::HyperStudy::GetPropType {propId}` (and per-solver siblings `GetMatType`, `GetLoadType`, `GetCompType`, `GetLoadcolType`, `GetGroupType`, `GetControlVolType`)

- **Signature:** (`hsnastran.tcl:636`, one dialect per solver-profile file)
  `hm_getvalue props id=$propId dataname=config` / `cardimage`-style lookup
  wrapped as a plain string classifier, returning e.g. `"PSHELL"`, `"PCOMP"`,
  `"PBUSH"`, `"HM_ELAS"`.
- **Return shape:** string card-type name, or empty string if unrecognized.
- **Precondition/side-effect:** read-only. Live-verified:
  `::HyperStudy::GetPropType 1` returned `PSHELL` against the real
  `01-Test_Model.hm` property 1.
- **Confidence: RUNTIME-TESTED** (Nastran variant only; sibling
  radioss/lsdyna/abaqus/ansys files' `GetPropType`/`GetMatType`/etc. are
  **LOCAL-INSTALL**, source-read only, not live-probed since this
  project is Nastran-focused).

### 7. `::HyperStudy::UpdateDV {dvName entName subentityName entId varvalue}` (per-solver, `hsnastran.tcl:820` for Nastran)

- **Signature:** the actual write-back dispatcher called once per design
  variable during `hswritesolverinputdeck.tcl`'s `SetParameterValue` ->
  `UpdateDV` chain. Switches on `dvName` (`Materials`/`FORCE`/`MOMENT`/`LOAD`)
  and, for materials, on `GetMatType` (`MAT1`/`MAT2`/`MAT8`/`MAT9`) to resolve
  the correct raw HyperMesh attribute-index number, then calls a real mutating
  command:
  - Materials -> `*attributeupdatedouble MATERIAL $entId $attnum 1 1 0
    $varvalue` (attribute index hard-coded per property, e.g. MAT1 `E`=1,
    `G`=2, `NU`=3, `RHO`=4; MAT8 `E1`=196 ... `RHO`=202; MAT9 has 21
    Gij+RHO indices 215-236 — see source for the full table, not repeated
    here since it is purely a raw-index lookup table with no additional
    semantics).
  - `FORCE`/`MOMENT` -> `*createmark loads 1 "by id only" $entId` +
    `*loadsupdate 1 <1|2> 1 0 1 0 0 0 0 0 1 $varvalue 0 0 1` +
    `hm_markclear loads 1`.
  - `LOAD` (a `loadcols` "S" scale-factor array) -> either
    `*attributeupdatedouble loadcols $entId 379 1 1 0 $varvalue` (for `S0`) or
    an array-rebuild-and-write via `*createdoublearray` +
    `*attributeupdatedoublearray loadcols $entId 380 1 2 0 1 $loadnumsets`
    (for `S1`, `S2`, ...).
- **Return shape:** none (mutating command).
- **Precondition/side-effect:** **mutates the live model** — this is the real
  write-back path, not a dry run. Requires the target entity to exist and be
  of the expected card type; no validation beyond the `switch`/`if` dispatch
  (unrecognized `matType`/`dvName` silently does nothing — `attnum` stays
  unset and the final `*attributeupdatedouble` line would error on an unset
  variable, i.e. this is not gracefully handled for unknown card types).
- **Confidence: LOCAL-INSTALL** (source-read; the underlying primitive
  commands `*attributeupdatedouble`/`*loadsupdate`/`*createmark`/
  `hm_markclear` are already RUNTIME-TESTED elsewhere in this repo's docs —
  see `HYPERMESH_ENTITY_MODEL_API_REF.md` — but this specific dispatch/index
  table was not independently re-exercised end-to-end in this session).

### 8. `::HyperStudy::UpdateThickness` / `UpdatePlyAngles` / `UpdateStiffness` / `UpdateMass` (property/element write-back, `hsnastran.tcl:713-818`)

- **Signature:** same dispatch pattern as `UpdateDV`, keyed by `GetPropType`
  instead of `GetMatType`:
  - Thickness: PSHELL -> `*attributeupdatedouble props $id 95 1 1 0 $val`;
    PSHEAR -> attribute `91`; PCOMP/PCOMPG -> array rebuild via
    `hm_attributearrayvalue props $id \$PCOMP_T $r_index -byid` for every
    other layer + `*createdoublearray`/`*attributeupdatedoublearray props
    $id 3024 1 2 0 1 $array_length` (single-value writes into a
    multi-layer array are implemented as read-all-then-rewrite-all, not a
    single-cell write).
  - Ply angles: same array-rebuild pattern against attribute `3025`
    (`$PCOMP_THETA`).
  - Stiffness: HM_ELAS -> attribute `610+index`; PBUSH -> attribute
    `844+index`; PELAS -> attribute `84`; element-level (`ELEMENTS` entity
    type) -> attribute `175`.
  - Mass: element-level only -> `*createmark elements 1 $entId` +
    `*masselementupdate 1 1 $varvalue 0 "" 0 0` + `hm_markclear elements 1`.
- **Return shape:** none (mutating).
- **Precondition/side-effect:** same live-mutation caveat as `UpdateDV`; the
  PCOMP/PCOMPG array-rebuild path additionally depends on
  `GetNumberOfThickness`/`GetNumberOfPlyAngles` (attribute-count queries) being
  correct for the property's actual layer count.
- **Confidence: LOCAL-INSTALL** (source-read only in this session; the
  scalar PSHELL/PSHEAR/PELAS paths reuse `*attributeupdatedouble`, already
  RUNTIME-TESTED elsewhere; the PCOMP array-rebuild and mass/element paths
  were not independently re-exercised here).

### 9. `::HyperStudy::mainTask__Import` / `mainTask__Write` (top-level task entry points)

- **Signature:** the two functions actually invoked by HyperStudy's task
  runner (`hsimportvariables.tcl`/`hswritesolverinputdeck.tcl` end with a call
  to one of these). Both: read the task's input XML (env var
  `HST_TASK_INPUT` for import; `task__wri_input.xml` in the model dir for
  write) via `tdom`, `*readfile` the `.hm` model with `hm_answernext yes`,
  then either open the parameter-picker dialog (import) or loop
  `SetParameterValue` over every row (write), then close/log.
- **Return shape:** none (entry point, drives the whole batch process to
  completion or logs an error and exits).
- **Precondition/side-effect:** full-process side effects — loads a model,
  mutates it (write path), and for the write path this is expected to run to
  completion in a single `hmbatch.exe` invocation with no further export step
  needed beyond whatever `*feoutputwithdata` call HyperStudy's outer PDD
  config wires up after `mainTask__Write` returns (that final export call
  itself is not shown inside these two files' `proc` bodies — the header
  comment in `hswritesolverinputdeck.tcl` names `*feoutputmergeincludefiles`/
  `*feoutputwithdata` as the intended write step, but the actual call site is
  generated/injected by HyperStudy's PDD template rather than hard-coded in
  this `.tcl` file).
- **Confidence: LOCAL-INSTALL** (source-read; requires the full
  HyperStudy environment-variable/XML contract to exercise live, which is out
  of scope for a HyperMesh-only probe in this session).

## Practical guidance for an agent automating this bridge

- If the goal is **"expose HyperMesh entities as HyperStudy design
  variables"**: this is a one-time, typically interactive setup step
  (`hsimportvariables.tcl`'s dialog) that writes a `.hstp` file — not
  something worth reverse-engineering into a headless Tcl call sequence
  unless the exact same commands 1-4 above are driven directly (skip the
  HyperStudy dialog entirely and call `*createentity parameter` /
  `*setvalue parameter` / `*setparameter` yourself against known
  entity/attribute IDs, which is fully scriptable and live-verified in this
  file).
- If the goal is **"given a design-variable value from an external
  optimizer/DOE loop, mutate the model and write a solver deck"**: this is
  the `hswritesolverinputdeck.tcl` / `UpdateDV` / `Update*` path, and it is
  fully headless-scriptable — but note it mutates the live model with no
  rollback, matching the general live-mutation caution already documented
  project-wide in `HANDOFF.md`'s Risk Register (P0 item 16: "Live card-field
  mutation must stay disabled until card-specific validation exists" — the
  attribute-index tables in `hsnastran.tcl` are exactly the kind of
  card-specific mapping that register entry is warning about, applied to a
  different entry point).
- Do not confuse this file's `parameter`/`*setparameter` mechanism with the
  `designvars`/`dvprels`/`dequations`/`optiresponses` OptiStruct entity types
  already covered by Track 4 dataname coverage — see "Two separate meanings
  of 'design variable'" above.
- `*createentity parameter name=<name>` requires alphanumeric-only names;
  sanitize any entity-derived label before using it as a parameter name.
