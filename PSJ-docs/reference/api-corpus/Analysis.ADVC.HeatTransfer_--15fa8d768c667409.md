# Analysis.ADVC.HeatTransfer()

Analysis.ADVC.HeatTransfer()

Description​

Create and export the ADVC (*.adx) file for the Heat Transfer analysis.

Syntax​

Analysis.ADVC.HeatTransfer(...)

Ribbon: Analysis » ADVC » Heat Transfer

Inputs​

strName​

A String specifying the job name of ADVC analysis. This name would be the name of analysis job in Assembly Tree and the name of ADX file after exported.

This is a required input.

strDescription​

A String specifying the description for ADVC analysis job. The description would write in ADX file, where contents will be written below ModelInfo.

The default value is "".

crlProcessSequence​

A List of Cursor specifying the ADVC process sequences. This argument controls the Process solution type and its setting information depended on solution type.

The default value is [].

crlElemLocationGroup​

A List of Cursor specifying the element locations. The model contains Element group such as 3D Element, 2D Element, 1D Element to use this argument.

The default value is [].

crlNodeLocationGroup​

A List of Cursor specifying the node locations. The model contains Node group to use this argument.

The default value is [].

bWriteGroup​

A Boolean specifying whether to write group which output a selected group of Faces, Elements, Nodes as Surface Segment, Element Set and Node set respectively.
If bWriteGroup=True, the ADX file would contained group information such as Part, Face, Element(3D, 2D, 1D), Node,...

The default value is False.

crEdit​

A Cursor specifying the existing ADVC job in Assembly Tree. If this argument is not None, the specified ADVC job will be modified. Otherwise, a new job will be created.

The default value is None.

bResultReference​

A Boolean specifying whether to use the settings of Result Reference.
If bResultReference=True, the settings of Result Reference arguments will be valid to use.

The default value is False.

iSeparateFile​

An Integer specifying the method to separate file. This option allows to separate information into many exported ADX files by the specified type.
If iSeparateFile=0, this option would export only 1 ADX file contains all information of all bodies/parts in the model (ModelInfo, Unit, Geometry, LBCs, Process Sequence,...).

If iSeparateFile=1, this option would export 2 ADX files, which the first ADX file has same name as analysis Job will contain general information (such as ModelInfo, Unit, LBCs, Job name, Process Sequence, other settings of ADVC Structure analysis). When the last one ADX file which has suffix name "_model", contains Geometry information (such as Node, Part, Element,...).

If iSeparateFile=2, this option would export ADX files, which each body/part in model would be written individually Geometry information, Group in model would be written in another file, while other information would be written in the ADX file has same name as analysis Job.

If iSeparateFile=3, this option would export ADX file that write information of selected part/body. If selection does not have at least a specific body/part, Jupiter would write all bodies/part (same option as iSeparateFile=0).

If iSeparateFile=4, this option would export 1 ADX file contains LBCs information of the chosen LBCs.

The default value is 0.

bExportRelatedAllLBCs​

A Boolean specifying whether to export all related Load Boundary Condition. This argument is to be used when iSeparateFile=3.
If True, this option would export ADX file contains related information to LBCs such as Contact, Connection RBE, Bolt Pretension,...

The default value is False.

bUseEntityName​

A Boolean specifying whether to use entity name in exported file or not.
If True, this option would export ADX file that write Entity name to Geometry information such as Part, Face,...

If False, this option would export ADX file without writing Entities name to Geometry information.

The default value is False.

crlTargets​

A List of Cursor specifying the list of targets. The target could be Part or LBCs item.

The default value is [].

iLoadType​

An Integer specifying the load type used for analysis.
If iLoadType=0: Load Case, which is a group of specific Loads, BCs applies on the model. The model could apply many Load Cases which may have same setting of LBCs. Exporting ADX file would write all Load Cases.

If iLoadType=1: Load, which will export ADX file stores all Loads, BCs as a 1 Load case only.

The default value is 1.

bSameOutputOnAllProcess​

A Boolean specifying whether to use the same output request for all processes.
If True, set same output request (Displacement, Stress, Strain,...) for all defined processes.

