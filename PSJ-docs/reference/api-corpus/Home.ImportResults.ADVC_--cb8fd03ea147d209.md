# Home.ImportResults.ADVC()

Home.ImportResults.ADVC()

Description​

Import ADVC result file.

Syntax​

Home.ImportResults.ADVC(...)

Macro: ImportADVC

Ribbon: Home » ImportResults » ADVC

Inputs​

strPath​

A String specifying ADVC result folder path.

This is a required input.

iImportType​

An Integer specifying import type:

1: Standard ADVC2 by Property

2: Simple Topology

The default value is 1.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0 (degree).

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0 (degree).

bADVCProcessNameRule​

A Boolean specifying whether or not ADVC process IDs defined on the ADVC side are displayed.

The default value is False.

bDisplayNAResult​

A Boolean specifying whether or not the "NA Result Display" option in ADVC is enabled. When set to true, it shows "Data: ---" for missing data and "No data available" in watch data notes, applicable only to nodal output results. When set to false, standard data display rules apply.

The default value is False.

strSelectResultFilePath​

A String specifying .xml file that defines which result is imported.

The default value is "".

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The ADVC file is imported successfully.

False: The ADVC file cannot be imported.

Sample Code​

#Please set path to your sample ADVC folder.
folderpath="C:/Temp/SampleADVC"

Home.ImportResults.ADVC(folderpath)
