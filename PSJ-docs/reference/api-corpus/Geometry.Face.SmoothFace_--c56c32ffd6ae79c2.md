# Geometry.Face.SmoothFace()

Geometry.Face.SmoothFace()

Description​

Create geometric face from given boundaries set by selected edges.
This function can create curved surface if selected edges are curved.

Syntax​

Geometry.Face.SmoothFace(...)

Macro: CreateSmoothFaceGUI

Ribbon: Geometry » Face » SmoothFace

Inputs​

crlTargets​

A List of Cursor specifying boundary edges.

This is a required input.

iElementGeneration​

An Integer specifying element type.

0: TRI

1: QUAD

The default value is 0.

dGradation​

A Double specifying gradation factor.

The default value is 1.

bFaceSmooth​

A Boolean specifying connection continuity.

False: G0

True: G1

The default value is True.

crlTargetParts​

A List of Cursor specifying a part that the created face belongs to. If crlTargetParts is empty then creating the new part.

The default value is [].

bInterpolation​

A Boolean specifying whether to make facet sizes or mesh sizes uniform.

The default value is False.

Return Code​

A Cursor specifying the new created face.

Sample Code​

Geometry.Part.Sphere()
Geometry.Edge.Angle(
    [CursorPair(Node(146), Node(147)), 
    CursorPair(Node(148), Node(168)), 
    CursorPair(Node(267), Node(268)), 
    CursorPair(Node(224), Node(244))])
Geometry.DeleteEntity.Face(crlFaces=[Face(2)])

created_face = Geometry.Face.SmoothFace(crlTargets=[Edge(3)])
JPT.Debugger(created_face)
