# JPT.GetMinResultId()

JPT.GetMinResultId()

説明​

プロット結果の最小値を持つ節点/要素のIDを取得します。

構文​

JPT.GetMinResultId(...)

入力​

bVisible ​

可視エンティティに対象を制限するかどうかを指定する _Bool_型

デフォルト値は False です。

戻り値​

プロット結果の最小値を持つ節点/要素のID（表示位置のタイプに基づく）を指定する _Integer_型です。

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

# プロット結果の最小値を持つ節点のIDを取得
minNodeID = JPT.GetMinResultId()
JPT.Debugger(minNodeID)

# プロット結果の最小値を持つ要素のIDを取得
JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XY, 2}, {2, 1, 0, 0, 0, 0, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, \
                             0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, \
                             0, 0, 0, 0.000000, 0}, 0, 0)')

minElemID = JPT.GetMinResultId()
JPT.Debugger(minElemID)
