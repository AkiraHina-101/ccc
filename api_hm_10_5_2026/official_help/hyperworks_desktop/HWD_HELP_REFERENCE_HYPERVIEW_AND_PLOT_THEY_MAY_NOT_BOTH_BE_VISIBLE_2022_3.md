# HyperWorks Desktop Help reference — HyperView and plot. They may not both be visible. (2022.3)

1 source pages in the shared Desktop Help Index Terms. This exact source-label group may mix API contracts and user guidance. Open the direct Altair page for full details. [Back to route index](./HWD_OTHER_HELP_CATALOG_2022_3.md).

| Official page | Exact Type / Application | Syntax | Purpose | Key inputs / outputs / returns |
| --- | --- | --- | --- | --- |
| [*Connection()](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/sessions/connection_sf.htm) | HyperView and plot. They may not both be visible. | `*Connection (mpgid, mwinid, mid, spgid, swinid, sid)` | Used to establish a live link between a measure and a plot curve. A master/slave relationship is created be the two entities. The measure is the master and the slave is the child. Update events are passed from the master to the slave as needed; this is what makes it a live link. | **Inputs:** mpgid Master page ID (zero based index). mwinid Master window ID (zero based index). mid String consisting of "measureid:itemid:dopt" measureid measure ID itemid measure item ID dopt display option 0 x_coord, 1 y_coord, 2 z_coord, 3 mag spgid Slave page ID (zero based index). swinid Slave window ID (zero based index). sid Slave ID is the curve label. |
