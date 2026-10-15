# JPT.GetSelectedEdges()

JPT.GetSelectedEdges()

説明​

選択されたエッジのすべての情報を取得します。

構文​

JPT.GetSelectedEdges()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

選択されたエッジのすべての情報を含む EdgeVector オブジェクトまたは List of DEdge オブジェクト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Home.Find(strSearch="87 90 91 94 95 96 97 98", strSelectedType="Edge")
JPT.ViewFitToModel()

# すべての選択されたエッジの情報を取得
listSelEdges = JPT.GetSelectedEdges()
JPT.Debugger(listSelEdges)
JPT.Debugger(listSelEdges[3])