If False, set output request which will base on user's desired result for each process.

The default value is True.

bDeleteFloatingNode​

A Boolean specifying whether to delete floating nodes or not.
If True, the exported ADX file would not write the floating nodes information.

If False, the exported ADX file would write the floating nodes information.

The default value is True.

bBC​

A Boolean specifying whether to separate boundary condition. This argument is to be used when iSeparateFile=3.
If True, the exported ADX file would write LBCs information.

The default value is True.

bCheckBCDuplicate​

A Boolean specifying whether to check if duplicate the boundary conditions.
If True, to check LBCs duplication when export ADX file.

The default value is False.

bAutoAssignDummyProp​

A Boolean specifying whether to automatically assign dummy property for dummy entities. This argument is to be used when the model has that unassigned property.
If True, the model would be exported with dummy property for the Part that does not have property. The others Part (which already assigned property) will export with its property setting.

If False, the model will export ADX file in case of the model has all property in all Parts, but if there is one Part that does not have property in the model, this option will not export file.

The default value is False.

crDummyPropMaterial​

A Cursor specifying the dummy property material for automatically assigning dummy property when export ADX file.

The default value is None.

bReferenceRestartData​

A Boolean specifying whether to use the Reference Restart Data.
If True, the settings of Reference Restart Data arguments will be valid to use.

If False, the settings of Reference Restart Data arguments will be ignored even though User has set value or not.

The default value is False.

strReferenceRestartDataPath​

A String specifying the path of Reference Restart Data.

The default value is "".

iNumberProcesses​

An Integer specifying the number of processes for Reference Restart Data.

The default value is DFLT_INT.

iNumberSteps​

An Integer specifying the number steps of Reference Restart Data.

The default value is DFLT_INT.

iCoordinateType​

An Integer specifying the coordinate type of Reference Restart Data.
If iCoordinateType=0: Initial type

If iCoordinateType=1: Deformation type

The default value is 0.

iUpdateContactSearch​

An Integer specifying whether to update contact search for Reference Restart Data.
If iUpdateContactSearch=0: No

If iUpdateContactSearch=1: Yes

The default value is 1.

listLoadNodeContact​

A List of LOAD_NODE_CONTACT specifying the list of load node contacts.

The default value is [].

iHeatConvection​

An Integer specifying the Heat Convection type. There are 2 types of Heat Convection:
If iHeatConvection=0: Direct

If iHeatConvection=1: Indirect

The default value is 1.

strPath​

A String specifying the exporting path for ADX file.

The default value is "".

iNumType​

An Integer specifying the numeric format type. This argument would allow numeric setting type of adx file.
If iNumType=0: Real Type - The numerical values in real number format (e.g 123.456).

If iNumType=1: Power Type - The numerical values in exponential/scientific format (e.g 1.234E-005).

The default value is 0.

iUiWidth​

An Integer specifying the limitation number of digits before the point of the number. This option allows to control number digits of value in exported ADX file.

The default value is 10.

iUiPrecision​

An Integer specifying the limitation number of digits after the point of the number. This option allows to control number digits of value in exported ADX file.

The default value is 1.

bExportGeometryID​

A Boolean specifying whether to write geometry ID number.

The default value is False.

bSeparatePartInfoFile​

A Boolean specifying whether to separate Part Information Files.

The default value is False.

strADVCTemplateFilePath​

A String specifying the path of ADVC Template File.

The default value is "".

bOutputDefinition​

A Boolean specifying to be enable/disable the option that sets the output request.

The default value is True.

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

Analysis.ADVC.MakeProcess.SteadyState(strName="Process_0")

creating_status = Analysis.ADVC.HeatTransfer(strPath="D:/Job_1.adx",
                                             strName="Job_1",
                                             crlProcessSequence=[ADVCProcessSSH(1)],
                                             crlTargets=[Part(1)],
                                             bAutoAssignDummyProp=True,
                                             crDummyPropMaterial=Material(1),
                                             listLoadNodeContact=[],
                                             iUiPrecision=6,
                                             bExportGeometryID=True)

JPT.Debugger(creating_status)
