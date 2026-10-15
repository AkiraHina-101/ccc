# MeshEdit.CreateNode.Absolute()

MeshEdit.CreateNode.Absolute()

Description​

Create a node by inputting the direct coordinate value.

Syntax​

MeshEdit.CreateNode.Absolute(...)

Macro: CreateNode

Ribbon: MeshEdit » CreateNode » Absolute

Inputs​

dlCoordinate​

A List of Double specifying the node coordinate.

The default value is [].

iNewNodeID​

An Integer specifying the new node ID.

The default value is the maximum node ID + 1.

Return Code​

A Cursor specifying the created floating node.

Sample Code​

# Create an absolute node
newNode = MeshEdit.CreateNode.Absolute(dlCoordinate=[0.01, 0.0, 0.0], iNewNodeID=489)
JPT.Debugger(newNode) # for checking the return value
