# Home.ImportResults.OptishapeTS()

Home.ImportResults.OptishapeTS()

Description​

Import Optishape-TS result file.

Syntax​

Home.ImportResults.OptishapeTS(...)

Macro: ImportOptishapeTS

Ribbon: Home » ImportResults » OptishapeTS

Inputs​

strlPaths​

A List of String specifying Optishape-TS result file paths.

This is a required input.

iImportType​

An Integer specifying import type. For Optishape-TS, it is always set to 1.

The default value is 1.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0 (degree).

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0 (degree).

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Optishape file is imported successfully.

False: The Optishape file cannot be imported.

Sample Code​

import os
#Put your result
result_data='C:/Temp/OptiShapeResult'

Home.ImportResults.OptishapeTS(
    strlPaths=[os.path.join(result_data,"sample.op2")])
