# Analysis.Nastran.ModalTransientResponse()

Analysis.Nastran.ModalTransientResponse()

Description​

Export the input file for Nastran Modal Transient Response Analysis (SOL 112).

Syntax​

Analysis.Nastran.ModalTransientResponse(...)

Ribbon: Analysis » Nastran » Modal Transient Response(SOL 112)

Inputs​

strName​

A String specifying the job name of Nastran analysis.

The default value is "Job_1".

strDescription​

A String specifying the description of Nastran analysis job.

The default value is "".

crlTargets​

A List of Cursor specifying the list of target parts.

The default value is [].

nastranAnalysis​

A NASTRAN_ANALYSIS specifying the Nastran analysis input parameter.

The default value is NASTRAN_ANALYSIS.

bDummyPropAutoAssign​

A Boolean specifying whether to enable or disable the auto dummy properties creation option.

The default value is False.

iDummyPropMaterialID​

An Integer specifying the material ID which using for dummy property assignment.

The default value is 0.

crEdit​

A Cursor specifying an existing Nastran job.

If this parameter is used, the specified job will be modified.

If it is left None, a new job will be created.

The default value is None.

strPath​

A String specifying the export path for bdf file.

The default value is "".

iModelCheckAnswer​

An Integer specifying the model checking option.

0: disable model checking option used for seeking dummy property.

1: enable model checking option used for seeking dummy property.

The default value is 0.

iDeleteSlaveNodesAnswer​

An Integer specifying the deleting slave nodes option.

0: disable the deleting slave nodes checking option.

1: enable the deleting slave nodes checking option.

The default value is 0.

Return Code​

A Cursor specifying the newly created or the modified Nastran job.

Sample Code​

Geometry.Part.Cube()
Meshing.SolidMeshing(crlParts=[Part(1)], bTet10=True, dGradingFactor=1.05,
     dStretchLimit=0.1, iSpeedVsQual=1, iRegion=1, bSafeMode=False,
     iParallel=12, bInternalMeshOnly=False, iPartColor=65280)

Properties.Material.Add("Structural_Steel", [Density([(DENSITY, 7.85e-09)]),
     Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])
Properties.Solid(crMaterial=Material(1), dDynaRemeshVal1=DFLT_DBL,
     dDynaRemeshVal2=DFLT_DBL, dDispHG=DFLT_DBL, crlTargets=[Part(1)], iFLG=-1)

BoundaryConditions.FixedConstraint(crlTargets=[Face(25)])
BoundaryConditions.Pressure.General(dPressure=10.0, dlDirection=[0.0, 0.0, -1.0],
     crlTargets=[Face(26)])

nastran_param = NASTRAN_ANALYSIS(iSolverType=1, iGridFormatType=1, dEpsilon=DFLT_DBL,
     iMaxNumOfIter=DFLT_INT, iMemory=DFLT_INT, iNcpu=1, iSolNo=105,
    nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeStress=0, iTypeStrain=0),
    nastranNonlinear=NASTRAN_NONLINEAR(bUseEPSW=True))
Analysis.Nastran.ModalTransientResponse(nastranAnalysis= nastran_param,strPath="D:/Job_1.bdf")
