# Tools.DraftAngleHideContour()

Tools.DraftAngleHideContour()

Description​

Hide result contour of Draft Angle function.

Syntax​

Tools.DraftAngleHideContour(...)

Macro: HideContourDraftAngle()

Ribbon: Tools » DraftAngleHideContour

Inputs​

This function does not have input argument.

Return Code​

A Boolean specifying whether the function succeeded or not.

0: Failed

1: Succeeded

Sample Code​

# Create Sample Model
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

# Calculate Draft Angle
draft_angle_result=Tools.DraftAngle(dlDraftDirection=[0, 1, 0], crlTargets=[Part(1)])

# Show result by contour
Tools.DraftAngleShowContour(listPairCursorData=draft_angle_result)

# Hide result contour
Tools.DraftAngleHideContour()
