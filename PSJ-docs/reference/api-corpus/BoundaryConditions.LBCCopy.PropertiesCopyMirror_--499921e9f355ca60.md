# BoundaryConditions.LBCCopy.PropertiesCopyMirror()

BoundaryConditions.LBCCopy.PropertiesCopyMirror()

Description​

Copy a property mirror.

Syntax​

BoundaryConditions.LBCCopy.PropertiesCopyMirror(...)

Ribbon: BoundaryConditions » LBCCopy » PropertiesCopyMirror

Inputs​

iMethod​

An Integer specifying the method.

The default value is 2.

iMatchMethod​

An Integer specifying the match method.

The default value is 0.

poslPoints​

A Position List specifying the points.

The default value is [].

dOffset​

A Double specifying the offset.

The default value is 0.

dTol​

A Double specifying the tolerance.

The default value is 1.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.LBCCopy.PropertiesCopyMirror(iMethod=2, iMatchMethod=0, poslPoints=[], dOffset=0, dTol=1, crlTargets=[])
