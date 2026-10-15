# ExportVTFxFile()

ExportVTFxFile()

Description​

Export the VTFX file.

Syntax​

ExportVTFxFile(str strPath, int iModelType, bool bExcludeBarPart, bool bSurfaceElementOnly, int iData2D, list lSelectedResults, bool bDisplayPostAddTrescaStress, int iCurUnitLength, int iCurUnitTime, int iCurUnitMass, int iCurUnitForce, int iCurUnitAngle, int iCurUnitTemperature, bool bSetDefaultResult)

Inputs​

1. str​

A string specifying the path to the VTFX file.

2. int​

An integer specifying the model type.

3. bool​

A boolean specifying whether to exclude bar parts.

4. bool​

A boolean specifying whether to include only surface elements.

5. int​

An integer specifying the data type for 2D data.

6. list​

A list of selected results to be included in the export.

7. bool​

A boolean specifying whether to display post-processed Tresca stress.

8. int​

An integer specifying the current unit for length.

9. int​

An integer specifying the current unit for time.

10. int​

An integer specifying the current unit for mass.

11. int​

An integer specifying the current unit for force.

12. int​

An integer specifying the current unit for angle.

13. int​

An integer specifying the current unit for temperature.

14. bool​

A boolean specifying whether to set the default result for the exported file.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ExportVTFxFile("path/to/the/file", 1, 0, 0, 0, [], 0, 0, 0, 0, 0, 1, 1, 0)
