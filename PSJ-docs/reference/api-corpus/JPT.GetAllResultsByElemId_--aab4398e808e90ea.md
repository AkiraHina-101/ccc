# JPT.GetAllResultsByElemId()

JPT.GetAllResultsByElemId()

説明​

指定した要素のすべての結果値を取得します。

構文​

JPT.GetAllResultsByElemId(elementID,breturnBlank)

入力​

elementID​

要素のIDを指定する Integer の入力です。

この入力は必須です。

bReturnBlank​

空白値を表現するオプションを指定する Boolean 型の入力です。

デフォルト値はFalseです。

戻り値​

要素のすべての結果を指定するリストです。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, Mises, 2}, \
                            {1, 0, 0, 0, 16, 0, 0, 0.000000, 0}, 0, \
                            {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, \
                            {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')

# 要素ID = 33 のすべての結果値を取得
valuesElemID = JPT.GetAllResultsByElemId(33)
for data in valuesElemID:
    type, id, value= data
    print(f'Type:{type} ID:{id} Value:{value}')
