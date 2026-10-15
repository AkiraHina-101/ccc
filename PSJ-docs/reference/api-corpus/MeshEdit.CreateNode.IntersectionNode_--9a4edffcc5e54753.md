# MeshEdit.CreateNode.IntersectionNode()

MeshEdit.CreateNode.IntersectionNode()

Description​

Create node by intersection node

Syntax​

MeshEdit.CreateNode.IntersectionNode(crlFaces, crlParts, crlEdges, crlNodes)

Ribbon: MeshEdit » CreateNode » IntersectionNode

Inputs​

crlFaces​

A List of Cursor specifying the face.

This is a required input.

crlParts​

A List of Cursor specifying the part.

This is a required input.

crlEdges​

A List of Cursor specifying the edge.

This is a required input.

crlNodes​

A List of Cursor specifying the node.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.CreateNode.IntersectionNode(crlFaces, crlParts, crlEdges, crlNodes)
