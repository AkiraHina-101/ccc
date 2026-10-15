# JPT.GetSelectedPartsCr()

JPT.GetSelectedPartsCr()

説明​

選択されたパートのすべての情報を Cursor のリスト形式で取得します。

構文​

JPT.GetSelectedPartsCr()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

選択されたパートのtypeIDとIDを含むカーソルリストを指定する String です（マクロ文字列タイプ）。

サンプルコード​

# モデルを準備
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Home.Find(strSearch="5 6 7", strSelectedType="Part")
JPT.ViewFitToModel()

# 選択されたパートの情報を取得
listCursorSelParts = JPT.GetSelectedPartsCr()
JPT.Debugger(listCursorSelParts)
