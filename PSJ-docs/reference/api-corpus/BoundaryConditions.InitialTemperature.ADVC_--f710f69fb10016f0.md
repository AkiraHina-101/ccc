# BoundaryConditions.InitialTemperature.ADVC()

BoundaryConditions.InitialTemperature.ADVC()

Description​

Read the temperature result output from format of Adventure Cluster solver and defines it as the initial temperature.

Syntax​

BoundaryConditions.InitialTemperature.ADVC(...)

Ribbon: Boundary Conditions » Initial Temperature » ADVC file

Inputs​

strName​

A String specifying the initial temperature name.

The default value is "InitialTemperature1".

strFilePathName​

A String specifying the ADVC temperature result file path.

This is a required input.

bUseDefault​

A Boolean specifying whether enable or disable the default temperature.

The default value is False.

crlTargets​

A List of Cursor specifying list of target part for initial temperature.

This is a required input.

crEdit​

A Cursor specifying an existing initial temperature.

If this parameter is used, the specified initial temperature will be modified.

If it is left None, a new initial temperature will be created.

The default value is None.

Return Code​

A Cursor specifying the created LBC.

Sample Code​

import os

temp_folder = os.environ["Temp"] + "/TechnoStar"

if os.path.isdir(temp_folder):
    pass
else:
    os.mkdir(temp_folder)

Geometry.Part.Cube(iPartColor=6473570)
BoundaryConditions.BoundaryTemperature.Constant(dFTemp=293.15, 
                                                crlTargets=[Part(1)])
Properties.Material.Add("Structural_Steel", 
                        [Density([(DENSITY, 
                                   7.85e-09)]), 
                        Elastic([(YOUNGS_MODULUS, 
                                  200000.0), 
                                 (POISSONS_RATIO, 
                                  0.3)])])
Properties.Shell(crlTargets=[Part(1)], 
                 strName="Shell Property 1", 
                 iPropertyColor=16131973, 
                 crMatMembrane=Material(1), 
                 crMatBend=Material(1), 
                 crMatShear=Material(1), 
                 dMatOrient1=DFLT_DBL, 
                 dThickness=0.001, 
                 dBendStiff=DFLT_DBL, 
                 dThickRatio=DFLT_DBL, 
                 dNSM=DFLT_DBL, 
                 dFiberDist1=DFLT_DBL, 
                 dFiberDist2=DFLT_DBL, 
                 dPlateOff=DFLT_DBL, 
                 iItgPts=DFLT_INT)
Analysis.ADVC.MakeProcess.SteadyState(strName="ADVC_DEFAULT_PROCESS", 
                                      advcHeatTimeStep=ADVC_HEAT_TIME_STEP(dMaxdt=1.0, 
                                                                           dMindt=1e-05))
Analysis.ADVC.MakeProcess.SteadyState(strName="ADVC_DEFAULT_PROCESS", 
                                      advcHeatTimeStep=ADVC_HEAT_TIME_STEP(dMaxdt=1.0, 
                                                                           dMindt=1e-05), 
                                      crEdit=ADVCProcessSSH(1), 
                                      listLoadNode=[ADVC_LOAD_NODE(cr=LbcTempBoundary(1))])
Analysis.ADVC.MakeProcess.SteadyState(strName="ADVC_DEFAULT_PROCESS", 
                                      advcHeatTimeStep=ADVC_HEAT_TIME_STEP(dMaxdt=1.0, 
                                                                           dMindt=1e-05), 
                                      crEdit=ADVCProcessSSH(1))
Analysis.ADVC.HeatTransfer(strPath=temp_folder + "/test.adx", 
                           strName="Job_1", 
                           crlProcessSequence=[ADVCProcessSSH(1)], 
                           crlTargets=[Part(1)], 
                           bAutoAssignDummyProp=True, 
                           crDummyPropMaterial=Material(1), 
                           listLoadNodeContact=[], 
                           iUiPrecision=6, 
                           bExportGeometryID=True)

JPT.Exec('New Document()')

Geometry.Part.Cube()

created_bcs = BoundaryConditions.InitialTemperature.ADVC(strFilePathName = temp_folder \
                                                                           + "/test.adx", 
                                                         crlTargets=[Part(1)])

JPT.Debugger(created_bcs)
