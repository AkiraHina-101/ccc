# JPT.GetAllElems()

JPT.GetAllElems()

説明​

すべての既存要素の情報を取得します。

注記

この機能をPostドキュメントで実行すると、0が返されます。すべてのPost要素を取得したい場合は、 GetAllPostElems を使用してください。

構文​

JPT.GetAllElems()

入力​

このユーティリティ機能には、入力値は必要ありません。

戻り値​

すべての既存要素の情報を含む ElemVector オブジェクトまたは DElem オブジェクトのリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべての既存要素の情報を取得
listDElems = JPT.GetAllElems()
JPT.Debugger(listDElems)

# リスト内の各既存要素の関連情報をすべて表示
for elem in listDElems:
    JPT.Debugger(elem)
