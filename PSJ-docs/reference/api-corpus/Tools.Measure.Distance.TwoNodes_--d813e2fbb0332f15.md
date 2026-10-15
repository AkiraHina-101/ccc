# Tools.Measure.Distance.TwoNodes()

Tools.Measure.Distance.TwoNodes()

Description​

Measure distance between two nodes.

Syntax​

Tools.Measure.Distance.TwoNodes(...)

Ribbon: Tools » Measure » Distance » TwoNodes

Inputs​

crNode1​

A Cursor specifying the first node to measure distance.

This is a required input.

crNode2​

A Cursor specifying the second node to measure distance.

This is a required input.

strTarget​

A String specifying the target projection axis, or the three-dimensional space (3D) to refer to measure. This parameter can be one of the following:
If strTarget="X": Return the distance value along the X axis.

If strTarget="Y": Return the distance value along the Y axis.

If strTarget="Z": Return the distance value along the Z axis.

If strTarget="Dist": Return the angle value on in 3D space.

If strTarget="All": Return all the 4 distance values in a list, in order "Dist", "X", "Y", "Z".

The default value is "All".

iPrecision​

An Integer specifying the number of digit after floating point. The greater iPrecision could be, the more accuracy of distance can be measured.

The default value is 6.

crCoord​

A Cursor specifying the coordinate reference system in which the distance will refer to measure.

The default value is None.

Return Code​

A List of Double specifying the distance between two nodes.

Sample Code​

Geometry.Part.Cube()

distance = Tools.Measure.Distance.TwoNodes(crNode1=Node(454), 
                                           crNode2=Node(472), 
                                           strTarget="Dist")

JPT.Debugger(distance)

print_str = ", ".join([str(value) for value in distance])
print(print_str)
