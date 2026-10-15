# MeshEdit.CreateNode.CircleCenter()

MeshEdit.CreateNode.CircleCenter()

Description​

Create a node/floating node at the center of the selected circular edge.

Syntax​

MeshEdit.CreateNode.CircleCenter(...)

Macro: CreateNodeEdgeCenter

Ribbon: MeshEdit » CreateNode » CircleCenter

Inputs​

crlEdges​

A List of Cursor specifying the circular edge.

This is a required input.

iNewNodeID​

An Integer specifying the new node ID.

The default value is the maximum node ID + 1.

bImprint​

A Boolean specifying whether to imprint the creating node to face.

The default value is False.

crFace​

A Cursor specifying the face on which the node will imprint.

The default value is [].

Return Code​

A List of Cursor specifying the created floating or imprinted node.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Edge.Circle(veclPositions=[[0.005555555555555556, 0.005555555555555556, 0.01]], 
                                    crlTargetFace=[Face(26)], dOutRadius=1.5)

# Create center node of circle
newNode = MeshEdit.CreateNode.CircleCenter(crlEdges=[Edge(55)], iNewNodeID=540)
JPT.Debugger(newNode) # for checking the return value
