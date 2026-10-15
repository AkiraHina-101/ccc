# BoundaryConditions.Submodel.SubmodelForcedFlux()

BoundaryConditions.Submodel.SubmodelForcedFlux()

Description​

Create submodel forced flux.

Syntax​

BoundaryConditions.Submodel.SubmodelForcedFlux(...)

Ribbon: BoundaryConditions » Submodel » SubmodelForcedFlux

Inputs​

strName​

A String specifying the name.

This is a required input.

iSolver​

An Integer specifying the solver.

The default value is 0.

strFilePathName​

A String specifying the file path name.

The default value is "/home/".

iProcessNo​

An Integer specifying the process no.

The default value is 0.

iReferType​

An Integer specifying the refer type.

The default value is -1.

dExtensionRange​

A Double specifying the extension range.

The default value is DFLT_DBL.

dExtensionTol​

A Double specifying the extension tolerance.

The default value is DFLT_DBL.

dExtensionLimitTol​

A Double specifying the extension limit tolerance.

The default value is DFLT_DBL.

strGlobalElementSet​

A String specifying the global element set.

The default value is "".

iUseBucket​

An Integer specifying the use bucket.

The default value is -1.

iNumBucketMaxX​

An Integer specifying the number bucket maximum x.

The default value is DFLT_INT.

iNumBucketMaxY​

An Integer specifying the number bucket maximum y.

The default value is DFLT_INT.

iNumBucketMaxZ​

An Integer specifying the number bucket maximum z.

The default value is DFLT_INT.

iPrevBc​

An Integer specifying the prev bc.

The default value is -1.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

BoundaryConditions.Submodel.SubmodelForcedFlux(strName, iSolver=0, strFilePathName="/home/", iProcessNo=0, iReferType=-1, dExtensionRange=DFLT_DBL, dExtensionTol=DFLT_DBL, dExtensionLimitTol=DFLT_DBL, strGlobalElementSet="", iUseBucket=-1, iNumBucketMaxX=DFLT_INT, iNumBucketMaxY=DFLT_INT, iNumBucketMaxZ=DFLT_INT, iPrevBc=-1, crlTargets=[], crEdit=None)
