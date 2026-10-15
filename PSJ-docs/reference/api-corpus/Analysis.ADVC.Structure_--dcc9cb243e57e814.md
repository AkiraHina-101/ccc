# Analysis.ADVC.Structure()

Analysis.ADVC.Structure()

Description​

Create and export the ADVC (*.adx) file for the Structure analysis.

Syntax​

Analysis.ADVC.Structure(...)

Ribbon: Analysis » ADVC » Structure

Inputs​

strName​

A String specifying the job name of ADVC analysis. This name would be the name of analysis job in Assembly Tree and the name of the ADX file after exported.

The default value is "".

strDescription​

A String specifying the description for ADVC analysis job. The description would write in the ADX file, where contents will be written below ModelInfo.

The default value is "".

crlProcessSequence​

A List of Cursor specifying the list of ADVC process sequence. This argument controls the Process solution type and its setting information depended on solution type.

The default value is [].

crlElemLocationGroup​

A List of Cursor specifying the list of element location. The model contains element group such as 3D Element, 2D Element, 1D Element to use this argument.

The default value is [].

crlNodeLocationGroup​

A List of Cursor specifying the list of node location. The model contains node group to use this argument.

The default value is [].

bWriteGroup​

A Boolean specifying to be enable/disable the write group option which output a selected group of faces, elements, nodes as Surface Segment, Element Set and Node set respectively.
If True, ADX file would contained group information such as Part, Face, Element(3D,2D,1D), Node,...

If False, ADX won't write group information.

The default value is False.

crEdit​

A Cursor specifying an existing ADVC job in Assembly Tree to modify it. If this parameter is used, the specified ADVC job will be modified. If it is left None, a new ADVC job will be created.

The default value is None.

bResultReference​

A Boolean specifying to be enable/disable the Result Reference option is defined or not.
If True, this option will allow to active settings of Result Reference. The settings of Result Reference arguments will be valid to use.

If False, this option will be disable settings of Result Reference. In this case, the settings of Result Reference arguments will be ignored even though User has set value or not.

The default value is False.

iSeparateFile​

An Integer specifying the separate file type. This option allows to separate information into many exported ADX files by selected type.
If iSeparateFile=0: None, this option would export only 1 ADX file contains all information of all bodies/parts in the model (ModelInfo, Unit, Geometry, LBCs, Process Sequence,...)

If iSeparateFile=1: By Model, this option would export 2 ADX files, which the first ADX file has same name as analysis Job will contain general information (such as ModelInfo, Unit, LBCs, Job name, Process Sequence, other settings of ADVC Structure analysis).
When the last one ADX file which has suffix name "_model", contains Geometry information (such as Node, Part, Element,...)

If iSeparateFile=2: By Body, this option would export ADX files, which each body/part in model would be written individually Geometry information, Group in model would be written in another file, while other information would be written in the ADX file has same name as analysis Job.

If iSeparateFile=3: By Selected Body, this option would export ADX file that write information of selected part/body. If selection does not have at least a specific body/part, Jupiter would write all bodies/part (same option as None).

If iSeparateFile=4: By Selected LBCs, this option would export 1 ADX file contains LBCs information of the chosen LBCs.

The default value is 0.

bExportRelatedAllLBCs​

A Boolean specifying to be enable/disable the option that export all related Load Boundary Condition. This option could be used when iSeparateFile=3(By Selected Body), if not, this setting is not activated for both True or False.
If True, this option would export the ADX file contains related information to LBCs such as Contact, Connection RBE, Bolt Pretension,...

If False, this option won't export related information to LBCs such as Contact, Connection RBE, Bolt Pretension,...

The default value is False.

bUseEntityName​

A Boolean specifying to be enable/disable the option that use entity name in exported file or not.
If True, this option would export the ADX file that write Entity name(Name of the Part/Entity) to Geometry information such as Part, Face,...

If False, this option would export the ADX file without writing Entities name to Geometry information.

