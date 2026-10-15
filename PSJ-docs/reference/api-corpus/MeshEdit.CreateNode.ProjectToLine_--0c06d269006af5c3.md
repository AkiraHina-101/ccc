# MeshEdit.CreateNode.ProjectToLine()

MeshEdit.CreateNode.ProjectToLine()

Description​

Create a node by projecting the third selected node/floating node to the shortest distance of the two previously selected nodes/floating nodes.

Syntax​

MeshEdit.CreateNode.ProjectToLine(crlTa)

Macro: CreateNodeProjectToLine

Ribbon: MeshEdit » CreateNode » ProjectToLine

Inputs​

crlNodes​

A List of Cursor specifying the selected nodes.

This is a required input.

Return Code​

A Cursor specifying the created floating node.

Sample Code​

# Prepare model
Geometry.Part.Cube()

# Create line projected node
newNode = MeshEdit.CreateNode.ProjectToLine(crlNodes=[Node(7, 8, 76)])
JPT.Debugger(newNode) # for checking the return value
