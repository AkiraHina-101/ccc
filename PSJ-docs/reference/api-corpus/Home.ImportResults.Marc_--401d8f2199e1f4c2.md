# Home.ImportResults.Marc()

Home.ImportResults.Marc()

Description​

Import Marc result file.

Syntax​

Home.ImportResults.Marc(...)

Macro: ImportMarc

Ribbon: Home » ImportResults » Marc

Inputs​

strPath​

A String specifying Marc result file path.

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

True: The Marc result is imported successfully.

False: The Marc result cannot be imported.

Sample Code​

#Please set path to your sample marc file.
filepath="C:/Temp/Sample.t16"

Home.ImportResults.Marc(filepath)
