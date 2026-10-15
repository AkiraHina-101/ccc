# BoundaryConditions.Submodel.ForcedTempertature()

BoundaryConditions.Submodel.ForcedTempertature()

Description​

Create a submodel by using temperature field from the coarse model and apply it to the submodel as a boundary condition to get the accurate highly-refined response in the area of interest.

Syntax​

BoundaryConditions.Submodel.ForcedTempertature(...)

Ribbon: BoundaryConditions » Submodel » ForcedTempertature

Inputs​

strName​

A String specifying the submodel forced temperature name.

The default value is "SubmodelForcedTemperature1".

iSolver​

An Integer specifying the solver type. Currently, there is only ADVC solver is available.

0: ADVC solver.

The default value is 0.

strFilePathName​

A String specifying the file path name.

The default value is "/home/".

iProcessNo​

An Integer specifying the process number of ADVC solver. The value must be greater than 0.

This is the required input.

iReferType​

An Integer specifying the refer type.

0: Blank.

1: Result.

2: Restart.

The default value is 0.

dExtensionRange​

A Double specifying the extension range value.

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

0: Blank.

1: Yes.

2: No.

The default value is -1.

iNumBucketMaxX​

An Integer specifying the number bucket maximum X.

The default value is DFLT_INT.

iNumBucketMaxY​

An Integer specifying the number bucket maximum Y.

The default value is DFLT_INT.

iNumBucketMaxZ​

An Integer specifying the number bucket maximum Z.

The default value is DFLT_INT.

iPrevBc​

An Integer specifying the maintaining of the specified boundary conditions.

0: Blank.

1: Default hold.

The default value is -1.

crlTargets​

A List of Cursor specifying the target entities. The target entities could be Face or Nodes.

The default value is [].

crEdit​

A Cursor specifying the cursor of boundary condition Forced Temperature need editing.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()
created_lbc = BoundaryConditions.Submodel.ForcedTempertature(strName="SubmodelForcedTemperature1",
                                                             iReferType=-1,
                                                             crlTargets=[Face(26)])
JPT.Debugger(created_lbc)
