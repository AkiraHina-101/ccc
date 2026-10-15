# MeshEdit.CreateNode.IntersectionNode()

MeshEdit.CreateNode.IntersectionNode()

Description​

Create floating nodes at the intersection of a part or face with edges or a line segment defined by 2 nodes

Syntax​

MeshEdit.CreateNode.IntersectionNode(...)

Macro: CreateNodeIntersectionNode

Ribbon: MeshEdit » CreateNode » IntersectionNode

Inputs​

crlFaces​

A List of Cursor specifying the face.

This is a required input.

crlParts​

A List of Cursor specifying the part.

This is a required input.

crEdge​

A Cursor specifying the edge.

This is a required input.

crlNodes​

A List of Cursor specifying two nodes to make line.

This is a required input.

Return Code​

A List of Cursor specifying the created floating nodes.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=7697908)
MeshEdit.CreateNode.Offset(vecOffset=[0.003, 0.0, 0.0], crlNodes=[Node(324)])
MeshEdit.CreateNode.Offset(vecOffset=[-0.003, 0.0, 0.0], crlNodes=[Node(259)])

# Create Intersection Node
newNode = MeshEdit.CreateNode.IntersectionNode(crlFaces=[Face(24, 23)], crlParts=[], crlEdges=[], 
                                                crlNodes=[Node(489, 490)])
JPT.Debugger(newNode) # for checking the return value
