# Assemble.AddRibEx.General()

Assemble.AddRibEx.General()

Description​

Add rib part on a part.

Syntax​

Assemble.AddRibEx.General(...)

Macro: AddRibGeneralEx

Ribbon: Assemble » AddRibEx » General

Inputs​

dlPositions​

A List of Double specifying position of first end of the rib to create.

This is a required input.

crlFaces​

A List of Cursor specifying position of second end of the rib to create.

This is a required input.

dThickness​

A Double specifying the width of the rib.

The default value is 0.0005.

#dHeight​

A Double specifying the height of the rib from the attachment surface.

The default value is 0.001.

#crCoordinate​

A Cursor specifying the coordinate system to reference when attaching the rib.

The default value is None.

bDirectByCoord​

A Boolean specifying whether or not align the rib direction with the coordinate plane defined by the specified coordinate axes.

The default value is False.

iPlane​

An Integer specifying the coordinate plane:

0: Aligns the rib with the XY plane direction.

1: Aligns the rib with the YZ plane direction.

2: Aligns the rib with the ZX plane direction.

The default value is 0.

dOffsetX​

A Double specifying offset value the rib creation position in X direction.

The default value is 0.0.

dOffsetY​

A Double specifying offset value the rib creation position in Y direction.

The default value is 0.0.

dOffsetZ​

A Double specifying offset value the rib creation position in Z direction.

The default value is 0.0.

bTriangle​

A Boolean specifying whether creates the rib as a triangular rib with a higher starting point.

The default value is False.

bPlaneTop​

A Boolean specifying whether or not makes the rib top flat even when the attachment surface is curved.

The default value is True.

bCreateNewPart​

A Boolean specifying whether or not create a rib part as a new part.

The default value is False.

bMerge​

A Boolean specifying whether or not merge rib part to the part of target face belongs to.

The default value is True.

bPreview​

A Boolean specifying whether or not display preview.

The default value is True.

Return Code​

A Boolean specifying the function successfully executed or not.

Sample Code​

Geometry.Part.Cube()
Assemble.AddRibEx.General(
    dlPositions=[
        [0.007777777777777778, 0.003333333333333333, 0.01], 
        [0.002222222222222222, 0.007777777777777778, 0.01]], 
    crlFaces=[Face(26)], 
    dThickness=0.001, 
    dHeight=0.001)
