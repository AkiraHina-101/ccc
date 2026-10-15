# Analysis.AbaqusStep.DynamicStep()

Analysis.AbaqusStep.DynamicStep()

説明​

Dynamic analysisのための Abaqus ステップを作成します。

構文​

Analysis.AbaqusStep.DyanmicStep(...)

リボン: Analysis » AbaqusStep » DynamicStep

入力​

strName​

Dynamicステップ名を指定する String です。

この入力は必須です。

strDesp​

Dynamicステップの説明を指定する String です。

デフォルト値は "" です。

iAutomatic​

増分方法を指定する Integer です。

デフォルト値は 0 です。

iMaxInc​

最大増分数を指定する Integer です。

デフォルト値は 100 です。

dInitSize​

初期増分サイズを指定する Double です。

デフォルト値は 1.0 です。

dMinSize​

最小増分サイズを指定する Double です。

デフォルト値は 1.0e-5 です。

dMaxSize​

最大増分サイズを指定する Double です。

デフォルト値は 1.0 です。

iSuppressHalfResCal​

ハーフ増分残差許容の計算を抑制するかどうかを指定する Integer です。

デフォルト値は 0 です。

dHalfStepResTol​

ハーフ増分残差許容値を指定する Double です。

デフォルト値は DFLT_DBL です。

iMethod​

方程式ソルバーメソッドを指定する Integer です。

デフォルト値は 0 です。

iMatrixStorage​

方程式ソルバーマトリックスストレージ設定を指定する Integer です。

デフォルト値は 0 です。

iSolutionTech​

ソリューションテクニックを指定する Integer です。

デフォルト値は 0 です。

iAllowedIters​

カーネル行列が再形成される前に許可されるイテレーション数を指定する Integer です。

デフォルト値は 8 です。

dAdjustFactor​

各イテレーションでの解の調整係数を指定する Double です。

デフォルト値は 1.0 です。

iMaxContactIter​

最大接触イテレーション数を指定する Integer です。

デフォルト値は 30 です。

dDampingControl​

数値減衰制御パラメータを指定する Double です。

デフォルト値は -0.05 です。

iByPassCalInitAcceleration​

ステップの最初に初期加速度の計算をバイパスするかどうかを指定する Integer です。

デフォルト値は 1 です。

iNlGeom​

幾何学的非線形（大変形）解析を考慮するかどうかを指定する Integer です。

デフォルト値は 0 です。

dTimePeriod​

解析時間を指定する Double です。

デフォルト値は 1.0 です。

iIncldHeatEffect​

断熱加熱効果を考慮するかどうかを指定する Integer です。

デフォルト値は 1 です。

iConvertDscntIter​

重大な不連続性イテレーションの変換を指定する Integer です。

デフォルト値は 0 です。

iRamp​

ステップごとの線形変化数を指定する Integer です。

デフォルト値は 1 です。

iExtrapolateMethod​

各増分開始時の前の状態を推定する方法を指定する Integer です。

デフォルト値は 0 です。

iAcceptByMaxIters​

最大イテレーション数に達した後にソリューションを受け入れるかどうかを指定する Integer です。

デフォルト値は 0 です。

listAbaqusOutputRequest​

Abaqus 出力要求のリストを指定する ABAQUS_OUTPUT_REQUEST のリストです。

デフォルト値は ABAQUS_OUTPUT_REQUEST です。

crEdit​

既存の Abaqus ステップを指定する Cursor です。

このパラメータを使用すると、指定されたステップが変更されます。

None の場合、新しいステップが作成されます。

デフォルト値は None です。

戻り値​

作成/変更された Abaqus Dynamic ステップを指定する Cursor です。

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

creating_status = Analysis.AbaqusStep.DynamicStep("Step1", 
                                                  iAutomatic=1, 
                                                  listOutput=[])

JPT.Debugger(creating_status)
