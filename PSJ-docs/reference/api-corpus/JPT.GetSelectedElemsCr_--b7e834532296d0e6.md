# JPT.GetSelectedElemsCr()

JPT.GetSelectedElemsCr()

説明​

選択された要素のすべての情報を Cursor リスト形式で取得します。

構文​

JPT.GetSelectedElemsCr()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

選択された要素の typeID と ID を含むカーソルリスト（マクロ文字列型）を指定する String。

サンプルコード​

# モデルを準備
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Home.Find(strSearch="3199 3204 3201 3202 3200 3203 3186 3185 3183 3184 3181",
          strSelectedType="2D Element")
JPT.ViewFitToModel()

# 選択された要素の情報を取得
listCursorSelElems = JPT.GetSelectedElemsCr()
JPT.Debugger(listCursorSelElems)
