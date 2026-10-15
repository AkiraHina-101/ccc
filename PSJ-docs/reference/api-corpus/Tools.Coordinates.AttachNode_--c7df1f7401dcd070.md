# Tools.Coordinates.AttachNode()

Tools.Coordinates.AttachNode()

Description​

Create a Coordinate System at the specific node. Besides, it also be used to modify an existing Coordinate System.

Syntax​

Tools.Coordinates.AttachNode(...)

Ribbon: Tools » Coordinates » Attach Node

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

crNode​

A Cursor specifying the node at which the Coordinate is created.

This is a required input.

bCreateNew​

A Boolean specifying the option to create a new Coordinate or not. This argument uses follow with crEdit, when crEdit is defined, the argument bCreateNew uses to allow creating a new one based on selected Coordinate System or just modified the selected Coordinate System.
If True: A new Coordinate will be created.

If False: The Coordinate specified in crEdit will be modified.

The default value is True.

crEdit​

A Cursor specifying an existing Coordinate System to modify. If the bCreateNew is False, this specified Coordinate will be moved to the node specified in crNode, while bCreateNew is True, a new Coordinate will be created.

The default value is None.

Return Code​

A Cursor specifying the created Coordinate.

Sample Code​

Geometry.Part.Cylinder()
Tools.Coordinates.ThreeNode(veclPoints=[[0.01, 0.01, 0.01], 
                                        [0.002, 0.002, 0.002], 
                                        [0.01, 0.001, 0.01]])

created_coord = Tools.Coordinates.AttachNode(strName="CRect3", 
                                             crNode=Node(141), 
                                             crEdit=Coord(1))

JPT.Debugger(created_coord)
