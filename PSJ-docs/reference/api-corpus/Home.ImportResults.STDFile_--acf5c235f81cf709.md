# Home.ImportResults.STDFile()

Home.ImportResults.STDFile()

Description​

Import std result file.

Syntax​

Home.ImportResults.STDFile(...)

Macro: ImportSTDFile

Ribbon: Home » ImportResults » STDFile

Inputs​

strPath​

A String specifying std result file path.

This is a required input.

iImportType​

An Integer specifying import type. For STDFile, it is always set to 1.

The default value is 1.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0 (degree).

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0 (degree).

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The STD file (*.std file) is imported successfully.

False: The STD file (*.std file) cannot be imported.

Sample Code​

#Please set path to your sample std file.
filepath="C:/Temp/Sample.std"

Home.ImportResults.STDFile(filepath)
