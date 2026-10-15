# MeshEdit.CreateNode.Between2Nodes()

MeshEdit.CreateNode.Between2Nodes()

説明​

2つの選択された節点の間に節点を作成します。

構文​

MeshEdit.CreateNode.Between2Nodes(...)

マクロ: MeshEditCreateNodeBetween2Nodes

リボン: MeshEdit » CreateNode » Between2Nodes

入力​

iNewNodeID​

新しい節点IDを指定する Integer です。

デフォルト値は最大節点ID + 1 です。

iNumberOfNodes​

2つの対象節点の間に作成される新しい節点の数を指定する Integer です。

デフォルト値は0 です。

bImprint​

作成される節点をフェースに印字するかどうかを指定する Boolean です。

デフォルト値はFalse です。

crlNodes​

2つの対象節点を指定する Cursor のリストです。

デフォルト値は [] です。

crlFaces​

節点が印字されるフェースを指定する Cursor のリストです。

デフォルト値は [] です。

ノート

このバージョンでは複数フェースの印刷がサポートされていませんので、各操作ごとに crlFaces には単一のフェースを指定する必要があります。

戻り値​

浮遊または印字された節点を指定する Cursor のリストです。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()

# 2つの節点の間に節点を作成
newNodes = MeshEdit.CreateNode.Between2Nodes(iNewNodeID=490, iNumberofNodes=2, crlNodes=[Node(6, 7)])
JPT.Debugger(newNodes) # 戻り値を確認するため
