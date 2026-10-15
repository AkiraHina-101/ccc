# JPT.DItemListToMacroListTCursor()

JPT.DItemListToMacroListTCursor()

説明​

DItemVector オブジェクトまたは DItem オブジェクトの List を List of Cursor（マクロ文字列型）に変換します。

構文​

JPT.DItemListToMacroListTCursor(DItemList)

入力​

DItemList​

変換される DItemVector オブジェクトまたは DItem オブジェクトの List。

この入力は必須です。

戻り値​

すべての変換されたアイテムを含む String。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべての既存のフェースを取得して、List of Cursor（マクロ文字列型）に変換
## モデルからすべてのフェースを取得
listFaces = [JPT.CastToDItem(face) for face in JPT.GetAllFaces()] # DItem オブジェクトのリスト
## フェースを文字列オブジェクトに戻す、たとえば、戻り値 = [6:73, 6:74, ...]
JPT.Debugger(JPT.DItemListToMacroListTCursor(listFaces))
