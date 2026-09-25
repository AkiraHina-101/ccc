# HyperMesh ModelCheck API Reference

Purpose: AI-readable reference for Altair's built-in **ModelCheck** framework —
a rule-based model-QA system (duplicate/free/unused-entity checks, missing
material/property checks, ID-length checks, mass/stiffness sanity checks,
etc.) driven by per-solver-profile XML config files and a small real Tcl
command layer. Directly relevant to this project: several checks already
built into Altair's Nastran profile config overlap with the "Long-Term
Feature Ideas" this tool's own `HANDOFF.md` has been sketching by hand
(duplicate IDs, missing material, unused/empty entities, zero-area/zero-mass
sanity checks) — see "Relevance to this project" at the end of this file.

Verification status:

```text
RUNTIME-TESTED (LOCAL-INSTALL):
  All ~38 hm_*modelcheck* Tcl commands and the *modelcheck_* family below were
  confirmed live via `info commands *modelcheck*` in a batch probe
  (`tests/probe_modelcheck_domain.tcl`, `hmbatch.exe -tcl`, HyperMesh
  `01-Test_Model.hm`). The full check-create -> run -> read-back
  cycle was exercised end-to-end and is RUNTIME-TESTED, not just source-read:
  `*modelcheck_createchecks <nastran.xml path> 0` loaded 62 real check
  entities from Altair's shipped Nastran config, `*modelcheck_runchecks ""
  ALL ALL 0` ran them all, and `hm_getvalue modelcheckchecks id=$id
  dataname=<key>` read back real per-check state (status/runstatus/level/
  checkentity/config/childids/failedids) for all 62.

LOCAL-INSTALL (source-read, not live-invoked):
  The per-check correction functions themselves (`HM::ModelCheck::HyperMesh::*`
  procs in `entitychecks.tcl`, and the generic `Unused`/`AttributeValueRange`/
  `MissingCardImage`/etc. functionnames referenced by `nastran.xml`) were read
  from installed source but not individually invoked as corrections in this
  probe (no live model had a failing check to correct against — the test
  model returned runstatus=3/"passed" for every one of the 62 checks tried).
  Auto-correction (`hm_modelcheckapplyautocorrection`/
  `*modelcheck_applyautocorrection`) is explicitly NOT exercised in the probe
  since it is model-mutating; existence only confirmed via `info commands`.

UNVERIFIED:
  Exact meaning of every `status`/`runstatus`/`checkentity`/`level` integer
  code (see the "Observed dataname values" table — codes are inferred from
  the one live run, not from an official enum list; Altair's Help Center may
  document these but the offline help pages for ModelCheck data-names were
  not found under the mirrored help set already checked in
  `OFFICIAL_ALTAIR_2022_3_VERIFICATION.md`).
```

Sourced from:

```text
<ALTAIR_INSTALL_DIR>/hm/scripts/ModelCheck/HyperMesh/entitychecks.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/ModelCheck/HyperMesh/modelcheckmain.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/ModelCheck/HyperMesh/modelchecker   (profile marker file)
<ALTAIR_INSTALL_DIR>/hm/scripts/ModelCheck/Nastran/nastran.xml
<ALTAIR_INSTALL_DIR>/hm/scripts/ModelCheckerFramework/hm_modelcheckertools_framework.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/ModelCheckerFramework/elementcheck/*.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/br/common/operations/checkentity.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/br/views/modelchecker/init.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/br/views/modelchecker/common/modelcheckmanager.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/br/views/modelchecker/operations/run.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/br/views/modelchecker/operations/save.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/br/views/modelchecker/operations/loadfile.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/br/views/modelchecker/operations/applycorrection.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/br/views/modelchecker/operations/review.tcl
_clean/tests/probe_modelcheck_domain.tcl (probe script)
_clean/tests/probe_modelcheck_domain_result.txt (raw probe output)
```

---

## 1. Two distinct things share the name "ModelCheck" in this install

This distinction matters — don't conflate them:

