# Tools.Measure.Distance.FaceNode()

Tools.Measure.Distance.FaceNode()

Description​

Measure Distance By FaceNode

Syntax​

Tools.Measure.Distance.FaceNode(crlFaces, crlNodes, iPrecision=6)

Ribbon: Tools » Measure » Distance » FaceNode

Inputs​

crlFaces​

A List of Cursor specifying the face.

This is a required input.

crlNodes​

A List of Cursor specifying the node.

This is a required input.

iPrecision​

An Integer specifying the precision.

The default value is 6.

Return Code​

A Double specifying the distance between face - node.

Sample Code​

Geometry.Part.Trapezoid()
dist=Tools.Measure.Distance.FaceNode(crlFaces=[Face(23)], crlNodes=[Node(306)],iPrecision=15)
print(dist)
