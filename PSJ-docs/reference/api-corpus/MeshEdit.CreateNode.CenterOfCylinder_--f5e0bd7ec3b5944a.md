# MeshEdit.CreateNode.CenterOfCylinder()

MeshEdit.CreateNode.CenterOfCylinder()

Description​

Create a floating node at the center of the cylindrical surface in the longitudinal direction

Syntax​

MeshEdit.CreateNode.CenterOfCylinder(...)

Macro: MeshEditCreateNodeCylindCenter

Ribbon: MeshEdit » CreateNode » CenterOfCylinder

Inputs​

iNewNodeID​

An Integer specifying the new node ID.

The default value is the maximum node ID + 1.

crlFaces​

A List of Cursor specifying the selected cylindrical faces.

The default value is [].

Return Code​

A List of Cursor specifying the created floating nodes.

Sample Code​

# Prepare model
Geometry.Part.Cylinder()

# Create center node of cylinder
newNode = MeshEdit.CreateNode.CenterOfCylinder(crlFaces=[Face(5)], iNewNodeID=363)
JPT.Debugger(newNode) # for checking the return value
