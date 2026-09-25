# HyperMesh Connectors (CE_*/AE_*) API Reference

Purpose: document the real Connector-authoring API that backs the HyperMesh
Connector Browser (spot/bolt/seam/area connectors and attachments), which is
the correct answer to a gap flagged in `HYPERMESH_DATANAME_INDEX.md`:
`*createentity connectors` errors and `*createspotweld` does not create a
`connectors`-type entity. This file documents the actual creation/read/
realize command families instead: uppercase `*CE_*` / `*AE_*` batch macro
commands (mutate connectors/attachments) plus the lowercase `hm_ce_*` query
family (read connector state — separate command set, NOT the same namespace).

## Verification status

```text
RUNTIME-TESTED (LOCAL-INSTALL):
  `info commands *CE_*` / `info commands *AE_*` / `info commands *hm_ce_*`
  were run live in a real `hmbatch.exe -tcl` HyperMesh session
  with `01-Test_Model.hm` loaded (see `_clean/tests/probe_connectors_domain.tcl`
  through `probe_connectors_domain4.tcl` and their `*_out.txt` outputs).
  Confirmed to actually exist this way: 132 `*CE_*` commands, 10 `*AE_*`
  commands, ~100 `hm_ce_*` query commands.

  A full create -> query -> realize round trip was actually exercised and
  produced a real `connectors`-type entity (see "Resolved: creating a real
  connectors-type entity" section below) — this is the strongest evidence
  in this file and resolves the gap `HYPERMESH_DATANAME_INDEX.md` flagged.

LOCAL-INSTALL (source-read, NOT independently live-tested):
  Argument signatures for most other `*CE_*`/`*AE_*` commands below were
  read from real installed Tcl source under
  `hm/scripts/connectors/`, `hm/scripts/assemblytools/`,
  `hm/scripts/context/src/connectors/`, `hm/scripts/femsite/`,
  `hm/scripts/EngineeringSolutions/aerospace/rivetConnection/`,
  `hm/scripts/ImportExport/`, `hm/scripts/br/views/modules/`. These are
  real call sites (how Altair's own shipped Tcl calls the command), not
  guesses — but the call was not independently re-run by this session, so
  it is one tier below RUNTIME-TESTED.

UNVERIFIED (existence-only):
  Many `*CE_*`/`*AE_*` commands are C-registered (not Tcl `proc`s — no
  `proc` body exists to read) and have NO Tcl-source call site anywhere in
  the installed scripts tree either (they are called only from compiled
  GUI/panel code, e.g. `hmobj.dll`/connector panel C++). For these, only
  existence via `info commands` is confirmed; the argument list below is a
  best-effort inference from the command's own name and sibling commands'
  patterns, or left explicitly blank/UNKNOWN. Do not rely on these without
  a live test first.

NOT A NASTRAN-SPECIFIC LAYER:
  Connectors are solver-agnostic pre-realization intent objects (spot/bolt/
  seam/area) that get "realized" into real FE (nodes/elements/rigids/RBE2/
  RBE3 etc. depending on connector config and target solver profile). This
  file does not attempt to enumerate every one of the ~90 numeric
  `ce_config` values (5 = spot-weld-like rigid link config observed live;
  others read from source comments only, not enumerated here — out of
  scope, would need its own dedicated probe pass).
```

How to reproduce / refresh on a different install:

```tcl
info commands *CE_*
info commands *AE_*
info commands *hm_ce_*
```

---

## Two separate command families — do not confuse them

1. **`*CE_*` / `*AE_*` (uppercase, leading `*`)** — batch/macro-style
   **mutation** commands. These create, modify, realize, and export
   connectors and attachments. Called the same way as `*createmark`,
   `*setvalue`, etc. (leading `*`, space-separated positional args, no
   named flags). `CE_` = Connector Entity, `AE_` = Attachment Entity
   (attachments are a specialized connector subtype used by the
   assembly/subsystem tools — same underlying mechanism, separate command
   prefix).
2. **`hm_ce_*` (lowercase, no leading `*`)** — ordinary Tcl-proc-style
   **query** commands. These read back state of an already-created
   connector (type, size, state, linked entities, collector, detail
   values). Called like any other `hm_*` query command (return a value,
   no mark side effects).

A typical authoring flow is: build a mark of the anchor geometry (nodes/
points/lines/surfs) → `*CE_ConnectorCreateByMark` (or a sibling `Create*`
command) → optionally set details via `*CE_DetailSet*` → `*CE_Realize` to
turn the connector into real FE → optionally query with `hm_ce_*` at any
point.

---

## Resolved: creating a real `connectors`-type entity

This directly answers the gap flagged in `HYPERMESH_DATANAME_INDEX.md`
("`connectors` remains unresolved — needs the separate `hm_ce_*` Connector
API"). The actual creation path is **not** `hm_ce_*` (that family is
read-only) — it is `*CE_ConnectorCreateByMark`. Confirmed live:

```tcl
*clearmark nodes 1
*createmark nodes 1 "by id" $some_node_id
*clearmark comps 2
*createmark comps 2 all
*CE_ConnectorCreateByMark nodes 1 "spot" 1 components 2 1 5
;# -> creates connectors id=1 for real, confirmed via:
;#    hm_entitylist connectors id        -> "1"
;#    hm_ce_type 1                       -> "point/node"
;#    hm_ce_state 1                      -> "unrealized"
;# *CE_Realize 1 1 (mark-based, connectors mark 1) then runs without error
;# and the model's total element count increases (realized into real FE).
```

