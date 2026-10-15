# Analysis.ADVC.MakeProcess.Static()

Analysis.ADVC.MakeProcess.Static()

説明​

ADVC解析のためのADVC Structure Staticプロセスを作成します。このプロセスは一度に作成することも、複数回作成することもできます。

構文​

Analysis.ADVC.MakeProcess.Static(...)

マクロ： AdvcStaticProcess

リボン： Analysis » ADVC » Make Process » Static

入力​

strName​

ADVC - Staticプロセスのプロセス名を指定する _String_です。

これは必須の入力です。

iGeomNonlinear​

ジオメトリ非線形オプションを指定する _Integer_です：

もし iGeomNonlinear=0 の場合：なし

もし iGeomNonlinear=1 の場合：トータルラグランジュ - トータルラグランジュ法に起因する幾何学的非線形性を考慮します

もし iGeomNonlinear=2 の場合：アップデートラグランジュ - アップデートラグランジュ法に起因する幾何学的非線形性を考慮します

もし iGeomNonlinear=3 の場合：線形

もし iGeomNonlinear=4 の場合：非線形

デフォルト値は0です。

advcStructTimeStep​

構造静的パラメータ（時間ステップ、出力タイミング定義など）の設定を指定する _ADVC_STRUCT_TIME_STEP_です。

デフォルト値は ADVC_STRUCT_TIME_STEP です。

bConvergence​

収束パラメータ設定オプションを有効/無効にするかを指定する Boolean です。

もし True の場合：収束パラメータを修正するための設定オプションを有効にします

もし False の場合：収束パラメータを修正するための設定オプションを無効にします

デフォルト値は False です。

advcConvergence​

収束パラメータの設定を指定する _ADVC_CONVERGENCE_です。

デフォルト値は ADVC_CONVERGENCE です。

bContact​

接触イテレータパラメータ設定オプションを修正するかどうかを指定する Boolean です。

もし True の場合：接触イテレータパラメータを修正するための設定オプションを有効にします

もし False の場合：接触イテレータパラメータを修正するための設定オプションを無効にします

デフォルト値は False です。

advcContactIter​

接触イテレータパラメータの設定を指定する _ADVC_CONTACT_ITER_です。

デフォルト値は ADVC_CONTACT_ITER です。

bAutoIncrement​

オートインクリメントパラメータ設定オプションを修正するかどうかを指定する Boolean です。

もし True の場合：オートインクリメントパラメータを修正するための設定オプションを有効にします

もし False の場合：オートインクリメントパラメータを修正するための設定オプションを無効にします

デフォルト値は False です。

advcAutoIncrement​

オートインクリメントパラメータの設定を指定する _ADVC_AUTO_INCREMENT_です。

デフォルト値は ADVC_AUTO_INCREMENT です。

dStabilizationFactor​

安定化係数を指定する Double です。

デフォルト値は 0.0 です。

crEdit​

編集用途でのみ使用する Cursor で、アセンブリツリー内のADVC Staticプロセスを指定します。

デフォルト値は None です。

listLoadNode​

モデルに割り当てられた節点のリストを指定する List of ADVC_LOAD_NODE です。

デフォルト値は [] です。

listLoadCaseNode​

モデルに割り当てられたロードケースの節点のリストを指定する List of ADVC_LOAD_NODE です。

デフォルト値は [] です。

listLoadNodeContact​

モデルに割り当てられた接触の節点のリストを指定する List of ADVC_LOAD_NODE です。

デフォルト値は [] です。

ilOutputParamList​

変位、応力、ひずみなどの結果タイプの出力要求リストを指定する Integer のリスト です。

デフォルト値は [] です。

iRefType​

結果リファレンスのタイプを指定する Integer です。

もし iRefType=0 の場合：温度荷重

もし iRefType=1 の場合：応力

デフォルト値は 0 です。

strRefPath​

リファレンス結果のパスを指定する String です。

デフォルト値は "" です。

listAdvcRefStressResult​

リファレンス結果のデータのリストを表す List of ADVC_REF_STRESS_RESULT です。

デフォルト値は [] です。

戻り値​

作成または編集されたADVC Staticプロセスを指定する Cursor です。

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

creating_status = Analysis.ADVC.MakeProcess.Static(strName="Process_0", 
                                                   advcStructTimeStep=ADVC_STRUCT_TIME_STEP(iNumOfInc=10), 
                                                   dStabilizationFactor=DFLT_DBL, 
                                                   listLoadNode=[], 
                                                   listLoadCaseNode=[], 
                                                   listLoadNodeContact=[], 
                                                   listAdvcRefStressResult=[])

JPT.Debugger(creating_status)

Analysis.ADVC.Structure(strPath=environ["Temp"] + \
                                "/TechnoStar/Test.adx", 
                        strName="Job_1", 
                        crlProcessSequence=[ADVCProcessStatic(1)], 
                        crlTargets=[Part(1)], 
                        bAutoAssignDummyProp=True, 
                        listLoadNodeContact=[], 
                        iUiPrecision=6, 
                        bExportGeometryID=True)
