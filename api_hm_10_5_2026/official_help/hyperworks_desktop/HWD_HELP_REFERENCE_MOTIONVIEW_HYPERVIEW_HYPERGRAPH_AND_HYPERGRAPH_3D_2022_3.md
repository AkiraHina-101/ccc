# HyperWorks Desktop Help reference — MotionView, HyperView, HyperGraph and HyperGraph 3D. (2022.3)

1 source pages in the shared Desktop Help Index Terms. This exact source-label group may mix API contracts and user guidance. Open the direct Altair page for full details. [Back to route index](./HWD_OTHER_HELP_CATALOG_2022_3.md).

| Official page | Exact Type / Application | Syntax | Purpose | Key inputs / outputs / returns |
| --- | --- | --- | --- | --- |
| [*RegisterExternalDLLFunction()](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/preference/registerexternaldllfunction.htm) | MotionView, HyperView, HyperGraph and HyperGraph 3D. | `*RegisterExternalDLLFunction ("Function Name", "Third party DLL name", "Path to the compiled math function", "Number of Arguments", "Number of Outputs")` | Registers a MATLAB function in a library compiled with MATLAB Compiler version 4 or later. | **Inputs:** "Function Name" The display name of the function within the HyperWorks application. The name cannot contain spaces. "Third party DLL name" The name of the third party DLL. "Path to the compiled math function" The full path and filename of the compiled library. Usually a .dll file on Windows PC and a .so file on Linux and Unix. "Number of Outputs" The number of outputs returned from the math function. Usually "1". |
