# Analysis.TSSolver.NonlinearStatic()

Analysis.TSSolver.NonlinearStatic()

Description​

Export TechnoStar Nonlinear Static solver file (SOL106).

Syntax​

Analysis.TSSolver.NonlinearStatic(...)

Ribbon: Analysis » TS-Solver » Nonlinear Static(SOL 106)

Inputs​

strName​

A String specifying the job name of TechnoStar solver. Output set by this name will be saved in the Assembly tree.

The default value is "Job_1".

strDescription​

A String specifying the description of TechnoStar solver job.

The default value is "".

crlTargets​

A List of Cursor specifying the list of target part.

The default value is [] (all parts in the model).

nastranAnalysis​

A NASTRAN_ANALYSIS specifying the TechnoStar solver input parameter.

The default value is NASTRAN_ANALYSIS.

crEdit​

A Cursor specifying the created TechnoStar solver job. If this parameter is used, the value will be DynamisJob(ID), where ID is the ID of the solver job had been created. If it is left None, a new TechnoStar solver job will be created.

The default value is None.

strPath​

A String specifying the export location for bdf file.

This is a required input.

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

BoundaryConditions.FixedConstraint(crlTargets=[Face(24)])
BoundaryConditions.Pressure.General(dPressure=1000000.0, 
                                    crlTargets=[Face(21, 
                                                     23)])

input_param = NASTRAN_ANALYSIS(iSolverType=3, 
                               iGridFormatType=1, 
                               bUseCASI=True, 
                               dEpsilon=DFLT_DBL,
                               iMaxNumOfIter=DFLT_INT, 
                               iMemory=1024, 
                               iSolNo=106,
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeStrain=0),
                               nastranNonlinear=NASTRAN_NONLINEAR(iMAXITER=3, 
                                                                  bUseEPSU=True, 
                                                                  bUseEPSP=True, 
                                                                  bUseEPSW=True))

export_status = Analysis.TSSolver.NonlinearStatic(nastranAnalysis = input_param, 
                                                  strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                            "/TechnoStar/Test.bdf")

JPT.Debugger(export_status)
