# Tcl/Tk and GUI automation toolkits — source guide (Altair 2022.3)

Use this page to route Tcl/Tk GUI work to the right public Help layer. The detailed term-to-URL list is in [Altair Simulation Help Index Terms](ALTAIR_SIMULATION_HELP_INDEX_2022_3.md); the product-level starting points are in the [official Help catalog](../README.md).

## Choose the layer

| Layer | Use it for | Official source |
|---|---|---|
| Tcl/Tk | Standard widgets, bindings and geometry managers such as `grid`, `pack` and `place` | [Tk GUIs — HyperWorks Desktop 2022.3](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/hm/tk_gui_r.htm) |
| HWTK (HyperWorks GUI Toolkit) | Altair-style Tcl/Tk dialogs, reusable widgets, validation, file-pattern handling and custom-widget authoring | [HWTK guide — 2022.3](https://2022.help.altair.com/2022.3/hwsolvers/altair_help/topics/getting_started/overview_hwtk_r.htm) |
| HWAT (HyperWorks Automation Toolkit) | Tcl helper functions and widgets for assembling portable HyperWorks automation | [HWAT reference — Desktop 2022.3](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/hm/hwat_r.htm), [HWAT guide — 2022.3](https://2022.help.altair.com/2022.3/hwdesktop/altair_help/topics/tools/hw_auto_toolkit_r.htm), [HWAT coding conventions](HWAT_CODING_CONVENTIONS_2022_3.md) |
| HyperMesh Tcl GUI commands | HyperMesh-specific windows, panels and application integration | [HyperMesh GUI quick reference](../../hypermesh/classic_2022/HYPERMESH_GUI_API_REF.md), then exact pages in the [2022.3 Desktop API index](../hyperworks_desktop/HWD_API_HELP_INDEX_2022_3.md) |
| Python GUI | Native Python extensions and `hwx.gui` widgets | [Python GUI Toolkit](https://help.altair.com/hwdesktop/pythonapi/gui_toolkit.html); this is a different API surface from Tcl/Tk, HWTK and HWAT. |

## HWTK scope found in the 2022.3 guide

The official guide describes HWTK as a resource for Tcl/Tk dialogs, HyperWorks commands, GUI-standard demos and example code. Its table of contents has Base Widgets, Compound Widgets, Dialogs, Miscellaneous, Utils, Validation, Specify File Patterns and Write a New Custom Widget. The category landing pages for Base Widgets, Compound Widgets, Dialogs, Miscellaneous and Utils provide only their headings; the Index Terms catalog separately links individual widget references.

| 2022.3 HWTK table-of-contents page | Source coverage |
|---|---|
| [Base Widgets](https://2022.help.altair.com/2022.3/hwsolvers/altair_help/topics/chapter_heads/base_widgets_r.htm) | Landing page only; individual widgets are linked separately in the Index Terms catalog. |
| [Compound Widgets](https://2022.help.altair.com/2022.3/hwsolvers/altair_help/topics/chapter_heads/compound_widgets_r.htm) | Landing page only; individual widgets are linked separately in the Index Terms catalog. |
| [Dialogs](https://2022.help.altair.com/2022.3/hwsolvers/altair_help/topics/chapter_heads/dialogs_r.htm) | Landing page only. |
| [Miscellaneous](https://2022.help.altair.com/2022.3/hwsolvers/altair_help/topics/chapter_heads/misc_r.htm) | Landing page only. |
| [Utils](https://2022.help.altair.com/2022.3/hwsolvers/altair_help/topics/chapter_heads/utils_r.htm) | Landing page only. |
| Validation, Specify File Patterns, Write a New Custom Widget | Direct topic pages are summarized in the [HWTK quick reference](HWTK_WIDGET_REFERENCE_2022_3.md). |

The Index Terms catalog includes these directly useful pages:

- [Validation](https://2022.help.altair.com/2022.3/hwsolvers/altair_help/topics/reference/hwtk/validation_r.htm) — entry validation options and commands.
- [Specify File Patterns](https://2022.help.altair.com/2022.3/hwsolvers/altair_help/topics/reference/hwtk/specifying_file_patterns_r.htm) — file-pattern behavior for toolkit dialogs.
- [Write a New Custom Widget](https://2022.help.altair.com/2022.3/hwsolvers/altair_help/topics/reference/hwtk/widget_custom_create_t.htm) — Itcl-based example using the HWTK widget interface.

The [2022.3 HWTK quick reference](HWTK_WIDGET_REFERENCE_2022_3.md) now captures all **40 widget-reference pages and 3 topic pages** linked from the Simulation Help Index Terms. Each page was retrieved successfully and mapped to its title, purpose, format/call form and direct Altair URL. This closes the indexed widget-page census; separate demo/tutorial links outside Index Terms still need to be checked.

## Current public HWTK coverage

The unversioned current Help portal independently exposes the five category pages above. Crawling those TOCs found **40 widget-reference pages and 3 topic pages**; all 43 direct pages returned HTTP 200 and are summarized in the [current HWTK quick reference](HWTK_WIDGET_REFERENCE_CURRENT.md). A link scan of those pages found no separate downloadable Tcl/archive/script files; the source uses examples within its Help pages. The matching 40/3 counts do not prove identical content or compatibility between releases; use the direct page from the target release.

## HWAT terms indexed for 2022.3

The Simulation Help Index Terms mapping contains **179 distinct `::hwat::*` namespace terms** grouped as follows. All 179 linked function pages have now been summarized with syntax, arguments, returns, short purpose and an official URL in the [HWAT function quick reference](HWAT_FUNCTION_REFERENCE_2022_3.md). These are the terms exposed by that Index Terms page, not proof that every shipped HWAT API is represented.

| Namespace | Listed terms | What the namespace broadly covers |
|---|---:|---|
| `::hwat::core` | 9 | Higher-level HyperWorks model operations |
| `::hwat::io` | 12 | File and model input/output helpers |
| `::hwat::math` | 16 | Vector, matrix and angle helpers |
| `::hwat::solver` | 14 | Solver-oriented model operations |
| `::hwat::utils` | 113 | Entity, geometry, assembly and utility helpers |
| `::hwat::xml` | 15 | XML parsing and attribute helpers |

The Desktop HWAT overview lists seven categories, including **Widget (Tk)**, while the linked `::hwat::*` Index Terms above expose six namespaces and no separate widget namespace. HWTK is documented separately. The distinct HWAT Widget (Tk) namespace or command list is not enumerated in the captured Index Terms; continue checking public guide pages before treating that branch as accounted for.

## Current public HWAT coverage

The current HWD overview links to the HWAT reference, and its six current namespace TOCs expose **179 function pages**. All 179 direct pages were retrieved and summarized in the [current HWAT quick reference](HWAT_FUNCTION_REFERENCE_CURRENT.md). Its command names and syntax strings match the 179 entries in the 2022.3 catalog; that comparison does not establish identical details for all arguments, examples or behavior. The overview still documents seven categories including **Widget (Tk)**, but the Functions tree lists only core, I/O, math, solver, utils and XML. The separate Tk category therefore remains an open public-source inventory gap.

Release caveat: these current routes are unversioned. The HWD portal advertises HyperWorks 2026, but the linked [Functions landing page](https://help.altair.com/hwdesktop/altair_help/topics/chapter_heads/functions_r.htm) labels itself 2025.1, and direct function pages do not carry a consistent release number. Treat the reference as a current-portal lookup, not a compatibility guarantee for one exact release.

## Fast lookup workflow

1. Confirm whether the script is Tcl/Tk, a HyperMesh-specific GUI command, HWTK, HWAT, or Python `hwx.gui`.
2. Search the release-matched [Simulation Help Index Terms](ALTAIR_SIMULATION_HELP_INDEX_2022_3.md) for an exact widget/function name or topic.
3. Open the direct official page and record its release, syntax, inputs, results/side effects and examples in the owning reference.
4. When an index category is only a stub, follow the guide TOC and demos to locate child pages. Record the remaining gap instead of inferring a missing API.

