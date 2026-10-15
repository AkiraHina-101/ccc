# MeshEdit.CreateNode.Point()

MeshEdit.CreateNode.Point()

Description​

Create node point

Syntax​

MeshEdit.CreateNode.Point(iNodeID=1, posPoint=[0,0,0], bImprint=True, crShape=None)

Ribbon: MeshEdit » CreateNode » Point

Inputs​

iNodeID​

An Integer specifying the node ID.

The default value is 1.

posPoint​

A Position specifying the point.

The default value is [0,0,0].

bImprint​

A Boolean specifying the imprint.

The default value is True.

crShape​

A Cursor specifying the shape.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.CreateNode.Point(iNodeID=1, posPoint=[0,0,0], bImprint=True, crShape=None)
