# JPT.DrawLine()

JPT.DrawLine()

説明​

メインウィンドウに線を引く

構文​

JPT.DrawLine()

入力​

listStartPoint​

線の始点の座標を指定する list（例：[x1, y1, z1]）。

値はSI単位（メートル）で表されます。

listEndPoint​

線の終点の座標を指定する list（例：[x2, y2, z2]）。

値はSI単位（メートル）で表されます。

color​

矢印の色を表す16進数形式の Int。

デフォルトの色はシアン（RGB(0, 255, 255)）です。

width​

矢印の幅をピクセル単位で指定する Int。

デフォルトは1です。

戻り値​

成功または失敗を指定する Boolean。

True: 成功。

False: 失敗。

サンプルコード​

#モデルの準備
Geometry.Part.Cube(dlLength=[10.0, 10.0, 10.0])
JPT.ViewFitToModel()

# [0, 0, 0]から[10, 20, 30]にデフォルトの色と幅で白い線を引く：
JPT.DrawLine([0, 0, 0], [10, 20, 30])

# [5, 5, 5]から[15, 15, 15]に赤い線を幅2.5で引く：
JPT.DrawLine([5, 5, 5], [15, 15, 15], 255, 2.5)

# [1, 1, 1]から[2, 2, 2]に緑の線を幅1.5で引く：
JPT.DrawLine([1, 1, 1], [2, 2, 2], 65280, 1.5)
