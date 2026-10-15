# Home.ImportResults.Universal()

Home.ImportResults.Universal()

Description​

Import Universal result file.

Syntax​

Home.ImportResults.Universal(...)

Macro: ImportUniversal

Ribbon: Home » ImportResults » Universal

Inputs​

strPath​

A String specifying Universal result file path.

This is a required input.

iImportType​

An Integer specifying import type. For Universal file, it is always set to 1.

The default value is 1.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0 (degree).

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0 (degree).

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Universal file (*.unv file) is imported successfully.

False: The Universal file (*.unv file) cannot be imported.

Sample Code​

#Please set path to your sample universal file.
filepath="C:/Temp/Sample.unv"

Home.ImportResults.Universal(filepath)
