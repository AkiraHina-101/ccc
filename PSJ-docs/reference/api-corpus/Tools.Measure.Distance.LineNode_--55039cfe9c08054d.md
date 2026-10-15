# Tools.Measure.Distance.LineNode()

Tools.Measure.Distance.LineNode()

Description​

Measures the distance of a perpendicular line from a node toward the line defined by the two nodes.

Syntax​

Tools.Measure.Distance.LineNode(crlNodes, iPrecision=6)

Ribbon: Tools » Measure » Distance » LineNode

Inputs​

crlNodes​

A List of Cursor specifying the target node.

This is a required input.

iPrecision​

An Integer specifying the precision.

The default value is 6.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Tools.Measure.Distance.LineNode(crlNodes, iPrecision=6)
