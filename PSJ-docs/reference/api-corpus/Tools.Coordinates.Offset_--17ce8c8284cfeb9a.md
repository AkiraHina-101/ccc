# Tools.Coordinates.Offset()

Tools.Coordinates.Offset()

Description​

Create a Coordinate System by offsetting with a specified value. Besides, it also be used to modify an existing Coordinate System.

Syntax​

Tools.Coordinates.Offset(...)

Ribbon: Tools » Coordinates » Offset

Inputs​

strName​

A String specifying the name.

The default value is "CRect1".

iCoordType​

An Integer specifying the type of Coordinate system, which is one of the following:
If iCoordType=0: Rectangular Coordinate - which can be known as Cartesian Coordinate System (Oxyz)

If iCoordType=1: Cylindrical Coordinate - (r, φ, z) Coordinate System, where (r, φ, z) are (radial distance, azimuth angle, axial Coordinate or height z) respectively

If iCoordType=2: Spherical Coordinate - (r, θ, φ) Coordinate System, where (r, θ, φ) are (radial distance, azimuth angle, polar angle) respectively

The default value is 0.

vecTranslate​

A Vector specifying the translation vector which contains position value in metre.

The default value is [0.0,0.0,0.0].

bCreateNew​

A Boolean specifying the option to create a new Coordinate or not. This argument uses follow with crEdit, when crEdit is defined, the argument bCreateNew uses to allow creating a new one based on selected Coordinate System or just modified the selected Coordinate System.
If True: A new Coordinate will be created.

If False: The Coordinate specified in crEdit will be modified.

The default value is True.

crRefCoord​

A Cursor specifying the coordinate reference system to offset the Coordinate specified in crEdit. The values specified in vecTranslate will be computed from this reference Coordinate.

The default value is None (Global Coordinate).

crEdit​

A Cursor specifying an existing Coordinate System to modify. If the bCreateNew is False, this specified Coordinate will be modified, while bCreateNew is True, a new Coordinate will be created.

The default value is None.

Return Code​

A Cursor specifying the created Coordinate.

Sample Code​

Geometry.Part.Cylinder()
Tools.Coordinates.ThreeNode(veclPoints=[[0.01, 0.01, 0.01], 
                                        [0.002, 0.002, 0.002], 
                                        [0.01, 0.001, 0.01]])

created_coord = Tools.Coordinates.Offset(strName="CRect2", 
                                         vecTranslate=[0.01, 
                                                       0.01, 
                                                       0.01])

JPT.Debugger(created_coord)
