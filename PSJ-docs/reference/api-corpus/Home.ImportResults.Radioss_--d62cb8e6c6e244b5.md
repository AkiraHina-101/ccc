# Home.ImportResults.Radioss()

Home.ImportResults.Radioss()

Description​

Import Open Radioss result file.

Syntax​

Home.ImportResults.Radioss(...)

Macro: ImportRadioss

Ribbon: Home » ImportResults » Radioss

Inputs​

strlPaths​

A List of String specifying Open Radioss result file path.

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

bReadLoadAndConstraint​

A Boolean specifying whether or not to read loads and constraint.

The default value is False.

bReadConnection​

A Boolean specifying whether or not to read connections.

The default value is False.

bCreateResultsAtMidNode​

A Boolean specifying whether or not create result at Mid Nodes.

The default value is False.

The default value is False.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Open Radioss file is imported successfully.

False: The Open Radioss cannot be imported.

Sample Code​

<Type here>
