# Analysis.TSSolver.NonlinearFrequency()

Analysis.TSSolver.NonlinearFrequency()

説明​

TechnoStar非線形周波数解析（SOL 126）の入力デッキをエクスポートします。

構文​

Analysis.TSSolver.NonlinearFrequency(...)

リボン: Analysis » TS-Solver » Nonlinear Frequency (SOL 126)

入力​

strName​

TechnoStarソルバーのジョブ名を指定する String 。この名前で設定された出力はアセンブリツリーに保存されます。

デフォルト値は「Job_1」です。

strDescription​

TechnoStarソルバージョブの説明を指定する String です。

デフォルト値は "" です。

crlTargets​

ターゲットパートのリストを指定する Cursor のリストです。

デフォルト値は [] （モデル内のすべてのパート） です。

nastranAnalysis​

TechnoStarソルバーの入力パラメータを指定する NASTRAN_ANALYSIS() です。

デフォルト値は NASTRAN_ANALYSIS() です。

crEdit​

作成された TechnoStar ソルバージョブを指定する Cursor です。このパラメータを使用すると、値は DynamisJob(ID) となります。ここで ID は作成されたソルバージョブのIDです。None のままにしておくと、新しい TechnoStar ソルバージョブが作成されます。

デフォルト値は None です。

strPath​

bdfファイルのエクスポート先を指定する String です。

この入力は必須です。

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
                               iSolNo=126,
                               nastranEigen126=NASTRAN_EIGEN126(dModalStartFreq=0.0, 
                                                                dModalEndFreq=100.0, 
                                                                iModalNoOfModes=3,
                                                                dMLDSStartFreq=0.0, 
                                                                dMLDSEndFreq=100.0, 
                                                                iMLDSNoOfModes=3),
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeDisplacement=50, 
                                                                           iTypeSpcforces=50,
                                                                           iTypeStress=50, 
                                                                           iTypeStrainenergy=50, 
                                                                           iTypeAcceleration=50),
                               nastranSettings=NASTRAN_SETTINGS(strK6ROT="100"),
                               nastranNonlinear=NASTRAN_NONLINEAR(iNINC=DFLT_INT, 
                                                                  bUseEPSU=True, 
                                                                  bUseEPSP=True, 
                                                                  bUseEPSW=True,
                                                                  dEPSU=0.001, 
                                                                  dEPSP=0.001, 
                                                                  dEPSW=0.001),
                               nastranSubcase=[NASTRAN_SUBCASE(iId=1, 
                                                               strTitle="Subcase1"),
                                               NASTRAN_SUBCASE(iId=2, 
                                                               strTitle="Subcase2")])

export_status = Analysis.TSSolver.NonlinearFrequency(nastranAnalysis = input_param, 
                                                     strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                               "/TechnoStar/Test.bdf")

JPT.Debugger(export_status)
