# HyperWorks Desktop Help reference — HyperGraph 2D, HyperGraph 3D, MediaView, MotionView, and TextView. (2022.3)

1 source pages in the shared Desktop Help Index Terms. This exact source-label group may mix API contracts and user guidance. Open the direct Altair page for full details. [Back to route index](./HWD_OTHER_HELP_CATALOG_2022_3.md).

| Official page | Exact Type / Application | Syntax | Purpose | Key inputs / outputs / returns |
| --- | --- | --- | --- | --- |
| [*RegisterHMATHReader()](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/preference/registerhmathreader.htm) | HyperGraph 2D, HyperGraph 3D, MediaView, MotionView, and TextView. | `*RegisterHMATHReader (filename, type, ext, category, funcHyperView)` | Registers a HyperMath reader with the specified characteristics/attributes. | **Inputs:** filename The filename of reader (an HML file). type (optional) The string that appears in the file type selector. ext (optional) The suffix associated with this file type. The program uses this information to filter file names easier and to accelerate file recognition. category The reader category. Options include ASCII, binary, or general. func The user-defined HyperMath function name. This should be unique so it does not conflict with other HyperMath readers. |
