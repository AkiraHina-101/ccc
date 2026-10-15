# JPT.GetMaxResultId()

JPT.GetMaxResultId()

説明​

プロット結果の最大値を持つ節点/要素のIDを取得します。

構文​

JPT.GetMaxResultId(...)

入力​

bVisible ​

可視エンティティに制限するかどうかを指定する Boolean （True のみの対象かそれ以外か）。

デフォルト値は False です。

戻り値​

プロット結果の最大値を持つ（表示位置のタイプに基づく）節点/要素の ID を指定する Integer です。

注記

結果がまだプロットされていない場合、このユーティリティは -1 を返します。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 4}, {1, 1, 0, 0, 1, 8, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, \
                             0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, 0)')

# プロット結果の最大値を持つ節点の ID を取得
maxNodeID = JPT.GetMaxResultId()
JPT.Debugger(maxNodeID)

# プロット結果の最大値を持つ要素の ID を取得
JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 2}, {2, 1, 0, 0, 0, 0, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, \
                             0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, 0)')

maxElemID = JPT.GetMaxResultId()
JPT.Debugger(maxElemID)
