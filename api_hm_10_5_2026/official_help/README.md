# Altair public Help catalog — start here

This section gives an AI a fast route into Altair's public Help, organized by product family and release. It catalogs official Help entry points and Index Terms, and links to concise source-derived page summaries where those have been collected. Open the linked Altair page for the full contract, examples and limitations; keep the source release beside any summary.

Use [`../API_INDEX.md`](../API_INDEX.md) as the library entry point and [`../REFERENCE_FORMAT.md`](../REFERENCE_FORMAT.md) when adding a source-backed summary. Exact byte-identical generated route pages are represented once in this active catalog; their retained copies and the legacy runtime/audit notes are listed in [`../archive/README.md`](../archive/README.md).

## Route by software first; preserve each source's release

This catalog is organized for the current product reference library. A useful Altair source can be added even when its page is labeled 2022.3, 2022, or another release. Keep that label beside the citation and do not infer that the current product has identical behavior. Start with the owning software, then its child API/documentation layer, then the source release.

| Need | Start here | What it covers |
|---|---|---|
| HyperMesh, HyperView and shared Desktop Help from the 2022.3 release | [2022.3 source set](#altair-20223) | Separate product and shared-reference indexes. Preserve each source's 2022.3 label in the current product library. |
| Current HyperWorks product Help | [Current product Help index](altair_hyperworks/HYPERWORKS_PRODUCT_HELP_INDEX_CURRENT.md) | The current unified HyperWorks product Help Index Terms; includes HyperMesh, HyperView and shared clients. The portal currently identifies this as the 2026 release. |
| Current public API reference (Tcl and other API/reference pages) | [Current HWD API index](hyperworks_desktop/HWD_API_HELP_INDEX_CURRENT.md) | Current Altair API / Reference Guides Index Terms. |
| Current Python APIs and Python GUI toolkit | [HyperMesh Python API 2026.0](https://help.altair.com/hwdesktop/pythonapi/index.html) | Navigation includes Framework, HyperMesh, HyperView, HyperGraph, HyperStudy, TableView, Task Manager, Report and GUI Toolkit. This is a separate API surface from Tcl/Tk. |
| Product list and official Help entry points | [Altair HyperWorks Help home](https://help.altair.com/hwdesktop/altair_help/index.htm) | The official portal's product tree, including desktop clients, solvers, and companion tools. |

## Altair 2022.3

The 2022.3 product Help home pages expose user-facing topic trees in addition to the Index Terms catalogs. These TOCs are discovery sources, not API counts. Tutorial category pages can be short launch/navigation articles; their linked lesson routes were recursively crawled and summarized in the catalogs below:

- [HyperMesh 2022.3 Help home](https://2022.help.altair.com/2022.3/hwdesktop/hm/index.htm) — product topic tree (Get Started, Tutorials, interfaces, entities, panels, geometry, meshing, connectors, model setup, and other workflows).
- [HyperMesh 2022.3 Tutorials](https://2022.help.altair.com/2022.3/hwdesktop/hm/topics/chapter_heads/tutorials_r.htm) — the landing page plus 111 distinct tutorial-related pages are summarized with source links in the [HyperMesh tutorial catalog](hypermesh/HYPERMESH_TUTORIAL_CATALOG_2022_3.md). The Index Terms map 155 terms to those 111 URLs; the lessons themselves remain workflow documentation, not API contracts.
- [HyperView 2022.3 Help home](https://2022.help.altair.com/2022.3/hwdesktop/hv/index.htm) — product topic tree for display, model, results, annotations, menus, tools, and solver interfacing.
- [HyperView 2022.3 Tutorials](https://2022.help.altair.com/2022.3/hwdesktop/hv/topics/chapter_heads/tutorials_hv_r.htm) — six linked tutorial topics, including animation, visibility/view controls, result data analysis, querying results, working with models, and annotations. The 39 distinct tutorial-related URLs are summarized with source links in the [HyperView tutorial catalog](hyperview/HYPERVIEW_TUTORIAL_CATALOG_2022_3.md); their Index Terms contain 157 tutorial terms.
- [HyperWorks Desktop 2022.3 Help home](https://2022.help.altair.com/2022.3/hwdesktop/hwd/index.htm) — shared desktop topic tree; includes scripting-related Reference Guides, Tcl/Tk, batch, translators and result math routes.
- [HyperWorks Desktop 2022.3 tutorials](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/chapter_heads/tutorials_r.htm) — the shared HWD Index Terms map 39 terms to 17 distinct tutorial-path URLs, summarized in the [shared Desktop tutorial catalog](hyperworks_desktop/HYPERWORKS_DESKTOP_TUTORIAL_CATALOG_2022_3.md).
- [Altair Simulation 2022.3 Tutorials directory](https://2022.help.altair.com/2022.3/hwdesktop/altair_help/topics/tutorials/tutorials_hyperworks_r.htm) — cross-product tutorial discovery page; overlaps product-specific tutorial trees and must not be added as a separate API denominator.

- [HyperMesh Help index](hypermesh/HYPERMESH_HELP_INDEX_2022_3.md) — 2,298 terms, 2,438 references, 1,290 distinct page paths.
- [HyperMesh reference route catalog](hypermesh/HYPERMESH_HWD_REFERENCE_CANDIDATES_2022_3.md) — 4,498/4,498 direct pages grouped by exact `Type`/`Application`, with page syntax/purpose summaries and official links. This is a route census, not a command count.
- [HyperMesh product Help page summaries](hypermesh/HYPERMESH_PRODUCT_HELP_SUMMARIES_2022_3.md) — titles and concise descriptions for all 1,290 product-specific direct pages mapped by the 2022.3 Index Terms.
- [Help-home / release-note supplements](hyperworks_desktop/HYPERMESH_HYPERVIEW_TOC_SUPPLEMENTS_2022_3.md) — off-index 2022.3 “What's New” and release-note routes for HyperMesh, HyperView and shared Desktop, plus the HyperMesh Crash and Safety landing page. These supplement the complete Index Terms route sets and must be counted separately.
- [Tutorial Help-home tree crawl](hyperworks_desktop/HYPERMESH_HYPERVIEW_TUTORIAL_TOC_CATALOG_2022_3.md) — recursively follows official 2022.3 tutorial-tree links: HyperMesh 149 linked URLs (146 retrieved, 3 broken/malformed spellings now mapped to working canonical pages), HyperView 39/39, and shared Desktop 15/15. It includes off-index lesson/category pages and overlaps the Index Terms catalogs; deduplicate by URL before any total.
- [HyperMesh additional Help routes](hypermesh/HYPERMESH_OFF_INDEX_HELP_2022_3.md) and [HyperView additional Help routes](hyperview/HYPERVIEW_OFF_INDEX_HELP_2022_3.md) — the completed recursive 2022.3 Help-link crawl found 17 and 4 additional reachable pages respectively outside the completed direct route catalogs. The HyperMesh supplement also indexes 33 downloadable tutorial/model input files by direct Altair link.
- [Shared Desktop additional Help routes](hyperworks_desktop/HWD_OFF_INDEX_HELP_2022_3.md) — 127 further reachable pages outside the direct HWD Index Terms catalogs, including navigation topics and extra GUI/reference material. Across the HM/HV/HWD crawl, 15 broken link spellings have a matching working official route; 6 linked routes remain unresolved and are listed with their source pages.
- **Link-crawl boundary:** the completed crawl followed HTML/XML Help pages reachable inside the official 2022.3 `hm`, `hv`, and `hwd` trees. It visited 1,858 distinct page URLs: 1,837 returned HTTP 200 and 21 returned 404. Fifteen failed link spellings map to a working official page; six substantive routes remain unresolved and are listed with their referrers. Images, scripts and stylesheets are not counted as documentation pages. Links to solver-owned or other product trees remain assigned to their own Help scope.
- HyperMesh's shared HWD `reference/hm` route has 4,498 distinct direct URLs in the 2022.3 Index Terms. All 4,498 pages were retrieved and grouped by their exact Type/Application label in the [route catalog](hypermesh/HYPERMESH_HWD_REFERENCE_CANDIDATES_2022_3.md); 4,081 are explicitly labeled HyperMesh, 25 HyperWorks Tcl Query, and 392 pages provide no Type/Application label. This is a reference-route page count, not a command/API count. The earlier `*`/`hm_` term filter covered only 3,582 URLs. See [current handoff](../../api_hm_evidence/STATUS.md) for remaining web-source gaps.
- [HyperView Help index](hyperview/HYPERVIEW_HELP_INDEX_2022_3.md) — 875 terms, 947 references, 704 distinct page paths.
- [HyperView product Help page summaries](hyperview/HYPERVIEW_PRODUCT_HELP_SUMMARIES_2022_3.md) — titles and concise descriptions for all 704 product-specific direct pages mapped by the 2022.3 Index Terms.
- [HyperWorks Desktop API / Tcl / GUI index](hyperworks_desktop/HWD_API_HELP_INDEX_2022_3.md) — 11,888 terms, 12,916 references, 11,569 distinct page paths.
- [HyperWorks Desktop Tcl reference route catalog](hyperworks_desktop/HWD_TCL_REFERENCE_CATALOG_2022_3.md) — all 4,077 direct `reference/tcl` pages grouped by exact source Type/Application across HyperView, HyperWorks Tcl, HyperGraph, MotionView and related clients; 62 pages do not state a label. This is a page count, not a command count.
- [Remaining shared HyperWorks Desktop Help routes](hyperworks_desktop/HWD_OTHER_HELP_CATALOG_2022_3.md) — all 2,977 other direct HWD Index Terms pages, grouped into 91 exact source-label catalogs. Together with the HyperMesh reference route (4,498), Tcl reference route (4,077), and shared tutorials (17), these account for all 11,569 non-index page URLs in the 2022.3 HWD Index Terms. This is a page-route census, not a callable API count.
- [HyperWorks Desktop `poI*` method contract catalog](hyperworks_desktop/HYPERWORKS_DESKTOP_POI_API_CATALOG_2022_3.md) — 1,916 direct pages fetched from the 2022.3 Desktop Index Terms; includes syntax, description, owning Application label and available contract details.
- [Altair Simulation Help index](toolkits/ALTAIR_SIMULATION_HELP_INDEX_2022_3.md) — 436 terms, 470 references, 381 distinct page paths across the shared Simulation Help book. This includes HWTK/HWAT and unrelated Simulation-tool documentation; the counts are book-wide, not toolkit-only.
- [Tcl/Tk toolkit source guide](toolkits/GUI_TOOLKITS_HWTK_HWAT_2022_3.md) — routes standard Tk, HWTK, HWAT, HyperMesh GUI commands and Python GUI; tracks release-specific indexed coverage and the HWAT Widget (Tk) source gap.
- [HyperMesh GUI and script-authoring reference](../hypermesh/classic_2022/HYPERMESH_GUI_API_REF.md) — adds the exact 2022.3 Desktop Scripts tree and direct Create Scripts, Run Scripts, Command Files, Utility Menu, Tcl/Tk, and GUI-category routes. The Tcl GUI Commands and Tcl/Tk Commands landing pages are stubs; use linked Index Terms or direct child pages for contracts.
- [HyperView Result Math scripted plug-ins](../hyperview/2022/HYPERVIEW_API_REF.md) — see the 2022.3 section for TclPlugin and TemplexPlugin event flow, table inputs/outputs, interpreter functions and configuration prerequisite. Keep this scripting layer separate from HyperView console Tcl/HWI APIs.
- [HWTK widget quick reference](toolkits/HWTK_WIDGET_REFERENCE_2022_3.md) — 40 widget pages and 3 topic pages linked by the 2022.3 Simulation Help Index Terms, retrieved with direct Altair links.
- [Current HWTK widget quick reference](toolkits/HWTK_WIDGET_REFERENCE_CURRENT.md) — 40 widget pages and 3 topic pages found through the current Help category tree; all 43 retrieved with direct Altair links.
- [HWAT function quick reference](toolkits/HWAT_FUNCTION_REFERENCE_2022_3.md) — 179 official function pages with syntax, arguments, returns and source links.
- [Current HWAT function quick reference](toolkits/HWAT_FUNCTION_REFERENCE_CURRENT.md) — 179 function pages from six current namespace category trees; same names and syntax strings as 2022.3, with the Widget (Tk) category still absent from the tree.
- [HWAT coding conventions](toolkits/HWAT_CODING_CONVENTIONS_2022_3.md) — concise Tcl style, naming, return and function-header conventions from official Help.

## Other current product Help indexes

The current portal has separate Index Terms catalogs for these additional applications. Their generated Markdown files preserve every term-to-page link. Across all sources currently mapped, there are 26 populated Index Terms mappings (4 for 2022.3 and 22 current); EDEM has a separate Index Terms URL that returns no linked terms and is routed through its Help-home guide list instead:

- [HyperLife](altair_hyperworks/HYPERLIFE_HELP_INDEX_CURRENT.md) — 472 terms, 297 distinct page paths.
- [HyperLife Weld Certification](altair_hyperworks/HYPERLIFE_WELD_CERTIFICATION_HELP_INDEX_CURRENT.md) — 259 terms, 147 paths.
- [HyperLife Crack Growth](altair_hyperworks/HYPERLIFE_CRACK_GROWTH_HELP_INDEX_CURRENT.md) — 208 terms, 120 paths.
- [HyperMesh CFD](altair_hyperworks/HYPERMESH_CFD_HELP_INDEX_CURRENT.md) — 1,186 terms, 678 paths.
- [HyperMesh NVH](altair_hyperworks/HYPERMESH_NVH_HELP_INDEX_CURRENT.md) — 540 terms, 350 paths.
- [HyperStudy](altair_hyperworks/HYPERSTUDY_HELP_INDEX_CURRENT.md) — 618 terms, 355 paths.
- [HyperView Player](altair_hyperworks/HYPERVIEW_PLAYER_HELP_INDEX_CURRENT.md) — 21 terms, 13 paths.
- [Feko](altair_hyperworks/FEKO_HELP_INDEX_CURRENT.md) — 29,134 terms, 2,495 paths.
- [SimLab](altair_hyperworks/SIMLAB_HELP_INDEX_CURRENT.md) — 47 terms, 34 paths.
- [SimSolid](altair_hyperworks/SIMSOLID_HELP_INDEX_CURRENT.md) — 527 terms, 448 paths.
- [Compose](altair_hyperworks/COMPOSE_HELP_INDEX_CURRENT.md) — 1,690 terms, 1,631 paths; OML/Python user guide and reference index.
- [Twin Activate](altair_hyperworks/TWIN_ACTIVATE_HELP_INDEX_CURRENT.md) — 2,520 terms, 2,039 paths.
- [Flow Simulator](altair_hyperworks/FLOW_SIMULATOR_HELP_INDEX_CURRENT.md) — 172 terms, 171 paths.
- [Inspire](altair_hyperworks/INSPIRE_HELP_INDEX_CURRENT.md) — 1,590 terms, 786 paths; product guide covers the Inspire family branches shown in its Help navigation.
- [EDEM](altair_hyperworks/EDEM_HELP_INDEX_CURRENT.md) — the official Index Terms endpoint currently returns no term links; use the [EDEM Help home](https://help.altair.com/EDEM/index.htm) to route to Programming Guide, Coupling Interface Programming Guide and EDEMpy.

Current solver Help is hosted in separate solver portals and has separate Index Terms catalogs:

- [OptiStruct](solvers/OPTISTRUCT_HELP_INDEX_CURRENT.md) — 3,717 terms, 1,928 distinct page paths.
- [Radioss](solvers/RADIOSS_HELP_INDEX_CURRENT.md) — 2,823 terms, 1,887 paths.
- [MotionSolve](solvers/MOTIONSOLVE_HELP_INDEX_CURRENT.md) — 990 terms, 685 paths.
- [AcuSolve](solvers/ACUSOLVE_HELP_INDEX_CURRENT.md) — 929 terms, 966 paths.
- [nanoFluidX](solvers/NANOFLUIDX_HELP_INDEX_CURRENT.md) — 171 terms, 133 paths.
- [ultraFluidX](solvers/ULTRAFLUIDX_HELP_INDEX_CURRENT.md) — 58 terms, 31 paths.

Entry points: [Solver Help home](https://help.altair.com/hwsolvers/altair_help/index.htm) and [CFD Solvers Help home](https://help.altair.com/hwcfdsolvers/altair_help/index.htm). The official Desktop portal also lists manufacturing solutions and companion tools. [Manufacturing Solutions Help](https://help.altair.com/hwdesktop/mfs/mfs_content.htm) is a shared book with product chapters (including HyperXtrude); it does not use the Index Terms catalog format. Route each chapter through that book and record its owning product. Other tools still need source-by-source routing because some are chapter links rather than independent Index Terms sites.

The current HyperMesh/HyperView/HyperGraph/MotionView product Help catalog is shared at the portal level. Do not infer separate per-product page counts from it until its linked entries are classified by their actual page scope. Companion tools such as HWTK, HWAT, HvTrans and HgTrans have separate official Help routes. The [GUI/toolkit source map](GUI_AND_TOOLKIT_SOURCES.md) records both current routes and release-specific catalogs. The 2022.3 HWTK guide and 40 widget pages are summarized in the [2022.3 HWTK reference](toolkits/HWTK_WIDGET_REFERENCE_2022_3.md); the [current HWTK category-tree census](toolkits/HWTK_WIDGET_REFERENCE_CURRENT.md) also found 40 widget pages and 3 topic pages (43/43 retrieved). No direct downloadable sample files were linked from those 43 pages; sample code is handled through the in-page examples. The 2022.3 HWAT reference has 179 function pages; the [current HWAT catalog](toolkits/HWAT_FUNCTION_REFERENCE_CURRENT.md) independently found and summarized 179 functions across six namespaces. The current HWAT overview still names a seventh Widget (Tk) category absent from those namespace trees, and its linked Functions landing page shows a 2025.1 label while the HWD portal advertises 2026. Do not treat the current unversioned URLs as a uniform release compatibility guarantee.

Counts are parsed from the official Index Terms pages and describe index coverage only. Repeated terms and multiple terms linking to one page are retained. These counts do not claim that every page is an API contract.

## Route an implementation question

1. Identify the application that owns the behavior: HyperMesh, HyperView, a shared HyperWorks Desktop client, a solver, or a companion product.
2. Identify the API surface: Tcl command, Tcl/Tk GUI, HWT/HWAT toolkit, HWI/HWC, Python API, file format, or user-interface workflow. Do not assume two surfaces share syntax because they run in one application.
3. Select the exact release catalog. “Current” means the release identified by the current official portal at the time this catalog was generated; check the page title/release notes before carrying details forward.
4. Search the product's generated Index Terms for the exact command, class, panel, file type, or feature name. Follow the direct Altair Help link and read the full page.
5. Summarize the page in the focused product/API Markdown: purpose, syntax/signature, inputs, outputs/side effects, examples/limits, release, and official URL. Clearly label a source-backed summary; runtime testing is not needed for clear documentation.
6. If the page is missing or unclear, search the official Help portal and relevant official reference books. Record a scope gap instead of implying a complete API catalog.

The generated indexes are exhaustive only with respect to the Index Terms source pages listed above. They are navigation aids, not proof that all documentation pages in every Altair product are represented. Public Help may have additional books or separately hosted guides, and local Help installations can vary by installed package.

## GUI and supporting layers

- Use the focused [GUI and toolkit source map](GUI_AND_TOOLKIT_SOURCES.md) to choose between Tcl/Tk, HWTK, HWAT, shared HWI/HWC and Python `hwx.gui`.
- For current Python UI work, start at the [Python API Guide](https://help.altair.com/hwdesktop/pythonapi/index.html) and its GUI Toolkit branch; do not route Python UI requests through Tcl references.
- For Tcl/Tk and HWT/HWAT GUI work, search the release-matched HWD catalog and open its GUI/toolkit source pages. At 2022.3, also use the focused [HyperMesh GUI reference](../hypermesh/classic_2022/HYPERMESH_GUI_API_REF.md), which links known official examples and marks toolkit-list gaps.
- For HWI/HWC, start in the HWD catalog and inspect the page's documented client/application scope.
- For solver-deck names, card fields, and import/export behavior, route to the owning product/profile or solver Help, not the generic desktop API index alone.

## Source entry points

- [Current product Help home](https://help.altair.com/hwdesktop/altair_help/index.htm)
- [Current HyperWorks product Help Index Terms](https://help.altair.com/hwdesktop/hwx/indexTerms.htm)
- [Current API / Reference Guides Index Terms](https://help.altair.com/hwdesktop/hwd/indexTerms.htm)
- [Current Python API Guide](https://help.altair.com/hwdesktop/pythonapi/index.html)
- [2022.3 HyperMesh Index Terms](https://2022.help.altair.com/2022.3/hwdesktop/hm/indexTerms.htm)
- [2022.3 HyperView Index Terms](https://2022.help.altair.com/2022.3/hwdesktop/hv/indexTerms.htm)
- [2022.3 HyperWorks Desktop Index Terms](https://2022.help.altair.com/2022.3/hwdesktop/hwd/indexTerms.htm)
