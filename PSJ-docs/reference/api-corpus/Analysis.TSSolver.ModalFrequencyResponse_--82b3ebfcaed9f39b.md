# Analysis.TSSolver.ModalFrequencyResponse()

Analysis.TSSolver.ModalFrequencyResponse()

説明​

TechnoStarモーダル周波数応答解析（SOL 111）の入力デッキをエクスポートします。

構文​

Analysis.TSSolver.ModalFrequencyResponse(...)

リボン: Analysis » TS-Solver » Modal Frequency Response(SOL 111)

入力​

strName​

TechnoStarソルバーのジョブ名を指定する String です。この名前で出力されたセットはアセンブリツリーに保存されます。

デフォルト値は "Job_1" です。

strDescription​

TechnoStarソルバージョブの説明を指定する String です。

デフォルト値は "" です。

crlTargets​

対象パートのリストを指定する Cursor のリストです。

デフォルト値は []（モデルの全てのパート）です。

nastranAnalysis​

TechnoStarソルバーの入力パラメータを指定する NASTRAN_ANALYSIS です。

デフォルト値は NASTRAN_ANALYSIS です。

crEdit​

作成されたTechnoStarソルバージョブを指定する Cursor です。このパラメータが使用されると、値はDynamisJob(ID)となります。ここで ID は作成されたソルバージョブのIDです。None の場合、新しいTechnoStarソルバージョブが作成されます。

デフォルト値は None です。

strPath​

bdfファイルの書き出し場所を指定する String です。

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
                               iSolNo=111,
                               nastranEigen=NASTRAN_EIGEN(dStartFreq=0.0, 
                                                          dEndFreq=100.0, 
                                                          iNoOfModes=3),
                               nastranFrequency=NASTRAN_FREQUENCY(dStartFrequency=0.0, 
                                                                  dIncrement=10.0, 
                                                                  iumOfInc=10),
                               nastranFreqTimestep=NASTRAN_FREQ_TIMESTEP(iDampingType=1),
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iValueAcceleration=DFLT_INT, 
                                                                           iValueVelocity=DFLT_INT,
                                                                           iTypeDisplacement=9, 
                                                                           iTypeStress=0, 
                                                                           iTypeStrain=0),
                               nastranNonlinear=NASTRAN_NONLINEAR(bUseEPSW=True))

export_status = Analysis.TSSolver.ModalFrequencyResponse(nastranAnalysis = input_param, 
                                                         strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                                   "/TechnoStar/Test.bdf")

JPT.Debugger(export_status)
