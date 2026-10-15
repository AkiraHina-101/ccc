# JPT.DItemToMacroListTCursor()

JPT.DItemToMacroListTCursor()

説明​

DItem オブジェクトを Cursor のリスト（マクロ文字列型）に変換します。

構文​

JPT.DItemToMacroListTCursor(DItem)

入力​

DItem​

変換する DItem オブジェクト。

この入力は必須です。

戻り値​

すべての変換されたアイテムを含む String。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべての既存の節点を取得し、そのうちの1つを _Cursor_ のリスト（マクロ文字列型）に変換します
## モデルからすべての節点を取得
listNodes = [JPT.CastToDItem(node) for node in JPT.GetAllNodes()] # DItem オブジェクトのリスト
## 作成されたリストから1つの節点を取得
node = listNodes[0] # DItem オブジェクト
## 節点を文字列オブジェクトに返却、例えば、return value = [10:772]
JPT.Debugger(JPT.DItemToMacroListTCursor(node))
