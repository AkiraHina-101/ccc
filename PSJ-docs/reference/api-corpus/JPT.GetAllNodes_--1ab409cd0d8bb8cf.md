# JPT.GetAllNodes()

JPT.GetAllNodes()

説明​

すべての既存の節点の情報を取得します。

注記

この機能はポストドキュメントで実行されると、0を返します。すべてのポスト節点を取得したい場合は、GetAllPostNodes を使用してください。

構文​

JPT.GetAllNodes()

入力​

このユーティリティ機能には、入力値は必要ありません。

戻り値​

すべての既存節点の情報を含む NodeVector オブジェクトまたは List of DNode オブジェクト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# すべての既存節点の情報を取得
listDNodes = JPT.GetAllNodes()
JPT.Debugger(listDNodes)

# リスト内の各既存節点の関連情報をすべて表示
for node in listDNodes:
    JPT.Debugger(node)
