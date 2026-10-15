# JPT.GetResultByNodeId()

JPT.GetResultByNodeId()

説明​

指定された節点の結果値を取得します。

構文​

JPT.GetResultByNodeId(nodeID)

入力​

nodeID​

結果値を確認する節点の Integer を指定します。

これは必須の入力です。

戻り値​

節点の結果を指定します 倍精度浮動小数点数 型。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Displacement, X, 1}, {1, 1, 0, \
                             0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, \
                             {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, \
                             {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')

# 節点ID = 62 の結果値を取得します
valueNodeID = JPT.GetResultByNodeId(62)
print("節点ID = 62 のX成分の変位: " + str(valueNodeID))
