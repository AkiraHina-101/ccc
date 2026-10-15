# Home.ImportResults.Nastran()

Home.ImportResults.Nastran()

Description​

Import Nastran / Vibro result file.

Syntax​

Home.ImportResults.Nastran(...)

Macro: ImportNastran

Ribbon: Home » ImportResults » Nastran

Inputs​

strPath​

A String specifying nastran result file path.

The default value is "".

strlPaths​

A List of String specifying nastran hdf5 result file paths.

The default value is [].

iImportType​

An Integer specifying import type:

1: Standard Nastran Op2 by Property

2: Simple Topology

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

bIsVibro​

A Boolean specifying whether or not the file is Vibro Acoustic.

The default value is False.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Nastran file (*.op2 file) is imported successfully.

False: The Nastran file (*.op2 file) cannot be imported.

Sample Code​

import os
NastranFile = os.path.join(
    JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH), 
    'SampleData/PSJ/PSJ-Utility/PostSample/101_solid.op2')
Home.ImportResults.Nastran(strPath=NastranFile)
