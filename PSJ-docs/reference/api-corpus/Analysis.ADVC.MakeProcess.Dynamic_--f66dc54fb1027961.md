# Analysis.ADVC.MakeProcess.Dynamic()

Analysis.ADVC.MakeProcess.Dynamic()

Description​

Create an ADVC Dynamic process.
This process could be created in one time or multiple times.

Syntax​

Analysis.ADVC.MakeProcess.Dynamic(...)

Macro: AdvcDynamicProcess

Ribbon: Analysis » ADVC » Structure » Dynamic

Inputs​

strName​

A String specifying the name of the ADVC Dynamic process will be created.

This is a required input.

iGeomNonlinear​

An Integer specifying the geometry nonlinear type:
0: None

1: Linear

2: Nonlinear

3: Total Lagrange

4: Updated Lagrange

The default value is 0.

advcStructTimeStep​

An ADVC_STRUCT_TIME_STEP specifying the time step parameters.

The default value is ADVC_STRUCT_TIME_STEP.

bConvergence​

A Boolean specifying whether to apply the convergence parameters or not.

The default value is False.

advcConvergence​

An ADVC_CONVERGENCE specifying the convergence parameters.

This argument will be specified when bConvergence=True.

The default value is ADVC_CONVERGENCE.

bContact​

A Boolean specifying whether to apply the contact parameters or not.

The default value is False.

advcContactIter​

An ADVC_CONTACT_ITER specifying the contact iteration parameters.

This argument will be specified when bContact=True.

The default value is ADVC_CONTACT_ITER.

bAutoIncrement​

A Boolean specifying whether to apply the auto increment parameters or not.

The default value is False.

advcAutoIncrement​

An ADVC_AUTO_INCREMENT specifying the auto increment parameters.

This argument will be specified when bAutoIncrement=True.

The default value is ADVC_AUTO_INCREMENT.

bDynamic​

A Boolean specifying whether to apply the ADVC dynamic parameters or not.

The default value is False.

advcDynamic​

A ADVC_DYNAMIC specifying the ADVC dynamic parameters.

This argument will be specified when bDynamic=True.

The default value is ADVC_DYNAMIC.

crEdit​

A Cursor specifying an ADVC Dynamic process.
If this parameter is used, the specified job will be modified.

If it is left None, a new job will be created.

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

A List of Integer specifying the output param list.

The default value is [].

iRefType​

An Integer specifying the reference type.

The default value is -1.

strRefPath​

A String specifying the reference path.

The default value is "".

listAdvcRefStressResult​

A List specifying the ADVC reference stress result.

The default value is [].

Return Code​

A Cursor specifying the created or the modified ADVC Dynamic process.

Sample Code​

step = Analysis.ADVC.MakeProcess.Dynamic(strName="Process_0", 
                                         iGeomNonlinear=0,
                                         advcStructTimeStep=ADVC_STRUCT_TIME_STEP(), 
                                         bConvergence=False,
                                         advcConvergence=ADVC_CONVERGENCE(), 
                                         bContact=False,
                                         advcContactIter=ADVC_CONTACT_ITER(),
                                         bAutoIncrement=False, 
                                         advcAutoIncrement=ADVC_AUTO_INCREMENT(), 
                                         bDynamic=False,
                                         advcDynamic=ADVC_DYNAMIC(), 
                                         crEdit=None, 
                                         listLoadNode=[], 
                                         listLoadCaseNode=[],
                                         listLoadNodeContact=[], 
                                         ilOutputParamList=[], 
                                         iRefType=-1, 
                                         strRefPath="",
                                         listAdvcRefStressResult=[])

JPT.Debugger(step)
