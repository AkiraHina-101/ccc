# JPT.GetAllResultsByNodeId()

JPT.GetAllResultsByNodeId()

説明​

指定した節点のすべての結果値を取得します。

構文​

JPT.GetAllResultsByNodeId(nodeID)

入力​

nodeID​

結果値を確認する節点のIDを指定する Integer です。

この入力は必須です。

bReturnBlank​

空白値を表現するオプションを指定する Boolean  です。

デフォルト値は False です。

戻り値​

節点のすべての結果を指定するリストです。

サンプルコード​

# モデルを準備します
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, XX, 4}, \
                            {1, 1, 0, 0, 16, 0, 0, 0.000000, 0}, 0, \
                            {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, \
                            {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')

# 節点ID = 60 の結果値を取得します
valuesNodeID = JPT.GetAllResultsByNodeId(60)
for data in valuesNodeID:
    type, id, value= data
    print(f'Type:{type} ID:{id} Value:{value}')
