# JPT.GetAllCustomNotes()

JPT.GetAllCustomNotes()

説明​

すべての既存のカスタムノートの情報をすべて取得します。

構文​

JPT.GetAllCustomNotes()

入力​

このユーティリティ関数には、入力値は必要ありません。

戻り値​

すべての既存のカスタムノートのすべての情報を含む CustomNoteVector オブジェクトまたは DCustomNote オブジェクトの List 。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべての既存のエッジの情報を取得
listDEdges = JPT.GetAllEdges()
JPT.Debugger(listDEdges)

# リスト内の各既存エッジの関連情報をすべて表示
for edge in listDEdges:
    JPT.Debugger(edge)
