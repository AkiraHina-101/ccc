# HyperWorks Desktop Help reference — HyperGraph 3D (2022.3)

6 source pages in the shared Desktop Help Index Terms. This exact source-label group may mix API contracts and user guidance. Open the direct Altair page for full details. [Back to route index](./HWD_OTHER_HELP_CATALOG_2022_3.md).

| Official page | Exact Type / Application | Syntax | Purpose | Key inputs / outputs / returns |
| --- | --- | --- | --- | --- |
| [*Add2DSymbolStyle()](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/preference/add2dsymbolstyle.htm) | HyperGraph 3D | `*Add2DSymbolStyle (name, path)` | Loads a bitmap file for use as a 2D symbol. | **Inputs:** name Name of the symbol. path The path of the image file defining the symbol. |
| [*Add3DSymbolStyle()](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/preference/add3dsymbolstyle.htm) | HyperGraph 3D | `*Add3DSymbolStyle (name, path, component_id, decimate)` | Loads any finite element model that can be displayed in HyperView and uses it as a 3D symbol. | **Inputs:** name The name of the symbol. path The path to the finite element model defining the symbol. component_id The ID of the component to load (or -1). decimate Whether to decimate the symbol model (true/false). |
| [*BeginPlot3DDefaults()](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/preference/beginplot3ddefaults.htm) | HyperGraph 3D | `*BeginPlot3DDefaults()` | Begins the HyperGraph 3D-specific defaults block in the preferences file. | Not stated |
| [*EndPlot3DDefaults()](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/preference/endplot3ddefaults.htm) | HyperGraph 3D | `*EndPlot3DDefaults()` | Ends the HyperGraph 3D-specific defaults block in the preferences file. | Not stated |
| [*SetZAxisLabel()](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/preference/setzaxislabel.htm) | HyperGraph 3D | `*SetZAxisLabel ("string")` | Specifies the default label for the primary z axis. | **Inputs:** string The default label for the primary z axes. Must be in double quotes. |
| [*ZAxisLabel()](https://2022.help.altair.com/2022.3/hwdesktop/hwd/topics/reference/preference/zaxislabel.htm) | HyperGraph 3D | `*ZAxisLabel (label)` | Specifies the label for the z axis. | **Inputs:** label The label for the Z axis. |
