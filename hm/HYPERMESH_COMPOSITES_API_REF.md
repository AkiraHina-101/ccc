# HyperMesh Composites (Ply / Laminate) Automation API Reference

Purpose: AI-readable reference for the Tcl automation surface around
composite ply and laminate *authoring* (creating/editing ply stacks,
laminates, ply-to-set/element links) in HyperMesh. This file does NOT
duplicate the underlying Nastran card field inventory (PCOMP/PCOMPG/PCOMPLS/
PCOMPP field-by-field mapping) — see
`_clean/docs/HYPERMESH_NASTRAN_CARD_FIELD_REF.md` for that. This file covers
the entity-level `plies`/`laminates` entity types and the C-registered Tcl
commands that create/update them, sourced from the closed-source
"HyperLaminate" GUI's backing Tcl and the `composites` script tree.

Verification status:

```text
RUNTIME-TESTED (LOCAL-INSTALL):
  Command *existence* and basic create/update/query round-trip confirmed live
  via `hmbatch.exe -tcl` against `01-Test_Model.hm` in
  `_clean/tests/probe_composites_domain.tcl` (info commands *ply*/*laminate*/
  *composite* glob + real *plycreate/*plyupdate/*laminatecreate calls that
  succeeded and produced a queryable `plies`/`laminates` entity with the
  laminate correctly referencing its ply). Raw probe output kept at
  `_clean/tests/probe_composites_domain_out.txt`.

LOCAL-INSTALL (source-read only, not independently re-run):
  Exact positional-argument order/count for `*plycreate`, `*plyupdate`,
  `*laminatecreate`, `*laminateupdate` is transcribed from real call sites in
  the installed HyperLaminate GUI backing Tcl (`hm/scripts/entities/
  createPlyDlgFuncs.tcl`, `hm/scripts/entities/createLaminateDlgFuncs.tcl`),
  not from an official Altair Tcl command reference page (Altair does not
  publish a standalone man-page style doc for these two commands the way it
  does for the generic Modify Commands category). Treat positional argument
  meaning as high-confidence (multiple independent call sites agree) but not
  OFFICIAL.

UNVERIFIED:
  `*plyabsorb`, `*plydrape`, `*plyrealization`(+`_option`), `*plynormalsdisplay`,
  `*plynormalsreverse`, `*plythicknessfactor`, `*setply`/`*setglobalply`
  (+`_option`), `*laminaterealize`/`*laminaterealizewithoptions`/
  `*laminateunrealize`, and the `*composite*size*/*shuffle*desvar*` family are
  confirmed to EXIST (seen in `info commands` glob output or grepped call
  sites) but were not exercised in the live probe — argument shapes below are
  transcribed from source call sites only, not executed.
```

Source files read in full or in relevant part:

```text
<ALTAIR_INSTALL_DIR>/hm/scripts/entities/createPlyDlgFuncs.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/entities/createLaminateDlgFuncs.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/entities/hmPlyRealization.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/entities/hmLaminateRealization.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/entities/hmPlyDraping.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/context/src/composites/*.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/EngineeringSolutions/aerospace/FEAbsorbPly/FEAbsorbPly.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/EngineeringSolutions/aerospace/OrientationReview/OrientationReview.tcl
_clean/tests/probe_composites_domain.tcl (live probe, this session)
```

Note on `hm/scripts/hyperlaminate/*.tbc`: unlike HyperGraph's closed `.tbc`
bytecode (confirmed unreadable, see `HYPERGRAPH_API_REF.md`), the
HyperLaminate `.tbc` files in this install are plain ASCII Tcl source (`file`
confirms "ASCII text" — likely `.tbc` here just means "Tcl Batch Compiler
staging area" naming convention, not actual bytecode). They were readable but
turned out to be **the same GUI dialog/tree-widget code** as
`hm/scripts/entities/create{Ply,Laminate}DlgFuncs.tcl` (same
`::hmdb::api::ply::*` / `::hmdb::api::laminate::*` namespace, thousands of
lines of tree-control/tab-pane/dialog callback plumbing) — not a separate or
richer automation surface. No new reusable commands were found there beyond
what's already covered below.

---

## Scope verdict: this API surface is genuinely thin

Unlike Connectors (large `hm_ce_*` family) or the entity/GUI core, composite
ply/laminate **authoring** boils down to a **small number of C-registered
Tcl commands** (`*plycreate`, `*plyupdate`, `*laminatecreate`,
`*laminateupdate`, plus a half-dozen narrow utility commands). Everything else
in `hm/scripts/composites/` and `hm/scripts/hyperlaminate/` is GUI
dialog/tree-widget callback code (tab panes, CSV import/export UI, "Same As"
pop-downs, mouse-motion handlers) that calls back into these same few
commands — it is not a wider hidden command surface. This matches the
`API_DOC_EXPANSION_TASKLIST.md` prediction ("likely a smaller, more contained
API than Connectors"). Reading/querying existing plies and laminates reuses
the generic entity-model commands already documented in
`HYPERMESH_ENTITY_MODEL_API_REF.md` and `HYPERMESH_DATANAME_INDEX.md`
(`hm_getvalue`, `hm_getentityvalue`, `hm_getentityarray`, `hm_entitylist`) —
nothing composite-specific was needed for reads.

---

## Entity types

`plies` and `laminates` are both confirmed-valid entity type strings (see
`HYPERMESH_ENTITY_TYPE_INDEX.md`; basic dataname coverage already recorded in
`HYPERMESH_DATANAME_INDEX.md` Track 4 — `plies` has a valid type-index dataname
key 0, `laminates` does not surface one via the attribute-index probe, so use
`hm_getentityvalue`/`hm_getentityarray` fallback keys for laminate fields, as
already noted there).

- **`plies`** — a ply entity: a single lamina definition (material,
  thickness, orientation angle, drape table, integration points, backing
  geometric collector: a `sets`/`lines`/`surfs` mark).
- **`laminates`** — a stack of plies (a "STACK"/"LAM_STACK" card-image
  entity referencing an ordered `plies` list) OR an "interface laminate" /
  "sublaminate" referencing other `laminates` plus an interface-pair list.
  Distinguishing a normal stack from a sublaminate/interface laminate is a
  GUI-side concept (`GetLaminateType` in `createLaminateDlgFuncs.tcl`) — see
  Notes below.

---

## Ply creation / update

### `*plycreate`

**Signature:**
```tcl
*plycreate <name> <color> <collector_type> <collector_mark_id> <material> \
    <thickness1> <orientation> <integration_points> <output_results> \
    <thickness2> <thickness3> <thickness4> <drape_table_id> [<system_id>]
```
- `<name>`: string, new ply's entity name (must not already exist — the GUI
  layer checks `hm_entitylist plies name` first and blocks on collision; the
  raw command itself was not observed to auto-dedupe).
- `<color>`: integer HM color index (e.g. `1`).
- `<collector_type>`: `sets` | `lines` | `surfs` (lowercase seen in source;
  the live probe used `sets` successfully). This is the ply's backing
  geometric collector — for `sets`, elements are first marked and wrapped
  with `*entitysetcreate <setname> elems 1` before this call (see Notes).
- `<collector_mark_id>`: mark id (integer) that must already hold the
  collector entities via `*createmark <collector_type> <mark_id> ...` before
  calling `*plycreate`.
- `<material>`: material name string, or `""` for none.
- `<thickness1>`: float, single-thickness value (or T1 of 4 for
  multi-thickness plies — see call sites using `strPlyT1`..`strPlyT4`).
- `<orientation>`: float, fiber orientation angle.
- `<integration_points>`: integer (0 if unused/unsupported for the profile).
- `<output_results>`: 0/1 flag for per-ply result output request.
- `<thickness2>`, `<thickness3>`, `<thickness4>`: floats, extra thickness
  slots for multi-thickness plies (0 if single-thickness).
- `<drape_table_id>`: integer id of a pre-existing drape `tables`-type
  entity, or `0`/blank if none.
- `[<system_id>]`: optional trailing system/coordinate-system id argument,
  seen appended in some call sites (`$::hmdb::api::ply::system`) — omit for a
  simple ply.

**Return shape:** Live probe observed a return value of `1` on the newly
created ply's Tcl-list result — consistent with Altair's general
`*xxxcreate` convention of returning the new entity id, but this was not
cross-checked against `hm_entityinfo` for a second, third ply to confirm it's
always the id vs. always "1" for a first entity of that type. Treat as
"probably new entity id" (LOCAL-INSTALL inference, not fully RUNTIME
confirmed for id-value correctness beyond the first ply in a fresh model).

**Precondition/side-effect:** Requires the collector mark (`sets 1`, etc.)
to be pre-populated via `*createmark`. Creates a new `plies`-type entity.
Does not itself assign a Nastran card image — for solver-specific ply card
images (`PLY`, `P19_PLY`, etc.) a separate `*dictionaryload plies <mark>
<templatefile> <cardimage>` + `*initializeattributes plies <name>` step is
used by the GUI layer (see `HYPERMESH_ENTITY_MODEL_API_REF.md` for the
generic `*dictionaryload`/`*initializeattributes` mechanism, which applies
identically here — not composite-specific).

**Confidence:** RUNTIME-TESTED for command existence + basic success
(returned `1`, `hm_entitylist plies name` afterward showed `probe_ply1`).
Argument order/meaning LOCAL-INSTALL (source-transcribed from
`createPlyDlgFuncs.tcl` lines ~534-563 and the CSV-import path at
`createLaminateDlgFuncs.tcl` line 1456).

---

### `*plyupdate`

**Signature (single-thickness form, most common):**
```tcl
*plyupdate <mark_id> <update_collector_flag> <collector_type> <collector_mark_id> \
    <update_material_flag> <material> \
    <update_thickness_flag> <thickness1> \
    <update_orientation_flag> <orientation> \
    <update_integration_flag> <integration_points> \
    <update_output_flag> <output_results> \
    <thickness2> <thickness3> <thickness4> \
    <update_drape_flag> <drape_table_id> \
    [<update_system_flag> <system_id>]
```
Each "update_X_flag" is a 0/1 boolean gating whether the following value(s)
are actually applied — this is the standard Altair `*xxxupdate` pattern of
"flag, value" pairs per field (same pattern documented for
`*materialupdate`/`*propertyupdate` in `HYPERMESH_ENTITY_MODEL_API_REF.md`).
`<mark_id>` must be pre-populated with the target `plies` via `*createmark
plies <mark_id> ...` before calling.

**Return shape:** integer status (probe returned `1` on success; unclear if
this is a boolean-success code or an id — for `*plyupdate` a status code is
more consistent with the update-family convention seen elsewhere in this
project's docs).

**Precondition/side-effect:** Mutates the plies on the pre-populated mark.
CSV-import path (`createLaminateDlgFuncs.tcl` line 1458) shows a shorter
variant used for bulk reapply:
```tcl
*plyupdate 1 1 SETS 1 1 $material 1 $thickness 1 $orientation 1 0 1 $resCode 0 0 0 1 $tblId
```
confirming the flag/value pairing holds even in that abbreviated real-world
usage (collector type given uppercase `SETS` there vs lowercase `sets`
elsewhere — HyperMesh's Tcl command dispatch is generally case-insensitive
for such string tokens, but this was not independently re-verified here).

**Confidence:** RUNTIME-TESTED for existence + a no-op-shaped call succeeding
(`*plyupdate 1 0 sets 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0` returned `1` without
error in the probe). Full argument semantics LOCAL-INSTALL
(source-transcribed, two independent call sites agree on shape).

---

## Laminate creation / update

### `*laminatecreate`

**Signature (plain stack form):**
```tcl
*laminatecreate <name> <color> <convention> <repeat_count> <configuration> \
    <mark_id_of_plylist> [<system_id>]
```
**Signature (interface-laminate / sublaminate form):**
```tcl
*laminatecreate <name> <color> <convention> <repeat_count> <configuration> \
    <mark_id_of_lamlist> <interface_flag> <numrows> <numcols> [<system_id>]
```
- `<name>`: new laminate entity name (existence-checked against
  `hm_entitylist laminates name` by the GUI layer the same way `plycreate`
  checks `plies name`).
- `<color>`: integer HM color index.
- `<convention>`: integer enum, "Laminate Convention" (top-down vs
  bottom-up stacking reference — GUI exposes this via
  `GetLaminateConvention`/`GetLamConvIdfromName`; exact enum-to-string
  mapping not independently re-derived here, see those procs in
  `createLaminateDlgFuncs.tcl` lines 133-191 and 2249-2298 if needed).
- `<repeat_count>`: integer, symmetric-repeat count for the stack.
- `<configuration>`: integer enum, "Laminate Configuration"
  (`GetLamConfigIdfromName`, `createLaminateDlgFuncs.tcl` line 2228).
- Ply-list case: a **pre-populated `plies` mark id** established via
  `*createlist plies <mark_id> <plylist>` (list of ply ids/names), matching
  the live probe's working call:
  ```tcl
  *createmark plies 1 "by name only" "probe_ply1"
  *createlist plies 1 [hm_getmark plies 1]
  *laminatecreate "probe_lam1" 1 0 1 0 1 0
  ```
  (probe used `mark_id=1`, `repeat_count=1`, `configuration=0`,
  `mark_id_of_plylist=1`, trailing `0` = no system).
- Interface-laminate case: pre-populate a `laminates` mark with the
  sub-laminates via `*createlist laminates <mark_id> <lamlist>`, plus a
  2D interface-pair array via `*createentityarray2d <numrows> 2
  <interfacelist>` immediately before the call (see
  `createLaminateDlgFuncs.tcl` lines 1674-1687) — `<numrows>`/`<numcols>`
  describe that array's shape, `<interface_flag>` is `1` for this branch.

**Return shape:** Live probe returned `1` for a first-laminate-in-model
create; a subsequent `hm_getentityvalue laminates "probe_lam1" id 0` and
`hm_getentityarray laminates <id> plies -byid` confirmed the laminate really
was created and correctly lists `probe_ply1`'s id as its ply. Same
"probably new entity id" caveat as `*plycreate` applies.

**Precondition/side-effect:** Requires plies (or sub-laminates) to already
exist and be gathered on a mark/list before the call — `*laminatecreate`
itself does not create plies. Card-image assignment (`STACK`, `LAM_STACK`,
`PCOMPP`, etc.) is a separate `*dictionaryload laminates <mark>
<templatefile> <cardimage>` + `*initializeattributes laminates <name>` step,
same generic mechanism as elsewhere (not composite-specific — see
`HYPERMESH_ENTITY_MODEL_API_REF.md`). For `RadiossBlock`/`OptiStruct`
profiles with a `PCOMPP`/`P17_STACK`/`P51_STACK` card image, the GUI layer
also creates a companion `props` entity and links it via `*setvalue props
id=<id> STATUS=1 laminate=<laminate_id>` plus per-ply `phi`/`zi` arrays set
via `*setvalue laminates id=<id> STATUS=2 Prop_phi=<list>` /
`Prop_Zi=<list>` (or `LAM_Stack_phi`/`LAM_Stack_Zi` for the `LAM_STACK`
variant) — this is a real, reusable pattern for stacking-sequence metadata
if targeting those specific profiles/card images.

**Confidence:** RUNTIME-TESTED (both call forms confirmed to exist via `info
commands`; the plain-stack form actually executed successfully end-to-end in
the live probe, producing a laminate that correctly cross-references its
ply). Interface-laminate form and the `props`/`phi`/`zi` linkage pattern are
LOCAL-INSTALL (source-transcribed only, not executed here).

---

### `*laminateupdate`

**Signature (transcribed from source, single-block form):**
```tcl
*laminateupdate <mark_id> <update_convention_flag> <convention> ...
```
Full argument tail was not fully transcribed in this pass (call sites at
`createLaminateDlgFuncs.tcl` lines 2015/2118/2169/2188 continue onto wrapped
lines covering repeat-count, configuration, and ply-list-flag/value pairs
following the same flag-then-value convention as `*plyupdate`). Existence
and the flag/value pairing pattern are confirmed; the complete field list is
**not** fully documented here — flagged as a gap rather than guessed.

**Confidence:** RUNTIME-TESTED for existence only (`info commands
*laminate*` includes `*laminateupdate`). Argument shape: UNVERIFIED beyond
"follows the flag/value pairing convention." Do not rely on a specific field
order without reading `createLaminateDlgFuncs.tcl` around those line numbers
first, or running a targeted probe.

---

## Other confirmed-existing composite commands (not exercised live)

All of the below were confirmed to exist via the live `info commands`
glob probe (`*ply*` / `*laminate*` / `*composite*`) but were **not** called
in the probe — argument shapes are transcribed from grep'd call sites only
where noted, otherwise name-only. Confidence: UNVERIFIED for all rows below
unless stated.

| Command | Observed usage pattern (source-transcribed) | Notes |
|---|---|---|
| `*plyabsorb` | `*plyabsorb comps 1` / `*plyabsorb props 1` | Absorbs FE mesh into ply geometry from a pre-populated `comps`/`props` mark. From `FEAbsorbPly.tcl`. |
| `*plydrape` | `*plydrape plies 1 application="LaminateTool" seednode=$id refdirection=$id applicationdirection=$id size=$v strain=$v [uninitializeFlag=0/1] [showLamToolFlag=0/1]` | Keyword=value argument style (unlike the positional `*plycreate`/`*plyupdate`). Runs ply draping simulation on a pre-marked `plies` set. From `context/src/composites/drape.tcl`, `LTdrapeestimator_perform.tcl`. |
| `*plynormalsdisplay` | `*plynormalsdisplay <plyname> <mark_or_flag> <scale>` | Toggles/displays ply normal vectors. From `context/src/composites/normals.tcl`, `OrientationReview.tcl`. |
| `*plynormalsreverse` | `*plynormalsreverse <plyname> <mark_or_flag> <scale>` | Reverses ply normal direction. Same source files as above. |
| `*plyrealization` / `*plyrealization_option` | invoked via the `hmPlyRealization.tcl` GUI (`::hm::plyrealization::Realize`) | "Realizes" a flat/idealized ply pattern onto 3D mesh geometry. Argument shape not transcribed — GUI-driven with many upstream state variables; likely not practically callable standalone without replicating substantial GUI state. |
| `*laminaterealize` / `*laminaterealizewithoptions` / `*laminateunrealize` | invoked via `hmLaminateRealization.tcl` (`::hm::laminaterealization::Realize`) | Same caveat as ply realization — core-sample-file-driven workflow (reads external ASCII "core sample" ply-shape files), not a simple entity mutation. |
| `*plythicknessfactor` | name only, seen in `info commands` output | Not found in a readable call site in this pass — purpose inferred from name only (per-ply thickness scaling factor), do not rely on this without a further probe. |
| `*setply` / `*setply_option` / `*setglobalply` / `*setglobalply_option` | names only, seen in `info commands *ply*` output | Not found in a readable call site in this pass. Likely ply-level/global-default display or solver-option setters given the naming convention, but this is a guess, not a finding — flagged UNKNOWN purpose. |
| `*compositesizedesvarcreate(withlaminateoption)` / `*compositesizedesvarupdate(withlaminateoption)` / `*compositesizelaminatethicknessupdate` / `*compositeshuffledesvarcreate(withlaminateoption)` / `*compositeshuffledesvarupdate(withlaminateoption)` / `*compositeshufflepairingconstraintupdate` / `*freesizedesvarcreate(withlaminateoption)` / `*freesizedesvarupdate(withlaminateoption)` / `*freesizelaminatethicknessupdate` | names only | This is the OptiStruct **composite optimization design-variable** family (size/shuffle/free-size DVs referencing laminates) — a distinct, adjacent domain from plain ply/laminate authoring. Out of scope for this file's stated task (laminate/ply authoring, not optimization DV setup); flagged here for a future "OptiStruct composite optimization" doc if ever prioritized. Cross-reference: `designvars`/`dvprels` entity types already have dataname coverage per Track 4 of `HYPERMESH_DATANAME_INDEX.md`. |
| `*compositeanalysis` | name only | Likely triggers a composite failure/analysis check pass (ties to `br/views/composite/operations/compositeanalysis_perform.tcl`, `CompositeFailureWizard`). Not exercised. |
| `*showcompositelayers` | name only | Likely a display/visibility toggle for composite layer rendering, analogous to other `*show*`/display commands documented in `HYPERMESH_COLOR_RENDER_API_REF.md`. Not exercised. |
| `*collectorcreate` | `*collectorcreate materials "$name" "" $colorId` | Generic entity-collector creation, not composite-specific (used here just to auto-create a referenced material by name) — already effectively covered by the generic `*createentity` pattern in `HYPERMESH_ENTITY_MODEL_API_REF.md`; listed here only because it appears adjacent to ply/laminate creation call sites. |

---

## Read/query patterns (reuse the generic entity API — nothing composite-specific)

No composite-specific read commands were found or needed. Use the same
`hm_getvalue`/`hm_getentityvalue`/`hm_getentityarray`/`hm_entitylist`
mechanism documented in `HYPERMESH_ENTITY_MODEL_API_REF.md` and
`HYPERMESH_DATANAME_INDEX.md`:

```tcl
# List all laminate names in the model
hm_entitylist laminates name

# Get a laminate's ordered ply-id list (RUNTIME-TESTED in this session's probe)
set lamid [hm_getentityvalue laminates "MyLaminate" id 0]
hm_getentityarray laminates $lamid plies -byid

# Get a laminate's ply list by name instead of id (source-transcribed,
# equivalent to ::hmdb::api::GetLaminatePlyList in createLaminateDlgFuncs.tcl)
hm_getentityarray laminate "MyLaminate" plies -byname
```

Note the entity-type-string inconsistency observed directly in source:
`hm_getentityarray` is called with the **singular** `laminate` in
`GetLaminatePlyList`/`GetInterfacePlyList` (`createLaminateDlgFuncs.tcl`
lines 3990, 4047) but the **plural** `laminates` in the live probe above and
in `*createmark laminates ...` calls throughout the same file. Both forms
were not cross-tested against each other in the live probe (only `laminates`
plural was actually run and confirmed working); flag this as a
LOCAL-INSTALL/UNVERIFIED discrepancy worth a quick live check
(`catch {hm_getentityarray laminate ...}` vs `laminates`) before relying on
the singular form in new code — prefer the plural `laminates` form, which is
the one this session actually confirmed live.

---

## Notes / gotchas for an agent writing new automation code here

1. **Always pre-populate a mark before `*plycreate`/`*laminatecreate`/
   `*plyupdate`/`*laminateupdate`.** None of these commands take inline
   entity references for their collector/ply-list arguments — they all read
   from a `*createmark`/`*createlist`-populated mark id.
2. **Name-collision checking is a GUI-layer responsibility, not enforced by
   the raw command.** The live probe did not test creating a second ply/
   laminate with a duplicate name — assume no built-in guard and check
   `hm_entitylist plies name` / `hm_entitylist laminates name` yourself
   first, matching what the GUI layer does.
3. **Card-image/template assignment is a separate step**, using the same
   generic `*dictionaryload <type> <mark> <templatefile> <cardimage>` +
   `*initializeattributes <type> <name>` pair documented for other entity
   types in `HYPERMESH_ENTITY_MODEL_API_REF.md` — `*plycreate`/
   `*laminatecreate` only create the bare entity.
4. **Ply thickness has both a single-value and a 4-slot multi-thickness
   form** (`thickness1..4` positional args) gated by a separate
   "IsMultipleThickness" concept in the GUI layer — pick one calling
   convention per ply and stay consistent; do not assume `thickness1` alone
   is always meaningful for a ply created via the multi-thickness path.
5. **`*plydrape` and the `*laminaterealize*`/`*plyrealization` family use
   keyword=value arguments and lean on external "core sample" files / seed
   node & direction vector ids** — these are full drape-simulation
   workflows, not simple property setters. Treat them as a separate,
   heavier-weight feature if ever needed; this file's live-tested core is
   the plain create/update pair above.
6. Cross-reference `HYPERMESH_NASTRAN_CARD_FIELD_REF.md` for what a PCOMP/
   PCOMPG/PCOMPLS/PCOMPP card actually looks like once exported — this file
   only covers getting HyperMesh's internal `plies`/`laminates` entities
   populated in the first place.
