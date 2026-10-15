# Geometry.ExtractRefSurface()

Geometry.ExtractRefSurface()

Description​

Create a new part by recursively finding adjacent surfaces that are at an angle of less than or equal to the specified angle.

Syntax​

Geometry.ExtractRefSurface(...)

Ribbon: Geometry » Extract Surfaces

Inputs​

crlRefFaces​

A List of Cursor specifying the faces to be extracted.

This is a required input.

dFaceAngle​

A Double specifying the angle in degrees between the adjacent faces to be extracted. If dFaceAngle=-1, the selected faces are extracted only.

The default value is 60.0.

strName​

A String specifying the original name of new parts. The final name is a concatenation of the original name and sequence number.

The default value is "ExtractFace_1".

bMergePart​

A Boolean specifying whether to merge new parts into a single part.

The default value is False.

Return Code​

A List of Cursor specifying the created parts, or None if fail.

Sample Code​

cube1 = Geometry.Part.Cube()

cube2 = Geometry.Part.Cube(dlOrigin=[0.011, 0.0, 0.0], 
                           strName="Cube_2", 
                           iPartColor=6409934)

Assembly.RightClick.AddToReference(crSrcPart=cube1, 
                                   crDestPart=cube1)

Assembly.RightClick.AddToReference(crSrcPart=cube2, 
                                   crDestPart=cube2)

created_part = Geometry.ExtractRefSurfaces(crlRefFaces=[RefFace((52, 
                                                                 26))], 
                                           dFaceAngle=-1.0, 
                                           strName="ExtractFace_3",
                                           bIsMergePart=True)

JPT.Debugger(created_part)
