# Geometry.Part.Cylinder()

Geometry.Part.Cylinder()

Description​

Create a cylindrical body at a specific location. Its relative location is computed based on the specified local coordinate system.

Syntax​

Geometry.Part.Cylinder(...)

Ribbon: Geometry » Part » Cylinder

Inputs​

strName​

A String specifying the name of the newly created part.

The default value is "Cylinder_1".

crLocalCoordinate​

A Cursor specifying the local coordinate system.

The default value is None.

bHollow​

A Boolean specifying weather to hollow the created cylinder or not.

If True, the cylinder will have a hollow at the center with radius defined by dTopInnerRadius and dBottomInnerRadius.

If False, the cylinder will not have a hollow at the center.

The default value is False.

bTapered​

A Boolean specifying weather to make the cylinder tapered (radius at two ends is different).

If True, the cylinder will be tapered with radius defined by dBottomOuterRadius.

If False, the cylinder will not be tapered.

The default value is False.

dlOrigin​

A List of Double representing the X-, Y-, and Z-coordinates of the center of the cylinder.

The default value is [0.0,0.0,0.0].

dTopInnerRadius​

A Double specifying the inner radius in meters of the top end of the cylinder.

The default value is 0.001.

dTopOuterRadius​

A Double specifying the outer radius in meters of the top end of the cylinder.

The default value is 0.01.

dBottomInnerRadius​

A Double specifying the inner radius in meters of the bottom end of the cylinder.

The default value is 0.001.

dBottomOuterRadius​

A Double specifying the outer radius in meters of the bottom end of the cylinder.

The default value is 0.01.

dHeight​

A Double specifying the height of the cylinder.

The default value is 0.01.

iCircularNodes​

An Integer specifying the number of nodes to be generated on the circle at both ends.

The default value is 36.

iAxialNodes​

An Integer specifying the number of nodes in the axial direction of the cylinder.

The default value is 10.

iPartColor​

An Integer specifying the color of the newly created part.

The default value is 7105764.

Return Code​

A Cursor specifying the created part.

Sample Code​

created_cylinder = Geometry.Part.Cylinder(dlOrigin=[0.005, 0.005, 0.005],
                                          strName="Cylinder_2", 
                                          iPartColor=7463537)

JPT.Debugger(created_cylinder)
