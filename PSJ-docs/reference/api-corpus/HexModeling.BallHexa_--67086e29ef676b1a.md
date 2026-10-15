# HexModeling.BallHexa()

HexModeling.BallHexa()

Description​

Hexa modeling ball hexa

Syntax​

HexModeling.BallHexa(...)

Ribbon: HexModeling » BallHexa

Inputs​

crPart​

A Cursor specifying the part.

This is a required input.

vecCenter​

A Vector specifying the center.

The default value is [0.0,0.0,0.0].

dRadius​

A Double specifying the radius.

The default value is 5.0.

dMeshSize​

A Double specifying the mesh size.

The default value is 0.5.

iType​

An Integer specifying the type.

The default value is 0.

iLayer​

An Integer specifying the layer.

The default value is 3.

bMakeCenterNode​

A Boolean specifying the make center node.

The default value is True.

strName​

A String specifying the part name.

The default value is "HexBall_1".

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

HexModeling.BallHexa(crPart=None, vecCenter=[0.0,0.0,0.0], dRadius=5.0, dMeshSize=0.5, iType=0, 
    iLayer=3, bMakeCenterNode=True, strPartName="HexBall_1")
