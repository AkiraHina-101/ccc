# JPT.GetSharedElements()

JPT.GetSharedElements()

説明​

共有要素のすべての情報を取得します。

構文​

JPT.GetSharedElements(DItemVector)

入力​

DItemVector​

共有要素を取得する DItem オブジェクトまたは DItem オブジェクトのリストです。

この入力は必須です。

戻り値​

すべての共有要素の情報を含む DItemVector オブジェクトまたは DItem オブジェクトのリストです。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6217822)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6908379)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=7138924)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=15753968)
JPT.ViewFitToModel()

# 共有面の作成
JPT.Exec('AssembleFaceMatingStep([], [], [3:1, 3:2, 3:3, 3:4], 1e-05)')
JPT.Exec('AssembleFaceEx([49, 24, 50, 75, 101, 76], 1e-05, 0, 0)')

# すべての共有要素の情報を取得
listParts = JPT.GetAllByTypeID(JPT.DItemType.BODY)
listSharedElems = JPT.GetSharedElements(listParts)
JPT.Debugger(listSharedElems)
