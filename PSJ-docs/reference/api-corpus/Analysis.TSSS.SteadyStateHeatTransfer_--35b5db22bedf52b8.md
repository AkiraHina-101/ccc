# Analysis.TSSS.SteadyStateHeatTransfer()

Analysis.TSSS.SteadyStateHeatTransfer()

Description​

Export the Input Deck for TechnoStar SunShine Steady State Heat Transfer analysis (SOL 153).

Syntax​

Analysis.TSSS.SteadyStateHeatTransfer(...)

Ribbon: Analysis » SunShine » Steady State Heat Transfer(SOL 153)

Inputs​

strName​

A String specifying the job name of TechnoStar SunShine solver. Output set by this name will be saved in the Assembly tree.

The default value is "Job_1".

strDescription​

A String specifying the description of TechnoStar SunShine solver job.

The default value is "".

crlTargets​

A List of Cursor specifying the list of target part.

The default value is [] (all parts in the model).

nastranAnalysis​

A NASTRAN_ANALYSIS specifying the TechnoStar Sunshine solver input parameter.

The default value is NASTRAN_ANALYSIS.

crEdit​

A Cursor specifying the created TechnoStar SunShine solver job. If this parameter is used, the value will be DynamisJob(ID), where ID is the ID of the solver job had been created. If it is left None, a new TechnoStar solver job will be created.

The default value is None.

strPath​

A String specifying the export location for bdf file.

This is a required input.

iModelCheckAnswer​

An Integer specifying the model checking option.

The default value is 0.

iDeleteSlaveNodesAnswer​

An Integer specifying the deleting slave nodes option.

The default value is 0.

Return Code​

A Cursor specifying the exported job.

Sample Code​

from os import environ
import re

Geometry.Part.Cube()
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
                 iPropertyColor=16131973, 
                 crMaterial=Material(1), 
                 iCordM=-2, 
                 dDynaRemeshVal1=DFLT_DBL, 
                 dDynaRemeshVal2=DFLT_DBL, 
                 dDispHG=DFLT_DBL, 
                 iFLG=-1)

BoundaryConditions.BoundaryTemperature.Constant(dFTemp=373.15, 
                                                crlTargets=[Face(24)])
BoundaryConditions.HeatFlux.SurfaceFlux(strName="SurfaceHeatFlux1", 
                                        dFflux=150000.0,
                                        iDistributionMethod=1, 
                                        crTable=None, 
                                        crlTargets=[Face(23)])

input_param = NASTRAN_ANALYSIS(iSolverType=6, 
                               iGridFormatType=1, 
                               dEpsilon=1e-13,
                               iMaxNumOfIter=500, 
                               iNumberOfThreads=1, 
                               iMemory=2, 
                               iNcpu=1, 
                               iSolNo=153,
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeThermal=1, 
                                                                           iTypeFlux=6),
                               nastranNonlinear=NASTRAN_NONLINEAR(iMAXITER=DFLT_INT, 
                                                                  bUseEPSP=True, 
                                                                  bUseEPSW=True,
                                                                  dEPSU=DFLT_DBL, 
                                                                  dEPSP=0.001, 
                                                                  dEPSW=1e-06))

export_status = Analysis.TSSS.SteadyStateHeatTransfer(nastranAnalysis = input_param, 
                                                      strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                                "/TechnoStar/Test.bdf")

JPT.Debugger(export_status)
