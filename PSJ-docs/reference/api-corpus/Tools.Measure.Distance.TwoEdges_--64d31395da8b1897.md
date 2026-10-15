# Tools.Measure.Distance.TwoEdges()

Tools.Measure.Distance.TwoEdges()

Description​

Measure the distance of two edges.

Syntax​

Tools.Measure.Distance.TwoEdges(...)

Ribbon: Tools » Measure » Distance » TwoEdges

Inputs​

crEdge1​

A Cursor specifying the first edge to measure distance.

This is a required input.

crEdge2​

A Cursor specifying the second edge to measure distance.

This is a required input.

iPrecision​

An Integer specifying the number of digit after floating point. The greater iPrecision could be, the more accuracy of distance can be measured.

The default value is 6.

Return Code​

A Double specifying the distance between two edges.

Sample Code​

Geometry.Part.Cube()

distance = Tools.Measure.Distance.TwoEdges(crEdge1=Edge(20), 
                                           crEdge2=Edge(18))

JPT.Debugger(distance)
