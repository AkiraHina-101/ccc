# BoundaryConditions.InitialTemperature.ADVC()

BoundaryConditions.InitialTemperature.ADVC()

説明​

ADVENTUREClusterソルバーの形式から温度結果出力を読み取り、初期温度として定義します。

構文​

BoundaryConditions.InitialTemperature.ADVC(...)

Ribbon: Boundary Conditions » Initial Temperature » ADVC file

入力​

strName​

初期温度名を指定する String 。

デフォルト値は "InitialTemperature1" です。

strFilePathName​

ADVC温度結果ファイルのパスを指定する String 。

これは必須の入力です。

bUseDefault​

デフォルトの温度を有効または無効にするかを指定する Boolean 型。

デフォルト値は False です。

crlTargets​

初期温度の対象パートのリストを指定する Cursor のリスト型。

これは必須の入力です。

crEdit​

既存の初期温度を指定する Cursor 型。

このパラメータを使用すると、指定した初期温度が変更されます。

パラメータが None の場合は、新しい初期温度が作成されます。

デフォルト値は None です。

戻り値​

作成されたLBCを指定する Cursor 型。

サンプルコード​

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
