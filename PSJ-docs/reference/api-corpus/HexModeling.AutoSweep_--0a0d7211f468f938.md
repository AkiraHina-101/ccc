# HexModeling.AutoSweep()

HexModeling.AutoSweep()

Description​

Hex Modeling Auto Sweep

Syntax​

HexModeling.AutoSweep(...)

Ribbon: HexModeling » AutoSweep

Inputs​

crlParts​

A List of Cursor specifying the part.

The default value is [].

dMeshSize​

A Double specifying the mesh size.

The default value is 0.0.

bLayers​

A Boolean specifying the layers.

The default value is False.

iLayers​

An Integer specifying the layers.

The default value is 2.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()
HexModeling.AutoSweep(crlParts=[Part(1)], dMeshSize=0.002, iLayers=5)
