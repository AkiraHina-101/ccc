# HyperWorks Desktop Help reference — HyperView, MotionView, HyperGraph (2022.3)

1 source pages in the shared Desktop Help Index Terms. This exact source-label group may mix API contracts and user guidance. Open the direct Altair page for full details. [Back to route index](./HWD_OTHER_HELP_CATALOG_2022_3.md).

| Official page | Exact Type / Application | Syntax | Purpose | Key inputs / outputs / returns |
| --- | --- | --- | --- | --- |
| [*RegisterFunctionKeyProcedure()](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/preference/registerfunctionkeyprocedure.htm) | HyperView, MotionView, HyperGraph | `*RegisterFunctionKeyProcedure (key, modifier, Tcl filename, Tcl procedure)` | Assigns Tcl procedures to function keys. | **Inputs:** key The function key to be assigned to the Tcl procedure. Accepts an integer from 1 to 12. modifier The modifier (Shift, Ctrl, Ctrl+Shift) to be used with the function key. Accepts an integer from 0 to 3. 0 No modifier 1 shift 2 ctrl 3 Ctrl+Shift Tcl filename The full path to the Tcl file that contains the procedure. Tcl procedure The name of the procedure to call when the modifier and function key are pressed. Arguments for the Tcl procedure may also be included. |
