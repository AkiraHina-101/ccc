# Analysis.AbaqusStep.SteadyStateStep()

Analysis.AbaqusStep.SteadyStateStep()

Description​

Create Abaqus step for Steady State analysis.

Syntax​

Analysis.AbaqusStep.SteadyStateStep(...)

Ribbon: Analysis » AbaqusStep » SteadyStateStep

Inputs​

strName​

A String specifying the Steady State step name.

This is a required input.

strDesp​

A String specifying the Steady State step description.

The default value is "".

iAutomatic​

An Integer specifying the increment method.

The default value is 0.

iMaxInc​

An Integer specifying the maximum number of increments.

The default value is 100.

iInitSize​

An Integer specifying the initial increment size.

The default value is 1.

dMinSize​

A Double specifying the minimum increment size.

The default value is 1.0e-5.

dMaxSize​

A Double specifying the maximum increment size.

The default value is 1.0.

dMaxAllowTChange​

A Double specifying the maximum value of the allowable temperature change.

The default value is DFLT_DBL.

endStepTemp​

An ABAQUS_PAIR specifying the end step temperature information.

The default value is ABAQUS_PAIR.

dMaxAllowEmissivityChange​

A Double specifying the maximum allowable emissivity change per increment.

The default value is 0.1.

iMethod​

An Integer specifying the equation solver method.

The default value is 0.

iMatrixStorage​

An Integer specifying the equation solver matrix storage setting.

The default value is 0.

iSolutionTech​

An Integer specifying the solution technique.

The default value is 0.

iAllowedIters​

An Integer specifying the number of iterations allowed before the kernel matrix is reformed.

The default value is 8.

iAdjustFactor​

An Integer specifying the adjustment factor for the number of solutions in each iteration.

The default value is 1.

iMaxContactIter​

An Integer specifying the maximum number of contact iterations.

The default value is 30.

iNlGeom​

An Integer specifying whether or not to consider geometric nonlinear (large deformation) analysis.

The default value is 0.

dTimePeriod​

A Double specifying the analysis time.

The default value is 1.0.

iConvertDscntIter​

An Integer specifying the conversion of severe discontinuity iterations.

The default value is 0.

iRamp​

An Integer specifying the number of linear change over step.

The default value is 0.

iExtrapolateMethod​

An Integer specifying the Extrapolate previous state at start of each increment.

The default value is 0.

listAbaqusOutputRequest​

An ABAQUS_OUTPUT_REQUEST list specifying the list of Abaqus output request.

The default value is ABAQUS_OUTPUT_REQUEST.

crEdit​

A Cursor specifying an existing Abaqus step.

If this parameter is used, the specified step will be modified.

If it is left None, a new step will be created.

The default value is None.

Return Code​

A Cursor specifying the created/modified Abaqus Steady State step.

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

creating_status = Analysis.AbaqusStep.SteadyStateStep("Step1", 
                                                      iAutomatic=1, 
                                                      iRamp=1, 
                                                      listAbaqusOutputRequest=[])

JPT.Debugger(creating_status)
