# Geometry.Face.ExtendFace()

Geometry.Face.ExtendFace()

Description​

Create a face extended from an edge.

Syntax​

Geometry.Face.ExtendFace(...)

Macro: ExtendFace

Ribbon: Geometry » Face » ExtendFace

Inputs​

crEdge​

A Cursor specifying source edge.

This is a required input.

crFace​

A Cursor specifying target face when Metric is set "Offset" or "Cylinder".

The default value is None.

crRefFace​

A Cursor specifying reference face when Metric is set "Cylinder", Method is "To Face".

The default value is None.

crFirstNode​

A Cursor specifying the first node to set axis by Metric "2Nodes".

The default value is None.

crSecondNode​

A Cursor specifying the second node to set axis by Metric "2Nodes".

The default value is None.

crElemEdge​

A CursorPair specifying element edge to set axis by Metric "Element Edge".

The default value is [].

extendFaceDirection​

A Class of EXTEND_FACE_DIRECTION specifying the direction settings for the extended face in 3D dimension.

The default value is EXTEND_FACE_DIRECTION.

extendFaceMesh​

A Class of EXTEND_FACE_MESH specifying the mesh settings for the extended face.

The default value is EXTEND_FACE_MESH.

extendFaceOption​

A Class of EXTEND_FACE_OPTION specifying the geometric settings for the extended face.

The default value is EXTEND_FACE_OPTION.

Return Code​

A Cursor specifying the new created face.

Sample Code​

Geometry.Part.Cube()
created_face = Geometry.Face.ExtendFace(crEdge=Edge(19), 
                                      extendFaceDirection=EXTEND_FACE_DIRECTION(
                                          dComponentX=0, 
                                          dComponentZ=0), 
                                      extendFaceMesh=EXTEND_FACE_MESH(), 
                                      extendFaceOption=EXTEND_FACE_OPTION())
JPT.Debugger(created_face)
