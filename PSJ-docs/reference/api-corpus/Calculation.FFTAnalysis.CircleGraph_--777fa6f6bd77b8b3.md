# Calculation.FFTAnalysis.CircleGraph()

Calculation.FFTAnalysis.CircleGraph()

説明​

円グラフを表示します。

構文​

Calculation.FFTAnalysis.CircleGraph(...)

マクロ: CmdFFTCircleGraph

リボン: Calculation » FFTAnalysis » CircleGraph

入力​

iNewLayer​

円グラフを作成するモードのレイヤーを指定する Integer です。

デフォルト値は1です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果のサンプルファイルへのパスを設定してください。
filePath="C:/Temp/Sample..."

# エクスポートされたCSVファイルへのパスを設定してください。
fileExport="C:/Temp/ExportFile.csv"

# 結果モデルの準備
Home.ImportResults.ADVC(filePath, iImportType=1, dFaceAngle=60, dEdgeAngle=60)

# FFT条件の設定
Calculation.FFTAnalysis.SetCondition(crlTargets=[Elem(...)], crl2DElems=[Elem(...)], crTopNode=RONode(7584), 
                                    crBottomNode=RONode(9717), dlCenterPoint=[207.65, -190.85, 191.06], 
                                    dBoreRadius=49.8668, dBoreHeight=170.105, dlAxisDefined=[0.0, 0.71, -0.71], 
                                    iDepthDirection=-1, iNumOfLayerPoint=20, 
                                    dlLayers=[0.0, 56.7015, 113.403, 170.105], dlAxisX=[0.14, 0.7, 0.7])

# XYプロット
Calculation.FFTAnalysis.XYPlot(bDefineOA=True, strPath=fileExport, bExportData=True, bExportAllPlot=True, b2DPlot=True)

# 円グラフ
graph = Calculation.FFTAnalysis.CircleGraph(iNewLayer=3)
JPT.Debugger(graph)
