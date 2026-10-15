# ImportADVC()

ImportADVC()

Description​

Import ADVC result file.

Syntax​

ImportADVC(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle, bool bADVCProcessNameRule, bool bDisplayNAResult, str strSelectResultFilePath)

Inputs​

1. str​

A String specifying ADVC result folder path.

2. int​

An Integer specifying import type:

3. double​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

4. double​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

5. bool​

A Boolean specifying whether or not ADVC process IDs defined on the ADVC side are displayed.

6. bool​

A Boolean specifying whether or not the "NA Result Display" option in ADVC is enabled. When set to true, it shows "Data: ---" for missing data and "No data available" in watch data notes, applicable only to nodal output results. When set to false, standard data display rules apply.

7. str​

A String specifying result file path.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ImportADVC("path/to/the/file", 1, 60.0, 60.0, 1, 1, "")
