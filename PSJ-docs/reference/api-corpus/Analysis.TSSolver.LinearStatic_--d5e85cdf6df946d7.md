# Analysis.TSSolver.LinearStatic()

Analysis.TSSolver.LinearStatic()

説明​

テクノスター・ソルバーの線形静解析（SOL 101）のための入力デッキをエクスポートします。

構文​

Analysis.TSSolver.LinearStatic(...)

リボン: Analysis » TS-Solver » Linear Static(SOL 101)

入力​

strName​

テクノスター・ソルバーのジョブ名を指定する String の値です。この名前で設定された出力はアセンブリツリーに保存されます。

デフォルト値は "Job_1" です。

strDescription​

テクノスター・ソルバージョブの説明を指定する String の値です。

デフォルト値は "" です。

crlTargets​

ターゲットパートのリストを指定する Cursor のリストです。

デフォルト値は []（モデル内のすべてのパート）です。

nastranAnalysis​

テクノスター・ソルバーの入力パラメータを指定する NASTRAN_ANALYSIS 型の値です。

デフォルト値は NASTRAN_ANALYSIS です。

crEdit​

作成されたテクノスター・ソルバージョブを指定する Cursor です。このパラメータを使用すると、値は DynamisJob(ID) になります。ここで、ID は作成されたソルバージョブのIDです。None のままにしておくと、新しいテクノスター・ソルバージョブが作成されます。

デフォルト値は None です。

strPath​

bdf ファイルのエクスポート先を指定する String の値です。

これは必須の入力です。

戻り値​

エクスポートされたジョブを指定する Cursor です。

サンプルコード​

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
                               bUseCASI=True, 
                               dEpsilon=DFLT_DBL,
                               iMaxNumOfIter=DFLT_INT, 
                               iMemory=1024, 
                               iSolNo=101,
                               nastranFreqTimestep=NASTRAN_FREQ_TIMESTEP(iDampingType=2, 
                                                                         iModalDampingTableId=0),
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeStrain=0),
                               nastranNonlinear=NASTRAN_NONLINEAR(iKMETHOD=3, 
                                                                  iMAXITER=DFLT_INT, 
                                                                  bUseEPSW=True, 
                                                                  dEPSU=DFLT_DBL,
                                                                  dEPSP=DFLT_DBL))

export_status = Analysis.TSSolver.LinearStatic(nastranAnalysis = input_param, 
                                               strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                         "/TechnoStar/Test.bdf")

JPT.Debugger(export_status)