The default value is False.

bMatrixSolverParam​

A Boolean specifying to be enable/disable the option that the Matrix Solver Parameter is defined ot not.
If True, this option will allow to active settings of Matrix Solver Parameter. The settings of Matrix Solver Parameter arguments will be valid to use.

If False, this option will be disable settings of Matrix Solver Parameter. In this case, the settings of Matrix Solver Parameter arguments will be ignored even though User has set value or not.

The default value is False.

iPreconditionType​

An Integer specifying the precondition type.
If iPreconditionType=0: Scaling

If iPreconditionType=1: CGCG

If iPreconditionType=2: CGCG2

If iPreconditionType=3: CGCG2_Diag

If iPreconditionType=4: CGCG2-SOR

The default value is 0.

iMatrixStructure​

An Integer specifying the matrix structure type.
If iMatrixStructure=0: Symmetry

If iMatrixStructure=1: Asymmetry

The default value is 0.

crlTargets​

A List of Cursor specifying the list of targets. The target could be Part or LBCs item.

The default value is [].

iLoadType​

An Integer specifying the load type uses for analysis.
If iLoadType=0: Load Case, which is a group of specific Loads, BCs applies on model. The model could apply many Load Cases which may have same setting of LBCs. Exporting ADX file would write all Load Cases.

If iLoadType=1: Load, which will export the ADX file stores all Loads, BCs as a 1 Load case only.

The default value is 1.

bSameOutputOnAllProcess​

A Boolean specifying to be enable/disable the same output request for all processes.
If True, this option would set same output request (Displacement, Stress, Strain,...) for all defined processes.

If False, this option would set output request which will base on user's desired result for each process.

The default value is True.

bDeleteFloatingNode​

A Boolean specifying to be enable/disable the option that would delete floating node or not.
If True, this option would export an ADX file without writing floating nodes information.

If False, this option would export an ADX file with floating nodes information.

The default value is True.

bBC​

A Boolean specifying to be enable/disable the option that would separate boundary condition. This option could be used when iSeparateFile=3 (By Selected Body), if not, this setting is not activated for both True or False.
If True, this option would export an ADX file would write LBCs information.

If False, this option won't export an ADX file would write LBCs information.

The default value is True.

bCheckBCDuplicate​

A Boolean specifying to be enable/disable checking whether boundary conditions are duplicated or not.
If True, this option checks LBCs duplication when export the ADX file.

If False, this option won't check LBCs duplication when export the ADX file.

The default value is False.

bAutoAssignDummyProp​

A Boolean specifying to be enable/disable automatically assign dummy property option. This option used when model that has not assign property yet. If the model already has property
If True, the model would be exported with dummy property for the Part that does not have property. The others Part (which already assigned property) will export with its property setting.

If False, the model will export ADX file in case of the model has all property in all Parts, but if there is one Part that does not have property in the model, this option will not export file.

The default value is False.

crDummyPropMaterial​

A Cursor specifying the dummy property material for automatically assigning dummy property when export the ADX file.

The default value is None.

bReferenceRestartData​

A Boolean specifying to be enable/disable the Reference Restart Data is defined or not.
If True, this option will allow to active settings of Reference Restart Data. The settings of Reference Restart Data arguments will be valid to use.

If False, this option will be disable settings of Reference Restart Data. In this case, the settings of Reference Restart Data arguments will be ignored even though User has set value or not.

The default value is False.

strReferenceRestartDataPath​

A String specifying the path of Reference Restart Data.

The default value is "".

iReferenceRestartDataProcessNum​

An Integer specifying the number of process for Reference Restart Data.

The default value is DFLT_INT.

iReferenceRestartDataStepNum​

An Integer specifying the number of Reference Restart Data step.

The default value is DFLT_INT.

iReferenceRestartDataCoordType​

An Integer specifying the coordinate type of Reference Restart Data.
If iReferenceRestartDataCoordType=0: Initial type

