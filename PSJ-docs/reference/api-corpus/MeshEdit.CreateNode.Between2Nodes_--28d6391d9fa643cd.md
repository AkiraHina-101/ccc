# MeshEdit.CreateNode.Between2Nodes()

MeshEdit.CreateNode.Between2Nodes()

Description​

Create node between two selected nodes.

Syntax​

MeshEdit.CreateNode.Between2Nodes(...)

Macro: MeshEditCreateNodeBetween2Nodes

Ribbon: MeshEdit » CreateNode » Between2Nodes

Inputs​

iNewNodeID​

An Integer specifying the new node ID.

The default value is the maximum node ID + 1.

iNumberOfNodes​

An Integer specifying the number of new nodes to be created between two target nodes.

The default value is 0.

bImprint​

A Boolean specifying whether to imprint the creating node to face.

The default value is False.

crlNodes​

A List of Cursor specifying two target nodes.

The default value is [].

crlFaces​

A List of Cursor specifying the face on which the node will imprint.

The default value is [].

Note

This version does not support multi-faces printing, so crlFaces should be specified with a single face for each operation.

Return Code​

A List of Cursor specifying the created floating or imprinted nodes.

Sample Code​

# Prepare model
Geometry.Part.Cube()

# Create a node between two nodes
newNodes = MeshEdit.CreateNode.Between2Nodes(iNewNodeID=490, iNumberofNodes=2, crlNodes=[Node(6, 7)])
JPT.Debugger(newNodes) # for checking the return value
