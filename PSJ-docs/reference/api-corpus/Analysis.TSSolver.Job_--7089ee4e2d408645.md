# Analysis.TSSolver.Job()

Analysis.TSSolver.Job()

Description​

Create TechnoStar Solver Job which is necessary for Analysis.TSSolver.ExportDynamisBdf.

Syntax​

Analysis.TSSolver.Job(...)

Macro: DynamisJob

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

Return Code​

A Cursor specifying the created jobs.

Sample Code​

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

BoundaryConditions.FixedConstraint(crlTargets=[Face(25)])
BoundaryConditions.Pressure.General(dPressure=10.0, 
                                    dlDirection=[0.0, 
                                                 0.0, 
                                                 -1.0],
                                    crlTargets=[Face(26)])

dynamic_param = NASTRAN_ANALYSIS(iSolverType=3, 
                                 iGridFormatType=1, 
                                 dEpsilon=DFLT_DBL,
                                 iMaxNumOfIter=DFLT_INT, 
                                 iMemory=DFLT_INT, 
                                 iNcpu=1, 
                                 iSolNo=101,
                                 nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iValueBcresults=DFLT_INT, 
                                                                             iValueBgresults=DFLT_INT,
                                                                             iTypeStrain=0), 
                                 nastranNonlinear=NASTRAN_NONLINEAR(iKMETHOD=3, 
                                                                    iMAXITER=1, 
                                                                    bUseEPSW=True))

created_job = Analysis.TSSolver.LinearStatic(nastranAnalysis = dynamic_param)

JPT.Debugger(created_job)
