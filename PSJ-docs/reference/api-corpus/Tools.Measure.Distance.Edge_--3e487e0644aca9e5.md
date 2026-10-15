# Tools.Measure.Distance.Edge()

Tools.Measure.Distance.Edge()

Description​

Measure the edge length.

Syntax​

Tools.Measure.Distance.Edge(...)

Ribbon: Tools » Measure » Distance » Edge

Inputs​

crEdge​

A Cursor specifying the edge to measure the distance.

This is a required input.

iPrecision​

An Integer specifying the number of digit after floating point. The greater iPrecision could be, the more accuracy of distance can be measured.

The default value is 6.

Return Code​

A Double specifying the length of the specified edge.

Sample Code​

Geometry.Part.Cube()

length = Tools.Measure.Distance.Edge(crEdge=Edge(15))

JPT.Debugger(length)
