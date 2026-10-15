# MeshEdit.CreateNode.CircleCenter()

MeshEdit.CreateNode.CircleCenter()

Description​

Create node at center of circle

Syntax​

MeshEdit.CreateNode.CircleCenter(crlEdges, iNodeID, bImprint=False, crFace=None)

Ribbon: MeshEdit » CreateNode » CircleCenter

Inputs​

crlEdges​

A List of Cursor specifying the edge.

This is a required input.

iNodeID​

An Integer specifying the node ID.

This is a required input.

bImprint​

A Boolean specifying the imprint.

The default value is False.

crFace​

A Cursor specifying the face.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.CreateNode.CircleCenter(crlEdges, iNodeID, bImprint=False, crFace=None)
