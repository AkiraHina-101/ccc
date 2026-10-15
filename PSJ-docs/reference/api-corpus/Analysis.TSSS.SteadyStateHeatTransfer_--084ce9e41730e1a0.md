# Analysis.TSSS.SteadyStateHeatTransfer()

Analysis.TSSS.SteadyStateHeatTransfer()

説明​

TechnoStar SunShine Steady State Heat Transfer 解析（SOL 153）のための入力デッキをエクスポートします。

構文​

Analysis.TSSS.SteadyStateHeatTransfer(...)

リボン: Analysis » SunShine » Steady State Heat Transfer(SOL 153)

入力​

strName​

TechnoStar SunShine ソルバーのジョブ名を指定する String です。この名前によって設定した出力は組み立てツリーに保存されます。

デフォルト値は "Job_1" です。

strDescription​

TechnoStar SunShine ソルバージョブの説明を指定する String です。

デフォルト値は "" です。

crlTargets​

ターゲットパートのリストを指定する Cursor リストです。

デフォルト値は []（モデル内のすべてのパート）です。

nastranAnalysis​

TechnoStar Sunshine ソルバーの入力パラメータを指定する NASTRAN_ANALYSIS です。

デフォルト値は NASTRAN_ANALYSIS です。

crEdit​

作成された TechnoStar SunShine ソルバージョブを指定する Cursor です。このパラメータを使用すると、値は DynamisJob(ID) となります。ここで、ID は作成されたソルバージョブのIDです。None のままにすると、新しい TechnoStar ソルバージョブが作成されます。

デフォルト値は None です。

strPath​

bdf ファイルのエクスポート先を指定する String です。

これは必須の入力です。

iModelCheckAnswer​

モデルチェックオプションを指定する Integer です。

デフォルト値は 0 です。

iDeleteSlaveNodesAnswer​

削除するスレーブ節点のオプションを指定する Integer です。

デフォルト値は 0 です。

戻り値コード​

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

BoundaryConditions.BoundaryTemperature.Constant(dFTemp=373.15, 
                                                crlTargets=[Face(24)])
BoundaryConditions.HeatFlux.SurfaceFlux(strName="SurfaceHeatFlux1", 
                                        dFflux=150000.0,
                                        iDistributionMethod=1, 
                                        crTable=None, 
                                        crlTargets=[Face(23)])

input_param = NASTRAN_ANALYSIS(iSolverType=6, 
                               iGridFormatType=1, 
                               dEpsilon=1e-13,
                               iMaxNumOfIter=500, 
                               iNumberOfThreads=1, 
                               iMemory=2, 
                               iNcpu=1, 
                               iSolNo=153,
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeThermal=1, 
                                                                           iTypeFlux=6),
                               nastranNonlinear=NASTRAN_NONLINEAR(iMAXITER=DFLT_INT, 
                                                                  bUseEPSP=True, 
                                                                  bUseEPSW=True,
                                                                  dEPSU=DFLT_DBL, 
                                                                  dEPSP=0.001, 
                                                                  dEPSW=1e-06))

export_status = Analysis.TSSS.SteadyStateHeatTransfer(nastranAnalysis = input_param, 
                                                      strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                                "/TechnoStar/Test.bdf")

JPT.Debugger(export_status)
