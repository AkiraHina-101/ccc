# Tools.Measure.Angle.TwoElemEdges()

Tools.Measure.Angle.TwoElemEdges()

Description​

Syntax​

Tools.Measure.Angle.TwoElemEdges(...)

Ribbon: Tools » Measure » Angle » TwoElemEdges

Inputs​

crpElemEdge1​

A Cursor Pair specifying the element edge1 - two nodes.

This is a required input.

crpElemEdge2​

A Cursor Pair specifying the element edge2 - two nodes.

This is a required input.

strTarget​

A String specifying the target.

The default value is "Angle".

iPrecision​

An Integer specifying the precision.

The default value is 6.

Return Code​

Value measured with the precision set in iPrecision in String format.

Sample Code​

Geometry.Part.Cube()

angle = Tools.Measure.Angle.TwoElemEdges(
            crpElemEdge1=CursorPair(Node(95), Node(487)), 
            crpElemEdge2=CursorPair(Node(453), Node(462)))

JPT.Debugger(angle)
