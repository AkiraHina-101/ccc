# HyperWorks Desktop Help reference — HyperView, MotionView, HyperGraph. (2022.3)

1 source pages in the shared Desktop Help Index Terms. This exact source-label group may mix API contracts and user guidance. Open the direct Altair page for full details. [Back to route index](./HWD_OTHER_HELP_CATALOG_2022_3.md).

| Official page | Exact Type / Application | Syntax | Purpose | Key inputs / outputs / returns |
| --- | --- | --- | --- | --- |
| [*RegisterCtrlKeyProcedure()](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/preference/registerctrlkeyprocedure.htm) | HyperView, MotionView, HyperGraph. | `*RegisterCtrlKeyProcedure (key, Tcl filename, Tcl procedure)` | Assigns Tcl procedures to keyboard letter keys. | **Inputs:** key The keyboard letter key to be assigned to the Tcl procedure. Letters are not case sensitive.Note: The following keys are already in use and cannot be used with this preference statement: B C E N O P S V X Tab Esc Text navigation keys (Arrow keys, Insert, Home, Page Up, Delete, End, Page Down). Any other shortcut keys defined by the operating system. Tcl filename The full path to the Tcl file that contains the procedure. Tcl procedure The name of the procedure to call when the Ctrl and keyboard letter keys are pressed. Arguments for the Tcl procedure may also be included. |
