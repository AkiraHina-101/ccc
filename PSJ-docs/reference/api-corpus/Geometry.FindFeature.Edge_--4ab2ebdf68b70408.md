# Geometry.FindFeature.Edge()

Geometry.FindFeature.Edge()

Description​

Find and select the specific edges according to their characteristic.

Syntax​

Geometry.FindFeature.Edge(...)

Ribbon: Geometry » Find Feature » Edges

Inputs​

crlParts​

A List of Cursor specifying the parts to find the specific faces. This argument must be specified if the iEdgeType argument value is not equal to 4.

This is a required input.

iEdgeType​

An Integer specifying the specified type of Edges.

If iEdgeType=0, find and select the straight edge lines.

If iEdgeType=1, find and select the edges that form a closed profile.

If iEdgeType=2, find and select the edges of circular shape.

If iEdgeType=3, find and select the edges of semi-circular shape.

If iEdgeType=4, find and select the edges of bolt hole.

If iEdgeType=5, find and select the concentric edge of the specified edge.

The default value is 0.

crlEdges​

A List of Cursor specifying the edges used to find the their concentric edges. This argument must be specified if iEdgeType=5.

The default value is [].

dDiameterMin​

A Double specifying the minimum diameter of bolt hole.

The default value is 1.0.

dDiameterMax​

A Double specifying the maximum diameter of bolt hole.

The default value is 2.0.

crlFaces​

A List of Cursor specifying the faces used to find the edges of bolt hole. This argument is to be used if iEdgeType=4.

The default value is [].

Return Code​

A List Cursor of edges if success, or None if fail.

Sample Code​

cube=Geometry.Part.Cube()
edges = Geometry.FindFeature.Edge(crlParts=[cube])
JPT.Debugger(edges)
