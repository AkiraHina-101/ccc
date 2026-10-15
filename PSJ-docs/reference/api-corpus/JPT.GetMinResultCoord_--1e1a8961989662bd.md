# JPT.GetMinResultCoord()

JPT.GetMinResultCoord()

説明​

プロット結果の最小値を持つ要素の節点/中心節点の座標を取得します。

構文​

JPT.GetMinResultCoord(...)

入力​

bVisible​

ターゲットを見えるエンティティのみに制限するかどうかを指定する Bool（True）または指定しない（False）選択肢です

デフォルト値は False です。

戻り値​

プロット結果の最小値を持つ要素（表示位置タイプに基づく）の節点/中心節点の座標を指定する DoubleVector です。

注記

結果をまだプロットしていない場合、このユーティリティはリスト = [-1.79769e+308, -1.79769e+308, -1.79769e+308] を返します。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 4}, {1, 1, 0, 0, 1, 8, 0, \
                             0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, 0)')

# プロット結果の最小値を持つ要素の節点の座標を取得
minNodeCoord = JPT.GetMinResultCoord()
JPT.Debugger(minNodeCoord)

# プロット結果の最小値を持つ要素の中心の座標を取得
JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 2}, {2, 1, 0, 0, 0, 0, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, \
                             0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, 0)')

minElemCenterCoord = JPT.GetMinResultCoord()
JPT.Debugger(minElemCenterCoord)