Important caveats discovered live:
- The connector entity created this way is **not** addressable through the
  normal `hm_getvalue connectors id=$id dataname=<key>` /
  `hm_attributeindexmax connectors $id` mechanism used by every other
  entity type in `HYPERMESH_DATANAME_INDEX.md` — `hm_attributeindexmax`
  returned `0` for a real, just-created connector. Connectors are queried
  exclusively through the separate `hm_ce_*` family (see below), not the
  generic dataname system.
- `hm_entitylist connectors name` errors with `"entities of this type do
  not have names"` — connectors are id-only, like `elems`/`nodes`.
- The connector "type" string for `*CE_ConnectorCreateByMark` must be one
  of exactly `spot`, `bolt`, `seam`, `area` (confirmed via the live error
  message `"only spot or bolt or seam or area is accepted for ce type."`
  when an invalid string was passed).
- Recommendation for `HYPERMESH_DATANAME_INDEX.md`: update its `connectors`
  section to point here instead of describing the gap as unresolved. Not
  done in this pass (optional per this file's task scope) — flagged here
  for a future pass.

---

## Command reference

Format per command: **Signature**, **Return shape**, **Precondition/
side-effect**, **Confidence**.

### Creation (`*CE_*`)

**`*CE_ConnectorCreateByMark <anchor_type> <anchor_mark_id> <ce_type> <num_layers> <link_type> <link_mark_id> <realize_flag> <ce_config>`**
- Signature (live-confirmed args, positions match real usage):
  `anchor_type` = `nodes`|`points`|`lines`|`surfs`; `anchor_mark_id` = an
  existing mark of that type; `ce_type` = literal `spot`|`bolt`|`seam`|
  `area`; `num_layers` = integer layer count; `link_type` = usually
  `components` (also seen `comps`); `link_mark_id` = mark of link
  components; `realize_flag` = `0`/`1`; `ce_config` = numeric connector
  config id (`5` observed live as a working rigid-link-style spot config;
  other values not enumerated here).
- Return shape: returns `1` on success (observed live); creates one new
  `connectors`-type entity (query its id via `hm_entitylist connectors
  id`, always the newest/last in the list right after creation).
- Precondition/side-effect: requires valid non-empty anchor mark and link
  mark; wrap in `catch` — invalid `ce_type` string or empty marks raise a
  real Tcl error with a descriptive message (`"Connectors have not been
  selected."`, `"only NODES accepted for location."`, etc., all observed
  live). Adds a real `connectors` entity.
- Confidence: **RUNTIME-TESTED (LOCAL-INSTALL)** — actually created a
  connector and confirmed via `hm_entitylist`/`hm_ce_type`/`hm_ce_state`.

**`*CE_ConnectorCreateByMarkWithCC <anchor_type> <mark_id> <ce_type> ... <connector_control_name_or_id>`**
- Signature: same family as above, with an extra Connector Control (CC)
  argument selecting a named/id'd `connectorcontrols` entity instead of the
  bare numeric config. Exact arg order not independently re-run.
- Return shape: same as `CreateByMark` — new `connectors` entity.
- Precondition: a valid `connectorcontrols` entity must already exist
  (create one via `*AE_AttachmentControlDefaultCreate`/
  `*CE_FE_CreateDCC`/`*CE_FE_CreateUCCFromDCC`, see below).
- Confidence: **LOCAL-INSTALL/UNVERIFIED** (no direct Tcl call site
  found in installed scripts for this specific sibling; inferred from the
  `*CE_ConnectorCreateByListWithCC` naming pattern and `info commands`
  existence only).

**`*CE_ConnectorCreateByList <entity_type> <id_list> <ce_type> <num_layers> <link_type> <link_mark_id> <realize_flag> <ce_config>`**
- Signature: list-based sibling of `CreateByMark` — same positional
  meaning, but anchors passed as an explicit id list rather than a mark.
- Return shape: new `connectors` entity, same as `CreateByMark`.
- Confidence: **LOCAL-INSTALL/UNVERIFIED** — confirmed to exist via
  `info commands`, naming/arg-order inferred from `CreateByMark` sibling,
  no direct call site found in installed Tcl to confirm exact order.

**`*CE_ConnectorCreateWithRules <anchor_type> <mark_id> <link_type> <link_mark_id> <flag1> <flag2> <flag3> <flag4> <flag5> <ce_config>`**
- Signature (from real call sites):
  ```tcl
  *CE_ConnectorCreateWithRules nodes 1 components 2 1 1 0 0 0 2
  *CE_ConnectorCreateWithRules points 1 components 2 1 1 0 0 0 3
  ```
  (from `hm/scripts/weld-connector-lib.tcl:514`,
  `hm/scripts/nastran/ContinuousWeld.tcl:945`,
  `hm/scripts/nastran/rigid-connector-nas.tcl:90,92`). Anchor type omits an
  explicit `ce_type` string (unlike `CreateByMark`) — rule-based creation
  auto-picks connection style; the trailing numeric arg is the `ce_config`.
- Return shape: creates connector(s) automatically per link rules, no
  return value captured at any call site (all wrapped in bare `catch {...}`
  ignoring the result).
- Precondition: anchor mark + link component mark must be populated first.
- Confidence: **LOCAL-INSTALL** (4 real call sites across
  `weld-connector-lib.tcl`, `ContinuousWeld.tcl`, `rigid-connector-nas.tcl`
  — all Altair Nastran-profile connector tooling, high relevance for this
  project).

**`*CE_ConnectorCreateByAutopitchNew <link_type> <link_mark_id> <option_string>`**
- Signature: `hm/scripts/hmAutoPitchGUI.tcl:564`:
  `*CE_ConnectorCreateByAutopitchNew components 2 $OptionString` — creates
  a row of evenly-pitched spot connectors along an edge/seam automatically;
  `$OptionString` is a semicolon/space-packed options blob built elsewhere
  in that GUI file (not a simple scalar — treat as opaque, GUI-owned).
- Return shape: creates multiple `connectors` entities in one call
  (auto-pitch = a series along a path).
- Confidence: **LOCAL-INSTALL** (1 real call site, but the options
  string's internal format was not decoded — flagged for anyone reusing
  this outside the GUI).

**`*CE_ConnectorAreaCreate <anchor_type> <mark_id> <"area"|name> <link_type> <link_mark_id> <ce_config>`**
- Signature: UNKNOWN exact order — no Tcl call site found anywhere in the
  installed scripts tree (area connectors appear to be created only from
  compiled panel code). A live probe call
  `*CE_ConnectorAreaCreate surfs 1 "probe_area" components 2 1` returned
  `"Surfaces have not been selected."` (i.e. it parsed far enough to
  reject an empty surfs mark — consistent with, but not proof of, this
  arg order).
- Return shape: UNKNOWN.
- Confidence: **UNVERIFIED** (existence confirmed via `info commands`;
  argument order is a best-effort guess from sibling `Create*` commands,
  partially corroborated by one live error message, not a working call).

**`*CE_ConnectorAreaCreateFromList`**, **`*CE_ConnectorLineCreate`**,
**`*CE_ConnectorLineCreateWithRules`**,
**`*CE_ConnectorSeamCreateUsingLines`**,
**`*CE_ConnectorSeamCreateUsingLinelist`**
- Signature: UNKNOWN — same situation as `CE_ConnectorAreaCreate`: exist
  in `info commands`, zero Tcl call sites in the installed scripts tree,
  no live successful call made. Named consistently with the anchor-type
  naming pattern seen in the rest of this family (`Area`→surfs, `Line`/
  `Seam`→lines), so the anchor-entity-type argument is very likely the
  first positional argument, but arg count/order is otherwise a guess.
- Confidence: **UNVERIFIED** (name/existence only).

### Realize / Unrealize

**`*CE_Realize <mark_type_implicit_connectors> <connector_mark_id> <flag>`**
- Signature (live-confirmed):
  ```tcl
  *clearmark connectors 1
  *createmark connectors 1 $cid
  *CE_Realize 1 1
  ```
  First arg = connectors mark id, second arg = a flag (`1` observed
  working). Converts unrealized connector intent objects on the given mark
  into real FE (elements/rigids/etc., depending on `ce_config`).
- Return shape: returns `1` on success (observed live); increases the
  model's total element count (observed live: `hm_entitylist elems id`
  count went up after realizing a spot connector). Does not change
  `hm_ce_state`'s reported string reliably in every case — re-check with
  `hm_ce_state` after calling if the realized/unrealized flag matters to
  your code, rather than assuming success from lack of a Tcl error alone.
