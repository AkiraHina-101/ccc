# Geometry.ExtractSurfaces()

Geometry.ExtractSurfaces()

Description​

Create a new part by recursively finding adjacent surfaces are at an angle of less than or equal to the specified angle.

Syntax​

Geometry.ExtractSurfaces(...)

Ribbon: Geometry » Extract Surfaces

Inputs​

crlFaces​

A List of Cursor specifying the starting faces using for the extracting process.

This is a required input.

dFaceAngle​

A Double specifying the limit angle used for spreading from the selected faces to the adjacent faces in degree.

If dFaceAngle=-1, only the selected faces will be extracted.

The default value is 60.0.

strName​

A String specifying the name of the part(s) which will be created after executing the function.

The default value is "ExtractFace_1".

bMergePart​

A Boolean specifying whether to merge the created parts into a single part or not.

The default value is False.

Return Code​

A List of Cursor specifying the created parts.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.011, 0.0, 0.0],
                   strName="Cube_2",
                   iPartColor=6409934)
bodies = Geometry.ExtractSurfaces([Face(52, 26)],
                                  dFaceAngle=-1.0,
                                  strName="ExtractFace_4",
                                  bMergePart=True)
JPT.Debugger(bodies)
