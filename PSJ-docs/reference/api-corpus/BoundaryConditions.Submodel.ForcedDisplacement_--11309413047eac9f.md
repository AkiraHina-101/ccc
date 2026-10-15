# BoundaryConditions.Submodel.ForcedDisplacement()

BoundaryConditions.Submodel.ForcedDisplacement()

Description​

Create a forced displacement boundary condition for node-based submodeling.

Syntax​

BoundaryConditions.Submodel.ForcedDisplacement(...)

Ribbon: BoundaryConditions » Submodel » Submodel Forced Displacement

Inputs​

strName​

A String specifying the new Boundary Condition name.

The default value is "SubmodelForcedDisplacement1".

iSolver​

An Integer specifying the applied Solver. Possible value is 0 corresponding to ADVC solver.

The default value is 0.

strDataDirectory​

A String specifying the data directory name of the global model containing the model, result, and restart. It can be specified as either an absolute path or a relative path.

The default value is "/home/".

iProcessNo​

An Integer specifying the process number.

The default value is 0.

bMapX​

A Boolean specifying whether to map the X translational degree of freedom.

The default value is True.

bMapY​

A Boolean specifying whether to map the Y translational degree of freedom.

The default value is True.

bMapZ​

A Boolean specifying whether to map the Z translational degree of freedom.

The default value is True.

iReferType​

An Integer specifying the reference destination for the result directory of the global model.

0: Not specified - Refers to the normal output result (dir name / result)

1: Result - Refer to the normal output result (dir name / result)

2: Restart - Refer to the restart output result (dir name / restart)

The default value is 0.

dExtensionRange​

A Double specifying the extension of the range in the global coordinate system. Extend the search range by range in the global coordinate system.

The default value is DFLT_DBL.

dExtensionTol​

A Double specifying the extension of the range in the element coordinate system. Extend the search range by tolerance in the element coordinate system. If specified value smaller than dExtensionLimitTol, the extension parameter in the element coordinate system is dExtensionLimitTol.

The default value is DFLT_DBL.

dExtensionLimitTol​

A Double specifying the Newton-Raphson iteration convergence tolerance for calculating the "global coordinates corresponding to the submodel".

The default value is DFLT_DBL.

strGlobalElementSet​

A String specifying the element group name of the "global element containing submodel" that is known in advance.

The default value is "".

iUseBucket​

An Integer specifying whether to use the bucket method to speed up the search.

0: Not specified - Use the bucket method

1: Yes - Use the bucket method

2: No - Do not use the bucket method

The default value is 0.

iNumBucketMaxX​

An Integer specifying the maximum number of bucket divisions in the x-direction.

The default value is DFLT_INT.

iNumBucketMaxY​

An Integer specifying the maximum number of bucket divisions in the y-direction.

The default value is DFLT_INT.

iNumBucketMaxZ​

An Integer specifying the maximum number of bucket divisions in the z-direction.

The default value is DFLT_INT.

iPrevBc​

An Integer specifying the specified boundary condition to maintain.

0: Not specified

1: Default Hold

The default value is 0.

crlTargets​

A List of Cursor specifying the targets to be applied. The target can be Face entities or Node entities. The crlTargets and crForcedDispBC arguments are mutually exclusive. One of them must be specified.

The default value is [].

crForcedDispBC​

A Cursor specifying the existing Boundary Condition (Forced Displacement). If this argument is not None, the specified Boundary Condition will be modified. Otherwise, a new Boundary Condition will be created. The crlTargets and crForcedDispBC arguments are mutually exclusive. One of them must be specified.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

Geometry.Part.Cube()
created_bcs = BoundaryConditions.Submodel.ForcedDisplacement(crlTargets=[Face(26)])
JPT.Debugger(created_bcs)
