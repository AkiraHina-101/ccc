# JPT.CastDItemToDLoadBC()

JPT.CastDItemToDLoadBC()

説明​

選択した座標系の情報を取得するために、DItem オブジェクトを DLoadBC オブジェクトに変換します。

構文​

JPT.CastDItemToDLoadBC(DItemObject)

入力​

DItemObject​

変換に使用される DItem オブジェクトです。

これは必須の入力です。

戻り値​

関連情報を持つ DLoadBC オブジェクト（境界条件）。

サンプルコード​

# シンプルなサンプルを準備
Geometry.Part.Cube(iPartColor=6409934)
BoundaryConditions.Pressure.General(crlTargets=[Face(26)])
JPT.ViewFitToModel()

# 作成された DItem オブジェクトのリストから DItem オブジェクト（Pressure）を取得
listDItemLoadBCs = JPT.GetAllByTypeID(JPT.DItemType.LBC_G_PRESSURE)
dItemLoadBC = listDItemLoadBCs[0]
JPT.Debugger(dItemLoadBC)

# 上記の DItem オブジェクトから DLoadBC オブジェクトに変換
dLoadBC = JPT.CastDItemToDLoadBC(dItemLoadBC)
JPT.Debugger(dLoadBC)
