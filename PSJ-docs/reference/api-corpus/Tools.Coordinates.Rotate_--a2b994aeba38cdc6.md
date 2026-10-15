# Tools.Coordinates.Rotate()

Tools.Coordinates.Rotate()

Description​

Create a Coordinate System by rotating with a specified value. Besides, it also be used to modify an existing Coordinate System.

Syntax​

Tools.Coordinates.Rotate(...)

Ribbon: Tools » Coordinates » Rotate

Inputs​

strName​

A String specifying the name of the Coordinate.

The default value is "CRect1".

iCoordType​

An Integer specifying the type of Coordinate system, which is one of the following:

If iCoordType=0: Rectangular Coordinate - which can be known as Cartesian Coordinate System (Oxyz)

If iCoordType=1: Cylindrical Coordinate - (r, φ, z) Coordinate System, where (r, φ, z) are (radial distance, azimuth angle, axial Coordinate or height z) respectively

If iCoordType=2: Spherical Coordinate - (r, θ, φ) Coordinate System, where (r, θ, φ) are (radial distance, azimuth angle, polar angle) respectively

The default value is 0.

vecRotate​

A Vector specifying the rotation vector. Every component of this vector specified a degree to rotate the Coordinate about axis x, y, z, respectively. The unit of this argument is in degree (°).

The default value is [0.0,0.0,0.0].

bCreateNew​

A Boolean specifying the option to create a new Coordinate or not. This argument uses follow with crEdit, when crEdit is defined, the argument bCreateNew uses to allow creating a new one based on selected Coordinate System or just modified the selected Coordinate System.

If True: A new Coordinate will be created.

If False: The Coordinate specified in crEdit will be modified.

The default value is True.

crRefCoord​

A Cursor specifying the coordinate reference system to rotate the Coordinate specified in crEdit. The angles specified in vecRotate will be computed from this reference Coordinate.

The default value is None (Global Coordinate).

crEdit​

A Cursor specifying an existing Coordinate System to modify. If the bCreateNew is False, this specified Coordinate will be modified, while bCreateNew is True, a new Coordinate will be created.

The default value is None.

Return Code​

A Cursor specifying the created Coordinate.

Sample Code​

Geometry.Part.Cube()
Tools.Coordinates.ThreeNode(crlNodes=[Node(7, 
                                           63, 
                                           87)])

created_coord = Tools.Coordinates.Rotate(vecRotate=[59.9886811502157, 0.0, 0.0], 
                                         bCreateNew=False,
                                         crRefCoord=Coord(1), 
                                         crEdit=Coord(1))

JPT.Debugger(created_coord)
