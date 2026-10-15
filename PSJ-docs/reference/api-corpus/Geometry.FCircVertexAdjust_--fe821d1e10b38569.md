# Geometry.FCircVertexAdjust()

Geometry.FCircVertexAdjust()

Description​

Align the vertexes positions on the circles. Cylinder faces can also be split by 90 degree, for creating mapped mesh.

Syntax​

Geometry.FCircVertexAdjust(...)

Ribbon: Geometry » FCirc Vertex Adjust

Inputs​

crlParts​

A List of Cursor specifying the parts whose vertices will be adjusted.

The default value is [].

bFullCylinder​

A Boolean specifying whether to divide the full cylinder faces by 90 degree or not. If bFullCylinder=True, the cylindrical surfaces and torus surfaces in the selected parts will be divided into four locations at each 90 degree. This splitting makes it easier to create a mapped mesh.

The default value is False.

bCylinderMoreThan90​

A Boolean specifying whether to divide the cylinder faces more than 90 degree interior angle or not. The cylinder surfaces in the selected part with an internal angle of 90 degree or more will be divided at the 90 degree position if bCylinderMoreThan90=True.

The default value is False.

dMinRadius​

A Double specifying the minimum radius of the cylinder faces to be split. Faces with radius less than the input value are kept.

The default value is 0.0.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Make a cylinder with 2 misaligned vertex
Geometry.Part.Cylinder()
Geometry.BreakEntity.Edge(crlNodes=[Node(66)])
Geometry.BreakEntity.Edge(crlNodes=[Node(51)])

# Align vertex positions on 2 circles of the cylinder
adjust_status = Geometry.FCircVertexAdjust(crlParts=[Part(1)])

JPT.Debugger(adjust_status)
