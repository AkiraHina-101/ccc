# Tools.Measure.Radius.Edge()

Tools.Measure.Radius.Edge()

Description​

Measure arc radius of the specified edge.

Syntax​

Tools.Measure.Radius.Edge(...)

Ribbon: Tools » Measure » Radius » Edge

Inputs​

crEdge​

A Cursor specifying the edge to measure the arc radius. The selected edge should be a curved edge, not to be a straight edge.

This is a required input.

iPrecision​

An Integer specifying the number of digit after floating point. The greater iPrecision could be, the more accuracy of arc radius can be measured.

The default value is 6.

Return Code​

A Double specifying the arc radius value.

Sample Code​

Geometry.Part.Cylinder()

radius = Tools.Measure.Radius.Edge(crEdge=Edge(1))

JPT.Debugger(radius)
