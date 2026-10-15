# JPT.CastDItemToDRONode()

JPT.CastDItemToDRONode()

説明​

選択した Post 節点の情報を取得するために、 DItem オブジェクトを DPostNode オブジェクトに変換します。

構文​

JPT.CastDItemToDRONode(DItemObject)

入力​

DItemObject​

変換に使用される DItem オブジェクト。

これは必須の入力です。

戻り値​

関連情報を持つ DPostNode オブジェクト（Post 節点）。

コードサンプル​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

# 作成された DItem オブジェクトのリストから DItem オブジェクト（Pressure の LBC オブジェクト）を取得
listDItemPostNodes = JPT.GetAllByTypeID(JPT.DItemType.POST_NODE)
dItemPostNode = listDItemPostNodes[0]
JPT.Debugger(dItemPostNode)

# 上記の DItem オブジェクトから DPostNode オブジェクトに変換
dPostNode = JPT.CastDItemToDRONode(dItemPostNode)
JPT.Debugger(dPostNode)
