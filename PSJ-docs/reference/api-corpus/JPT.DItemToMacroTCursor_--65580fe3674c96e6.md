# JPT.DItemToMacroTCursor()

JPT.DItemToMacroTCursor()

説明​

_ [DItem]（../data-type/psj-utility/pre-utility/built-in-types/DItem）_ オブジェクトを Cursor（マクロ文字列型）に変換します。

構文​

JPT.DItemToMacroTCursor（DItem）

入力​

DItem​

変換する [DItem]（../data-type/psj-utility/pre-utility/built-in-types/DItem） オブジェクト。

これは必須の入力です。

戻り値​

すべての変換されたアイテムを含む String です。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべての既存の節点を取得し、そのうちの1つを _Cursor_ （マクロ文字列型）の _List_ に変換します
## モデルからすべての節点を取得します
listNodes = [JPT.CastToDItem(node) for node in JPT.GetAllNodes()] # _DItem_ オブジェクトのリスト
## 作成したリストから1つの節点を取得します
node = listNodes[0] # _DItem_ オブジェクト
## 節点を文字列オブジェクトに戻します。例えば、戻り値 = 10:772
JPT.Debugger(JPT.DItemToMacroTCursor(node))
