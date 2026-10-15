# Analysis.TSSS.ModalFrequencyResponse()

Analysis.TSSS.ModalFrequencyResponse()

説明​

TechnoStar SunShine Modal Frequency Response 解析（SOL 111）のための入力デッキをエクスポートします。

構文​

Analysis.TSSS.ModalFrequencyResponse(...)

リボン: Analysis » SunShine » Modal Frequency Response(SOL 111)

入力​

strName​

TechnoStar SunShineソルバーのジョブ名を指定する String 。この名前で設定された出力はアセンブリツリーに保存されます。

デフォルト値は "Job_1" です。

strDescription​

TechnoStar SunShineソルバージョブの説明を指定する String 。

デフォルト値は "" です。

crlTargets​

ターゲットパートのリストを指定する Cursor のリスト。

デフォルト値は []（モデル内のすべてのパート）です。

nastranAnalysis​

TechnoStar Sunshineソルバーの入力パラメータを指定する NASTRAN_ANALYSIS 型。

デフォルト値は NASTRAN_ANALYSIS です。

crEdit​

作成されたTechnoStar SunShineソルバージョブを指定する Cursor 型。このパラメータを使用すると、値はDynamisJob(ID)になります。ここで、ID は作成されたソルバージョブのIDです。None のままにすると、新しいTechnoStarソルバージョブが作成されます。

デフォルト値は None です。

strPath​

bdfファイルのエクスポート先を指定する String 。

これは必須の入力です。

iModelCheckAnswer​

モデルチェックオプションを指定する Integer 。

デフォルト値は 0 です。

iDeleteSlaveNodesAnswer​

スレーブ節点を削除するオプションを指定する Integer 。

デフォルト値は 0 です。

戻り値​

エクスポートされたジョブを指定する Cursor 型。

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

input_param = NASTRAN_ANALYSIS(iSolverType=6, 
                               iGridFormatType=1, 
                               dEpsilon=DFLT_DBL,
                               iMaxNumOfIter=DFLT_INT, 
                               iNumberOfThreads=1, 
                               iMemory=2, 
                               iNcpu=1, 
                               iSolNo=111,
                               nastranFreqTimestep=NASTRAN_FREQ_TIMESTEP(iDampingType=1),
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iValueAcceleration=DFLT_INT,
                                                                           iValueVelocity=DFLT_INT, 
                                                                           iTypeDisplacement=9, 
                                                                           iTypeStress=0, 
                                                                           iTypeStrain=0),
                               nastranNonlinear=NASTRAN_NONLINEAR(bUseEPSW=True))

export_status = Analysis.TSSS.ModalFrequencyResponse(nastranAnalysis = input_param, 
                                                     strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                               "/TechnoStar/Test.bdf")

JPT.Debugger(export_status)
