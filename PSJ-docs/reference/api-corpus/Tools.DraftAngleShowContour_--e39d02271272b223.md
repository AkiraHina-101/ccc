# Tools.DraftAngleShowContour()

Tools.DraftAngleShowContour()

Description​

Display result contour of Draft Angle function.

Syntax​

Tools.DraftAngleShowContour(...)

Macro: ShowContourDraftAngle

Ribbon: Tools » DraftAngleShowContour

Inputs​

listPairCursorData​

A List of Cursor-Value specifying a list of pair data (list type), which data includes cursor and value.

This is a required input.

iContourDivision​

An Integer specifying the number of divisions of contour.

dContourMax​

A Double specifying the number of the maximum value of contour.

dContourMin​

A Double specifying the number of the minimum value of contour.

Return Code​

A Boolean specifying whether the function succeeded or not.

0: Failed

1: Succeeded

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

#Show result with different parameter 
Tools.DraftAngleShowContour(
    listPairCursorData=draft_angle_result, 
    iDivisionNumber=5, dContourMax=60, dContourMin=-60)
