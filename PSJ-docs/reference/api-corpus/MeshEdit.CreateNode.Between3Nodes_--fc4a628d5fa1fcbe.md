# MeshEdit.CreateNode.Between3Nodes()

MeshEdit.CreateNode.Between3Nodes()

Description​

Create a center node of 3 selected nodes.

Syntax​

MeshEdit.CreateNode.Between3Nodes(...)

Macro: MeshEditCreateNodeBetween3Nodes

Ribbon: MeshEdit » CreateNode » Between3Nodes

Inputs​

iNewNodeID​

An Integer specifying the new node ID.

The default value is the maximum node ID + 1.

bImprint​

A Boolean specifying whether to imprint the creating node to face.

The default value is False.

crlNodes​

A List of Cursor specifying three target nodes.

The default value is [].

crlFaces​

A List of Cursor specifying the face on which the node will imprint.

The default value is [].

Note

This version does not support multi-faces printing, so crlFaces should be specified with a single face for each operation.

Return Code​

A Cursor specifying the created floating or imprinted node.

Sample Code​

# Prepare model
Geometry.Part.Cube()

# Create a node at the center of three nodes
newNode = MeshEdit.CreateNode.Between3Nodes(iNewNodeID=490, crlNodes=[Node(8, 7, 5)])
JPT.Debugger(newNode) # for checking the return value
