# MidPlane.FindMidPlane()

MidPlane.FindMidPlane()

Description​

Create mid-planes for the specified parts.

Syntax​

MidPlane.FindMidPlane(...)

Macro: FindMidPlane

Ribbon: MidPlane » FindMidPlane

Inputs​

crlTargetParts​

A List of Cursor specifying parts.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube(dlLength=[0.001, 0.01, 0.01])
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0],
                    dlLength=[0.002, 0.01, 0.01],
                    strName="Cube_2",
                    iPartColor=6409934)
MidPlane.FindMidPlane(crlTargetParts=[Part(1, 2)])
