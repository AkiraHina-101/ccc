# MeshEdit.CreateNode.Between3Nodes()

MeshEdit.CreateNode.Between3Nodes()

Description​

Create node point

Syntax​

MeshEdit.CreateNode.Between3Nodes(iNodeID=0, dX=0.0, dY=0.0, dZ=0.0, bImprint=False, crlNodes=[], crlFaces=[])

Ribbon: MeshEdit » CreateNode » Between3Nodes

Inputs​

iNodeID​

An Integer specifying the node ID.

The default value is 0.

dX​

A Double specifying the x.

The default value is 0.0.

dY​

A Double specifying the y.

The default value is 0.0.

dZ​

A Double specifying the z.

The default value is 0.0.

bImprint​

A Boolean specifying the imprint.

The default value is False.

crlNodes​

A List of Cursor specifying the node.

The default value is [].

crlFaces​

A List of Cursor specifying the face.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.CreateNode.Between3Nodes(iNodeID=0, dX=0.0, dY=0.0, dZ=0.0, bImprint=False, crlNodes=[], crlFaces=[])