- Precondition: mark must contain valid connector ids; connector must not
  already be fully realized (calling again on an already-realized
  connector was not tested — treat as unverified idempotency).
- Confidence: **RUNTIME-TESTED (LOCAL-INSTALL)** — actually called
  live in this session's probe, no Tcl error, element count increased.

**`*AE_Realize <mark_id> <flag>`** / **`*AE_Unrealize <mark_id>`**
- Signature (from `hm/scripts/br/views/connectors/core/utils.tcl:1407,1530`):
  ```tcl
  *clearmark attachments 2
  eval *createmark attachments 2 $ae_ids
  *AE_Realize 2 1
  ...
  *AE_Unrealize 2
  ```
  Same mark-based pattern as `CE_Realize`, but operating on `attachments`
  mark instead of `connectors` mark, and `Unrealize` takes only the mark
  id (no flag).
- Return shape: UNKNOWN exact return value (not captured at either real
  call site — both are bare statements, no `set`/`catch` capturing result).
- Precondition: mark of type `attachments` must be populated first (build
  via `*AE_AttachmentCreateWithOptions` or similar, then
  `*createmark attachments <id> $ae_ids`).
- Confidence: **LOCAL-INSTALL** (2 real call sites in the Connector
  Browser's own core utility file).

### Attachments (`*AE_*`)

**`*AE_AttachmentControlDefaultCreate <name_or_empty> <flag>`**
- Signature (live-confirmed, real call sites in
  `hm/scripts/br/views/connectors/core/common/operations/create.tcl:86`
  and `hm/scripts/context/src/connectors/core/connectorcontrolmanager.tcl:397`):
  `*AE_AttachmentControlDefaultCreate "" 1` — creates a default
  `attachmentcontrols` entity (empty string = auto-name).
- Return shape: returns `1` on success (observed live in this session's
  probe: `errC3=0 errMsg3=1`). Creates one `attachmentcontrols` entity —
  however in this session's probe, `hm_entitylist attachmentcontrols name`
  still came back empty immediately after the call; either the entity is
  id-only (like `connectors`) or the create was a true no-op silently
  returning `1` regardless. Flagged explicitly as an open discrepancy —
  do not assume the entity list will show a new row.
- Precondition: none observed; safe to call repeatedly in a session (each
  call was wrapped in `catch` at every real call site, suggesting Altair's
  own code doesn't trust it to always succeed either).
- Confidence: **RUNTIME-TESTED (LOCAL-INSTALL)** for "runs without a
  Tcl error and returns 1"; **UNVERIFIED** for "actually creates a visible
  `attachmentcontrols` row" (contradicted by this session's own probe).

**`*AE_AttachmentControlCreateFromAnother <new_name> <source_name> <flag>`**
- Signature (from `connectorcontrolmanager.tcl:937`):
  `*AE_AttachmentControlCreateFromAnother $newEntityName
  $item_contents(username) 1` — clones an existing attachment control by
  name into a new named one.
- Return shape: UNKNOWN (call site wraps in bare `catch`, discards result).
- Confidence: **LOCAL-INSTALL** (1 real call site).

**`*AE_AttachmentControlCreateFromDefault <new_name> <controller_name> <flag>`**
- Signature (from `connectorcontrolmanager.tcl:962,991`):
  `*AE_AttachmentControlCreateFromDefault $newEntityName $controllerName 1`
  — same pattern, but sourced from a named default controller rather than
  cloning another control instance.
- Return shape: UNKNOWN (discarded at both call sites).
- Confidence: **LOCAL-INSTALL** (2 real call sites).

**`*AE_AttachmentCreateWithOptions <anchor_type> <mark_id> <link_type> <link_mark_id> <options_string>`**
- Signature: UNKNOWN exact order — no Tcl call site found anywhere in the
  installed scripts tree (same situation as `CE_ConnectorAreaCreate`). A
  live probe call `*AE_AttachmentCreateWithOptions nodes 1 components 2 1
  ""` ran without raising a Tcl error (`rc=0`), but this session did not
  confirm a resulting `attachments`-type entity was actually created — no
  follow-up `hm_entitylist attachments` check was run after that specific
  call. Treat the arg order above as a plausible guess only.
- Return shape: UNKNOWN.
- Confidence: **UNVERIFIED**.

**`*AE_UpdateLink <mark_id> <link_uid>`**
- Signature (from
  `hm/scripts/br/views/connectors/core/common/widgets/updatelink.tcl:1315`):
  ```tcl
  eval *createmark attachments 1 $_selection
  *AE_UpdateLink 1 $linkuid
  ```
  Re-points an existing attachment's link to a new set of entities
  (selection already placed on an `attachments` mark) using an opaque
  `linkuid` handle managed by the Connector Browser's own link-change
  tracking (see `*CE_SetLinkChangeManagerSettings` below — same
  link-change-tracking subsystem, shared between CE and AE).
- Return shape: UNKNOWN (not captured at the call site).
- Confidence: **LOCAL-INSTALL** (1 real call site).

**`*AE_ConvertBoltLinkToAttachment`**
- Confidence: **UNVERIFIED** — exists in `info commands`, zero Tcl call
  sites found, no live test attempted (name suggests converting a
  bolt-type connector's link into an attachment's link representation).

**`*AE_AttachmentAbsorb`**, **`*AE_AttachmentControlConvert`**
- Confidence: **UNVERIFIED** — same situation, name-only.

### Linking connectors to entities (`*CE_*Link*`)

**`*CE_AddLinkEntities <ce_mark_type> <ce_mark_id> <layer_index> <link_type> <link_mark_id> ...`**
- Signature (from real call sites in `hm/scripts/connectors/ce_table.tcl`
  lines 187/188/212/213/219/220 — the Connector Browser's own "add link
  entities" button handler, all four sibling variants appear together):
  ```tcl
  *CE_FE ...
  *CE_Realize ...
  *CE_AddLinkEntities ...
  *CE_AddLinkEntitiesWithRules ...
  ```
  called as a block per connector row; exact positional args not
  individually isolated in this read (the four calls share setup code
  above them in the source) — treat this entry as "confirmed to exist and
  be called together with Realize in the browser's own link-editing flow",
  not as a confirmed standalone signature.
- Confidence: **LOCAL-INSTALL** (real call sites, imprecise arg
  isolation).

**`*CE_AddLinkEntitiesWithRules`**, **`*CE_AddLinkEntitiesWithArrays`**,
**`*CE_AddLinkEntitiesWithDetails`**, **`*CE_AddLinkEntitiesWithXYZs`**
- Confidence: **LOCAL-INSTALL/UNVERIFIED** mixed —
  `WithRules` has real call sites (see above and
  `hm/scripts/connectors/ce_table.tcl:4058`); `WithArrays` has one real
  call site (`hm/scripts/context/src/connectors/core/ConnectorLinks.tcl:308`,
  arg pattern not isolated); `WithDetails`/`WithXYZs` are existence-only
  (no Tcl call site found).

**`*CE_RemoveLink <link_id_or_mark>`**
- Signature (from `hm/scripts/connectors/ce_table.tcl:3320,3324`) — removes
  a previously-added link entity/reference from a connector. Exact arg not
  isolated from surrounding code in this read.
- Confidence: **LOCAL-INSTALL**.

**`*CE_MarkUpdateLink`**, **`*CE_MarkUpdateLinkMark`**,
**`*CE_MarkUpdateLinkGroup`**, **`*CE_MarkCombineLinks`**,
**`*CE_MarkRemoveLink`**, **`*CE_MarkRemoveLinkMark`**,
**`*CE_MarkReplaceLinkEntities`**, **`*CE_MarkSplitLink`**
- Real call site for `*CE_MarkUpdateLink`:
  `hm/scripts/assemblytools/assembly_tc.tcl:454` and
  `hm/scripts/connectors/ce_table.tcl:3811`. The rest of this
  `*CE_Mark*Link*` sibling group exist in `info commands` but have no
  isolated call site read in this pass.
- Confidence: **LOCAL-INSTALL** (`MarkUpdateLink` only) /
  **UNVERIFIED** (siblings, name-only).

**`*CE_UpdateLink <ce_id> ...`**
- Real call site: `hm/scripts/connectors/ce_table.tcl:3877`.
- Confidence: **LOCAL-INSTALL**.

### Detail (property/config) setters

**`*CE_DetailSetString <ce_id> <detail_name> <value> <flag1> <flag2>`**
- Signature (many real call sites, consistent 5-arg pattern):
  ```tcl
  *CE_DetailSetString $conn "jeid" $conn 0 1
  *CE_DetailSetString $conn "proc" "21" 0 1
  *CE_DetailSetString $conn "tan_dim1" $value 0 1
  *CE_DetailSetString $ceid "ce_dvst_allthksetting" $thicknessAll 0 1
  ```
  (from `hm/scripts/femsite/conn/procs/export.tcl`,
  `hm/scripts/connectors/dvstthickness_options.tcl`,
  `hm/scripts/connectors/prop_opt_nas_hilock.tcl`). `<ce_id>` = a single
  connector id (not a mark); `<detail_name>` = a string key, often
  prefixed `ce_`; final two integer args consistently `0 1` at every real
  call site observed (meaning not confirmed, but the pattern is
  consistent enough to treat as the normal/default call form).
- Return shape: no result captured at any call site (bare `catch {...}`).
- Confidence: **LOCAL-INSTALL** (9+ real call sites, byte-consistent
  arg pattern — the strongest source-derived signature in this file).

**`*CE_DetailSetDouble <ce_id> <detail_name> <value> <flag1> <flag2>`**
- Signature: `*CE_DetailSetDouble $ceId "ce_tolerance" $tol 0 0` (from
  `hm/scripts/assemblytools/realizeconnectors.tcl:324`) and
  `*CE_DetailSetDouble $conn ce_diameter $value 0 0` (from
  `hm/scripts/femsite/conn/procs/export.tcl:239`) — same shape as
  `DetailSetString`, numeric value instead of string.
- Confidence: **LOCAL-INSTALL** (2 real call sites).

**`*CE_DetailSetInt <ce_id> <detail_name> <value> <flag1> <flag2>`**
- Signature: `hm/scripts/assemblytools/realizeconnectors.tcl:315,319,362,363`
  — same shape, integer value.
- Confidence: **LOCAL-INSTALL** (4 real call sites).

**`*CE_DetailSetIntByMark <mark_id> <detail_name> <value> <flag1> <flag2>`**,
**`*CE_DetailSetDoubleByMark`**, **`*CE_DetailSetStringByMark`**,
**`*CE_DetailSetTripleByMark`**, **`*CE_DetailSetUintByMark`**
- Signature: `*CE_DetailSetIntByMark` has 4 real call sites in
  `hm/scripts/assemblytools/realizeconnectors.tcl` and
  `.../at/utils/HyperMeshEntity/ConnectorsAutoRealize.tcl` — same arg
  shape as the non-`ByMark` sibling but first arg is a connectors mark id
  instead of a single connector id (applies the detail to every connector
  on the mark in one call). `DetailSetDoubleByMark` has 2 real call sites
  in the same two files. The `String`/`Triple`/`Uint` ByMark siblings exist
  in `info commands` but have no isolated call site read in this pass.
- Confidence: **LOCAL-INSTALL** (`Int`/`Double` ByMark variants) /
  **UNVERIFIED** (`String`/`Triple`/`Uint` ByMark variants, name-only).

**`*CE_DetailSetTriple`**, **`*CE_DetailSetUint`**,
**`*CE_SetSpecificDetail <ce_id> <detail_name> <value> ...>`**,
**`*CE_SetSpecificDetailById <ce_id> <detail_id> <value> ...`**
- `SetSpecificDetail`/`SetSpecificDetailById` have real call sites in
  `hm/scripts/connectors/prop_ansys.tcl:411,414`,
  `prop_opt_nas_hilock.tcl:381,402,968,971,974`,
  `prop_rigid_crbody.tcl:88,117` — a parallel/older detail-setting API
  alongside `DetailSet*`, apparently used more by the property-card
  (`prop_*.tcl`) connector-config scripts than by the browser itself.
  `SetGlobalSharedEntitySettings`, `SetLinkChangeManagerSettings` are
  sibling global-settings setters, existence-only in this pass.
- Confidence: **LOCAL-INSTALL** (`SetSpecificDetail`/`ById`, 8+ real
  call sites) / **UNVERIFIED** (`DetailSetTriple`/`DetailSetUint`,
  name-only).

**`*CE_DetailDelete <ce_id> <detail_name>`**, **`*CE_DetailDeleteByMark`**
- Signature: `hm/scripts/connectors/prop_opt_nas_hilock.tcl:560,561,562`
  — removes a previously-set detail key from a connector.
- Confidence: **LOCAL-INSTALL** (3 real call sites, `DetailDelete`
  only; `ByMark` sibling is existence-only).

**`*CE_GlobalSetInt <detail_name> <value>`**, **`*CE_GlobalSetDouble`**,
**`*CE_GlobalSetString`**
- Signature: `hm/scripts/context/src/connectors/core/ConnectorBolt.tcl:7,17`
  — sets a *global* (session-wide, not per-connector) connector setting,
  e.g. default bolt behavior flags.
- Confidence: **LOCAL-INSTALL** (`GlobalSetInt`, 2 real call sites) /
  **UNVERIFIED** (`Double`/`String` siblings, name-only).

### Export

**`*CE_ExportFile <flag> <"all"|selection> <file_path> <heading> <with_metadata_flag> <format_option> <extra_string> <extra_flag> [fem_data_flag] [app_data_flag]`**
- Signature (5 real call sites, consistent leading shape across all of
  them):
  ```tcl
  *CE_ExportFile 1 "all" $of_name $heading $with_mdata $option 0 0
  *CE_ExportFile 1 "all" $xmlFile "ALTAIR_DEFAULT" 1 3 "0" 0
  *CE_ExportFile 1 "all" "[file normalize $Con_singleFile]" "ALTAIR_DEFAULT" $Con_metadataCheck $option1 "" 0
  *CE_ExportFile 1 "all" $filePath "ALTAIR_DEFAULT" 0 5 "" 0
  ```
  (from `hm/scripts/connectors/ce_table.tcl:3168`,
  `hm/scripts/femsite/conn/procs/export.tcl:150`,
  `hm/scripts/ImportExport/Export_GUI_Connectors.tcl:522`,
  `hm/scripts/br/views/modules/core/actions.tcl:788`). `<heading>` is
  consistently the literal string `"ALTAIR_DEFAULT"` at every call site
  that isn't the browser's own custom-heading path. `<format_option>`
  numeric values seen: `3` and `5` (not enumerated further — likely a
  connector-XML/CSV format selector).
- Return shape: return value discarded/`catch`-wrapped at every call site.
- Confidence: **LOCAL-INSTALL** (5 real call sites, highly consistent
  positional pattern — second-strongest source-derived signature in this
  file after `DetailSetString`).

**`*CE_ExportFiles`**, **`*CE_ExportOneFile`**,
**`*CE_ExportMainConnectorsFile <flag> <path> <heading> <flag2>`**,
**`*CE_ExportMasterConnectorsFile`**
- `ExportMainConnectorsFile` has a real call site:
  `hm/scripts/weld-connector-lib.tcl:56`:
  `*CE_ExportMainConnectorsFile 1 "$maspath" "ALTAIR_DEFAULT" 1`.
  `ExportOneFile` has a real call site:
  `hm/scripts/assemblytools/at/utils/CommonUtilApi/moduleutils.tcl:242`.
  `ExportFiles`/`ExportMasterConnectorsFile` are existence-only.
- Confidence: **LOCAL-INSTALL** (`MainConnectorsFile`, `OneFile`) /
  **UNVERIFIED** (`ExportFiles`, `MasterConnectorsFile`, name-only).

### Grouping / organizing

**`*CE_ConnectorGroupCreateAndOrganizeConnectors <collector_type> <mark_id_or_flag> <criteria_option> <delete_option> <organize_option_or_mark>`**
- Signature (2 real call sites,
  `hm/scripts/br/views/connectors/core/common/operations/organize.tcl:225,264`):
  ```tcl
  *CE_ConnectorGroupCreateAndOrganizeConnectors connectorgroups 3 0 0 $markid
  *CE_ConnectorGroupCreateAndOrganizeConnectors CONNECTORGROUPS $criteriaOption $deleteOption $organizeOption
  ```
  Note the inconsistent casing between the two real call sites
  (`connectorgroups` vs `CONNECTORGROUPS`) — both are real, unedited
  source lines; Tcl command args are case-sensitive strings passed through
  to the C-registered command, so this is presumably tolerant of case (not
  independently confirmed) — flagged as an odd but real inconsistency in
  Altair's own shipped code, not a typo introduced by this doc.
  Live probe call `*CE_ConnectorGroupCreateAndOrganizeConnectors
  connectorgroups 3 0 0 0` ran without a Tcl error (`errC4=0`).
- Return shape: creates/organizes a `connectorgroups` entity from existing
  connectors per the criteria/delete/organize options (numeric enums, not
  decoded further here).
- Confidence: **RUNTIME-TESTED (LOCAL-INSTALL)** for "runs without a
  Tcl error"; **LOCAL-INSTALL** for the exact argument meanings
  (inferred from variable names at the 2 real call sites, not from an
  Altair doc).

**`*CE_ConnectorGroup`**
- A live no-arg call `*CE_ConnectorGroup` returned without a Tcl error in
  this session's probe (`err=0`) — but with no arguments this is not proof
  it does anything meaningful; likely requires args to have an effect.
- Confidence: **UNVERIFIED**.

**`*CE_ConnectorCombine`**, **`*CE_ConnectorPartition`**,
**`*CE_ConnectorRemoveDuplicates`**, **`*CE_ConnectorLineCombine`**,
**`*CE_ConnectorLineCombineWithCC`**, **`*CE_SeamCombineByMark`**
- Confidence: **UNVERIFIED** — exist in `info commands`, no isolated call
  site read in this pass, no live test attempted (name suggests
  merge/split/dedup operations on existing connectors, analogous to the
  entity-merge patterns documented for other types in
  `HYPERMESH_ENTITY_MODEL_API_REF.md`).

### FE registration / shared-entity plumbing (`*CE_FE_*`)

This sub-family (`CE_FE_Register`, `CE_FE_RegisterAdvanced`,
`CE_FE_RegisterSharedEntities`, `CE_FE_RegisterSharedEntitiesByMark`,
`CE_FE_UnregisterRealizedEntities`, `CE_FE_UnregisterSharedEntitiesByMark`,
`CE_FE_AutoRegisterSharedEntitiesByMark`, `CE_FE_SetCommonDetails`,
`CE_FE_SetDetails`, `CE_FE_SetDetailsAndRealize`, `CE_FE_SetSpecificDetail`,
`CE_FE_SetSpecificDetailById`, `CE_FE_CreateDCC`, `CE_FE_CreateUCCFromDCC`,
`CE_FE_CreateUCCFromUCC`, `CE_FE_CreateUCCFromConnector`,
`CE_FE_UCCUpdateByDCC`, `CE_FE_UpdateUCCUseConnector`,
`CE_FE_ConnectorUpdateByCC`, `CE_FE_LoadFeConfig`, `CE_FE_GlobalFlags`,
`CE_FE_1DQuality`, `CE_FE_3DQuality`, `CE_FE_Absorb`,
`CE_FE_AbsorbAndCreate`) manages Connector Controls (DCC = Default
Connector Control, UCC = User Connector Control) and the low-level
"registration" step that ties realized FE back to their owning connector.

Real call sites found:
- `*CE_FE_CreateDCC 1` —
  `hm/scripts/context/src/connectors/core/connectorcontrolmanager.tcl:399`.
- `*CE_FE_CreateUCCFromUCC $newEntityName $item_contents(username)` — same
  file, line 939.
- `*CE_FE_CreateUCCFromDCC $newEntityName $controllerName` — same file,
  line 964.
- `*CE_FE_SetDetailsAndRealize 2 1001 $projtol 0 0 0 0 0 $acmdia $wcfg 1 1`
  — `hm/scripts/weld-connector-lib.tcl:519` (mark id 2, a numeric config
  id `1001`, then tolerance/geometry/flag args — the highest-arity real
  call site found in this whole family, worth reading in full if
  reproducing weld-connector creation).
- `*CE_FE_SetSpecificDetail`/`*CE_FE_SetSpecificDetailById` — same shape
  as the non-FE `SetSpecificDetail`/`ById` siblings above, real call site
  in `connectorcontrolmanager.tcl` context.

Confidence: **LOCAL-INSTALL** for the 4 commands with real call
sites listed above; **UNVERIFIED** (name-only) for the remaining ~20
commands in this sub-family — this is the single largest sub-family in the
whole `*CE_*` command set and the least independently confirmed; treat it
as the next place to probe if a future pass needs FE-registration detail.

### Review / diagnostics (`*CE_Review*`)

**`*CE_ReviewConnectors <...>`**, **`*CE_ReviewLinks <...>`**,
**`*CE_ReviewConnectorCollectors`**, **`*CE_ReviewConnectorsReverse`**
- Real call sites in `hm/scripts/connectors/connector_review.tcl` (lines
  217-468) — these back the Connector Browser's "Review" panel (a
  diagnostic UI listing connectors/links with filter/sort options). Args
  are GUI-state-derived (filter option ids, sort flags) rather than plain
  data — not a clean scriptable signature; treat this sub-family as
  GUI-panel-bound, low reuse value for a headless automation agent.
- Confidence: **LOCAL-INSTALL** (real call sites) but explicitly
  flagged low-reuse/GUI-bound, same caveat style as the advtools
  dialog-bound procs noted in `HYPERVIEW_API_REF.md`.

**`*CE_ColinearityCheck`**, **`*CE_ProjectionCheck`**,
**`*CE_TooCloseToEdgeCheck`**, **`*CE_CheckLinkEntities`** (via
`hm_ce_checklinkentities`, see query section)
- Confidence: **UNVERIFIED** (name-only, model-QA/validation checks —
  plausibly useful for a ModelCheck-style future domain, see
  `API_DOC_EXPANSION_TASKLIST.md`'s suggested "ModelCheck" domain).

### Cleanup / conversion

**`*CE_Cleanup`**, **`*CE_ConvertByMark`**, **`*CE_ConvertByMark_new`**,
**`*CE_ConvertLinksByMark`**, **`*CE_Unrealize`**
- `Unrealize` is the direct counterpart to `CE_Realize` documented above
  (same mark-based pattern expected: `connectors` mark id + flag) — no
  isolated real call site found for `*CE_Unrealize` itself in this pass
  (only its `AE_Unrealize` attachment-layer sibling was confirmed above),
  so treat the exact arg count as inferred-by-symmetry, not confirmed.
- Confidence: **UNVERIFIED** for exact args on all 5 (name-only /
  inferred-by-symmetry).

---

## Query commands (`hm_ce_*`) — read-only, separate namespace from `*CE_*`

These are ordinary `hm_*`-style Tcl commands (no leading `*`, standard
`command arg1 arg2 ...` call form), confirmed live in this session's probe
against a real just-created connector (id `1`, type `spot`).

**`hm_ce_type <connector_id>`**
- Signature: `hm_ce_type $cid` (single connector id, NOT
  `hm_ce_type connectors $cid` — that two-arg form errors live with
  `"Connector entity not found."`).
- Return shape: a string describing the connector's anchor geometry kind,
  e.g. `"point/node"` (confirmed live for a nodes-anchored spot connector).
- Precondition: connector id must exist.
- Confidence: **RUNTIME-TESTED (LOCAL-INSTALL)**.

**`hm_ce_state <connector_id>`**
- Signature: `hm_ce_state $cid` (same single-arg form as `hm_ce_type`).
- Return shape: a string, e.g. `"unrealized"` (confirmed live, before
  calling `*CE_Realize`). Not re-checked live after realizing in this
  session — treat "does it flip to `realized` after `*CE_Realize`?" as
  RUNTIME-TEST-NEEDED, not assumed.
- Confidence: **RUNTIME-TESTED (LOCAL-INSTALL)** for the unrealized
  case; **RUNTIME-TEST-NEEDED** for confirming the post-realize value.

**`hm_ce_size <connector_id>`**
- Signature: `hm_ce_size $cid` — ran live without error, returned an empty
  string for a freshly-created point/node spot connector (size may only
  be populated for area/seam connectors with real geometric extent — not
  confirmed either way).
- Confidence: **RUNTIME-TESTED (LOCAL-INSTALL)** for "callable,
  returns without error"; return value's exact meaning for spot connectors
  is **UNVERIFIED**.

**`hm_ce_numlinkentities <connector_id> <layer_index>`**
- Signature: `hm_ce_numlinkentities $cid 1` — confirmed live, returned
  `0` for the freshly-created connector's layer 1 (consistent with the
  connector having a components-link mark that was cleared/consumed by
  creation, or with layer indices being 0-based elsewhere — not
  disambiguated here).
- Confidence: **RUNTIME-TESTED (LOCAL-INSTALL)**.

**`hm_ce_getlinkentities <connector_id> <layer_index>`**
- Signature: 2-arg form errors live with `"Invalid entity type given."` —
  the actual required signature is NOT `(id, layer_index)`; likely
  `(connector_id, layer_index, entity_type)` or similar (extra arg
  needed). Not resolved in this pass.
- Confidence: **UNVERIFIED** (2-arg guess confirmed wrong live; correct
  form not found).

**`hm_ce_getcollector <connector_id> <arg2>`**
- Signature: confirmed live to require exactly 2 parameters (error
  message: `"Requires 2 parameter(s)."` when called with 1 arg). Second
  arg not resolved in this pass — likely a collector-type selector.
- Confidence: **UNVERIFIED** for the second argument; arg **count** is
  RUNTIME-TESTED.

**`hm_ce_getfe <connector_id> <arg2> <arg3> <arg4>`**
- Signature: confirmed live to require exactly 4 parameters (error:
  `"Requires 4 parameter(s)."`). Args 2-4 not resolved in this pass.
- Confidence: **UNVERIFIED** for args 2-4; arg **count** is RUNTIME-TESTED.

**`hm_ce_detailget <ce_id> <detail_type> <detail_name>`**
- Signature: confirmed live via usage message:
  `"usage: hm_ce_detailget ce_id detail_type detail_name"` — 3 args, the
  read counterpart to `*CE_DetailSetString`/`*CE_DetailSetDouble`/etc.
  `<detail_type>` is presumably one of `int`/`double`/`string`/`triple`/
  `uint` mirroring the setter family names (not independently confirmed).
- Confidence: **RUNTIME-TESTED (LOCAL-INSTALL)** for the 3-arg
  signature itself (from the live usage string); **UNVERIFIED** for what
  values `<detail_type>` accepts.

**`hm_ce_info <ce_id> <RequestName>`**
- Signature: confirmed live via usage message:
  `"usage: hm_ce_info CE_ID RequestName"` — 2 args. `RequestName` values
  not enumerated (not an Altair-doc source available locally, and no Tcl
  call site found using this command).
- Confidence: **RUNTIME-TESTED (LOCAL-INSTALL)** for the 2-arg
  signature; **UNVERIFIED** for valid `RequestName` values.

**Other `hm_ce_*` commands confirmed to exist (not individually live-tested
beyond the `info commands` listing above):** `hm_ce_alldetailsget`,
`hm_ce_getconnectorcontrol`, `hm_ce_getconnectorcontrollist`,
`hm_ce_getconfigfromconnectorcontrol`,
`hm_ce_getdefaultconnectorcontrolfromconfig`, `hm_ce_cfglistget`,
`hm_ce_cfgnumget`, `hm_ce_cfgsolversget`, `hm_ce_compsgetfromelems`,
`hm_ce_compsgetfromentities`, `hm_ce_compsgetfromproperties`,
`hm_ce_findconnectorsfromFEs`, `hm_ce_findFEsfromconnectors`,
`hm_ce_findconnectorsfromparts`, `hm_ce_findconnectorsfromprops`,
`hm_ce_findpartsfromconnectors`, `hm_ce_findpropsfromconnectors`,
`hm_ce_findmodulesfromconnectors`, `hm_ce_findconnectorsfrommodules`,
`hm_ce_findconnectorsfromconnectors`, `hm_ce_findduplicates`,
`hm_ce_checklinkentities`, `hm_ce_checkprojection`,
`hm_ce_tooclosetoedgecheck`, `hm_ce_getlinkinfo`,
`hm_ce_getlinkentityinfo`, `hm_ce_getresolvedlinkentities`,
`hm_ce_getunsyncdata`, `hm_ce_getprojectiondata`,
`hm_ce_getprojectiondatabyvector`, `hm_ce_getthickness`,
`hm_ce_getrealizedtestpoints`, `hm_ce_gettestpoints`. Roughly 60 more
exist beyond this list (see full `info commands *hm_ce_*` output in
`_clean/tests/probe_connectors_domain3_out.txt`) — this file documents the
~30 most clearly reusable ones by name, not the full set.
- Confidence: **UNVERIFIED** (existence only) for every command in this
  paragraph.

---

## Summary / scope honesty note

The real `*CE_*`/`*AE_*` surface is large (132 + 10 = 142 mutation
commands, plus ~100 `hm_ce_*` query commands — 242+ total). This file
documents the ~35 commands with either a live-tested call or a real
installed-source call site (the genuinely reusable, non-GUI-callback
subset), plus names/existence for roughly another 60 that were confirmed
to exist but not independently verified further, and explicitly does not
attempt the remaining ~150+ (mostly GUI-panel-bound `hm_ce_*` finders and
the less-common `*CE_FE_*`/`*CE_Review*` variants) — those are named in
context above but not individually documented, per this task's explicit
instruction to prioritize depth on ~15-30 commands over shallow coverage
of everything.

## Cross-references

- `HYPERMESH_DATANAME_INDEX.md` — the `connectors` section there should be
  updated to point here instead of describing the gap as unresolved (not
  done in this pass, flagged as optional follow-up).
- `HYPERMESH_ENTITY_TYPE_INDEX.md` — lists `connectors`, `connectorgroups`,
  `connectorcontrols`, `connectorcontroldefaults`, `connectorsets`,
  `attachments`, `attachmentcontrols`, `attachmentcontroldefaults` as
  distinct entity types in the 174-type list; this file's commands create/
  manage instances of those types.
- `API_INDEX.md` — add an entry for this file (done, see below).

## Raw probe artifacts (for audit)

```text
_clean/tests/probe_connectors_domain.tcl   /  probe_connectors_domain_out.txt
_clean/tests/probe_connectors_domain2.tcl  /  probe_connectors_domain2_out.txt
_clean/tests/probe_connectors_domain3.tcl  /  probe_connectors_domain3_out.txt
_clean/tests/probe_connectors_domain4.tcl  /  probe_connectors_domain4_out.txt
```
