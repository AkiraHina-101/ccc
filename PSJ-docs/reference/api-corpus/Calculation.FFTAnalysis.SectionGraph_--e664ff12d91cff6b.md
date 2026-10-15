# Calculation.FFTAnalysis.SectionGraph()

Calculation.FFTAnalysis.SectionGraph()

説明​

セクショングラフを作成します。

構文​

Calculation.FFTAnalysis.SectionGraph(...)

マクロ: CmdFFTSectionGraph

リボン: Calculation » FFTAnalysis » SectionGraph

入力​

iPointIndex​

レイヤー上のポイントを指定する Integer 。

デフォルト値は1です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# 結果のサンプルファイルへのパスを設定してください。
filePath="C:/Temp/Sample..."

# CSVファイルへのエクスポートパスを設定してください。
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
Calculation.FFTAnalysis.CirclePlot(bOACircle=True, bDefineOA=True)

# セクショングラフ
graph = Calculation.FFTAnalysis.SectionGraph(iPointIndex=18)
JPT.Debugger(graph)
