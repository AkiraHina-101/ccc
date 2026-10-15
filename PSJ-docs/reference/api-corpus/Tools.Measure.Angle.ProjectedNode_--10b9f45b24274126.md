# Tools.Measure.Angle.ProjectedNode()

Tools.Measure.Angle.ProjectedNode()

Description​

Measure the projection angle onto the coordinate system plane.

Syntax​

Tools.Measure.Angle.ProjectedNode(...)

Ribbon: Tools » Measure » Angle » ProjectedNode

Inputs​

crNode​

A Cursor specifying the node.

This is a required input.

strTarget​

A String specifying the target projection plane (2D), or the three-dimensional space (3D) to refer to measure. This parameter can be one of the following:

If strTarget="XY": Return the angle that will project on plane Oxy.

If strTarget="YZ": Return the angle that will project on plane Oyz.

If strTarget="ZX": Return the angle that will project on plane Ozx.

If strTarget="Angle": Return the angle in 3D space.

If strTarget="All": Return all the 4 angle values in a list, in order "Angle", "XY", "YZ", "ZX".

The default value is "All".

iPrecision​

An Integer specifying the precision.

The default value is 6.

crCoord​

A Cursor specifying the coordinate system.

The default value is None.

Return Code​

A List of Double specifying the projected angles.

Sample Code​

Geometry.Part.Cube(strName="Cube_2", iPartColor=7697908)
angle = Tools.Measure.Angle.ProjectedNode(crNode=Node(461))
JPT.Debugger(angle)
