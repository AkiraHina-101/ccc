# BoundaryConditions.LBCCopy.GroupCopyMirror()

BoundaryConditions.LBCCopy.GroupCopyMirror()

Description​

Copy a group mirror.

Syntax​

BoundaryConditions.LBCCopy.GroupCopyMirror(...)

Ribbon: BoundaryConditions » LBCCopy » GroupCopyMirror

Inputs​

iMethod​

An Integer specifying the mirror group copy method.

The default value is 2.

iMatchMethod​

An Integer specifying the match method.
0: Node method. This matching method matches the exact nodes of the target to get matching results. It is useful when the target features are different.

1: Feature method. This matching method is very fast, especially for large models, and requires face-to-face, vertex to vertex like feature matching. 

The default value is 0.

poslPoints​

A Position List specifying the list of points that create the center line of mirror.

The default value is [].

dOffset​

A Double specifying the offset value for mirror in unit of length.

The default value is 0.0.

dTol​

A Double specifying the tolerance value to be used for determination of conformity.

Unit of length.

The default value is 1.0.

crlTargets​

A List of Cursor specifying the list of targets.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

result = BoundaryConditions.LBCCopy.GroupCopyMirror(iMethod=2, iMatchMethod=0,
    poslPoints=[], dOffset=0.0, dTol=1.0, crlTargets=[])

print(result) #for checking return value