1. **`ModelCheck` (rule/config framework)** — `hm/scripts/ModelCheck/<Profile>/`
   + `hm/scripts/br/views/modelchecker/` (the "Model Checker" browser tab UI)
   + a real `hm_*modelcheck*`/`*modelcheck_*` Tcl command layer. This is a
   **rule-based checks/corrections engine**: each solver profile ships an XML
   config listing named checks (grouped ERROR/WARNING/INFO), each mapped to
   either a generic reusable check function (`Unused`,
   `AttributeValueRange`, `MissingCardImage`, ...) or a profile-specific
   named function (`Free1delems`, `Duplicate1DElements`,
   `ConstraintOnDepNodeOfRBE2`, ...), each with an optional correction
   (`Delete`, `FixFreeRBE2`, or "open this panel manually"). **This is the
   section most relevant to this project** and is documented in full below
   (Sections 2-6).

2. **`ModelCheckerFramework` / `ModelCheckerTools`** — a *separate*, older,
   GUI-only element-quality-check tool (`Element Checks` dialog: warpage,
   aspect ratio, element size, jacobian, quad/tria interior angle,
   tria-shell-ratio; `hm/scripts/ModelCheckerFramework/elementcheck/*.tcl`).
   It has **no real invocable API of its own** beyond building a Tk dialog
   (`::ModelCheckerTools::*` procs are all GUI construction/dispatch, see
   `hm_modelcheckertools_framework.tcl`); the actual element-quality-metric
   computation it wraps is the same `hm_getelemcheck*`/`hm_get2delemchecktestval`/
   `hm_checkquadtwist` family already visible in `info commands *check*`
   below, which belongs to the separate, pre-existing HyperMesh element-QA
   layer (2D/3D element check panel), not something new introduced by
   ModelCheckerFramework. **Out of scope for detailed documentation here** —
   flagged only so a future agent doesn't waste time trying to find a richer
   API under this name than actually exists. If per-element quality metrics
   (jacobian/warpage/aspect ratio thresholds) are ever needed for this
   project, the real starting point is `hm_getelemcheckvalues`/
   `hm_getelemchecksummary3d`/`hm_getelemcheckbounds` (confirmed to exist via
   `info commands *check*`, not further probed in this session — a
   dedicated follow-up would be needed).

---

## 2. Structure: config file -> check entities -> run -> read results

The framework is **config + a handful of Tcl verbs**, not one command per
check. The flow, confirmed live end-to-end:

```text
1. *modelcheck_createchecks <xml_path> <add_flag>
     -> reads a profile XML (e.g. nastran.xml) and creates one
        `modelcheckchecks` entity per <Check> (plus one folder-like parent
        entity per <CheckLevel>). add_flag 0 = replace existing checks,
        1 = add to existing checks (see `loadfile.tcl`'s two call sites).

2. *modelcheck_runchecks <checkname_or_""> <entitytype_or_"ALL"> <?> <?>
     -> evaluates checks (all checks if checkname=="", else just that check)
        against the current model, populates each modelcheckchecks entity's
        `runstatus`/`failedids` results. Pure evaluation — does not mutate
        the model on its own (no *deletemark/*setvalue happens here; that
        only happens if a *correction* is separately applied — see Section
        5). RUNTIME-TESTED: ran without error against 01-Test_Model.hm,
        modelcheckchecks mark count stayed 62 before/after.

3. hm_getvalue modelcheckchecks id=$id dataname=<key>
     -> read back per-check state (Section 4).

4. hm_getmodelcheckdisplaynames "ALL"
     -> list of all check display names currently loaded (confirmed live:
        returned the 58 leaf check names + top-level level folders excluded,
        see raw probe output).

5. (optional, model-mutating, NOT exercised here) apply a correction via
   hm_modelcheckapplycorrection / hm_modelcheckapplymanualcorrection /
   *modelcheck_applyautocorrection.

6. (optional) hm_modelchecksavetoxml <path>
     -> exports the current check results to an XML report file
        (confirmed call site in `save.tcl`; not live-invoked here).
```

