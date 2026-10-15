# Analysis.AbaqusStep.DynamicStep()

Analysis.AbaqusStep.DynamicStep()

Description​

Create Abaqus step for Dynamic analysis.

Syntax​

Analysis.AbaqusStep.DyanmicStep(...)

Ribbon: Analysis » AbaqusStep » DynamicStep

Inputs​

strName​

A String specifying the Dynamic step name.

This is a required input.

strDesp​

A String specifying the Dynamic step description.

The default value is "".

iAutomatic​

An Integer specifying the increment method.

The default value is 0.

iMaxInc​

An Integer specifying the maximum number of increments.

The default value is 100.

dInitSize​

A Double specifying the initial increment size.

The default value is 1.0.

dMinSize​

A Double specifying the minimum increment size.

The default value is 1.0e-5.

dMaxSize​

A Double specifying the maximum increment size.

The default value is 1.0.

iSuppressHalfResCal​

An Integer specifying whether or not suppress the calculation of the half-increment residual tolerance.

The default value is 0.

dHalfStepResTol​

A Double specifying the half-increment residual tolerance value.

The default value is DFLT_DBL.

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

dAdjustFactor​

A Double specifying the adjustment factor for the number of solutions in each iteration.

The default value is 1.0.

iMaxContactIter​

An Integer specifying the maximum number of contact iterations.

The default value is 30.

dDampingControl​

An Double specifying the numerical damping control parameter.

The default value is -0.05.

iByPassCalInitAcceleration​

An Integer specifying whether or not to bypass calculations of initial accelerations at beginning of step.

The default value is 1.

iNlGeom​

An Integer specifying whether or not to consider geometric nonlinear (large deformation) analysis.

The default value is 0.

dTimePeriod​

A Double specifying the analysis time.

The default value is 1.0.

iIncldHeatEffect​

An Integer specifying whether or not to consider adiabatic heating effects.

The default value is 1.

iConvertDscntIter​

An Integer specifying the conversion of severe discontinuity iterations.

The default value is 0.

iRamp​

An Integer specifying the number of linear change over step.

The default value is 1.

iExtrapolateMethod​

An Integer specifying the Extrapolate previous state at start of each increment.

The default value is 0.

iAcceptByMaxIters​

An Integer specifying whether or not to accept the solution after reaching maximum number of iterations.

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

A Cursor specifying the created/modified Abaqus Dynamic step.

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

creating_status = Analysis.AbaqusStep.DynamicStep("Step1", 
                                                  iAutomatic=1, 
                                                  listOutput=[])

JPT.Debugger(creating_status)