If iReferenceRestartDataCoordType=1: Deformation type

The default value is 0.

iReferenceRestartDataUpdateContactSearch​

An Integer specifying the update contact search for Reference Restart Data.
If iReferenceRestartDataUpdateContactSearch=0: No

If iReferenceRestartDataUpdateContactSearch=1: Yes

The default value is 1.

listLoadNodeContact​

A LOAD_NODE_CONTACT List specifying the list of load node contact.

The default value is [].

bCreateProcessForBoltFixedLength​

A Boolean specifying the option that creates process for bolt fixed length.
If True, this option will set the "Bolt Fixed Length" given in the initial process to hold in the next process.

If False, this option will won't take the "Bolt Fixed Length" setting in the initial process to apply on the next process.

This setting uses the character string "BoltLoadFixedLength".

The default value is False.

strPath​

A String specifying the exporting path for the ADX file.

This is a required input.

iNumType​

An Integer specifying the numeric format type. This argument would allow numeric setting type of the ADX file.
If iNumType=0: Real Type - The numerical values in real number format (123.456).

If iNumType=1: Power Type - The numerical values in exponential/scientific format (1.234E-005).

The default value is 0.

iUiWidth​

An Integer specifying the limitation number of digits before the point of the number. This option allows to control number digits of value in the exported ADX file.

The default value is 10.

iUiPrecision​

An Integer specifying the limitation number of digits after the point of the number. This option allows to control number digits of value in the exported ADX file.

The default value is 1.

bExportGeometryID​

A Boolean specifying to be enable/disable the write geometry ID number.

The default value is False.

bSeparatePartInfoFile​

A Boolean specifying to be enable/disable the option that separate Part Information Files.

The default value is False.

strADVCTemplateFilePath​

A String specifying the path of Template File.

The default value is "".

bOutputDefinition​

A Boolean specifying to be enable/disable the option that sets the output request.

The default value is True.

iDataFormatType​

An Integer specifying the data format type.

iEJobType​

An Integer specifying the job type (Structure = 0)

vecObjectiveFunction​

A Vector specifying Objective Function.

Defined by Optimization_ObjectiveConstraint_Parameter. Members are as follows:
### ` enFunctionType` - An _Integar_ specifying the function type.
 | ID | Function | Description

 | -1 | Unknown_Function | No selection

 | 0 | Compliance_Function | Compliance Function

 | 1 | Displacement_Function | Displacement Function

 | 2 | Eigen_Frequency_Function | Eigen Frequency Function

 | 3 | Mass_Function | Mass Function

 | 4 | Maximum Displacement Function | Maximum Displacement Function

 | 5 | Maximum_Mises_Stress_Function | Maximum Mises Stress Function

 | 6 | Maximum_Principal_Stress_Function | Maximum Principal Stress Function

 | 7 | Minimum_Principal_Stress_Function | Minimum Principal Stress Function

 | 8 | Surface_Area_Function | Surface Area Function

 | 9 | Volume_Function | Volume Function

 | 10 | Optimization_Frozen_Node | Optimization Frozen Node

 | 11 | Optimization_Frozen_Element | Optimization_Frozen Element

 | 12 | Shape_Optimization_Fixed_Node | Shape Optimization Fixed Node

 | 13 | Shape_Optimization | Shape Optimization

 | 14 | Shape_Optimization_Contact_pair | Shape Optimization Contact pair

 | 15 | Shape_Optimization_Die_Drawing | Shape Optimization Die Drawing

 | 16 | Shape_Optimization_Interference_Node | Shape Optimization Interference Node

 | 17 | Shape_Optimization_Thickness | Shape Optimization Thickness

 | 18 | Topology_Optimization | Topology Optimization

 | 19 | Topology_Optimization_Die_Drawing | Topology Optimization Die Drawing

 | 20 | Optimization_Function_Type_Count | Optimization Function Type Count

This is a required input.

 strFunctionName​

A String specifying the name of function.

