# Analysis.TSSS.LinearStatic()

Analysis.TSSS.LinearStatic()

説明​

TechnoStar SunShine リニア静解析 (SOL 101) の入力デッキをエクスポートします。

構文​

Analysis.TSSS.LinearStatic(...)

マクロ: [TSSS_LinearStatic]

リボン: Analysis » SunShine » Linear Static(SOL 101)

入力​

strName​

TechnoStar SunShine ソルバーのジョブ名を指定する String です。この名前で設定された出力はアセンブリツリーに保存されます。

デフォルト値は "Job_1" です。

strDescription​

TechnoStar SunShine ソルバージョブの説明を指定する String です。

デフォルト値は "" です。

crlTargets​

ターゲットパートのリストを指定する Cursor リストです。

デフォルト値は [] (モデル内のすべてのパート) です。

nastranAnalysis​

TechnoStar Sunshine ソルバーの入力パラメータを指定する NASTRAN_ANALYSIS です。

デフォルト値は NASTRAN_ANALYSIS です。

crEdit​

作成された TechnoStar SunShine ソルバージョブを指定する Cursor です。このパラメータを使用すると、値は DynamisJob(ID) となります。ここで ID は作成されたソルバージョブのIDです。None の場合、新しい TechnoStar ソルバージョブが作成されます。

デフォルト値は None です。

strPath​

bdf ファイルのエクスポート先を指定する String です。

これは必須の入力です。

iModelCheckAnswer​

モデルチェックオプションを指定する Integer です。

デフォルト値は 0 です。

iDeleteSlaveNodesAnswer​

削除するスレーブ節点オプションを指定する Integer です。

デフォルト値は 0 です。

iInitTempType​

初期温度負荷タイプを指定する Integer です。

デフォルト値は 0 です。

bUSTARCalculation_b​

UStar 計算を有効にするかどうかを指定する Boolean です。

iMethod​

メソッドを指定する Integer です。

0 : デフォルト

1 : ORIGINAL

bDomainWithDSize_b​

ドメインに Dsize があるかどうかを指定する Boolean です。

iDSize​

Dsize の値を指定する Integer です。

bEPS_b​

EPS を有効にするかどうかを指定する Boolean です。

dEPS​

EPS 値を指定する Double です。

iGroupKey​

グループIDを指定する Integer です。

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

input_param = NASTRAN_ANALYSIS(iSolverType=6,
                               iGridFormatType=1,
                               dEpsilon=DFLT_DBL,
                               iMaxNumOfIter=DFLT_INT,
                               iNumberOfThreads=1,
                               iMemory=2,
                               iNcpu=1,
                               iSolNo=101,
                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeStrain=0),
                               nastranNonlinear=NASTRAN_NONLINEAR(iMAXITER=DFLT_INT,
                                                                  bUseEPSW=True,
                                                                  dEPSU=DFLT_DBL,
                                                                  dEPSP=DFLT_DBL))

export_status = Analysis.TSSS.LinearStatic(nastranAnalysis = input_param,
                                           strPath = re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                         "/TechnoStar/Test.bdf",
                                           iInitTempType=2)

JPT.Debugger(export_status)
