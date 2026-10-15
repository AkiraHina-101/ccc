# JPT.CastDItemToDEdge()

JPT.CastDItemToDEdge()

説明​

選択されたエッジの情報を取得するために、_ DItem_ オブジェクトを _ DEdge_ オブジェクトに変換します。

構文​

JPT.CastDItemToDEdge(DItemObject)

入力​

DItemObject​

変換に使用される DItem オブジェクトです。

これは必須の入力です。

戻り値​

関連情報を持つ DEdge オブジェクト（エッジ）。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
JPT.ViewFitToModel()

# 作成された DItem オブジェクトのリストから DItem オブジェクトを取得するための Edge オブジェクト
listDItemEdges = JPT.GetAllByTypeID(JPT.DItemType.EDGE)
dItemEdge = listDItemEdges[0]
JPT.Debugger(dItemEdge)

# 上記の DItem オブジェクトから DEdge オブジェクトに変換する
dEdge = JPT.CastDItemToDEdge(dItemEdge)
JPT.Debugger(dEdge)
