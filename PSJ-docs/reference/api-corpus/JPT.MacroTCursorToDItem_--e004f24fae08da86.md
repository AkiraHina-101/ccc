# JPT.MacroTCursorToDItem()

JPT.MacroTCursorToDItem()

説明​

カーソル（マクロ文字列型）を DItem オブジェクトに変換します。

構文​

JPT.MacroTCursorToDItem(cursor)

入力​

cursor​

マクロ文字列型を指定してください

この入力は必須です

戻り値​

DItem オブジェクト

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
JPT.ViewFitToModel()

# DItemに変換し、作成されたCube_1のすべての情報を取得します
dItem = JPT.Debugger(JPT.MacroTCursorToDItem("3:1"))
JPT.Debugger(dItem)
