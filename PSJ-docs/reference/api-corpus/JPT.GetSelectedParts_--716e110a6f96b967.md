# JPT.GetSelectedParts()

JPT.GetSelectedParts()

説明​

選択されたパートのすべての情報を取得します。

構文​

JPT.GetSelectedParts()

入力​

このユーティリティ関数には入力値は必要ありません。

返却値​

選択されたパートのすべての情報を含む BodyVector オブジェクト、または DBody オブジェクトのリストです。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Home.Find(strSearch="5 6 7 8", strSelectedType="Part")
JPT.ViewFitToModel()

# 選択されたパートの情報を取得
listSelParts = JPT.GetSelectedParts()
JPT.Debugger(listSelParts)
JPT.Debugger(listSelParts[2])
