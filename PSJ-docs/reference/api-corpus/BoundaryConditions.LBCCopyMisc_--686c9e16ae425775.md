# BoundaryConditions.LBCCopyMisc()

BoundaryConditions.LBCCopyMisc()

Description​

Unknown Description

Syntax​

BoundaryConditions.LBCCopyMisc(...)

Ribbon: BoundaryConditions » LBCCopyMisc

Inputs​

iMethod​

An Integer specifying the method.

The default value is 0.

iMatchMethod​

An Integer specifying the match method.

The default value is 0.

dlTransVec​

A Double List specifying the trans vector.

The default value is [0,0,0].

dTransMag​

A Double specifying the trans mag.

The default value is 0.

dTransOffset​

A Double specifying the trans offset.

The default value is 0.

dTransTol​

A Double specifying the trans tolerance.

The default value is 0.

crTranscrCoord​

A Cursor specifying the transcr coordinate.

The default value is None.

dlTransaxisVec​

A Double List specifying the transaxis vector.

The default value is [0,0,0].

dlTranscenterVec​

A Double List specifying the transcenter vector.

The default value is [0,0,0].

dRotateAngle​

A Double specifying the rotate angle.

The default value is 0.

dRotateTol​

A Double specifying the rotate tolerance.

The default value is 0.

crRotatecrCoord​

A Cursor specifying the rotatecr coordinate.

The default value is None.

veclMirrorPoint​

A Vector List specifying the mirror point.

The default value is [].

dMirrordOffset​

A Double specifying the mirrord offset.

The default value is 0.

dMirrorTol​

A Double specifying the mirror tolerance.

The default value is 0.1.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.LBCCopyMisc(iMethod=0, iMatchMethod=0, dlTransVec=[0,0,0], dTransMag=0, dTransOffset=0, dTransTol=0, crTranscrCoord=None, dlTransaxisVec=[0,0,0], dlTranscenterVec=[0,0,0], dRotateAngle=0, dRotateTol=0, crRotatecrCoord=None, veclMirrorPoint=[], dMirrordOffset=0, dMirrorTol=0.1, crlTargets=[])
