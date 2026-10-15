# Assemble.AddBoss()

Assemble.AddBoss()

Description​

Add boss shape to specific body as a union part.

Syntax​

Assemble.AddBoss(...)

Ribbon: Assemble » Add BOSS

Inputs​

crPart​

A Cursor specifying the part.

The default value is None.

iType​

An Integer specifying the type.

The default value is 0.

bMerge​

A Boolean specifying the merge.

The default value is True.

posOrgCenter​

A Position specifying the original center.

The default value is [0,0,0].

vecOrgDirection​

A Vector specifying the original direction.

The default value is [0,0,0].

crCoord​

A Cursor specifying the coordinate.

The default value is None.

iAxis​

An Integer specifying the axis.

The default value is 0.

dAngle​

A Double specifying the angle.

The default value is 0.0.

bHollow​

A Boolean specifying the hollow.

The default value is False.

dInnerRadius​

A Double specifying the inner radius.

The default value is 0.0.

dOrgOuterRadius​

A Double specifying the original outer radius.

The default value is 1.0.

dTaperAngle​

A Double specifying the taper angle.

The default value is 0.0.

iNodeOnCircle​

An Integer specifying the node on circle.

The default value is 12.

iNodeOnAxis​

An Integer specifying the node on axis.

The default value is 2.

dOriginalHeight​

A Double specifying the original height.

The default value is 5.0.

Return Code​

True if success, or False if fail.

Sample Code​

Geometry.Part.Cube()
result = Assemble.AddBoss(crPart=Part(1), iType=1, posOrgCenter=[0, 0.00555556, 0.00555556], vecOrgDirection=[-1.0, 0.0, 0.0], dOrgOuterRadius=1.2)
print(result)
