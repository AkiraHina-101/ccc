# JPT.GetSelectedNodes()

JPT.GetSelectedNodes()

説明​

選択した節点のすべての情報を取得します。

構文​

JPT.GetSelectedNodes()

入力​

このユーティリティ機能には入力値は必要ありません。

戻り値​

選択した節点のすべての情報を含む NodeVector オブジェクトまたは DNode オブジェクトのリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Home.Find(strSearch="20 21 22 23 24", strSelectedType="Node")
JPT.ViewFitToModel()

# 選択されたすべての節点の情報を取得
listSelNodes = JPT.GetSelectedNodes()
JPT.Debugger(listSelNodes)
JPT.Debugger(listSelNodes[1])
