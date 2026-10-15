# Analysis.ADVC.MakeProcess.Creep()

Analysis.ADVC.MakeProcess.Creep()

Description​

Create a Structure - Creep analysis as an ADVC process.

Syntax​

Analysis.ADVC.MakeProcess.Creep()

Macro: AdvcCreepProcess

Ribbon: Analysis » ADVC » MakeProcess » Creep

Inputs​

strName​

A String specifying the process name of Structure - Creep analysis.

This is a required input.

iGeomNonlinear​

An Integer specifying the geometry nonlinear.

The default value is 0.

advcStructTimeStep​

A Struct specifying the struct time step.

The default value is ADVC_STRUCT_TIME_STEP().

bConvergence​

A Boolean specifying the convergence.

The default value is False.

advcConvergence​

A Struct specifying the convergence.

The default value is ADVC_CONVERGENCE().

bContact​

A Boolean specifying the contact.

The default value is False.

advcContactIter​

A Struct specifying the contact iterator.

The default value is ADVC_CONTACT_ITER().

bAutoIncrement​

A Boolean specifying the auto increment.

The default value is False.

advcAutoIncrement​

A Struct specifying the auto increment.

The default value is ADVC_AUTO_INCREMENT().

dStabilizationFactor​

A Double specifying the stabilization factor.

The default value is DFLT_DBL.

bThetaDefined​

A Boolean specifying the theta defined.

The default value is False.

dTheta​

A Double specifying the theta.

The default value is DFLT_DBL.

crEdit​

A Cursor specifying the edit.

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

A List of ADVC_REF_STRESS_RESULT specifying the advc reference stress result.

The default value is [].

Return Code​

A Cursor specifying the created/modified Structure - Creep analysis as an ADVC process.

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
