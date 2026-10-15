# Analysis.AbaqusStep.CoupledTDStep()

Analysis.AbaqusStep.CoupledTDStep()

説明​

結合温度-変位解析のAbaqusステップを作成します。

構文​

Analysis.AbaqusStep.CoupledTDStep(...)

リボン: Analysis » AbaqusStep » CoupledTDStep

入力​

strName​

結合温度-変位解析のステップ名を指定する String です。

これは必須入力項目です。

strDesp​

結合温度-変位解析のステップの説明を指定する String です。

デフォルト値は "" です。

iEnableAutomatic​

増分法を指定する Integer です。

デフォルト値は 0 です。

iMaxInc​

インクリメント数の最大値を指定する Integer です。

デフォルト値は 100 です。

dInitSize​

初期インクリメントサイズを指定する Double です。

デフォルト値は 1.0 です。

dMinSize​

最小インクリメントサイズを指定する Double です。

デフォルト値は 1.0e-5 です。

dMaxSize​

最大インクリメントサイズを指定する Double です。

デフォルト値は 1.0 です。

abaqusPair1​

許容される温度変化の最大値を指定する ABAQUS_PAIR です。

デフォルト値は ABAQUS_PAIR です。

abaqusPair2​

クリープ／膨張／粘弾性歪みの許容誤差値を指定する ABAQUS_PAIR です。

デフォルト値は ABAQUS_PAIR です。

iCSVIntegration​

クリープ／膨張／粘弾性積分法を指定する Integer です。

デフォルト値は 0 です。

iMethod​

方程式ソルバーメソッドを指定する Integer です。

デフォルト値は 0 です。

iMatrixStorage​

方程式ソルバー行列の保存設定を指定する Integer です。

デフォルト値は 0 です。

iSolutionTech​

解法技術を指定する Integer です。

デフォルト値は 0 です。

iAllowedIters​

カーネル行列を再形成する前に許容される反復回数を指定する Integer です。

デフォルト値は 8 です。

dAdjustFactor​

任意の反復内の解の数に対する調整係数を指定する Double です。

デフォルト値は 1.0 です。

iMaxContactIter​

最大接触反復回数を指定する Integer です。

デフォルト値は 30 です。

iType​

自動静的安定化を指定する Integer です。

デフォルト値は 0 です。

iEnableUseAdaptive​

最大安定化比率までの適応安定化の使用の有無を指定する Integer です。

デフォルト値は 1 です。

dDampingFactor​

自動静的安定化のための減衰係数を指定する Double です。

デフォルト値は 0.0002 です。

dMaxRationofStrainEnergy​

自動静的安定化のための最大安定化比率を指定する Double です。

デフォルト値は 0.05 です。

iEnableNlgeom​

幾何学的非線形（大変形）解析の考慮の有無を指定する Integer です。

デフォルト値は 0 です。

dTimePeriod​

解析時間を指定する Double です。

デフォルト値は 1.0 です。

iTransient​

解析応答タイプを指定する Integer です。

デフォルト値は 1 です。

iConvertDscntIter​

深刻な不連続反復の変換を指定する Integer です。

デフォルト値は 0 です。

iRamp​

ステップごとの線形変化回数を指定する Integer です。

デフォルト値は 1 です。

iExtrapolateMethod​

各インクリメントの開始時点で前の状態を外挿するメソッドを指定する Integer です。

デフォルト値は 0 です。

iEnableIncludeCSV​

クリープ／膨張／粘弾性挙動の含有の有無を指定する Integer です。

デフォルト値は 0 です。

listAbaqusOutputRequest​

Abaqus出力要求のリストを指定する ABAQUS_OUTPUT_REQUEST のリストです。

デフォルト値は ABAQUS_OUTPUT_REQUEST です。

crEdit​

Abaqus結合温度-変位ステップの編集を指定する Cursor です。

デフォルト値は None です。

戻り値​

作成/修正されたAbaqus結合温度-変位ステップを指定する Cursor です。

サンプルコード​

from os import environ
import re

Geometry.Part.Cube(iPartColor=5619133)
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
                 iPropertyColor=12275404, 
                 crMaterial=Material(1), 
                 iCordM=-2, 
                 dDynaRemeshVal1=DFLT_DBL,
                 dDynaRemeshVal2=DFLT_DBL, 
                 dDispHG=DFLT_DBL, 
                 iFLG=-1)

creating_status = Analysis.AbaqusStep.CoupledTDStep(strName="Step1", 
                                                    strDesp="Test", 
                                                    abaqusPair1=ABAQUS_PAIR(dlTList=[0.0]), 
                                                    abaqusPair2=ABAQUS_PAIR(dlTList=[0.0]), 
                                                    iMatrixStorage=1, 
                                                    iType=2, 
                                                    iEnableNlgeom=1, 
                                                    iTransient=0, 
                                                    listAbaqusOutputRequest=[])

JPT.Debugger(creating_status)
