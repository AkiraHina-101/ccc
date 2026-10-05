# HyperWorks Desktop Tcl reference — HyperWorks Desktop Tcl Modify (Help 2022.3)

1 pages from the shared HWD reference route. This is a page-type grouping, not proof that every row is a callable API. Open the Altair page for its full contract. [Back to route index](./HWD_TCL_REFERENCE_CATALOG_2022_3.md).

| Official page | Exact Type / Application | Syntax | Purpose | Key inputs / outputs / returns |
| --- | --- | --- | --- | --- |
| [hwIPage SetLayout](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/tcl/hwipage_setlayout.htm) | HyperWorks Desktop Tcl Modify | `hwIPage_handle SetLayout type` | This command sets the page layout type. | **Inputs:** type The page layout type: -1 Indicates an error 0 One window 1 Two windows (left and right) 2 Two windows (top and bottom) 3 Three windows (one left and two right) 4 Three windows (two left and one right) 5 Three windows (two top and one bottom) 6 Three windows (one top and two bottom) 7 Three windows (left, middle, and right) 8 Three windows (top, middle, and bottom) 9 Four windows 10 Six windows (three rows of two) 11 Six windows (two rows of three) 12 Nine windows 13 Twelve windows (four rows of three) 14 Twelve windows (three rows of four) 15 Sixteen windows 16 Four windows (four rows of one) 17 Eight windows (four rows of two) 18 Four windows (one row of four) 19 Eight windows (two rows of four) |
