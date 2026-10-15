# Home.ImportResults.FrontISTR()

Home.ImportResults.FrontISTR()

Description​

Import FrontISTR result file.

Syntax​

Home.ImportResults.FrontISTR(...)

Macro: ImportFrontISTR

Ribbon: Home » ImportResults » FrontISTR

Inputs​

strPath​

A String specifying FrontISTR result folder path.

This is a required input.

iImportType​

An Integer specifying import type.

The default value is 1.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0 (degree).

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0 (degree).

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Front ISTR file is imported successfully.

False: The Front ISTR file cannot be imported.

Sample Code​

#Please set path to your sample FrontISTR folder.
folderpath="C:/Temp/SampleFrontISTR"

Home.ImportResults.FrontISTR(folderpath)
