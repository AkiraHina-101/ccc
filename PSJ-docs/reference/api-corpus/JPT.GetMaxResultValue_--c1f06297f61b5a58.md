# JPT.GetMaxResultValue()

JPT.GetMaxResultValue()

説明​

現在のプロット結果の最大値を取得します。

構文​

JPT.GetMaxResultValue(...)

入力​

bVisible​

視覚化されているエンティティに制限するかどうかを指定する Boolean 。

デフォルト値は False です。

戻り値​

プロット結果の最大値を指定する Integer です。

注記

結果がまだプロットされていない場合、このユーティリティは -1.7976931348623157e+308 を返します。

サンプルコード​

# モデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 4}, {1, 1, 0, 0, 1, 8, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, \
                             0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, 0)')

# プロット結果の最大値を取得
maxResult = JPT.GetMaxResultValue()
JPT.Debugger(maxResult)
