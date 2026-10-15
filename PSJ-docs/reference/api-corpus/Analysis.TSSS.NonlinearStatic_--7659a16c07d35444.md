# Analysis.TSSS.NonlinearStatic()

Analysis.TSSS.NonlinearStatic()

Description​

Export the Input Deck for TechnoStar SunShine Nonlinear Static analysis (SOL 106).

Syntax​

Analysis.TSSS.NonlinearStatic(...)

Macro:  TSSS_NonlinearStatic

Ribbon: Analysis » SunShine » Nonlinear Static(SOL 106)

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

iRadialReturn​

An Integer specifying the radial return algorithm used in Nonlinear Static Analysis.

The default value is DFLT_INT.

listNastranNonlinear​

A NASTRAN_NONLINEAR list specifying the Nastran Nonlinear parameter of TechnoStar SunShine solver.

The default value is [].

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

iLGDISP​

An Integer specifying LGDISP parameter.

This default value is -1.

iRigidMethod​

An Integer specifying export RIGID card.

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

input_param = NASTRAN_ANALYSIS(iSolverType=6, 
                               iGridFormatType=1, 
                               dEpsilon=DFLT_DBL,
                               iMaxNumOfIter=DFLT_INT, 
                               iNumberOfThreads=1, 
                               iMemory=2, 
                               iNcpu=1, 
                               iSolNo=106,
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iValueBcresults=DFLT_INT, 
                                                                           iTypeStrain=0,
                                                                           iTypeBcresults=1),
                               nastranNonlinear=NASTRAN_NONLINEAR(iKMETHOD=1, 
                                                                  iMAXITER=10,
                                                                  bUseEPSW=True, 
                                                                  dEPSU=DFLT_DBL, 
                                                                  dEPSP=DFLT_DBL))

export_status = Analysis.TSSS.NonlinearStatic(nastranAnalysis = input_param,
                                              iRadialReturn=1, 
                                              strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                        "/TechnoStar/Test.bdf")

JPT.Debugger(export_status)
