# JPT.MacroListTCursorToListDItem()

JPT.MacroListTCursorToListDItem()

説明​

カーソルリスト（マクロ文字列タイプ）を DItemVector に変換します。

構文​

JPT.MacroListTCursorToListDItem(cursorList)

入力​

cursorList​

マクロ文字列タイプであるカーソルリストを指定します（ String ）。

この入力は必須です。

戻り値​

変換されたアイテムを指定する DItemVector オブジェクトまたは DItem オブジェクトの List です。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()

# カーソルリスト（マクロ文字列形式）を DItemVector に変換する
## 節点カーソルのリストを作成
strCursorNode1 = "10:467"
strCursorNode2 = "10:477"
strCursorNode3 = "10:483"
listCursorNode = f"[{strCursorNode1}, {strCursorNode2}, {strCursorNode3}]"
## カーソルリストを DItem のリストに変換
JPT.Debugger(JPT.MacroListTCursorToListDItem(listCursorNode))
