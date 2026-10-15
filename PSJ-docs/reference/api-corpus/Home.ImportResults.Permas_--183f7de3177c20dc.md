# Home.ImportResults.Permas()

Home.ImportResults.Permas()

Description​

Import Permas result file.

Syntax​

Home.ImportResults.Permas(...)

Macro: ImportPermas

Ribbon: Home » ImportResults » Permas

Inputs​

strPath​

A String specifying nastran result file path.

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

True: The Permas file is imported successfully.

False: The Permas file cannot be imported.

Sample Code​

# Please set path to your sample universal file.
filepath="C:/Temp/result.post.gz"

Home.ImportResults.Permas(filepath)
