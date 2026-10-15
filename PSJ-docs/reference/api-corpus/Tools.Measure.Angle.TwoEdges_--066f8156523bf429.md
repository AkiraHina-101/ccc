# Tools.Measure.Angle.TwoEdges()

Tools.Measure.Angle.TwoEdges()

Description​

Measure the angle created by 2 edges.

Syntax​

Tools.Measure.Angle.TwoEdges(...)

Ribbon: Tools » Measure » Angle » TwoEdges

Inputs​

crEdge1​

A Cursor specifying the first edge to measure the angle.

This is a required input.

crEdge2​

A Cursor specifying the second edge to measure the angle.

This is a required input.

strTarget​

A String specifying the target projection plane (2D), or the three-dimensional space (3D) to refer to measure. This parameter can be one of the following:
If strTarget="XY": Return the angle that will project on plane Oxy.

If strTarget="YZ": Return the angle that will project on plane Oyz.

If strTarget="ZX": Return the angle that will project on plane Ozx.

If strTarget="Angle": Return the angle in 3D space.

If strTarget="All": Return all the 4 angle values in a list, in order "Angle", "XY", "YZ", "ZX".

The default value is "All".

crCoord​

A Cursor specifying the coordinate reference system in which the angle will refer to measure.

The default value is None.

iPrecision​

An Integer specifying the number of digit after floating point. The greater iPrecision could be, the more accuracy of angle can be measured.

The default value is 6.

Return Code​

A List of Double specifying the angles between edges.

Sample Code​

Geometry.Part.Cube()

angle = Tools.Measure.Angle.TwoEdges(crEdge1=Edge(19), 
                                     crEdge2=Edge(18))

JPT.Debugger(angle)
