# Home.ImportResults.MuxWeld()

Home.ImportResults.MuxWeld()

Description​

Import Mux-Weld result file.

Syntax​

Home.ImportResults.MuxWeld(...)

Macro: ImportMuxWeld

Ribbon: Home » ImportResults » MuxWeld

Inputs​

strPath​

A String specifying Mux-Weld result file path.

This is a required input.

iImportType​

An Integer specifying import type. For LS-Dyna, it is always set to 1.

The default value is 1.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0 (degree).

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0 (degree).

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The MuxWeld result is imported successfully.

False: The MuxWeld result cannot be imported.

Sample Code​

#Please set path to your sample mux-weld file.
filepath="C:/Temp/Sample.wsi"

Home.ImportResults.MuxWeld(filepath)
