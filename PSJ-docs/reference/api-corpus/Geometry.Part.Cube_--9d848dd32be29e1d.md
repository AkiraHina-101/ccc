# Geometry.Part.Cube()

Geometry.Part.Cube()

Description​

Create a cuboid body in a specific location. This relative location is computed to the specified local coordinate system.

Syntax​

Geometry.Part.Cube(...)

Macro: CreateCube

Ribbon: Geometry ➡ Part ➡ Cube

Inputs​

dlOrigin​

A List of Double representing the X-, Y-, and Z-coordinates of the origin point.

The default value is [0.0,0.0,0.0].

dlLength​

A List of Double specifying the cube length in meters in the X-, Y-, Z-axis direction.

The default value is [0.01,0.01,0.01].

ilAxialNodes​

A List of Integer specifying the number of nodes along to each X-, Y-, Z-axis.

The default value is [10,10,10].

strName​

A String specifying the name of the newly created part.

The default value is "Cube_1".

iPartColor​

An Integer specifying the color of the newly created part.

The default value is 7105764.

crLocalCoordinate​

A Cursor specifying the local coordinate system.

The default value is None.

Return Code​

A Cursor of cube if success, or None if fail.

Sample Code​

created_cube = Geometry.Part.Cube(dlOrigin=[0.005, 0.005, 0.005], 
                                  strName="Cube_1", 
                                  iPartColor=13259210)
JPT.Debugger(created_cube)
