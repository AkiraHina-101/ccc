# Tools.DraftAngle()

Tools.DraftAngle()

Description​

This function measures the draft angle of the mesh in the mold model to verify the draft angle.

Syntax​

Tools.DraftAngle(...)

Macro: DRAFT_ANGLE

Ribbon: Tools » DraftAngle

Inputs​

dlDraftDirection​

A List of Double specifying specifying the draft direction.

This is a required input.

crlTargets​

A List of Cursor specifying the target parts. This is a required input.

This is a required input.

Return Code​

listPairCursorData​

A List of Cursor-Value which data includes cursor and value.

Example of return value:
[[[11:1], 10], [[11:2], 12]] 
where [[11:1], 10] is Pair Cursor Data including [11:1] is a cursor, 10 is a value. The first item in Pair Cursor Data is cursor, and the second is a value (could be an integer, double, or a string)

Sample Code​

#Create Sample Model
Geometry.Part.Trapezoid(
    dlLength=[0.01, 0.001, 0.01], 
    ilAxialNodes=[10, 2, 10], 
    iPartColor=7961077)

JPT.ViewFitToModel()

MeshEdit.OneNode(
    crlNodes=[Node(45)],
    crlFaceFixed=[Face(21)], 
    bOffsetvector=True, dlOffset=[0.8, 0.0, 0.0], dOffset=0.0, 
    dDistStrong=2.0, dDistWeak=5.0)

MeshEdit.OneNode(
    crlNodes=[Node(56)],
    crlFaceFixed=[Face(21)], 
    bOffsetvector=True, dlOffset=[-0.8, 0.0, 0.0], dOffset=0.0,
    dDistStrong=2.0, dDistWeak=5.0)

MeshEdit.OneNode(
    crlNodes=[Node(4)], 
    crlFaceFixed=[Face(21)], 
    bOffsetvector=True, dlOffset=[0.8, 0.0, 0.0], dOffset=0.0, 
    dDistStrong=2.0, dDistWeak=5.0)

#Calculate Draft Angle
draft_angle_result=Tools.DraftAngle(dlDraftDirection=[0, 1, 0], crlTargets=[Part(1)])

#Show result by contour
Tools.DraftAngleShowContour(listPairCursorData=draft_angle_result)

#Save result in group 
Tools.DraftAngleCreateGroup(listPairCursorData=draft_angle_result)