This is a required input.

iDisplacementRelation​

A Int specifying to set Displacement Relation or not.

The default value is -1.

strDegreeOfFreedomNum​

A String specifying to set Degree Of Freedom Number.

dDisplacementCoefficient​

A Double specifying to set Displacement Coefficient.

iConstraint​

A Int specifying type of Constraint.
If iConstraint=0: Equality

If iConstraint=1: Inequality

dConstraintTol​

A Double specifying Constraint Tolerance.

iTargetType​

An Int specifying Target Type.
If iTargetType=0: Ratio

If iTargetType=1: Value

dRatioOrValue​

A Double specifying Ratio or Value.

dCoefficient​

A Double specifying to set Coefficient.

crNodeSet​

A Cursor specifying Node Set.

crPropOrElemSet​

A Cursor specifying Element Set.

crSurfaceSet​

A Cursor specifying Surface Set.

iKSKernel​

A Int specifying type of KS Kernel.
If iKSKernel=0: Exponential

If iKSKernel=1: Monomial

dRHO​

A Double specifying RHO.

dExponent​

A Double specifying Exponent.

iEigenNumber;​

An Int specifying Eigen Number.

vecConstraintFunction​

A Vector specifying Constraint Function.

Defined by Optimization_ObjectiveConstraint_Parameter. 

vecNonDesignableArea​

A Vector specifying Non-Designable Area.

Defined by Optimization_NonDesignableArea_Parameter. Members are as follows:
enFunctionType​

An Integar specifying the function type..

This is a required input.

strFunctionName​

A String specifying the name of function.

This is a required input.

iOptimization = -1​

An Int specifying type of Optimization.

If iOptimization=0: Shape

If iOptimization=1: Topology

strDegreeOfFreedomNum​

A String specifying Degree of Freedom Number.

crNodeSet​

A Cursor specifying Node Set.

crPropOrElemSet​

A Cursor specifying Element Set.

vecShapeTopology​

A Vector specifying Shape/Topology.

Defined by Optimization_ShapeTopology_Parameter. Members are as follows:
enFunctionType = Unknown_Function;​

An Integar specifying the function type..

This is a required input.

strFunctionName​

A String specifying the name of function.

This is a required input.

dInitialDensity​

A Double specifying Initial Density.

dDensityRandom​

A Double specifying Density Random.

dAlpha​

A Double specifying Alpha.

dDraftAngle​

A Double specifying Draft Angle.

dGap​

A Double specifying Gap.

dDepth​

A Double specifying Depth.

dAngle​

A Double specifying Angle.

dClearance​

A Double specifying Clearance.

dThicknessDepth​

A Double specifying Thickness Depth.

dMaxThickness​

A Double specifying Max Thickness.

dMinThickness​

A Double specifying Min Thickness.

iMaxIteration​

An Int specifying Max Iteration.

dMaxStrain​

A Double specifying Max Strain.

dMaxTheta​

A Double specifying Max Theta.

dH1Tolerance​

A Double specifying H1 Tolerance.

iOutputLast​

An Int specifying selection of Output Last.

If iOutputLast=0: No

If iOutputLast=1: Yes

iOutputInterval​

An Int specifying Output Interval.

iResoutLast​

An Int specifying selection of Resout Last.

If iResoutLast=0: No

If iResoutLast=1: Yes

iResoutInterval​

An Int specifying Resout Interval.

iArmijoCheck​

An Int specifying selection of Armijo Check.

If iArmijoCheck=0: No

If iArmijoCheck=1: Yes

dArmijoParam​

A Double specifying Armijo Param.

strDirection​

A String specifying Direction.

iPunchingOneSide​

An Int specifying selection of Punching|Outside.

If iPunchingOneSide=0: Punching

If iPunchingOneSide=1: Oneside

iAutoIncrement​

An Int specifying selection of Auto Increment.

If iAutoIncrement=0: No

If iAutoIncrement=1: Yes

