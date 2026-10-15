# JPT.GetMaxResultCoord()

JPT.GetMaxResultCoord()

説明​

プロット結果の最大値を持つ要素の節点/中心節点の座標を取得します。

構文​

JPT.GetMaxResultCoord(...)

入力​

bVisible​

ターゲットを可視エンティティに制限するか（True）どうかを指定する Boolean 。

デフォルト値は False です。

戻り値​

プロット結果の最大値を持つ要素の節点/中心節点の座標を指定する DoubleVector 型（表示設定タイプに基づく）。

注記

結果がまだプロットされていない場合、このユーティリティはリスト = [-1.79769e+308, -1.79769e
+308, -1.79769e+308] を返します。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 4}, {1, 1, 0, 0, 1, 8, 0, \
                             0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, 0)')

# プロット結果の最大値を持つ節点の座標を取得します
maxNodeCoord = JPT.GetMaxResultCoord()
JPT.Debugger(maxNodeCoord)

# プロット結果の最大値を持つ要素の中心の座標を取得します
JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 2}, {2, 1, 0, 0, 0, 0, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, \
                             0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, 0)')

maxElemCenterCoord = JPT.GetMaxResultCoord()
JPT.Debugger(maxElemCenterCoord)
