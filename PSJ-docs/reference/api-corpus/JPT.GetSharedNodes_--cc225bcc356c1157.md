# JPT.GetSharedNodes()

JPT.GetSharedNodes()

説明​

共有節点のすべての情報を取得します。

構文​

JPT.GetSharedNodes(DItemVector)

入力​

DItemVector​

共有節点を取得する DItem オブジェクトまたは DItem オブジェクトのリスト。

この項目は必須です。

戻り値​

すべての共有節点の情報を含む DItem オブジェクトまたは DItem オブジェクトのリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6217822)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6908379)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=7138924)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=15753968)
JPT.ViewFitToModel()

# 共有面を作成
JPT.Exec('AssembleFaceMatingStep([], [], [3:1, 3:2, 3:3, 3:4], 1e-05)')
JPT.Exec('AssembleFaceEx([49, 24, 50, 75, 101, 76], 1e-05, 0, 0)')

# すべての共有節点の情報を取得
listParts = JPT.GetAllByTypeID(JPT.DItemType.BODY)
listSharedNodes = JPT.GetSharedNodes(listParts)
JPT.Debugger(listSharedNodes)
