# Analysis.ADVC.MakeProcess.EigenValue()

Analysis.ADVC.MakeProcess.EigenValue()

Description​

Create a Structure - Eigenvalue analysis as an ADVC process.

Syntax​

Analysis.ADVC.MakeProcess.EigenValue(...)

Macro: AdvcEigenProcess

Ribbon: Analysis » ADVC » Structure » EigenValue

Inputs​

strName​

A String specifying the process name of Structure - Eigenvalue analysis.

This is a required input.

bEigenValue​

A Boolean specifying to be enable/disable the Eigenvalue parameters option.

The default value is False.

advcNormalModal​

A ADVC_NORMAL_MODAL specifying the parameters setting for the Eigenvalue analysis such as Eigen Num of Modes, Eigenvalue Parameter.

The default value is ADVC_NORMAL_MODAL.

crEdit​

A Cursor specifying the ADVC Eigenvalue process in Assembly Tree to modify it. This option uses only for editing process purpose.

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

A List of Integer specifying the list of output parameters.

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

A List of ADVC_REF_STRESS_RESULT specifying the advc reference stress result.

The default value is [].

Return Code​

A Cursor specifying the created/modified Structure - Eigenvalue analysis as an ADVC process.

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

creating_status = Analysis.ADVC.MakeProcess.EigenValue(strName="Process_0")

JPT.Debugger(creating_status)

Analysis.ADVC.Structure(strPath=environ["Temp"] + \
                                "/TechnoStar/Test.adx", 
                        strName="Job_1", 
                        crlProcessSequence=[ADVCProcessEigen(1)], 
                        crlTargets=[Part(1)], 
                        bAutoAssignDummyProp=True, 
                        crDummyPropMaterial=Material(1), 
                        listLoadNodeContact=[], 
                        iUiPrecision=6, 
                        bExportGeometryID=True)
