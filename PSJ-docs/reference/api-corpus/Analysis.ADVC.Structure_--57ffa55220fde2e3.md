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
