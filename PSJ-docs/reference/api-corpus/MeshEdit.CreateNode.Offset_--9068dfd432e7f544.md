# MeshEdit.CreateNode.Offset()

MeshEdit.CreateNode.Offset()

Description​

Create a new node by offsetting a distance from the selected node or floating point.

Syntax​

MeshEdit.CreateNode.Offset(...)

Macro: CreateNodeOffset

Ribbon: MeshEdit » CreateNode » Offset

Inputs​

vecOffset​

A List of Double specifying the offset vector.

The default value is [].

iRepeat​

An Integer specifying the repeat times.

The default value is 1.

crlNodes​

A List of Cursor specifying the selected nodes to create offset ones.

The default value is [].

crCoord​

A Cursor specifying the coordinate.

The default value is None.

Return Code​

A List of Cursor specifying the created floating nodes.

Sample Code​

# Prepare model
Geometry.Part.Cube()

# Create offset node
newNode = MeshEdit.CreateNode.Offset(vecOffset=[0.003, 0.0, 0.0], crlNodes=[Node(7)])
JPT.Debugger(newNode) # for checking the return value
