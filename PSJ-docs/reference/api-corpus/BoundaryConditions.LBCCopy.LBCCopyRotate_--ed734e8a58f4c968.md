# BoundaryConditions.LBCCopy.LBCCopyRotate()

BoundaryConditions.LBCCopy.LBCCopyRotate()

Description​

Copy a LBC rotate.

Syntax​

BoundaryConditions.LBCCopy.LBCCopyRotate(...)

Ribbon: BoundaryConditions » LBCCopy » LBCCopyRotate

Inputs​

iMethod​

An Integer specifying the method.
0: COPY_TRANS.
1: COPY_ROTATE.
2: COPY_MIRROR.

The default value is 1.

iMatchMethod​

An Integer specifying the match method.
0: MATCH NODE.
1: MATCH FEATURE.

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

A List of Cursor specifying the targets.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.LBCCopy.LBCCopyRotate(iMethod=1, iMatchMethod=0, posAxis=[0,0,0], posCenter=[0,0,0], dAngle=0.0, dTol=1, crCoord=None, crlTargets=[])
