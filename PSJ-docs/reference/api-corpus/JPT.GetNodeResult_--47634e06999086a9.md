# JPT.GetNodeResult()

JPT.GetNodeResult()

説明​

条件を満たす結果を持つ節点を取得します。

構文​

JPT.GetNodeResult(PostDataRangeType,
                     resultValue,
                     adjustment)

入力​

PostDataRangeType​

節点結果を取得する条件を記述する Enum です。

この入力は必須です。

resultValue​

参照値を指定する Double です。

この入力は必須です。

tolerance​

基本値 resultValue に対する調整を指定する Double です。

もし PostDataRangeType がスカラー型（EQ、NE、LT、GT、LE、GE）の場合、結果を取得する範囲は（resultValue - adjustment）から（resultValue + adjustment）までです

もし PostDataRangeType が範囲型（IR、OR、IRE、ORE）の場合、結果を取得する範囲は（resultValue）から（adjustment）までです

デフォルト値は 1E-5 です。

戻り値​

指定した条件を満たす節点のロードされた結果を含む Cursor のリストです。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Stress, Max Principal Stress, 4}, {1, 1, 0, 0, 1, 8, \
                             0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, \
                             0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')

# 節点結果が1より大きい（許容値=10E-3）ノーダルグループを作成
list_node_1= JPT.GetNodeResult(JPT.PostDataRangeType.GT,1,10E-3)
Tools.Group.CreateGroup(strGroupName="Group_Node_1", crlTargets=list_node_1)

# 節点結果が範囲（1、5）にあるノーダルグループを作成
list_node_2= JPT.GetNodeResult(JPT.PostDataRangeType.IR,1,5)
Tools.Group.CreateGroup(strGroupName="Group_Node_2", crlTargets=list_node_2)
