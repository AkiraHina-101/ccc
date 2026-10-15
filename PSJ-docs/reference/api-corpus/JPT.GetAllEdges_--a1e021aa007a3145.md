# JPT.GetAllEdges()

JPT.GetAllEdges()

説明​

すべての既存のエッジの情報を取得します。

構文​

JPT.GetAllEdges()

入力​

このユーティリティ関数には、入力値は必要ありません。

Return Code​

すべての既存のエッジの情報を含む EdgeVector オブジェクトまたは List of DEdge オブジェクト。

サンプルコード​

# モデルを準備
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
