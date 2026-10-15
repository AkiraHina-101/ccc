# JPT.GetSelectedElems()

JPT.GetSelectedElems()

説明​

選択した要素のすべての情報を取得します。

構文​

JPT.GetSelectedElems()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

選択した要素のすべての情報を含む ElemVector オブジェクトまたは List of DElem オブジェクトです。

サンプルコード​

# モデルの準備
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

# 選択した要素の情報を取得
listSelElems = JPT.GetSelectedElems()
JPT.Debugger(listSelElems)
JPT.Debugger(listSelElems[2])
