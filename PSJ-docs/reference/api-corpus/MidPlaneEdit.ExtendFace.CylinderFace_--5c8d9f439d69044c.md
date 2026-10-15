# MidPlaneEdit.ExtendFace.CylinderFace()

MidPlaneEdit.ExtendFace.CylinderFace()

Description​

Project an edge to face to get a new edge

Syntax​

MidPlaneEdit.ExtendFace.CylinderFace(crlExtFace=[], crRefFace=None, crEdge=None, iExtendType=1, iFaceType=0, iMethod=0, dParaAngleOffset=0.0, dParaArcLength=0.0, dParaZxy=0.0, iAxisPlane=0, iParaArcNodesNum=0, dOffLength=0.0, crlSelExtendedFace=[], crlSelRefFace=[], dCoMag=0.0, iAxisSystem=0, iCoorSystem=0, iCoX=0, iCoY=0, iCoZ=0, bOtherSameAsFaceNormal=False, dOtherArcNodesNum=0.0, dOtherArcRadius=0.0)

Ribbon: MidPlaneEdit » ExtendFace » CylinderFace

Inputs​

crlExtFace​

A List of Cursor specifying the extend face.

The default value is [].

crRefFace​

A Cursor specifying the reference face.

The default value is None.

crEdge​

A Cursor specifying the edge.

The default value is None.

iExtendType​

An Integer specifying the extend type.

The default value is 1.

iFaceType​

An Integer specifying the face type.

The default value is 0.

iMethod​

An Integer specifying the method.

The default value is 0.

dParaAngleOffset​

A Double specifying the parameter angle offset.

The default value is 0.0.

dParaArcLength​

A Double specifying the parameter arc length.

The default value is 0.0.

dParaZxy​

A Double specifying the parameter zxy.

The default value is 0.0.

iAxisPlane​

An Integer specifying the axis plane.

The default value is 0.

iParaArcNodesNum​

An Integer specifying the parameter arc nodes number.

The default value is 0.

dOffLength​

A Double specifying the off length.

The default value is 0.0.

crlSelExtendedFace​

A List of Cursor specifying the selection extended face.

The default value is [].

crlSelRefFace​

A List of Cursor specifying the selection reference face.

The default value is [].

dCoMag​

A Double specifying the coordinate mag.

The default value is 0.0.

iAxisSystem​

An Integer specifying the axis system.

The default value is 0.

iCoorSystem​

An Integer specifying the coordinate system.

The default value is 0.

iCoX​

An Integer specifying the coordinate x.

The default value is 0.

iCoY​

An Integer specifying the coordinate y.

The default value is 0.

iCoZ​

An Integer specifying the coordinate z.

The default value is 0.

bOtherSameAsFaceNormal​

A Boolean specifying the other same as face normal.

The default value is False.

dOtherArcNodesNum​

A Double specifying the other arc nodes number.

The default value is 0.0.

dOtherArcRadius​

A Double specifying the other arc radius.

The default value is 0.0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MidPlaneEdit.ExtendFace.CylinderFace(crlExtFace=[], crRefFace=None, crEdge=None, iExtendType=1, iFaceType=0, iMethod=0, dParaAngleOffset=0.0, dParaArcLength=0.0, dParaZxy=0.0, iAxisPlane=0, iParaArcNodesNum=0, dOffLength=0.0, crlSelExtendedFace=[], crlSelRefFace=[], dCoMag=0.0, iAxisSystem=0, iCoorSystem=0, iCoX=0, iCoY=0, iCoZ=0, bOtherSameAsFaceNormal=False, dOtherArcNodesNum=0.0, dOtherArcRadius=0.0)
