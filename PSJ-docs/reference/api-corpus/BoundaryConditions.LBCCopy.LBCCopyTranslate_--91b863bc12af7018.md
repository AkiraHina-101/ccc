# BoundaryConditions.LBCCopy.LBCCopyTranslate()

BoundaryConditions.LBCCopy.LBCCopyTranslate()

Description​

Copy a LBC translate.

Syntax​

BoundaryConditions.LBCCopy.LBCCopyTranslate(...)

Ribbon: BoundaryConditions » LBCCopy » LBCCopyTranslate

Inputs​

iMethod​

An Integer specifying the method.
0: COPY_TRANS.
1: COPY_ROTATE.
2: COPY_MIRROR.

The default value is 0.

iMatchMethod​

An Integer specifying the match method.
0: MATCH NODE.
1: MATCH FEATURE.

The default value is 0.

posVecTrans​

A Position specifying the vector trans.

The default value is [0,0,0].

dMagnitude​

A Double specifying the magnitude.

The default value is 1.

dTrandataDoffset​

A Double specifying the trandata offset.

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

BoundaryConditions.LBCCopy.LBCCopyTranslate(iMethod=0, iMatchMethod=0, posVecTrans=[0,0,0], dMagnitude=1, dTrandataDoffset=0.0, dTol=1, crCoord=None, crlTargets=[])
