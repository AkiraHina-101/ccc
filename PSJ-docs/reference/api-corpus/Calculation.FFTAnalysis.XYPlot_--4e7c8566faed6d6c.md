# Calculation.FFTAnalysis.XYPlot()

Calculation.FFTAnalysis.XYPlot()

説明​

円状XYプロットグラフを表示して、指定されたファイルにエクスポートします。

構文​

Calculation.FFTAnalysis.XYPlot(...)

マクロ: CmdFFTXYPlot

リボン: Calculation » FFTAnalysis » XYPlot

入力​

iFFTCondition​

指定されたFFT条件のIDを指定する Integer です。

デフォルト値は1です。

bDefineOA​

OA結果を表示するかどうかを指定する Boolean です。

デフォルト値は False です。

strDefineOA​

OA結果のグラフを表示するモードを指定する String です。

デフォルト値は「2-4」です。

strDefineMode​

円状XYプロットグラフを表示するモードを指定する String です。

デフォルト値は「2, 3, 4」です。

b3DPlot​

円状プロットグラフを3D空間で表示するかどうかを指定する Boolean です。

デフォルト値は False です。

bExportData​

FFT解析結果をファイルに保存するかどうかを指定する Boolean です。

デフォルト値は False です。

strPath​

FFT解析結果を保存するCSVファイルのパスを指定する String です。

デフォルト値は "" です。

bOriginalShift​

振幅データを出力する際にすべての層の値をシフトするかどうかを指定する Boolean 型です（0次モードは除く）。

デフォルト値は False です。

bExportAllPlot​

すべての結果の円状XYプロットおよび変形プロットをCSVファイルに保存するかどうかを指定する Boolean です。

デフォルト値は False です。

b2DPlot​

円状プロットグラフを3D空間で表示するかどうかを指定する Boolean です。

デフォルト値は False です。

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

# XYプロットして結果をファイルにエクスポート 
XYPlot = Calculation.FFTAnalysis.XYPlot(bDefineOA=True, strPath=fileExport, bExportData=True, 
                                        bExportAllPlot=True, b2DPlot=True)
JPT.Debugger(XYPlot)
