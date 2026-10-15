# Analysis.AbaqusStep.CoupledTDStep()

Analysis.AbaqusStep.CoupledTDStep()

Description​

Create Abaqus step for Coupled Temperature-Displacement analysis.

Syntax​

Analysis.AbaqusStep.CoupledTDStep(...)

Ribbon: Analysis » AbaqusStep » CoupledTDStep

Inputs​

strName​

A String specifying the step name of Coupled Temperature-Displacement analysis.

This is a required input.

strDesp​

A String specifying the step description of Coupled Temperature-Displacement analysis.

The default value is "".

iEnableAutomatic​

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

abaqusPair1​

An ABAQUS_PAIR specifying the maximum value of the allowable temperature change.

The default value is ABAQUS_PAIR.

abaqusPair2​

A ABAQUS_PAIR specifying the creep/swelling/viscoelastic strain error tolerance value.

The default value is ABAQUS_PAIR.

iCSVIntegration​

An Integer specifying the creep/swelling/viscoelastic integration method.

The default value is 0.

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

A Double specifying the adjustment factor for the number of solutions in any iteration.

The default value is 1.0.

iMaxContactIter​

An Integer specifying the maximum number of contact iterations.

The default value is 30.

iType​

An Integer specifying the automatic static stabilization.

The default value is 0.

iEnableUseAdaptive​

An Integer specifying whether or not use adaptive stabilization with max. Ratio of stabilization to strain energy.

The default value is 1.

dDampingFactor​

A Double specifying the damping factor for automatic static stabilization.

The default value is 0.0002.

dMaxRationofStrainEnergy​

A Double specifying the maximum ratio of stabilization to strain energy for automatic static stabilization.

The default value is 0.05.

iEnableNlgeom​

An Integer specifying whether or not to consider geometric nonlinear (large deformation) analysis.

The default value is 0.

dTimePeriod​

A Double specifying the analysis time.

The default value is 1.0.

iTransient​

An Integer specifying the analysis response type.

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

iEnableIncludeCSV​

An Integer specifying the inclusion of creep/swelling/viscoelatic behavior.

The default value is 0.

listAbaqusOutputRequest​

An ABAQUS_OUTPUT_REQUEST list specifying the list of Abaqus output request.

The default value is ABAQUS_OUTPUT_REQUEST.

crEdit​

A Cursor specifying the editing Abaqus Coupled Temperature-Displacement step.

The default value is None.

Return Code​

A Cursor specifying the created/modified Abaqus Coupled Temperature-Displacement step.

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

creating_status = Analysis.AbaqusStep.CoupledTDStep(strName="Step1", 
                                                    strDesp="Test", 
                                                    abaqusPair1=ABAQUS_PAIR(dlTList=[0.0]), 
                                                    abaqusPair2=ABAQUS_PAIR(dlTList=[0.0]), 
                                                    iMatrixStorage=1, 
                                                    iType=2, 
                                                    iEnableNlgeom=1, 
                                                    iTransient=0, 
                                                    listAbaqusOutputRequest=[])

JPT.Debugger(creating_status)
