# Tools.Measure.Distance.Plane3NodesToNode()

Tools.Measure.Distance.Plane3NodesToNode()

Description​

Measure the distance from node to plane(defined by 3 nodes)

Syntax​

Tools.Measure.Distance.Plane3NodesToNode(crNode1, crNode2, crNode3, crNode, iPrecision=6)

Ribbon: Tools » Measure » Distance » Plane3NodesToNode

Inputs​

crNode1​

A Cursor specifying the node1.

This is a required input.

crNode2​

A Cursor specifying the node2.

This is a required input.

crNode3​

A Cursor specifying the node3.

This is a required input.

crNode​

A Cursor specifying the node.

This is a required input.

iPrecision​

An Integer specifying the precision.

The default value is 6.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Tools.Measure.Distance.Plane3NodesToNode(crNode1, crNode2, crNode3, crNode, iPrecision=6)
