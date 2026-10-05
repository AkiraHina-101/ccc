# Altair API library — start here

This library helps an AI or engineer find the right Altair API/help page quickly. It is organized by **owning software → API layer → source release**. Official Help summaries are the primary reading path; the source URL and release label on every entry define what it actually documents.

## Read in this order

1. [Software and API-layer map](API_SOURCE_MAP.md) — decide which product owns the behavior and which scripting/API surface applies.
2. [Official Help catalog](official_help/README.md) — choose the product and release, then open the focused page-summary catalog.
3. [Focused product references](#focused-references) — use concise API-oriented summaries for recurring implementation questions.
4. [Summary format](REFERENCE_FORMAT.md) — use when adding a distinct, source-backed API note.
5. [Build status and handoff](../api_hm_evidence/STATUS.md) — see current documentation objective, completed source sets, and next work.

## Focused references

| Software / layer | Start here | What it is for |
|---|---|---|
| HyperMesh 2022.3 web Help | [Product and reference route catalogs](official_help/hypermesh/HYPERMESH_HWD_REFERENCE_CANDIDATES_2022_3.md) | Official page summaries grouped by source-declared Type/Application; page counts are routes, not command counts. |
| HyperMesh Classic Tcl / GUI | [Classic 2022 reference map](hypermesh/classic_2022/README.md) | Focused Tcl model/query, GUI, entity/data-name and solver-profile references. Preserve Classic 2022 release scope. |
| HyperView 2022 Tcl/HWI | [HyperView reference](hyperview/2022/HYPERVIEW_API_REF.md), [2022 `poI*` method catalog](hyperview/2022/HYPERVIEW_TCL_POI_API_CATALOG_2022.md) | Result, animation, client and method routes with direct Altair links. |
| HyperView 2022.3 web Help | [Product Help catalog](official_help/hyperview/HYPERVIEW_PRODUCT_HELP_SUMMARIES_2022_3.md) | Product pages and user-facing workflows, separate from API contracts. |
| Shared HyperWorks Desktop Tcl/HWI/HWC | [Official Tcl and other Help catalogs](official_help/hyperworks_desktop/HWD_TCL_REFERENCE_CATALOG_2022_3.md), [shared Help routes](official_help/hyperworks_desktop/HWD_OTHER_HELP_CATALOG_2022_3.md) | Cross-client methods, scripting, preferences, translators, batch and support routes. Check each page's Application label. |
| Tcl/Tk, HWTK, HWAT | [GUI/toolkit route map](official_help/GUI_AND_TOOLKIT_SOURCES.md), [2022.3 toolkit guide](official_help/toolkits/GUI_TOOLKITS_HWTK_HWAT_2022_3.md) | Choose standard Tk, HyperMesh GUI Tcl, HWTK, HWAT, or Python GUI by host and release. |
| HyperGraph, MotionView, HvTrans and auxiliary clients | [Product/source map](API_SOURCE_MAP.md) | Product-specific references are kept separate; do not merge APIs just because they share Tcl or HWI. |
| Solver formats and workflows | [Solver formats](solver_formats/README.md), [workflows](workflows/README.md) | Card/field/profile schemas and documented workflow notes, not general Tcl commands. |

## Find an API quickly

- Search the product's [official Help indexes](official_help/README.md) for the exact API, class, panel, file type, or feature name.
- Open its direct Altair page and use the short summary in the focused catalog; the official page remains the full contract.
- For an existing focused note, compare exact source URL and signature before adding anything. Update that note instead of copying a duplicate.
- Keep API descriptions separate from runtime evidence. A clear Altair Help page is enough to summarize documented behavior; runtime checks are only needed for installation/context availability or unresolved behavior.

## Scope and preservation

Source release is part of each fact. A 2022 or 2022.3 page may contribute useful documentation to a product reference, but it does not establish behavior in another release. The generated indexes are exhaustive only for the named index/crawl boundary; route counts are not total API counts.

Older runtime audits, project-only notes, prior navigation snapshots, and byte-identical generated pages are preserved in [archive](archive/README.md). They are historical/supporting material and are not the first-stop catalog. No archived document was discarded.
