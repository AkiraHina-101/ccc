# JPT.GetSelectedFaces()

JPT.GetSelectedFaces()

説明​

選択したフェースのすべての情報を取得します。

構文​

JPT.GetSelectedFaces()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

選択したフェースのすべての情報を含む FaceVector オブジェクトまたは DFace オブジェクトのリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Home.Find(strSearch="20 21 22 23 24", strSelectedType="Face")
JPT.ViewFitToModel()

# 選択したエッジの情報を取得
listSelFaces = JPT.GetSelectedFaces()
JPT.Debugger(listSelFaces)
JPT.Debugger(listSelFaces[2])
