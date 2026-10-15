# Analysis.TSSolver.LinearBucking()

Analysis.TSSolver.LinearBucking()

説明​

テクノスターソルバーリニアバックリング解析（SOL 105）の入力デッキをエクスポートします。

構文​

Analysis.TSSolver.LinearBucking(...)

リボン: Analysis » TS-Solver » Linear Buckling(SOL 105)

入力​

strName​

テクノスターソルバーのジョブ名を指定する String です。この名前で出力がアセンブリツリーに保存されます。

デフォルト値は "Job_1" です。

strDescription​

テクノスターソルバージョブの説明を指定する String です。

デフォルト値は "" です。

crlTargets​

ターゲットパートのリストを指定する Cursor リストです。

デフォルト値は []（モデル内のすべてのパート）です。

nastranAnalysis​

テクノスターソルバー入力パラメータを指定する NASTRAN_ANALYSIS です。

デフォルト値は NASTRAN_ANALYSIS です。

crEdit​

作成したテクノスターソルバージョブを指定する Cursor です。このパラメータを使用すると、値は DynamisJob(ID) となります。ここで、ID は作成されたソルバージョブのIDです。None のままにしておくと、新しいテクノスターソルバージョブが作成されます。

デフォルト値は None です。

strPath​

bdfファイルのエクスポート先を指定する String です。

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
                               dEpsilon=DFLT_DBL,
                               iMaxNumOfIter=DFLT_INT, 
                               iMemory=1024, 
                               iSolNo=105,
                               nastranEigen=NASTRAN_EIGEN(dStartFreq=0.0, 
                                                          dEndFreq=100.0, 
                                                          iNoOfModes=3),
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeStress=0, 
                                                                           iTypeStrain=0),
                               nastranNonlinear=NASTRAN_NONLINEAR(bUseEPSW=True))

export_status = Analysis.TSSolver.LinearBucking(nastranAnalysis = input_param, 
                                                strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                          "/TechnoStar/Test.bdf")

JPT.Debugger(export_status)
