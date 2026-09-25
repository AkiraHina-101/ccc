# Solver Profile Families — Scoping Survey (radioss/abaqus/ansys/marc/permas/samcef/dynakey)

Purpose: this is NOT a command reference. Per `API_DOC_EXPANSION_TASKLIST.md`'s
"NVH / dynakey / radioss / abaqus / ansys / marc / permas / samcef" backlog
item, this is a fast survey to decide whether any of these 7 solver-profile
folders under `hm/scripts/` are worth a full 4-part-format API doc pass later,
for a **Nastran-focused** automation agent. Verdict-only, not exhaustive
reading — proc counts are rough `grep -c "proc "` totals (includes nested/
namespaced procs), and only 2-3 representative files per folder were actually
opened.

**Tier: LOCAL-INSTALL (survey-level source skim), SCOPING-ONLY — not a
command reference, do not cite specific signatures from this file.**

## Method

1. `grep -rc "proc "` per folder under
   `<ALTAIR_INSTALL_DIR>/hm/scripts/<profile>/` for a rough
   proc count.
2. Skimmed top-level file lists per folder, opened 2-3 representative files
   per folder (smaller profiles read fully; larger ones sampled by
   suggestive filename — welds, cards, "fromnastran", "utils").
3. Looked specifically for anything generic-sounding that might apply to any
   solver profile including Nastran, or that might be misfiled under a
   solver folder for historical reasons.

## Per-profile verdicts

### radioss — SKIP
~1732 procs across 189 files (largest of the 7). Structure is deeply
profile-specific: `accelerometerMacro`, `BCs`, `clonePart`, `D01`,
`engineFileAsst`, `GRNOD`, `rbody`, `sections`, `materialTable`, `weld.tcl`
(`::radioss::meshlesswelds::*`, 35+ procs — dialog-driven meshless-weld
authoring tied to RADIOSS card formats "Fix"/"Block"). Notably,
`radioss/createPart/entitybrowser_gui.tcl` and
`entitybrowser_callbacks.tcl` are literally namespaced
`::abaqusentitybrowser::*` — i.e. copy-pasted from the Abaqus profile
verbatim, confirming this is boilerplate GUI/dialog code duplicated across
solver folders, not solver-specific logic worth extracting once, let alone
twice. No cross-solver generic utility found. Skip.

### abaqus — SKIP
~2937 procs across 152 files (highest raw proc count, likely inflated by
verbose per-dialog callback style). Top-level files are `create_cards.tcl`,
`abaquscontactcomparison.tcl`, `Contact_wizard`, `Dummy_Position_tool`,
`Renumber_tool`, `entitybrowser` (the browser radioss copied). One file,
`fromnastran.tcl`, sounds cross-solver-relevant by name, but it is a thin
GUI wrapper (`fromNastran::OpenNastranFile`/`SaveAbaqusFile`) around
Altair's separate external `fromnastran` HKS conversion executable/script —
it just manages file dialogs and calls out to that external tool; there is
no Nastran-reading logic in it to reuse. Skip.

### ansys — SKIP
~970 procs across 112 files. Files are ANSYS-specific: `ansys_create_cards`,
`ansys_analysis_options`, `convert70to80`/`convertlegacycontacts` (ANSYS
version-migration tools), `offset_ets`/`offset_reals` (ANSYS real-constant/
element-type ID offsetting), `pretension_bolt`, `hm_ansys_contact_wizard`.
All tightly coupled to ANSYS's ET/REAL/keyopt card model. No generic utility
spotted. Skip.

### marc — SKIP (thinnest of the 7)
Only ~36 procs across 6 files — by far the smallest. Read
`marc_resolvedirectprops.tcl` in full: it is a genuinely reusable-*shaped*
idea (reconciling direct per-element property/geometry assignment vs.
component-level assignment, flagging mixed/inconsistent cases) but it's
written entirely against Marc's own `PROP_GEOMITEM` card-image convention
and calls `*propertyupdate`/`*setvalue comps ... propertyid=` in a
Marc-specific way — the pattern is generic, the code is not directly
reusable without a rewrite, and this project's `HYPERMESH_ENTITY_MODEL_API_REF.md`
already documents the same underlying `*propertyupdate`/collector mechanism
for Nastran. Not worth extracting. Skip.

### permas — SKIP
~85 procs across 7 files. Entirely PERMAS card-menu/dialog plumbing
(`::PermasCards::CreateCardMenu` and per-card-category submenu builders —
loadstep/component/contact/control/property/group/load/material/output/set
cards) plus `permas_create_mpc_assign_11.tcl`, `permas_nlload_tables.tcl`,
`Abaq_groups_to_pemas_contsurfs.tcl` (a PERMAS<-Abaqus group converter, not
Nastran-relevant). No generic utility. Skip.

### samcef — SKIP
~34 procs across 3 files — smallest of all 7. `PretensionManager.tcl` and
`Samcef_Pretension.tcl` are a bolt-pretension GUI tool (large Tk variable
block + dialog callbacks) tied to SAMCEF's own load-collector/output
conventions; `samcef.mac` is the profile macro registration file. No
cross-solver value. Skip.

### dynakey (LS-DYNA) — SKIP, with one named non-finding
~935 procs across 77 files. Structure mirrors radioss closely: `clonePart`,
`createPart`, `errorcheck`, `materialTable`, `nameMapping`, `partInfo`,
`partReplacement`, `widgets`, plus dedicated rigid-body repair tools
(`findfreerigids.tcl`, `find_fix_freerigids.tcl`, `fix_illegalrigids.tcl`,
`constRgdBdyreview.tcl`) and `dynawelds.tcl`. Checked `utils.tcl` specifically
since the name is generic-sounding: it contains `file_readable` and
`show_file` (a scrollable Tk text-viewer dialog). Both are real and
technically solver-agnostic, but `file_readable` is a 3-line wrapper around
Tcl's own built-in `file exists`/`file isfile`/`file readable` (adds nothing
this project's own code couldn't call directly), and `show_file` is a
20-year-old generic Tk log-viewer dialog with no Nastran/model-data
relevance. Neither clears the bar for a follow-up extraction. Skip.

## Overall conclusion

All 7 profiles: **skip**, no full API doc pass recommended. The suspicion in
`API_DOC_EXPANSION_TASKLIST.md` that these are "solver-profile specific and
likely low-reuse for a Nastran-focused agent" is confirmed by direct
inspection, not just assumed. Two structural observations worth keeping in
mind if this ever needs revisiting:

1. GUI/dialog boilerplate is copy-pasted verbatim across profile folders
   (radioss's `entitybrowser_gui.tcl`/`entitybrowser_callbacks.tcl` are
   literally namespaced `::abaqusentitybrowser::*`) — so even "generic
   patterns" found in one profile folder are typically already duplicated,
   not uniquely sourced, elsewhere.
2. Where a profile folder contains a genuinely generic-*shaped* idea (Marc's
   direct-property-vs-component reconciliation logic), the underlying
   mechanism it calls (`*propertyupdate`, `*setvalue comps ... propertyid=`)
   is already documented for Nastran in `HYPERMESH_ENTITY_MODEL_API_REF.md`
   — so there is nothing net-new to pull forward even there.

No follow-up extraction task is recommended from this survey.