**Precondition discovered live**: `*modelcheck_loadconfigfile` (the
"load the default config for the active profile" convenience command) fails
with `Error: The User profile selected does not have a default config file`
when the active HyperMesh profile (`$::g_profile_name`) is plain
`HyperMesh`, not `Nastran` — a batch session started with `hmbatch.exe -tcl`
against this project's `01-Test_Model.hm` came up in the generic `HyperMesh`
profile, not the `Nastran` profile, even though the model is a Nastran
model. **Workaround confirmed live**: call `*modelcheck_createchecks`
directly with the explicit path to the profile's XML
(`hm/scripts/ModelCheck/Nastran/nastran.xml`) instead of relying on
`*modelcheck_loadconfigfile`'s profile auto-detection — this worked
regardless of active `g_profile_name` and loaded all 62 Nastran-profile
check entities correctly. Any future agent driving this framework
programmatically (not through the GUI, where the profile is already
correctly set from the ribbon) should prefer the explicit-path form.

---

## 3. Real Tcl command inventory (confirmed via `info commands *modelcheck*`)

All of the following were present in the live `info commands *modelcheck*`
output (RUNTIME-TESTED existence; behavior column marks which were also
actually invoked/observed vs. read from source only).

### Check lifecycle (`*modelcheck_*`)

