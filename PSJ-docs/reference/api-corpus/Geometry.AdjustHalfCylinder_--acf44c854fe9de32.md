# Geometry.AdjustHalfCylinder()

Geometry.AdjustHalfCylinder()

Description​

Adjust the split position of the cylinder face (For example, The bolt or bolt hole). By using this function, unevenly meshing caused by the difference of split positions can be avoided.

Syntax​

Geometry.AdjustHalfCylinder(...)

Ribbon: Geometry » AdjustHalfCylinder

Inputs​

poslPoint​

A Position List specifying list of 3 points to define the plane.
This argument is required when option "3 points" was selected.

The default value is [].

crlFaces​

A List of Cursor specifying list of face to cut.

This is a required input.

crCoord​

A Cursor specifying the coordinate.

The default value is None.

iAxisPlane​

An Integer specifying the axis plane.
If this value equal to 0, the cut plane is Oyz.

If this value equal to 1, the cut plane is Oxz.

If this value equal to 2, the cut plane is Oxy.

If this value equal to 3, the cut plane is specified by 3 nodes that user input in poslPoint.

The default value is 0.

bDivideFace​

A Boolean enable/disable option "divide face".

The default value is True.

crlParts​

A List of Cursor specifying list of the part.

The default value is [].

bMergeEdge​

A Boolean enable/disable option "merge edge".

The default value is True.

Return Code​

True if success, or None if fail.

Sample Code​

Geometry.Part.Cylinder(strName="Cylinder_4", 
                       iPartColor=13259210)
Geometry.Part.Cylinder(strName="Cylinder_5", 
                       dlOrigin=[0.0, 0.01, 0.0], 
                       dTopOuterRadius=0.005,
                       dBottomOuterRadius=0.005, 
                       iPartColor=7697908)

flag1 = Geometry.AdjustHalfCylinder(poslPoint=[[-2.775557561562891e-16, 
                                                0, 
                                                -5.551115123125783e-17]],
                                    crlFaces=[Face(5)], 
                                    iAxisPlane=2)

JPT.Debugger(flag1)

flag2 = Geometry.AdjustHalfCylinder(poslPoint=[[0, 
                                                0.009999999999999898, 
                                                6.938893903907228e-18]],
                                    crlFaces=[Face(10)], 
                                    iAxisPlane=2)

JPT.Debugger(flag2)
