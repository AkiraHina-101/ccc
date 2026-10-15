# Analysis.TSSolver.SteadyStateHeatTransfer()

Analysis.TSSolver.SteadyStateHeatTransfer()

説明​

TechnoStar Steady State Heat Transfer解析（SOL 153）のためのInput Deckをエクスポートします。

構文​

Analysis.TSSolver.SteadyStateHeatTransfer(...)

リボン: Analysis » TS-Solver » Steady State Heat Transfer(SOL 153)

入力​

strName​

TechnoStarソルバーのジョブ名を指定する String です。この名前で設定された出力はアセンブリツリーに保存されます。

デフォルト値は "Job_1" です。

strDescription​

TechnoStarソルバージョブの説明を指定する String です。

デフォルト値は "" です。

crlTargets​

対象パートのリストを指定する Cursor リストです。

デフォルト値は [] です（モデル内のすべてのパート）。

nastranAnalysis​

TechnoStarソルバーの入力パラメータを指定する NASTRAN_ANALYSIS です。

デフォルト値は NASTRAN_ANALYSIS です。

crEdit​

作成されたTechnoStarソルバージョブを指定する Cursor です。このパラメータを使用すると、値はDynamisJob(ID)になります。ここで、ID は作成されたソルバージョブのIDです。また、None の場合は新しいTechnoStarソルバージョブが作成されます。

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

BoundaryConditions.BoundaryTemperature.Constant(dFTemp=373.15, 
                                                crlTargets=[Face(24)])
BoundaryConditions.HeatFlux.SurfaceFlux(strName="SurfaceHeatFlux1", 
                                        dFflux=150000.0,
                                        iDistributionMethod=1, 
                                        crTable=None, 
                                        crlTargets=[Face(23)])

input_param = NASTRAN_ANALYSIS(iSolverType=3, 
                               iGridFormatType=1, 
                               bUseCASI=True, 
                               dEpsilon=1e-13,
                               iMaxNumOfIter=500, 
                               iMemory=1024, 
                               iSolNo=153,
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeThermal=1, 
                                                                           iTypeFlux=6))

export_status = Analysis.TSSolver.SteadyStateHeatTransfer(nastranAnalysis = input_param, 
                                                          strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                                    "/TechnoStar/Test.bdf")

JPT.Debugger(export_status)
