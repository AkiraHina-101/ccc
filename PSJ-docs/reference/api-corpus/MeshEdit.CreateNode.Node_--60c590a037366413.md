# MeshEdit.CreateNode.Node()

MeshEdit.CreateNode.Node()

Description​

Create a node by referring to the coordinate value of the existing node.

Syntax​

MeshEdit.CreateNode.Node(...)

Macro: MeshEditCreateNodeAtNode

Ribbon: MeshEdit » CreateNode » Node

Inputs​

iNewNodeID​

An Integer specifying the new node ID.

The default value is the maximum node ID + 1.

crTarget​

A Cursor specifying the target on which to create the node. The target can be a face or an edge.

The default value is None.

Return Code​

A Cursor specifying the created floating node.

Sample Code​

# Prepare model
Geometry.Part.Cube()

# Create node at node
newNode = MeshEdit.CreateNode.Node(iNewNodeId=489, crTarget=Node(480))
JPT.Debugger(newNode) # for checking the return value
