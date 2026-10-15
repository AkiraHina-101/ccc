# Analysis.ADVC.MakeProcess.Static()

Analysis.ADVC.MakeProcess.Static()

Description​

Create ADVC Structure Static process for analysis work. This process could be created in one time or multiple times.

Syntax​

Analysis.ADVC.MakeProcess.Static(...)

Macro: AdvcStaticProcess

Ribbon: Analysis » ADVC » Make Process » Static

Inputs​

strName​

A String specifying the process name of ADVC - Static process.

This is a required input.

iGeomNonlinear​

An Integer specifying the Geometry nonlinear option:
If iGeomNonlinear=0: None

If iGeomNonlinear=1: Total Lagrange - Consider the geometric nonlinearity due to total Lagrange method

If iGeomNonlinear=2: Updated Lagrange - Consider the geometric nonlinearity due to updated Lagrange method

If iGeomNonlinear=3: Linear

If iGeomNonlinear=4: NonLinear

The default value is 0.

advcStructTimeStep​

An ADVC_STRUCT_TIME_STEP specifying the setting of Structure Static parameters such as Time Step, Output Timing Definition.

The default value is ADVC_STRUCT_TIME_STEP.

bConvergence​

A Boolean specifying to be enable/disable the Convergence parameters setting option.

If True: Enable setting option to modify the Convergence parameters

If False: Disable setting option to modify the Convergence parameters

The default value is False.

advcConvergence​

An ADVC_CONVERGENCE specifying the Convergence parameters setting.

The default value is ADVC_CONVERGENCE.

bContact​

A Boolean specifying to modify the Contact iterator parameters setting option.
If True: Enable setting option to modify the Contact iterator parameters

If False: Disable setting option to modify the Contact iterator parameters

The default value is False.

advcContactIter​

An ADVC_CONTACT_ITER specifying the Contact iterator parameters setting.

The default value is ADVC_CONTACT_ITER.

bAutoIncrement​

A Boolean specifying to modify the Auto Increment parameters setting option.
If True: Enable setting option to modify the Auto Increment parameters

If False: Disable setting option to modify the Auto Increment parameters

The default value is False.

advcAutoIncrement​

An ADVC_AUTO_INCREMENT specifying the Auto Increment parameters setting.

The default value is ADVC_AUTO_INCREMENT.

dStabilizationFactor​

A Double specifying the Stabilization factor.

The default value is 0.0.

crEdit​

A Cursor specifying the ADVC Static process in Assembly Tree to modify it. This option uses only for editing process purpose.

The default value is None.

listLoadNode​

A List of ADVC_LOAD_NODE specifying the list of nodes that assigned loads in the model.

The default value is [].

listLoadCaseNode​

A List of ADVC_LOAD_NODE specifying the list of nodes that assigned load cases in the model.

The default value is [].

listLoadNodeContact​

A List of ADVC_LOAD_NODE specifying the list of nodes that assigned contacts in the model.

The default value is [].

ilOutputParamList​

A List of Integer specifying the list of output request for the result type such as Displacement, Stress, Strain,...

The default value is [].

iRefType​

An Integer specifying the result reference type.
If iRefType=0: Temperature Load

If iRefType=1: Stress

The default value is 0.

strRefPath​

A String specifying the path of reference result.

The default value is "".

listAdvcRefStressResult​

A List of ADVC_REF_STRESS_RESULT specifying the list of data of Reference Result.

The default value is [].

Return Code​

A Cursor specifying the created or the modified ADVC Static process.

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

creating_status = Analysis.ADVC.MakeProcess.Static(strName="Process_0", 
                                                   advcStructTimeStep=ADVC_STRUCT_TIME_STEP(iNumOfInc=10), 
                                                   dStabilizationFactor=DFLT_DBL, 
                                                   listLoadNode=[], 
                                                   listLoadCaseNode=[], 
                                                   listLoadNodeContact=[], 
                                                   listAdvcRefStressResult=[])

JPT.Debugger(creating_status)

Analysis.ADVC.Structure(strPath=environ["Temp"] + \
                                "/TechnoStar/Test.adx", 
                        strName="Job_1", 
                        crlProcessSequence=[ADVCProcessStatic(1)], 
                        crlTargets=[Part(1)], 
                        bAutoAssignDummyProp=True, 
                        listLoadNodeContact=[], 
                        iUiPrecision=6, 
                        bExportGeometryID=True)
