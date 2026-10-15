# Analysis.Nastran.LinearStatic()

Analysis.Nastran.LinearStatic()

Description​

Export the input file for Nastran Structure Linear Static anlysis (SOL 101).

Syntax​

Analysis.Nastran.LinearStatic(...)

Ribbon: Analysis » Nastran » LinearStatic

Inputs​

strName​

A String specifying the job name of Nastran analysis.

The default value is "Job_1".

strDescription​

A String specifying the description of Nastran analysis job.

The default value is "".

crlTargets​

A List of Cursor specifying list of target parts.

The default value is [].

nastranAnalysis​

A NASTRAN_ANALYSIS specifying the Nastran analysis input parameter.

The default value is NASTRAN_ANALYSIS.

bDummyPropAutoAssign​

A Boolean specifying whether to enable or disable the auto dummy properties creation option.

The default value is False.

iDummyPropMaterialID​

An Integer specifying the material ID which is used for dummy property assignment.

The default value is 0.

crEdit​

A Cursor specifying an existing Nastran job.

If this parameter is used, the specified job will be modified.

If it is left None, a new job will be created.

The default value is None.

strPath​

A String specifying the export path for bdf file.

This is a required input.

iModelCheckAnswer​

An Integer specifying the model checking option.

0: disable model checking option used for seeking dummy properties.

1: enable model checking option used for seeking dummy properties.

The default value is 0.

iDeleteSlaveNodesAnswer​

An Integer specifying the deleting slave nodes option.

0: disable the deleting slave nodes checking option.

1: enable the deleting slave nodes checking option.

The default value is 0.

Return Code​

A Cursor specifying the created job.

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

nastran_param = NASTRAN_ANALYSIS(iSolverType=1, 
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

exported_job = Analysis.Nastran.LinearStatic(nastranAnalysis = nastran_param, 
                                             strPath=re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                     "/TechnoStar/Test.bdf")

JPT.Debugger(exported_job)
