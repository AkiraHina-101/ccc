# Assemble.AddRib()

Assemble.AddRib()

Description​

Add the ribs to the body as a union part.

Syntax​

Assemble.AddRib(...)

Macro: AddRib

Ribbon: Assemble » Add Rib

Inputs​

crPart​

A Cursor specifying the part.

The default value is None.

crlFaces​

A List of Cursor specifying the face.

The default value is [].

veclPoints​

A Vector List specifying the points.

The default value is [].

dWidth​

A Double specifying the width.

The default value is 0.0.

dDepth​

A Double specifying the depth.

The default value is 0.0.

Return Code​

True if success, or False if fail.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.0025, 0.01, 0.005], dlLength=[0.005, 0.01, 0.002], strName="Cube_4", iPartColor=15429611)
result = Assemble.AddRib(crPart=Part(1), crlFaces=[Face(47)], dWidth=0.01)
print(result)
