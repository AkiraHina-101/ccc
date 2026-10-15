# Geometry.Face.FromMesh()

Geometry.Face.FromMesh()

Description​

This method creates a Part entity containing the geometric face from the specified mesh face. The result is a Part entity with a new mesh face.

Syntax​

Geometry.Face.FromMesh(crFace)

Macro: CreateFaceFromMeshFace

Ribbon: Geometry » Face » Face from Mesh Face

Inputs​

crFace​

A Cursor specifying the mesh face that new face is created base on.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()

Geometry.Face.FromMesh(crFace=Face(26))
