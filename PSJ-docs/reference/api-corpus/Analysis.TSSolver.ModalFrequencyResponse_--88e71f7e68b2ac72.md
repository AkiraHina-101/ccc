# Analysis.TSSolver.ModalFrequencyResponse()

Analysis.TSSolver.ModalFrequencyResponse()

Description​

Export the Input Deck for TechnoStar Modal Frequency Response analysis (SOL 111).

Syntax​

Analysis.TSSolver.ModalFrequencyResponse(...)

Ribbon: Analysis » TS-Solver » Modal Frequency Response(SOL 111)

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
                               dEpsilon=DFLT_DBL,
                               iMaxNumOfIter=DFLT_INT, 
                               iMemory=1024, 
                               iSolNo=111,
                               nastranEigen=NASTRAN_EIGEN(dStartFreq=0.0, 
                                                          dEndFreq=100.0, 
                                                          iNoOfModes=3),
                               nastranFrequency=NASTRAN_FREQUENCY(dStartFrequency=0.0, 
                                                                  dIncrement=10.0, 
                                                                  iumOfInc=10),
                               nastranFreqTimestep=NASTRAN_FREQ_TIMESTEP(iDampingType=1),
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iValueAcceleration=DFLT_INT, 
                                                                           iValueVelocity=DFLT_INT,
                                                                           iTypeDisplacement=9, 
                                                                           iTypeStress=0, 
                                                                           iTypeStrain=0),
                               nastranNonlinear=NASTRAN_NONLINEAR(bUseEPSW=True))

export_status = Analysis.TSSolver.ModalFrequencyResponse(nastranAnalysis = input_param, 
                                                         strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                                   "/TechnoStar/Test.bdf")

JPT.Debugger(export_status)
