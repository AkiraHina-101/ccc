# BoundaryConditions.LBCCopy.LBCCopyMirror()

BoundaryConditions.LBCCopy.LBCCopyMirror()

Description​

Copy a LBC mirror.

Syntax​

BoundaryConditions.LBCCopy.LBCCopyMirror(...)

Ribbon: BoundaryConditions » LBCCopy » LBCCopyMirror

Inputs​

iMethod​

An Integer specifying the method.

The default value is 2.

iMatchMethod​

An Integer specifying the match method.
0: MATCH NODE.
1: MATCH FEATURE.

The default value is 0.

poslPoints​

A Position List specifying points on the mirror plane.

The default value is [].

dOffset​

A Double specifying the offset.

The default value is 0.

dTol​

A Double specifying the tolerance.

The default value is 1.

crlTargets​

A List of Cursor specifying the target connections.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.LBCCopy.LBCCopyMirror(iMethod=2, iMatchMethod=0, poslPoints=[], dOffset=0, dTol=1, crlTargets=[])
