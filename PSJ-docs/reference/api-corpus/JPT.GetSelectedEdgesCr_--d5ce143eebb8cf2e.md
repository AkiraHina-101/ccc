# JPT.GetSelectedEdgesCr()

JPT.GetSelectedEdgesCr()

説明​

選択したエッジのすべての情報を Cursor のリスト 形式で取得します。

構文​

JPT.GetSelectedEdgesCr()

入力​

このユーティリティ関数には、入力値は必要ありません。

戻り値​

選択したエッジの typeID と ID を含むカーソルリスト（マクロ文字列型）を指定する String。

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

# 選択したエッジの情報を取得
listCursorSelEdges = JPT.GetSelectedEdgesCr()
JPT.Debugger(listCursorSelEdges)
