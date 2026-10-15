# Calculation.AcousticAnalysis.ACCombinedAnimation()

Calculation.AcousticAnalysis.ACCombinedAnimation()

概要​

物理量を選択して、変形、輪郭色、およびベクトルを個別にアニメーション表示します。

構文​

Calculation.AcousticAnalysis.ACCombinedAnimation(...)

マクロ: ACCombinedAnimation

リボン: Calculation » AcousticAnalysis » ACCombinedAnimation

入力​

iTimeStep​

時間ステップを指定する Integer 。

デフォルト値は 1 です。

iAnalysisType​

解析タイプを指定する Integer 。

デフォルト値は 1 です。

strName​

サブケース名を指定する String 。

デフォルト値は "FluidPressure" です。

bDeformation​

変形結果を使用するかどうかを指定する Boolean 型。

デフォルト値は True です。

bContour​

輪郭を表示するかどうかを指定する Boolean 型。

デフォルト値は True です。

bVector​

ベクトルを表示するかどうかを指定する Boolean 型。

デフォルト値は True です。

iContour​

輪郭オプションを指定する Integer 。

0: 流体圧力

1: 音響インテンシティ（法線）

デフォルト値は 0 です。

iVector​

ベクトルオプションを指定する Integer 。

0: 流体速度

1: 瞬時インテンシティ

デフォルト値は 0 です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# サンプル Nastran Vibro-Acoustic ファイルへのパスを設定してください。
filePath="C:/Temp/Sample.op2"

# 結果モデルを準備
Home.ImportResults.Nastran(strPath=filePath, dFaceAngle=60.16, dEdgeAngle=60.16, bIsVibro=True)

# AcousticAnalysis.ACCombinedAnimation
Calculation.AcousticAnalysis.ACCombinedAnimation(iTimeStep=2, iAnalysisType=4, strName="Subcase 201")
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=4, 
                iResultSet=201, 
                iTimeStep=2, 
                strResultName="Fluid Pressure", 
                strResultCompName="P", 
                iResultPos=1), 
                postDataOp=PostDataOp(
                iResultLocation=1, 
                iOptionCoord=1, 
                iOptionComplex=16))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=4, 
                    iResultSet=201, 
                    iTimeStep=2, 
                    strResultName="Fluid Pressure", 
                    strResultCompName="P"), 
                    postDataOption=PostDataOp(iOptionComplex=16))
