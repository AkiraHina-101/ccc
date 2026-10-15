# JPT.GetMinResultValue()

JPT.GetMinResultValue()

説明​

現在のプロット結果の最小値を取得します。

構文​

JPT.GetMinResultValue(...)

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

bVisible ​

表示対象を可視エンティティに制限するかどうかを指定する Boolean （True）または（False）。

デフォルト値は False です。

注記

結果がプロットされていない場合、このユーティリティは -1.7976931348623157e+308 を返します。

サンプルコード​

# モデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 4}, {1, 1, 0, 0, 1, 8, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, \
                             0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, 0)')

# プロット結果の最小値を取得
minResult = JPT.GetMinResultValue()
JPT.Debugger(minResult)
