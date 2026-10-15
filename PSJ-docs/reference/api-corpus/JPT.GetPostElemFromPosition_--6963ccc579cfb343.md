# JPT.GetPostElemFromPosition()

JPT.GetPostElemFromPosition()

説明​

特定の位置からポスト要素を取得します。

構文​

JPT.GetPostElemFromPosition(xCoordValue,
                            yCoordValue,
                            zCoordValue,
                            dTolerance,
                            bVisible)

入力​

xCoordValue​

カーテシャン座標系でのX座標の値をミリメートル[mm]単位で指定する Double 型の値です。

この入力は必須です。

yCoordValue​

カーテシャン座標系でのY座標の値をミリメートル[mm]単位で指定する Double 型の値です。

この入力は必須です。

zCoordValue​

カーテシャン座標系でのZ座標の値をミリメートル[mm]単位で指定する Double 型の値です。

この入力は必須です。

dTolerance​

指定位置から最も近い要素を見つけるための許容差をミリメートル[mm]単位で指定する Double 型の値です。この引数は、入力位置に最も近い要素を見つけるのに役立ちます。

この入力は必須です。

bVisible​

検索モードを指定する Boolean 型の値です。

True: 画面に表示されている要素のみを検索します

False: 非表示要素を検索できます

この入力は必須です。

戻り値​

ポスト要素情報を含む DPostElem オブジェクトです。

サンプルコード​

JPT.ClearLog()
# モデルパスの設定
JupiterPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
modelPath = JupiterPath + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"

# 結果のインポート
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 1, 1, 1)'.format(modelPath))
JPT.ViewFitToModel()

# 結果の表示
JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, Mises, 2}, {2, 0, 0, 0, 0, 0, 0, 0.000000, 0}, \
0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, \
{0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')
JPT.Exec('CmdShowPostDeformation(183:1, 1, 0, 1, 1, 0, 0.000000, 0, 0.070000, 0, 0.070000, 0.070000, 0.070000, 0)')

# 位置で要素を取得
elemWith_Tolerance = JPT.GetPostElemFromPosition(16, 20, 5, 0.1, 1)
JPT.Debugger(elemWith_Tolerance) #要素 ID = 409
