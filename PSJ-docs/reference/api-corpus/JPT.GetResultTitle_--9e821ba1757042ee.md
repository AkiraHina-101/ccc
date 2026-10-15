# JPT.GetResultTitle()

JPT.GetResultTitle()

説明​

結果が読み込まれたときのタイトルの内容を取得します。

構文​

JPT.GetResultTitle()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

タイトルのすべての情報を含む Dictionary です。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

# 結果と変位をロードします。
JPT.Exec('CmdShowPostContour(183:1, \
        {2, 0, 1, 6, Displacement, Translational, 1}, \
        {1, 1, 0, 0, 0, 0, 0, 0.000000, 0}, 0, \
        {0, 0, 0, 0, , , 0}, \
        {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, \
        {0, 0, 0, 0, , , 0}, \
        {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')
JPT.Exec('CmdShowPostDeformation(183:1, 2, 0, 1, 6, Displacement, Translational, \
        0, 0.000000, 0, 0.070000, 0, 0.070000, 0.070000, 0.070000, 0)')
JPT.Exec('CmdEnableMiddleNodes(1)')

title=JPT.GetResultTitle()
pprint(title)
