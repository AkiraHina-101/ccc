# MeshEdit.CreateNode.CenterOfSphere()

MeshEdit.CreateNode.CenterOfSphere()

Description​

Create node at the center sphere or the center of curvature of 4 nodes.

Syntax​

MeshEdit.CreateNode.CenterOfSphere(...)

Macro: MeshEditCreateNodeSphereCenter

Ribbon: MeshEdit » CreateNode » CenterOfSphere

Inputs​

iNewNodeID​

An Integer specifying the new node ID.

The default value is the maximum node ID + 1.

crlTargets​

A List of Cursor specifying the sphere face or 4 nodes.

The default value is [].

Return Code​

A Cursor specifying the created floating node.

Sample Code​

# Prepare model
Geometry.Part.Sphere(iPartColor=6409934)

# Create center node of sphere
newNode = MeshEdit.CreateNode.CenterOfSphere(crlTargets=[Face(1)], iNewNodeID=383)
JPT.Debugger(newNode) # for checking the return value
