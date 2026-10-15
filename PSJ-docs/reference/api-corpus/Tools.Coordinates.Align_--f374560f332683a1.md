# Tools.Coordinates.Align()

Tools.Coordinates.Align()

Description​

Create a Coordinate System by aligning an Axis direction of Coordinate System follow with an Edge or 2 selected Nodes (1D Element). Besides, it also be used to modify an existing Coordinate System.

Syntax​

Tools.Coordinates.Align(...)

Ribbon: Tools » Coordinates » Align

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

iCoordAxis​

An Integer specifying the Coordinate Axis to align with. This option can be one of the following:

If iCoordAxis=0: X axis - Referenced to the X-axis direction, the desired CS will have X axis follow selection direction

If iCoordAxis=1: Y axis - Referenced to the Y-axis direction, the desired CS will have Y axis follow selection direction

If iCoordAxis=2: Z axis - Referenced to the Z-axis direction, the desired CS will have Z axis follow selection direction

The default value is 0.

bCreateNew​

A Boolean specifying the option to create a new Coordinate or not. This argument uses follow with crEdit, when crEdit is defined, the argument bCreateNew uses to allow creating a new one based on the selected Coordinate System or just modified the selected Coordinate System.

If True: A new Coordinate will be created.

If False: The Coordinate specified in crEdit will be modified.

The default value is True.

crlNodes​

A List of Cursor specifying the nodes to determine alignment direction of the Coordinate. This parameter is used only when crEdge is None, otherwise edge option is prioritized.

If crEdge is not defined, this argument will be a required input. If this argument is not defined, crEdge must be defined.

crEdge​

A Cursor specifying an edge to determine alignment direction of the Coordinate. If crlNodes is [], this parameter must be defined by a specified edge.

This is a required input.

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

created_coord = Tools.Coordinates.Align(strName="CRect2", 
                                        bCreateNew=False, 
                                        crlNodes=[Node(179, 
                                                       194)],
                                        crEdit=Coord(1))

JPT.Debugger(created_coord)
