# BoundaryConditions.LBCCopy.GroupCopyRotate()

BoundaryConditions.LBCCopy.GroupCopyRotate()

Description​

Copy a group rotate.

Syntax​

BoundaryConditions.LBCCopy.GroupCopyRotate(...)

Ribbon: BoundaryConditions » LBCCopy » GroupCopyRotate

Inputs​

iMethod​

An Integer specifying the method.

The default value is 1.

iMatchMethod​

An Integer specifying the match method.

The default value is 0.

posAxis​

A Position specifying the axis.

The default value is [0,0,0].

posCenter​

A Position specifying the center.

The default value is [0,0,0].

dAngle​

A Double specifying the angle.

The default value is 0.0.

dTol​

A Double specifying the tolerance.

The default value is 1.

crCoord​

A Cursor specifying the coordinate.

The default value is None.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.LBCCopy.GroupCopyRotate(iMethod=1, iMatchMethod=0, posAxis=[0,0,0], posCenter=[0,0,0], dAngle=0.0, dTol=1, crCoord=None, crlTargets=[])
