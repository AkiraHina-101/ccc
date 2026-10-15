# Tools.Measure.Angle.ThreeNodes()

Tools.Measure.Angle.ThreeNodes()

Description​

Measure the angle by using the specified 3 nodes.

Syntax​

Tools.Measure.Angle.ThreeNodes(...)

Ribbon: Tools » Measure » Angle » ThreeNodes

Inputs​

crNode1​

A Cursor specifying the first node (A) to measure angle.

This is a required input.

crNode2​

A Cursor specifying the second node (B) to measure angle.

This is a required input.

crNode3​

A Cursor specifying the third node (C) to measure angle. Note that the angle to be measured is formed by vector BA and vector BC.

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

A List of Double specifying the angles between 3 nodes.

Sample Code​

Geometry.Part.Cube()

angle = Tools.Measure.Angle.ThreeNodes(crNode1=Node(445), 
                                       crNode2=Node(454),
                                       crNode3=Node(469), 
                                       strTarget="XY")
JPT.Debugger(angle)
