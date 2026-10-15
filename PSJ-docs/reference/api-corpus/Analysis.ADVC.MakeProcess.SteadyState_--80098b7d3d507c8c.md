# Analysis.ADVC.MakeProcess.SteadyState()

Analysis.ADVC.MakeProcess.SteadyState()

Description​

Create a Heat Transfer - Steady State analysis as an ADVC process.

Syntax​

Analysis.ADVC.MakeProcess.SteadyState(...)

Macro: AdvcSSHProcess

Ribbon: Analysis » ADVC » Make Process » Steady State

Inputs​

strName​

A String specifying the process name of Heat Transfer - Steady State analysis.

This is a required input.

advcHeatTimeStep​

An ADVC_HEAT_TIME_STEP specifying the setting of Heat Transfer - Steady State parameters such as End Condition, Incrementation, Output Timing Definition.

The default value is [].

bConvergence​

A Boolean specifying to modify the Convergence parameters setting option:

If True: Enable setting option to modify the Convergence parameters

If False: Disable setting option to modify the Convergence parameters

The default value is False.

advcConvergence​

An ADVC_CONVERGENCE specifying the Convergence parameters setting.

The default value is ADVC_CONVERGENCE().

crEdit​

A Cursor specifying the ADVC Heat Steady process in Assembly Tree to modify it. This option uses only for editing process purpose.

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

A List of Integer specifying the list of output request for the result type such as Displacement, Stress, Strain,...

The default value is [].

Return Code​

A Cursor specifying the created or the modified ADVC Steady State process.

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

creating_status = Analysis.ADVC.MakeProcess.SteadyState(strName="Process_0")

JPT.Debugger(creating_status)
