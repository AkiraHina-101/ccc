# Geometry.Face.FromMesh()

Geometry.Face.FromMesh()

Description​

Create a new part entity containing the new geometric face from the specified mesh face.

Syntax​

Geometry.Face.FromMesh(...)

Macro: CreateFaceFromMeshFace

Ribbon: Geometry » Face » Face from Mesh Face

Inputs​

crFace​

A Cursor specifying the mesh face that the new face is created base on.

This is a required input.

Return Code​

A Cursor specifying the new created face.

Sample Code​

Geometry.Part.Cube()

created_face = Geometry.Face.FromMesh(crFace=Face(26))
JPT.Debugger(created_face)
