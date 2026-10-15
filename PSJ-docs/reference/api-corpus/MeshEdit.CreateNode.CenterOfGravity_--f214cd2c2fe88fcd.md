# MeshEdit.CreateNode.CenterOfGravity()

MeshEdit.CreateNode.CenterOfGravity()

Description​

Create node Center Of Gravity

Syntax​

MeshEdit.CreateNode.CenterOfGravity(...)

Ribbon: MeshEdit » CreateNode » CenterOfGravity

Inputs​

iCreationType​

An Integer specifying the creation type.

0: Gravity

1: Shape

The default value is 1.

iNewNodeID​

An Integer specifying the new node ID.

The default value is the maximum node ID + 1.

crlParts​

A List of Cursor specifying the selected part.

The default value is [].

crlBarPart​

A List of Cursor specifying the selected bar part.

The default value is [].

crlFaces​

A List of Cursor specifying the selected face.

The default value is [].

Return Code​

A Cursor specifying the created floating node.

Sample Code​

# Prepare model
Geometry.Part.Cube()

# Create center node of gravity
newNode = MeshEdit.CreateNode.CenterOfGravity(iNodeID=489, crlTargets=[Part(1)])
JPT.Debugger(newNode) # for checking the return value
