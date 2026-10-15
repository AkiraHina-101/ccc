# Geometry.Face.Edges()

Geometry.Face.Edges()

Description​

Create a face using the given edges as the face's boundaries. It will create a face by creating the geometry consisting of the underlying surface, associated edges, and vertices. The planar surfaces and smooth surfaces are switched by changing the related arguments.

Syntax​

Geometry.Face.Edges(...)

Macro: CreateFaceFromEdges

Ribbon: Geometry » Face » Edges

Inputs​

crlEdges​

A List of Cursor specifying the edges that bound the new face. Either crlEdges or crlNodes must be specified.

crlParts​

A List of Cursor specifying a given part to that the new face will belong.

The default value is [].

crlNodes​

A List of Cursor specifying two nodes to define the direction in which the curved surface be created smoothly. If crlNodes is specified, the curved surface will be smoother than the face created by bound edges only.

The default value is [].

bSharedFace​

A Boolean specifying whether to create a shared face when the given edges are shared edges.

The default value is False.

bSmoothFace​

A Boolean specifying whether to create a smooth face instead of planar face.

The default value is False.

bCreatePart​

A Boolean specifying whether to stitch the newly created face to the new part. If bSharedFace=True, this argument will be ignored.

The default value is False.

bImproved​

A Boolean specifying whether the newly created face is created with smooth direction. This argument does not affect the operation if crlNodes is not specified.

The default value is False.

bBarsOnly​

A Boolean indicating whether all of the selected edges are Bar part only.

The default value is False.

bOnlyOnePart​

A Boolean indicating whether the newly created face is in the same new part. If bCreatePart=False, this argument will be ignored.

The default value is True.

bIncludeMidNodes​

A Boolean specifying whether to include middle nodes when creating face.

The default value is False.

Return Code​

A Cursor specifying the new face.

Sample Code​

Geometry.Part.Cube()

created_face = Geometry.Face.Edges(crlEdges=[Edge(9, 19)])

JPT.Debugger(created_face)
