# MeshEdit.CreateNode.CenterOfCylinder()

MeshEdit.CreateNode.CenterOfCylinder()

説明​

円筒表面の中央に、縦方向に浮動する節点を作成します。

構文​

MeshEdit.CreateNode.CenterOfCylinder(...)

マクロ: MeshEditCreateNodeCylindCenter

リボン: MeshEdit » CreateNode » CenterOfCylinder

入力​

iNewNodeID​

新しい節点IDを指定する Integer です。

デフォルト値は最大節点ID + 1 です。

crlFaces​

選択された円筒面を指定する Cursor のリストです。

デフォルト値は [] です。

戻り値​

作成された浮動する節点を指定する Cursor のリストです。

サンプルコード​

# モデルの準備
Geometry.Part.Cylinder()

# 円筒の中央節点を作成
newNode = MeshEdit.CreateNode.CenterOfCylinder(crlFaces=[Face(5)], iNewNodeID=363)
JPT.Debugger(newNode) # 戻り値を確認するために使用します
