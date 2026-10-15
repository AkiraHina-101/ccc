# Calculation.FFTAnalysis.CirclePlot()

Calculation.FFTAnalysis.CirclePlot()

説明​

変形プロットグラフを表示します。

構文​

Calculation.FFTAnalysis.CirclePlot(...)

マクロ: CmdFFTCirclePlot

リボン: Calculation » FFTAnalysis » CirclePlot

入力​

iFFTCondition​

指定されたFFT条件のIDを指定する Integer です。

デフォルト値は1です。

bOACircle​

OA Circle オプションを使用するかどうかを指定する Boolean です。

デフォルト値は False です。

strOACircle​

OA結果の変形プロットグラフを表示する層の数を指定する String です。

デフォルト値は "2" です。

bDefineOA​

Define OA Circle オプションを使用するかどうかを指定する Boolean です。

デフォルト値は False です。

strDefineOA​

OA曲線に使用されるモードを指定する String です。

デフォルト値は "2-4" です。

strDefineMode​

変形プロットがグラフィカルに表示されるモードを指定する String です。

デフォルト値は "2" です。

strModeLayer​

各モードでグラフィカルに表示される層を指定する String です。

デフォルト値は "2" です。

戻り値​

処理が正常に実行されたかどうかを指定する Boolean 型です:

True: 処理が正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果サンプルファイルへのパスを設定してください。
filePath="C:/Temp/Sample..."

# エクスポートされたCSVファイルへのパスを設定してください。
fileExport="C:/Temp/ExportFile.csv"

# 結果モデルを準備
Home.ImportResults.ADVC(filePath, iImportType=1, dFaceAngle=60, dEdgeAngle=60)

# FFT条件を設定
Calculation.FFTAnalysis.SetCondition(crlTargets=[Elem(...)], crl2DElems=[Elem(...)], crTopNode=RONode(7584), 
                                    crBottomNode=RONode(9717), dlCenterPoint=[207.65, -190.85, 191.06], 
                                    dBoreRadius=49.8668, dBoreHeight=170.105, dlAxisDefined=[0.0, 0.71, -0.71], 
                                    iDepthDirection=-1, iNumOfLayerPoint=20, 
                                    dlLayers=[0.0, 56.7015, 113.403, 170.105], dlAxisX=[0.14, 0.7, 0.7])

# 円プロット
circlePlot = Calculation.FFTAnalysis.CirclePlot(bOACircle=True, bDefineOA=True)
JPT.Debugger(circlePlot)
