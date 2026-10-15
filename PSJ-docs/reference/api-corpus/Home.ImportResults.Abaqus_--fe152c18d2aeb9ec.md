# Home.ImportResults.Abaqus()

Home.ImportResults.Abaqus()

Description​

Import Abaqus result file.

Syntax​

Home.ImportResults.Abaqus(...)

Macro: ImportAbaqus

Ribbon: Home » ImportResults » Abaqus

Inputs​

strPath​

A String specifying abaqus result file path.

This is a required input.

iVersion​

An Integer specifying version of abaqus file to import.

This is a required input.

iImportType​

An Integer specifying import type:

The default value is 1.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0 (degree).

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0 (degree).

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Abaqus file (*.odb file) is imported successfully.

False: The Abaqus file (*.odb file) cannot be imported.

Sample Code​

#Please set path to your sample Abaqus file.
filepath="C:/Temp/Sample.odb"

Home.ImportResults.Abaqus(filepath, iVersion=2023)
