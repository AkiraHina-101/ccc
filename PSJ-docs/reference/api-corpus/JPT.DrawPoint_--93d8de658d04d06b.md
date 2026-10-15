# JPT.DrawPoint()

JPT.DrawPoint()

説明​

メインウィンドウに点を描画します。

構文​

JPT.DrawPoint()

入力​

listPosition  ​

点の位置を指定する座標のリスト（例：[x, y, z]）です。

値はSI単位のメートルで表されます。

color​

矢印の色を表す16進数形式の Int です。

デフォルトの色はシアン（RGB(0, 255, 255））です。

width​

矢印の幅（ピクセル単位）を表す Float（float）です。デフォルト値は1.0です。

戻り値​

成功または失敗を指定する Boolean です。

True: 成功

False: 失敗

サンプルコード​

#ビュー用モデルを準備
Geometry.Part.Cube(dlLength=[10.0, 10.0, 10.0])
JPT.ViewFitToModel()

#デフォルトの色と幅で位置[10, 20, 30]に緑色の点を描画します：
JPT.DrawPoint([10, 20, 30])

#幅が2.5の位置[5, 15, 25]に赤い点を描画します：
JPT.DrawPoint([5, 15, 25], 255, 2.5)

#幅が1.5の位置[0, 0, 0]に青い点を描画します：
JPT.DrawPoint([0, 0, 0], 16711680, 1.5)
