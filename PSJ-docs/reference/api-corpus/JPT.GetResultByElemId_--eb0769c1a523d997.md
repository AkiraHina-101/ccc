# JPT.GetResultByElemId()

JPT.GetResultByElemId()

説明​

指定された要素の結果値を取得します。

構文​

JPT.GetResultByElemId(elementID)

入力​

elementID​

結果値を確認する要素のIDを指定する Integer 。

この入力は必須です。

戻り値​

要素の結果を指定する Double 。

サンプルコード​

# モデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XX, 2}, {2, 1, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, \
                             0.000000, 0}, 0, 0)')

# 要素ID = 658の結果値を取得
valueElementID = JPT.GetResultByElemId(658)
print("要素ID = 658のXX成分の応力: " + str(valueElementID))
