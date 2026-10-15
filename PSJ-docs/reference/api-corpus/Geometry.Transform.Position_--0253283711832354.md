# Geometry.Transform.Position()

Geometry.Transform.Position()

Description​

This method moves the parts by selecting three pairs of nodes. The given parts move onto a target position in a one-one correspondence between source and target.

Syntax​

Geometry.Transform.Position(crlParts, veclPoint=[[0.0, 0.0, 0.0]], bCreateNewPart=False, bCopyLBC=False,
    bCopyProperty=False)

Macro: PositionBody

Ribbon: Geometry » Transform » Position

Inputs​

crlParts​

A List of Cursor specifying the parts to be transformed.

This is a required input.

veclPoint​

A List of Vector specifying the points using for movement. Six points are required corresponding to three pairs of nodes respectively. Each pair is in a one-one correspondence between target and source.

The default value is [[0.0,0.0,0.0]].

bCreateNewPart​

A Boolean specifying whether to copy the transformed parts to new parts.

The default value is False.

bCopyLBC​

A Boolean specifying whether to copy load boundary conditions from the existing part to new parts. This argument will only affect the functionality when bCreateNewPart=True.

The default value is False.

bCopyProperty​

A Boolean selecting whether to copy property from the existing part to new parts. This argument will only affect the functionality when bCreateNewPart=True.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube(iPartColor=14540142)

Geometry.Part.Wedge(vecOrigin=[0.01, 0.01, 0.01], iPartColor=6678885)

Geometry.Transform.Position(crlParts=[Part(1)], veclPoint=[[0.0, 0.0, 10.0], [10.0, 0.0, 10.0],
    [0.0, 10.0, 10.0], [10.0, 10.0, 20.0], [20.0, 10.0, 20.0], [10.0, 20.0, 20.0]])
