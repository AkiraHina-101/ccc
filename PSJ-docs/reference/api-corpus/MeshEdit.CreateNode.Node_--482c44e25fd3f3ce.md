# MeshEdit.CreateNode.Node()

MeshEdit.CreateNode.Node()

説明​

既存の節点の座標値を参照して、節点を作成します。

構文​

MeshEdit.CreateNode.Node(...)

マクロ: MeshEditCreateNodeAtNode

リボン: MeshEdit » CreateNode » Node

入力​

iNewNodeID​

新しい節点IDを指定する Integer です。

デフォルト値は最大節点ID+1です。

crTarget​

節点の作成先を指定する Cursor です。作成先はフェースまたはエッジになります。

デフォルト値はなしです。

戻り値​

作成された浮遊節点を指定する Cursor です。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()

# 節点を節点に作成
newNode = MeshEdit.CreateNode.Node(iNewNodeId=489, crTarget=Node(480))
JPT.Debugger(newNode) # 戻り値の確認のため
