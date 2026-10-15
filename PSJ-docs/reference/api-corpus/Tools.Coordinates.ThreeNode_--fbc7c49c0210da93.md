# Tools.Coordinates.ThreeNode()

Tools.Coordinates.ThreeNode()

Description​

Create a Coordinate System by selecting 3 nodes.

Syntax​

Tools.Coordinates.ThreeNode(...)

Ribbon: Tools » Coordinates » ThreeNode

Inputs​

strName​

A String specifying the name of the Coordinate system.

The default value is "CRect1".

iCoordType​

An Integer specifying the type of Coordinate system, which is one of the following:
If iCoordType=0: Rectangular Coordinate - which can be known as Cartesian Coordinate System (Oxyz)

If iCoordType=1: Cylindrical Coordinate - (r, φ, z) Coordinate System, where (r, φ, z) are (radial distance, azimuth angle, axial Coordinate or height z) respectively

If iCoordType=2: Spherical Coordinate - (r, θ, φ) Coordinate System, where (r, θ, φ) are (radial distance, azimuth angle, polar angle) respectively

The default value is 0.

iOrder​

An Integer specifying the order of nodes or points when selecting the origin and axes of the Coordinate. This parameter can be one of the following:
If iOrder=0: O.Z.ZX Plane - Select in the order of Origin, a point on the Z-axis and a point on the ZX plane.

If iOrder=1: O.X.ZX Plane - Select in the order of Origin, a point on the X-axis and a point on the ZX plane.

If iOrder=2: O.Y.XY Plane - Select in the order of Origin, a point on the Y-axis and a point on the XY plane.

If iOrder=3: O.X.XY Plane - Select in the order of Origin, a point on the X-axis and a point on the XY plane.

If iOrder=4: O.Z.YZ Plane - Select in the order of Origin, a point on the Z-axis and a point on the YZ plane.

If iOrder=5: O.Y.YZ Plane - Select in the order of Origin, a point on the Y-axis and a point on the YZ plane.

The default value is 0.

crlNodes​

A List of Cursor specifying the nodes to create the Coordinate.

If the veclPoints is not defined, this argument will be a required input. If this parameter is not defined, veclPoints must be defined.

veclPoints​

A List of Vector specifying the points to create the Coordinate. This parameter can be used only when crlNodes is not defined, otherwise node selection will be prioritized.

The default value is [].

crRefCoord​

A Cursor specifying the coordinate reference system to create user Coordinate. The positions specified in crlNodes (or veclPoints) will be computed from this reference Coordinate.

The default value is None (Global Coordinate System).

crEdit​

A Cursor specifying an existing Coordinate. If this parameter is used, the specified Coordinate will be modified. If it is left None, a new Coordinate will be created.

The default value is None.

Return Code​

A Cursor specifying the created Coordinate.

Sample Code​

Geometry.Part.Cube()

created_coord = Tools.Coordinates.ThreeNode(crlNodes=[Node(7, 
                                                           93, 
                                                           477)])

JPT.Debugger(created_coord)