dStabilizationFactor​

A Double specifying Stabilization Factor.

dPoissonRatio​

A Double specifying Poisson Ratio.

iAutoFrozen​

An Int specifying selection of Auto Frozen.

If iAutoFrozen=0: No

If iAutoFrozen=1: Yes

iKeyCoordinate​

An Int specifying selection of Coodinate.

crNodeSet​

A Cursor to specifying Node Set.

crPropOrElemSet​

A Cursor to specifying Element Set.

crSurfaceSetNonInterferingArea​

A Cursor to specifying Non-Interfering Area.

crSurfaceSetOptimizedArea​

A Cursor to specifying Optimized Area.

iWolfeCheck​

An Int specifying selection of Wolfe Check.

If iWolfeCheck=0: No

If iWolfeCheck=1: Yes

dWolfeParam​

A Double specifying Wolfe Param.

iMatrix​

An Int specifying selection of Matrix.

If iMatrix=0: StiffnessLinear

If iMatrix=1: Stiffness

iElementDStiffness​

An Int specifying selection of Element D.Stiffness.

If iElementDStiffness=0: No

If iElementDStiffness=1: Yes

iConstraintMethod​

An Int specifying selection of Constraint Method.

If iConstraintMethod=0: No

If iConstraintMethod=1: Yes

dGrayScaleRatio​

A Double specifying gray scale ratio.

iOutputGrayScaleRatio​

An Int Specifing whether or not output gray scale ratio.

stOptimizationOutput​

A list of Boolean specifying the optimization output paramters. Output if it set True. 

bNodalShapeVariation = True/False

bShapeVariation = True/False

bNodalDensityRation = True/False

bDensityRation = True/False

bSensitivity = True/False

bSensitivityOf_Objective = _True/False

bSensitivityOf_Constraint = _True/False

bSensitivities = True/False

Return Code​

A Cursor specifying the created jobs.

Sample Code​

from os import environ

Geometry.Part.Cube(iPartColor=7929341)

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

Analysis.ADVC.MakeProcess.Static(strName="ADVC_DEFAULT_PROCESS",
                                 advcStructTimeStep=ADVC_STRUCT_TIME_STEP(dMaxDt=1.0, dMinDt=1e-05),
                                 dStabilizationFactor=DFLT_DBL,
                                 listLoadNode=[],
                                 listLoadCaseNode=[],
                                 listLoadNodeContact=[],
                                 listAdvcRefStressResult=[])

Analysis.ADVC.MakeProcess.Static(strName="ADVC_DEFAULT_PROCESS",
                                 advcStructTimeStep=ADVC_STRUCT_TIME_STEP(dMaxDt=1.0, dMinDt=1e-05),
                                 dStabilizationFactor=DFLT_DBL,
                                 crEdit=ADVCProcessStatic(1),
                                 listLoadNode=[],
                                 listLoadCaseNode=[],
                                 listLoadNodeContact=[],
                                 listAdvcRefStressResult=[])

Analysis.ADVC.MakeProcess.Static(strName="ADVC_DEFAULT_PROCESS",
                                 advcStructTimeStep=ADVC_STRUCT_TIME_STEP(dMaxDt=1.0, dMinDt=1e-05),
                                 dStabilizationFactor=DFLT_DBL,
                                 crEdit=ADVCProcessStatic(1),
                                 listLoadNode=[],
                                 listLoadCaseNode=[],
                                 listLoadNodeContact=[],
                                 listAdvcRefStressResult=[])

creating_status = Analysis.ADVC.Structure(strPath="D:/Job_1.adx",
                                          strName="Job_1",
                                          crlProcessSequence=[ADVCProcessStatic(1)],
                                          crlTargets=[Part(1)],
                                          bCheckBCDuplicate=True,
                                          crDummyPropMaterial=Material(1),
                                          iNumType=1,
                                          iUiPrecision=5)

JPT.Debugger(creating_status)
