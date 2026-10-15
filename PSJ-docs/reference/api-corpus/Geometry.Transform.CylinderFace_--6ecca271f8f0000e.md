# Geometry.Transform.CylinderFace()

Geometry.Transform.CylinderFace()

Description​

Translate two parts such that the specified two cylindrical surfaces concentric.

Syntax​

Geometry.Transform.CylinderFace(...)

Ribbon: Geometry » Transform » Cylinder Face

Inputs​

crlParts​

A List of Cursor specifying the cylinder part.

This is a required input.

veclPoint​

A List of Vector specifying the points to define the matching plane from source and target.
It contains the position of six points, the first three points define the source face, the others define the target face.

The default value is [[0.0, 0.0, 0.0]].

bCreateNewPart​

A Boolean specifying whether to keep the original part and create a new part after the transform operation.

The default value is False.

bCopyLBC​

A Boolean specifying whether to copy load boundary condition from original part to transformed one.
This argument will be ignored if bCreateNewPart=False.

The default value is False.

bCopyProperty​

A Boolean specifying whether to copy property from original part to transformed one.
This argument will be ignored if bCreateNewPart=False.

The default value is False.

Return Code​

No return value.

Sample Code​

Geometry.Part.Cylinder()
Geometry.Part.Cylinder(dlOrigin=[0.02, 0.0, 0.0], strName="Cylinder_2", iPartColor=6812659)
Geometry.Transform.CylinderFace(crlParts=[Part(1), Part(2)], veclPoint=[[0, 0, 0], [0, -1000, 0],
    [10, 0, 0], [0, 10, 0], [0, -990, 0], [10.0, 10, 10]], bCreateNewPart=True)
