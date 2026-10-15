# Geometry.MergeEntities.Faces()

Geometry.MergeEntities.Faces()

Description​

Merge the selected faces into a single face.

Syntax​

Geometry.MergeEntities.Faces(...)

Ribbon: Geometry » Merge Entities » Faces

Inputs​

crlFaces​

A List of Cursor specifying the faces using for merging.

This is a required input.

bMergeEdge​

A Boolean whether to merge edges between faces to be a continuously edges or not.

The default value is True.

bRemoveNonBoundEdge​

A Boolean whether to remove the edges which are not a boundary edge.

The default value is True.

Return Code​

A List of Cursor specifying a list of faces after executing the function.

Sample Code​

Geometry.Part.Cube()
Geometry.Edge.Line(dllPoints=[[0.005, 0, 0.01],
                              [0.006, 0.01, 0.01]],
                   crlFaces=[Face(26)])
Geometry.Edge.Line(dllPoints=[[0.002, 0.002, 0.01],
                              [0.003, 0.005, 0.01]],
                   crlFaces=[Face(26)])
merged_faces = Geometry.MergeEntities.Faces(crlFaces=[Face(26, 28)])
JPT.Debugger(merged_faces)
