# Analysis.ADVC.MakeProcess.Transient()

Analysis.ADVC.MakeProcess.Transient()

Description​

Create ADVC Heat Transfer for Transient process.

Syntax​

Analysis.ADVC.MakeProcess.Transient(...)

Macro: AdvcTHProcess

Ribbon: Analysis » ADVC » Heat Transfer » Make Process

Inputs​

strName​

A String specifying the name of the new process.

The default value is "".

iEndType​

An Integer specifying the end connection type. The possible values that it can take are 0, 1, and 2. Each of these numbers corresponds to "Max Time", "Steady Rate", "Both".

The default value is 1.

dMaxTime​

A Double specifying the maximum time. This argument is to be used when iEndType=1 or iEndType=2.

The default value is 1.

dSteadyRate​

A Double specifying the steady rate. This argument is to be used when iEndType=2 or iEndType=2.

The default value is 0.0.

iFixedOrAuto​

An Integer specifying the incrementation type.

If iFixedOrAuto=0: Use the fixed dt time value dFixedDt.

If iFixedOrAuto=1: Auto calculate the dt time value base on these parameters dMaxChange, dInitDt, dMaxDt, dMinDt.

The default value is 0.

dMaxChange​

A Double specifying the maximum change of temperature. This argument is to be used when iFixedOrAuto=1.

The default value is DFLT_DBL.

dInitDt​

A Double specifying the initial dt time. This argument is to be used when iFixedOrAuto=1.

The default value is DFLT_DBL.

iDefineMaxDt​

An Integer specifying whether to use the maximum dt time to calculate the incrementation when iFixedOrAuto=1.

The default value is 0.

dMaxDt​

A Double specifying the maximum dt time. This argument is to be used when iFixedOrAuto=1.

The default value is DFLT_DBL.

iDefineMinDt​

An Integer specifying whether to use the minimum dt time to calculate the incrementation when iFixedOrAuto=1.

The default value is 0.

dMinDt​

A Double specifying the minimum dt time. This argument is to be used when iFixedOrAuto=1.

The default value is DFLT_DBL.

dFixedDt​

A Double specifying the fixed dt time value. This argument is to be used when iFixedOrAuto=0.

The default value is DFLT_DBL.

iOutputLast​

An Integer specifying the output last.

The default value is -1.

iOutputInterval​

An Integer specifying the output interval.

The default value is DFLT_INT.

iRestartLast​

An Integer specifying the restart last.

The default value is -1.

iRestartInterval​

An Integer specifying the restart interval.

The default value is DFLT_INT.

dOutputTimeInterval​

A Double specifying the output time interval.

The default value is DFLT_DBL.

dRestartTimeInterval​

A Double specifying the restart time interval.

The default value is DFLT_DBL.

iOutputInit​

An Integer specifying the output initial.

The default value is -1.

iListOutputInterval​

An Integer specifying the list output interval.

The default value is DFLT_INT.

bConvergence​

A Boolean specifying the convergence.

The default value is False.

dCgTol​

A Double specifying the convergence tolerance.

The default value is DFLT_DBL.

dCgNrTol​

A Double specifying the convergence of Newton-Raphson method tolerance.

The default value is DFLT_DBL.

dCgDispTol​

A Double specifying the convergence of displacement tolerance.

The default value is DFLT_DBL.

dCgNrDispTol​

A Double specifying the convergence of Newton-Raphson method displacement tolerance.

The default value is DFLT_DBL.

dCgDispLimitTol​

A Double specifying the convergence of displacement limit tolerance.

The default value is DFLT_DBL.

dCgTotalDispLimitTol​

A Double specifying the convergence of total displacement limit tolerance.

The default value is DFLT_DBL.

dNewtonTol​

A Double specifying the Newton tolerance.

The default value is DFLT_DBL.

dNewtonDispTol​

A Double specifying the Newton displacement tolerance.

The default value is DFLT_DBL.

dNewtonDispLimitTol​

A Double specifying the Newton displacement limit tolerance.

The default value is DFLT_DBL.

dNewtonTotalDispLimitTol​

A Double specifying the Newton total displacement limit tolerance.

The default value is DFLT_DBL.

iCgloopMax​

An Integer specifying the convergence of loop maximum.

The default value is DFLT_INT.

iNewtonMax​

An Integer specifying the Newton maximum.

The default value is DFLT_INT.

dHtNlLoopTol​

A Double specifying the heat transfer nl loop tolerance.

The default value is DFLT_DBL.

iHtNlLoopMax​

An Integer specifying the heat transfer nl loop maximum.

The default value is DFLT_INT.

crEdit​

A Cursor specifying the existing ADVC process to be modified. If the default value is specified, a new process will be created, otherwise the specified ADVC process will be modified.

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

Return Code​

A Cursor specifying the created or the modified ADVC Transient process.

Sample Code​

from os import environ
import re

Geometry.Part.Cube(iPartColor=5619133)
Meshing.SolidMeshing(crlParts=[Part(1)],
                     bTet10=True, 
                     dGradingFactor=1.05, 
                     dStretchLimit=0.1, 
                     iSpeedVsQual=1, 
                     iRegion=1, 
                     bSafeMode=False, 
                     iParallel=12, 
                     bInternalMeshOnly=False, 
                     iPartColor=65280)

Properties.Material.Add("Concrete", 
                        [Density([(DENSITY, 2.3e-09)]), 
                        Elastic([(YOUNGS_MODULUS, 30000.0), 
                                 (POISSONS_RATIO, 0.18)])])

Properties.Solid(crlTargets=[Part(1)], 
                 strName="Solid Property 1", 
                 iPropertyColor=12275404, 
                 crMaterial=Material(1), 
                 iCordM=-2, 
                 dDynaRemeshVal1=DFLT_DBL,
                 dDynaRemeshVal2=DFLT_DBL, 
                 dDispHG=DFLT_DBL, 
                 iFLG=-1)

creating_status = Analysis.ADVC.MakeProcess.Transient(strName="Process_0", 
                                                      dSteadyRate=DFLT_DBL, 
                                                      listLoadNode=[],
                                                      listLoadCaseNode=[], 
                                                      listLoadNodeContact=[])

JPT.Debugger(creating_status)
