# MeshEdit.CreateNode.ProjectToPlane()

MeshEdit.CreateNode.ProjectToPlane()

Description​

Create a node by projecting the selected node/floating node to the selected face.

Syntax​

MeshEdit.CreateNode.ProjectToPlane(...)

Macro: MeshEditCreateNodeProjectNode

Ribbon: MeshEdit » CreateNode » ProjectToPlane

Inputs​

crlNodes​

A List of Cursor specifying the selected nodes.

The default value is [].

crlFaces​

A List of Cursor specifying the face on which the node will project.

The default value is [].

Note

This version does not support multi-faces printing, so crlFaces should be specified with a single face for each operation.

Return Code​

A List of Cursor specifying the imprinted nodes.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Meshing.GridMesh(listGridMesh=[GRID_MESH(crlFace=[Face(26)], crlCorner=[Node(6, 7, 8, 5)], 
                ilMeshCount=[5, 5], iShape=4, bOptimize=True)], bProjectToCad=True)

# Create plan projected node
newNode = MeshEdit.CreateNode.ProjectToPlane(crlNodes=[Node(501)], crlFaces=[Face(25)])
JPT.Debugger(newNode) # for checking the return value
