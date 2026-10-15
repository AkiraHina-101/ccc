# Analysis.ADVC.MakeProcess.DynamicExplicit()

Analysis.ADVC.MakeProcess.DynamicExplicit()

Description​

Create an ADVC Dynamic Explicit process.
This process could be created in one time or multiple times.

Syntax​

Analysis.ADVC.MakeProcess.DynamicExplicit(...)

Macro: AdvcDynamicExplicitProcess

Ribbon: Analysis » ADVC » MakeProcess » DynamicExplicit

Inputs​

strName​

A String specifying the name of the process.

This is a required input.

iGeomNonlinear​

An Integer specifying the geometric nonlinearity type:

If iGeomNonlinear=0, do not define the geometric nonlinearity type.

If iGeomNonlinear=1, a Linear geometric nonlinearity is specified.

If iGeomNonlinear=2, a Nonlinear geometric nonlinearity is specified.

If iGeomNonlinear=3, a Total Lagrange geometric nonlinearity is specified.

If iGeomNonlinear=4, a Updated Lagrange geometric nonlinearity is specified.

The default value is 0.

advcStructTimeStep​

A ADVC_STRUCT_TIME_STEP specifying the time step settings for ADVC solver.

The default value is ADVC_STRUCT_TIME_STEP.

bConvergence​

A Boolean specifying whether to apply the convergence parameters.

The default value is False.

advcConvergence​

A ADVC_CONVERGENCE specifying the convergence settings for ADVC solver. This argument must be specified when bConvergence=True.

The default value is ADVC_CONVERGENCE.

bContact​

A Boolean specifying whether to apply the contact parameters.

The default value is False.

advcContactIter​

A ADVC_CONTACT_ITER specifying the contact iterator settings for ADVC solver. This argument must be specified when bContact=True.

The default value is ADVC_CONTACT_ITER.

bAutoIncrement​

A Boolean specifying whether to apply the auto increment parameters.

The default value is False.

advcAutoIncrement​

A ADVC_AUTO_INCREMENT specifying the auto increment settings for ADVC solver. This argument must be specified when bAutoIncrement=True.

The default value is ADVC_AUTO_INCREMENT.

iLogMessageInterval​

An Integer specifying the log message interval.

The default value is DFLT_INT.

iLinearApproximation​

An Integer specifying the linear approximation.

The default value is -1.

dBulkViscosityCoef1​

A Double specifying the first bulk viscosity coefficient.

The default value is DFLT_DBL.

dBulkViscosityCoef2​

A Double specifying the second bulk viscosity coefficient.

The default value is DFLT_DBL.

dMassScalingdt​

A Double specifying the mass scaling of the dt time.

The default value is DFLT_DBL.

dDtScaleFactor​

A Double specifying the scale factor of the dt time.

The default value is DFLT_DBL.

dPenaltyScaleFactor​

A Double specifying the penalty scale factor.

The default value is DFLT_DBL.

iContactSearchInterval​

An Integer specifying the contact search interval.

The default value is DFLT_INT.

crEdit​

A Cursor specifying the existing process to be modified. If the default value is specified, a new process will be created, otherwise, the specified process will modified.

The default value is None.

listLoadNode​

A List of ADVC_LOAD_NODE specifying the load node.

If this argument is specified, the listLoadCaseNode will be empty.

The default value is [].

listLoadCaseNode​

A List of ADVC_LOAD_NODE specifying the loadcase node.

If this argument is specified, the listLoadNode will be empty.

The default value is [].

listLoadNodeContact​

A List of ADVC_LOAD_NODE specifying the load node contact.

This argument uses the instance of ADVC_LOAD_NODE and won't be duplicated with listLoadNode or listLoadCaseNode

The default value is [].

ilOutputParamList​

A List of Integer specifying the output parameters.

The default value is [].

iRefType​

An Integer specifying the reference type.

The default value is -1.

strRefPath​

A String specifying the reference path.

The default value is "".

listAdvcRefStressResult​

A List specifying the advc reference stress result.

The default value is [].

Return Code​

A Cursor specifying the created or the modified ADVC Dynamic Explicit process.

Sample Code​

step = Analysis.ADVC.MakeProcess.DynamicExplicit(strName="Process_0", 
                                                 iGeomNonlinear=3,
                                                 advcStructTimeStep=ADVC_STRUCT_TIME_STEP(iNumOfInc=10), 
                                                 listLoadNode=[], 
                                                 listLoadCaseNode=[],
                                                 listLoadNodeContact=[], 
                                                 listAdvcRefStressResult=[])

JPT.Debugger(step)
