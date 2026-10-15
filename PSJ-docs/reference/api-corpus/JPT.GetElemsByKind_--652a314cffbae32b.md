# JPT.GetElemsByKind()

JPT.GetElemsByKind()

説明​

種類（1D、2D、3Dなど）を入力して、要素のリスト を取得します。

構文​

JPT.GetElemsByKind(ElemKind)

入力​

ElemKind​

Jupiter内の要素の ElemKind を指定する Enum です。

これは必須の入力です。

戻り値​

入力された要素の種類と同じ要素を持つ関連要素の情報をすべて含む ElemVector オブジェクト、または DElem オブジェクトのリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべての既存の2D要素の情報を取得
list2DElems = JPT.GetElemsByKind(JPT.ElemKind.ELEMKIND_2D)
JPT.Debugger(list2DElems)

# リスト内の各既存2D要素の関連情報をすべて表示
for elem in list2DElems:
    JPT.Debugger(elem)