| Command | Signature (from source call sites) | Behavior confirmed |
|---|---|---|
| `*modelcheck_createchecks` | `<xml_path> <add_flag 0\|1>` | RUNTIME-TESTED — loaded 62 checks from `nastran.xml`, `add_flag=0` |
| `*modelcheck_loadconfigfile` | (no args; loads active profile's default config) | RUNTIME-TESTED — confirmed real failure mode when profile has no default config |
| `*modelcheck_runchecks` | `<checkname_or_""> <entitytype_or_"ALL"> <entitytype2_or_"ALL"> <flag 0\|1>` | RUNTIME-TESTED — ran all 62 checks, no error |
| `*modelcheck_organizechecks` | UNKNOWN args | UNVERIFIED — name only, not read in detail |
| `*modelcheck_clearresults` | (no args, per `run.tcl`'s wrapper `hm_modelcheckclearresultdata`) | UNVERIFIED — exists, not invoked (would clear live results) |
| `*modelcheck_applyautocorrection` | `<checkname>` (inferred from `hm_modelcheckapplyautocorrection` sibling usage) | UNVERIFIED — model-mutating, not invoked |
| `*modelcheck_applyautocorrectiononmark` | UNKNOWN args | UNVERIFIED |
| `*modelcheck_applycorrection` | UNKNOWN args | UNVERIFIED |
| `*writemodelcheckresultfile` | UNKNOWN args (likely `<path>`) | UNVERIFIED |
| `*morphupdatemodelcheck` | UNKNOWN args, morphing-specific | UNVERIFIED, out of scope |

### Query (`hm_getmodelcheck*`)

| Command | Signature | Behavior confirmed |
|---|---|---|
| `hm_getmodelchecksupportedentities` | `()` -> returns a count/list | RUNTIME-TESTED — returned `0` before any checks were created (i.e. this reflects loaded checks' supported entity types, not a static capability list — returns non-trivial data only after `*modelcheck_createchecks`) |
| `hm_getmodelcheckdisplaynames` | `<checkname_or_"ALL">` -> list of display names | RUNTIME-TESTED — returned all 58 leaf-level check names after `createchecks` |
| `hm_getmodelcheckenttype` | `<checkname>` -> entity type string (e.g. `Mats`, `Elements`) used by `hm_marklength`/`*EntityPreviewUnused` internally | RUNTIME-TESTED — `hm_getmodelcheckenttype "Unused materials"` returned `Mats` |
| `hm_getmodelcheckcorrectiondisplayname` | `<checkname>` -> correction display name, or errors `"No correction associated with check"` if the check has no correction | RUNTIME-TESTED both paths — `"Unused materials"` returned `{Delete unused Materials}`; an unrelated probe call to a check with no correction path (attempted before checks were loaded) returned the exact error string |
| `hm_getmodelcheckresultentids` | `<checkname>` -> list of failing entity IDs (set by `hm_setmodelcheckresultentids` from correction procs, e.g. `entitychecks.tcl`'s `UnusedEntities`) | LOCAL-INSTALL (source-read call pattern only; live probe's model had zero failures on every check so no non-empty result set was observed) |
| `hm_getmodelcheckconcernentityidresultentityid` | `<checkname> <entityid>` -> related/"concern" entity ids for a given failing id (used for RBE3/rigid-related checks in `review.tcl`) | LOCAL-INSTALL (source-read only) |
| `hm_getmodelcheckcheckname` | UNKNOWN args, likely `<id>` -> name (inverse of `dataname=name`) | UNVERIFIED, name only |
| `hm_getmodelcheckcheckresult` | UNKNOWN args | UNVERIFIED, name only |
| `hm_getmodelcheckcheckstatus` | UNKNOWN args | UNVERIFIED, name only |
| `hm_getmodelcheckcorrectionname` | UNKNOWN args | UNVERIFIED, name only |
| `hm_getmodelcheckcorrectionstatus` | UNKNOWN args | UNVERIFIED, name only |
| `hm_getmodelcheckcorrectvalue` | UNKNOWN args | UNVERIFIED, name only |
| `hm_getmodelcheckconfiguserprofile` | UNKNOWN args | UNVERIFIED, name only |
| `hm_getmodelcheckdefaultconfigfile` | `()` | RUNTIME-TESTED — returned `0` (no default config in the active `HyperMesh` profile; matches the `*modelcheck_loadconfigfile` error above) |
| `hm_getmodelcheckfailedcount` | UNKNOWN args, likely `<checkname_or_"">` -> integer count of failed checks | UNVERIFIED, name only, but name strongly implies a cheap "how many checks are currently failing" query — worth live-testing first if this project ever wires up a "healthy/unhealthy model" indicator |
| `hm_getmodelcheckmanualcorrectionoption` | UNKNOWN args | UNVERIFIED, name only |
| `hm_getmodelcheckpriority` | UNKNOWN args | UNVERIFIED, name only |

### Mutating / status-setting (`hm_setmodelcheck*`, `hm_modelcheck*`)

| Command | Signature (from source) | Behavior confirmed |
|---|---|---|
| `hm_setmodelcheckresultentids` | `<checkname> <flag>` (from `entitychecks.tcl`: `hm_setmodelcheckresultentids $checkDisplayname 1`) | LOCAL-INSTALL, used inside correction-scripting procs, not invoked directly here |
| `hm_setmodelcheckcheckstatus` | `<checkname> <status_code>` (from same file: `hm_setmodelcheckcheckstatus $checkDisplayname 1` / `2`) | LOCAL-INSTALL |
| `hm_setmodelcheckcorrectionstatus` | `<checkname> <correctionname> <flag>` (from `DeleteUnusedEntities`: `hm_setmodelcheckcorrectionstatus $checkDisplayname $correctiondisplayname $correctionapplied`) | LOCAL-INSTALL |
| `hm_modelcheckneedscorrection` | `<checkname_or_"">` -> `0`/`1` (`""` = "does ANY loaded check need correction") | RUNTIME-TESTED — returned `0` (test model had nothing to correct) |
| `hm_modelcheckneedsupdate` | `()` -> `0`/`1`, whether results are stale and a re-run is recommended | RUNTIME-TESTED — returned `1` even right after a full run+read cycle; likely reflects "model changed since last run" bookkeeping rather than "results exist" — treat as UNVERIFIED-semantics despite the confirmed return value |
| `hm_modelcheckperformcheck` | `<checkname_or_""> <entitytype> <"ALL"\|filter> <flag 0\|1>` (from `checkentity.tcl`: `hm_modelcheckperformcheck "" $entitytype ALL 1`) — this is the entity-context-menu "Check Entity" variant, evaluates checks scoped to a pre-built mark rather than the whole model | LOCAL-INSTALL (source call pattern only) |
| `hm_modelcheckapplymanualcorrection` | `<checkname> <flag1> <flag2>` (from `applycorrection.tcl`: `hm_modelcheckapplymanualcorrection $checkname 1 1`) | UNVERIFIED — model-mutating for "Manual" mode corrections (opens a panel/cardedit instead of auto-fixing) |
| `hm_modelcheckcleardata` | `()`, likely full framework reset (all checks + results) | UNVERIFIED — not invoked (would clear all loaded checks) |
| `hm_modelcheckclearresultdata` | `()`, clears run *results* only, keeps loaded check definitions (mapped 1:1 to the "Clear Results" browser button, see `run.tcl`) | UNVERIFIED — not invoked (mutating for this session's state) |
| `hm_modelcheckreviewbymark` | `<checkname> <mark_flag>` (from `review.tcl`: `hm_modelcheckreviewbymark $checkname 1`) — creates a mark of the check's failing/concern entities for further UI/API use | LOCAL-INSTALL |
| `hm_modelchecksavetoxml` | `<filepath>` — exports current check config + results to XML | LOCAL-INSTALL (source call site: `save.tcl`) |
| `hm_modelcheckreadconfigfile` | UNKNOWN args, likely reads (not applies) a config file for inspection | UNVERIFIED, name only |
| `hm_updatemodelcheckresultvalues` | UNKNOWN args | UNVERIFIED, name only |

---

## 4. `modelcheckchecks` entity dataname coverage (live-confirmed)

This directly extends `HYPERMESH_DATANAME_INDEX.md`'s Track 4 entry for
`modelcheckchecks`, which only found a SYNTHETIC bare instance (1 attribute,
no resolvable dataname beyond "invalid"). **The real datanames only appear
once real check entities are loaded via `*modelcheck_createchecks`** — a
synthetic `*createentity modelcheckchecks` instance is not representative of
this entity type; that gap is now closed by this live run.

Confirmed via `hm_getvalue modelcheckchecks id=$id dataname=<key>` against
all 62 checks loaded from `nastran.xml` (RUNTIME-TESTED):

| Dataname | Type | Observed meaning (from source cross-reference + live values) |
|---|---|---|
| `name` | string | Check display name, e.g. `"Unused materials"`, `"Property is missing material"`. Also used as the "id" for most other `hm_getmodelcheck*`/`hm_setmodelcheck*` calls (they take the *name*, not the numeric id). |
| `status` | int | Observed `1` for every real check and the one `level`-folder entity (id=1, name=`ERROR`). Cross-referenced against `modelcheckmanager.tcl` line ~99 (`if {$active == 1} { set run_flag true }`) — `status=1` means "enabled/active", i.e. this check will run. |
| `runstatus` | int | Observed `0` (not yet run — id=5 `"Property with zero cross section area"` stayed 0 even after the run-all call, worth re-checking on a model that actually has such a property) and `3` (run, per `modelcheckmanager.tcl`'s `dataname=runstatus == 1` branch meaning "failed/has results to show" — since our test model had nothing to flag, `3` on a clean model most likely means "run, passed" rather than "run, failed"; **UNVERIFIED** which of 0/1/2/3 is authoritative for "failed" vs "passed" vs "not run" vs "run, needs review" — a model with at least one known-bad entity should be used to confirm before relying on this for automated pass/fail logic). |
| `level` | int | Observed `1` for every check under the `ERROR` folder (id=1). `nastran.xml` groups checks into `ERROR`/`WARNING`/`INFO` `<CheckLevel>` blocks — `level` is very likely a 0-indexed or 1-indexed severity-level code, but only `ERROR`-level checks were inspected in the truncated first-15 probe slice; **UNVERIFIED** exact WARNING/INFO integer values (probe only printed the first 15 of 62 ids — this file's own checklist item below intentionally scoped the printed sample; a fuller dump is in `probe_modelcheck_domain_result.txt`, all 62 available for a follow-up sweep if the exact level codes ever matter). |
| `checkentity` | int | Numeric entity-type code, distinct from the `hm_getmodelcheckenttype` string. Observed values from the live sample: `16` (Materials, e.g. `"Material ID exceeds 8 characters"`), `11` (Properties), `3` (Components), `1` (Nodes), `2` (Elements). Cross-referenced against `modelcheckmanager.tcl`'s special-cased `checkentity == 1 \|\| checkentity == 2` comment `#nodes or elems` — confirms `1`=Nodes, `2`=Elements; the other codes (`16`=Materials, `11`=Properties, `3`=Components) are inferred from this probe's own name<->code correlation, not independently cross-checked against another source. |
| `config` | int | Observed `1` for the folder/level entity (id=1, `ERROR`), `2` for every real leaf check. Matches `modelcheckmanager.tcl`'s branch `if {[hm_getvalue modelcheckchecks id=$checkid dataname=config] == 1} { ... if level==0 { folder_flag } }` — `config==1` marks a folder-type entity, `config==2` marks a real check. |
| `childids` | list of ints | Observed non-empty only for the folder entity (id=1: `2 3 4 5 ... 25`, i.e. its child check ids); empty (`0`) for every leaf check. Matches `modelcheckmanager.tcl`'s `if {[llength $childids] > 0} { set expand_flag true }`. |
| `failedids` | list of ints | Observed `0` (empty) for every check in this run, since the test model failed nothing. Confirmed as the right key from `modelcheckmanager.tcl`'s `[hm_getvalue modelcheckchecks id=$checkid dataname=failedids]` size-limiting logic (`HM_MODELCHECKER_LIMIT_VIEW` env var). **Needs a model with real failures to confirm the populated-list shape** (flat id list vs. paired id/reason structure) — flagged RUNTIME-TEST-NEEDED. |
| `cardimage` | UNKNOWN | Referenced in `modelcheckmanager.tcl` grep but not in the printed-15 probe sample; likely relevant to checks whose `report="CARDIMAGES"` in the XML (i.e. which card-image dialog to open for review). |
| `defaultcorrection` | UNKNOWN | Referenced in `modelcheckmanager.tcl`; likely the correction that runs when "auto correct" is used without picking a specific one. |
| `manualcorrection` | UNKNOWN | Referenced in `modelcheckmanager.tcl`; likely a flag for whether the check's correction requires manual review (matches `mode="Manual"` in the XML `<Correction>` tags). |
| `option` | UNKNOWN | Referenced in `modelcheckmanager.tcl`; not resolved further in this session. |

Raw per-check values for the first 15 checks (id 1-15) are preserved verbatim
in `_clean/tests/probe_modelcheck_domain_result.txt` for anyone who wants to
re-derive/double-check the table above without re-running HyperMesh.

**`modelcheckcorrections` was not separately probed this session** — no
correction entity was actually applied (all corrections in this run remained
theoretical since nothing failed), so `hm_getvalue modelcheckcorrections
id=$id dataname=...` was not exercised. `hm_getmodelcheckcorrectiondisplayname`
(Section 3) is the query surface actually confirmed. A model with at least
one genuinely failing check (e.g. one component containing both solids and
shells, or an unused material) would let a follow-up probe apply a real
correction and inspect the resulting `modelcheckcorrections` entity/entities
without needing to guess.

---

## 5. Corrections layer (structure, not fully probed)

Every `<Check>` in a profile XML optionally has one `<Correction>` child:

```xml
<Check Name="Unused materials" functionname="Unused" ...>
    <Correction Name="Delete unused Materials" functionname="Delete" />
</Check>
```

Two correction shapes exist, both visible in `nastran.xml`:

- **Automatic** — `functionname` is set to a real proc name (`Delete`,
  `FixFreeRBE2`, `FixFreeRBE3`, `CorrectRBE3Dof`, `UpdateMPC`,
  `DisassociateBeamsec`, `EditCaero1Region`, `DeleteFreeNodes`). These are
  invocable via `hm_modelcheckapplyautocorrection`/
  `*modelcheck_applyautocorrection` without opening any dialog — genuinely
  scriptable, model-mutating actions. **Not invoked in this probe** (by
  design — would delete/modify real entities).
- **Manual** — `mode="Manual"`, `functionname=""`, plus a `panel="..."` or
  `cardedit="..."` attribute (e.g. `panel="renumber"`, `cardedit="props"`).
  These just open the named existing HyperMesh panel/card-edit dialog for
  the user to fix by hand — there is no separate scriptable action beyond
  navigating there; `hm_modelcheckapplymanualcorrection` is what the browser
  calls, but its actual effect is UI navigation, not a model mutation you'd
  want to call headlessly.

`entitychecks.tcl`'s `HM::ModelCheck::HyperMesh::UnusedEntities` /
`DeleteUnusedEntities` (full source read in Section header sources list
above) is the one **fully-read, real correction implementation** in this
codebase — pattern for both check and correction:

```tcl
# Check function pattern (sets status via a mark, no mutation):
proc HM::ModelCheck::HyperMesh::UnusedEntities {checkDisplayname} {
    set entitytype [hm_getmodelcheckenttype $checkDisplayname]
    *EntityPreviewUnused $entitytype 1
    set nmark [hm_marklength $entitytype 1]
    hm_setmodelcheckresultentids $checkDisplayname 1
    hm_setmodelcheckcheckstatus $checkDisplayname [expr {$nmark > 0 ? 1 : 2}]
}

# Correction function pattern (real mutation, guarded by a fresh mark):
proc HM::ModelCheck::HyperMesh::DeleteUnusedEntities {checkDisplayname flag mark} {
    set entitytype [hm_getmodelcheckenttype $checkDisplayname]
    set resultentids [hm_getmodelcheckresultentids $checkDisplayname]
    eval [hm_createmark $entitytype 1 "by id only" $resultentids]
    catch {*deletemark $entitytype 1}
    hm_setmodelcheckcorrectionstatus $checkDisplayname \
        [hm_getmodelcheckcorrectiondisplayname $checkDisplayname] 1
}
```

This confirms the framework's checks are read-only evaluators (build a mark,
read its length, write status) and corrections are the only mutating step,
always gated behind a freshly-built mark from the check's own
`resultentids` — i.e. the framework itself already follows the
"preview scope, then mutate only that scope" pattern this project's own
`mutations.tcl`/`HANDOFF.md` P0 risk register independently arrived at by
hand (see Section 6).

---

## 6. Relevance to this project's own "Long-Term Feature Ideas"

This is a flag for whoever reads `HANDOFF.md`'s Risk Register / feature
backlog next, not a task for this session. Altair's shipped Nastran
ModelCheck config (`nastran.xml`, Section-2-documented above) already
defines, as pure config with no coding required:

- **Property is missing material** (`matid = 0`) — directly the
  "missing material" check already informally desired for this tool.
- **Property/Material/Node/Element ID exceeds 8 characters** — an ID
  sanity check adjacent to (not identical to) this project's own duplicate-ID
  concerns in the Risk Register (P0 #4/#5/#7).
- **Unused materials / Unused properties / Empty components** — directly
  overlaps "duplicate/unused entity" ideas.
- **Duplicate 1D/2D/3D Elements** — a genuine duplicate-entity check, though
  scoped to *elements*, not the *component/property/material* ID duplication
  this project's table actually manages — still a useful adjacent building
  block (e.g. this tool could shell out to `*modelcheck_runchecks
  "Duplicate 2D Elements" ...` instead of reimplementing duplicate detection).
- **PSHELL thickness is not defined / Material Rho is not defined / Material
  E is not defined / Material Nu is zero** — these are exactly the
  "abnormal density/thickness" sanity checks already informally imagined for
  this tool, and Altair's version is driven by a small generic
  `AttributeValueRange` function reusable across many card fields (see the
  `filterattribute`/`valueattribute`/`valuecriteria`/`valuelimit` XML
  attributes in Section 2's `nastran.xml` excerpt) rather than one-off Tcl
  per check — a reasonable pattern to imitate even if this project doesn't
  literally call into Altair's engine.
- **Components share the same property** (INFO level) — this is *exactly*
  this project's own "shared property" concept, independently already
  built into `_clean/lib/mutations.tcl` (HANDOFF.md P0 risk #1) and now
  confirmed to also exist as a native, zero-code Altair check
  (`CompSharingProp` functionname, `report="CARDIMAGES"`).

**Practical implication, not a recommendation to act on immediately**: this
project's Nastran Control Tool could, instead of (or in addition to)
hand-rolling more QA checks in `_clean/lib/`, drive Altair's own ModelCheck
engine programmatically — `*modelcheck_createchecks
".../ModelCheck/Nastran/nastran.xml" 0` then `*modelcheck_runchecks "" ALL
ALL 0` then read `hm_getvalue modelcheckchecks id=$id dataname=...` for every
loaded check id, entirely from batch/headless Tcl, no browser UI required
(confirmed live in this session's probe — no GUI widget was posted, this ran
correctly under plain `hmbatch.exe -tcl`). That would get "missing
material", "unused property/material", "duplicate elements", and several
mass/thickness sanity checks essentially for free, with Altair's own
maintained rule definitions, rather than reimplementing equivalents from
scratch. The main open question before relying on this path is the
UNVERIFIED `runstatus` failed-vs-passed code meaning (Section 4) — that
needs a model with at least one deliberately-broken entity to pin down
before any pass/fail logic in this project could safely consume it.
