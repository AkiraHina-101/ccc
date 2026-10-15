# Tools.Measure.Angle.TwoElemEdges()

Tools.Measure.Angle.TwoElemEdges()

Description​

Syntax​

Tools.Measure.Angle.TwoElemEdges(crpElemEdge1, crpElemEdge2, strTarget="Angle", iPrecision=6)

Ribbon: Tools » Measure » Angle » TwoElemEdges

Inputs​

crpElemEdge1​

A Cursor Pair specifying the element edge1.

This is a required input.

crpElemEdge2​

A Cursor Pair specifying the element edge2.

This is a required input.

strTarget​

A String specifying the target.

The default value is "Angle".

iPrecision​

An Integer specifying the precision.

The default value is 6.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Tools.Measure.Angle.TwoElemEdges(crpElemEdge1, crpElemEdge2, strTarget="Angle", iPrecision=6)
