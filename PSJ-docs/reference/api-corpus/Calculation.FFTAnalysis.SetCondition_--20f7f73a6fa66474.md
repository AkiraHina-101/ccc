# Calculation.FFTAnalysis.SetCondition()

Calculation.FFTAnalysis.SetCondition()

説明​

FFT解析を実行します。

構文​

Calculation.FFTAnalysis.SetCondition(...)

マクロ: PostFFTConditionOut

リボン: Calculation » FFTAnalysis » SetCondition

入力​

strName​

砲身シリンダーの名前を指定する String です。

デフォルト値は "BORE_1" です。

crlTargets​

FFT解析を実行する対象パートを指定する Cursor リストです。

デフォルト値は [] です。

crl2DElems​

選択した2D要素を指定する Cursor リストです。

デフォルト値は [] です。

dAngle​

抽出する目標シリンダー表面の角度を指定する Double です。

デフォルト値は 20.0 です。

crTopNode​

砲身シリンダー表面の上端を決定する節点を指定する Cursor です。

デフォルト値は None です。

crBottomNode​

砲身シリンダー表面の下端(砲身の高さも定義するため)を決定する節点を指定する Cursor です。

デフォルト値は None です。

dlCenterPoint​

砲の座標系の中心座標を指定する Double のリストです。

デフォルト値は [0.0,0.0,0.0] です。

dBoreRadius​

砲身シリンダーの半径を指定する Double です。

デフォルト値は 0.0 です。

dBoreHeight​

砲身シリンダーの高さを指定する Double です。

デフォルト値は 0.0 です。

iAxisDirection​

グローバル座標系 X、Y、Zまたは任意の方向(ユーザー定義)で砲身シリンダーの軸方向を指定する Integer です。

デフォルト値は 3 です。

dlAxisDefined​

定義された砲身シリンダーの軸方向を指定する Double のリストです。

デフォルト値は [0.0,0.0,0.0] です。

iDepthDirection​

深度方向を指定する Integer です。

デフォルト値は 0 です。

iNumOfLayerPoint​

1層あたりの計算点の数を指定する Integer です。

デフォルト値は 36 です。

dlLayers​

各層の数と各層での深さ値を指定する Double のリストです。

デフォルト値は [] です。

iCalculationMethod​

計算方法を指定する Integer です。

0: ベストフィット円

1: ベストフィットシリンダー

デフォルト値は 0 です。

dlAxisX​

砲身シリンダーの X軸方向を指定する Double のリストです。

デフォルト値は [0.0,0.0,0.0] です。

crEdit​

既存のFFT条件を指定する Cursor です。

このパラメータが使用された場合、指定されたFFT条件が変更されます。

使用されない場合は、新しいFFT条件が作成されます。

デフォルト値は None です。

戻り値​

作成されたFFT条件を指定する Cursor です。

サンプルコード​

# サンプルファイルへのパスを設定してください。
filePath="C:/Temp/Sample..."

# 結果モデルを準備
Home.ImportResults.ADVC(filePath, iImportType=1, dFaceAngle=60, dEdgeAngle=60)

# FFT条件を設定
Calculation.FFTAnalysis.SetCondition(crlTargets=[Elem(...)], crl2DElems=[Elem(...)], crTopNode=RONode(7584), 
                                    crBottomNode=RONode(9717), dlCenterPoint=[207.65, -190.85, 191.06], 
                                    dBoreRadius=49.8668, dBoreHeight=170.105, dlAxisDefined=[0.0, 0.71, -0.71], 
                                    iDepthDirection=-1, iNumOfLayerPoint=20, 
                                    dlLayers=[0.0, 56.7015, 113.403, 170.105], dlAxisX=[0.14, 0.7, 0.7])
JPT.Debugger(FFTCondition)
