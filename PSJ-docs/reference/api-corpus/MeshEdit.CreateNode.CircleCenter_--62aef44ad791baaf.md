# MeshEdit.CreateNode.CircleCenter()

MeshEdit.CreateNode.CircleCenter()

説明​

選択した円形のエッジの中心に節点/浮遊節点を作成します。

構文​

MeshEdit.CreateNode.CircleCenter(...)

マクロ: CreateNodeEdgeCenter

リボン: MeshEdit » CreateNode » CircleCenter

入力​

crlEdges​

円形のエッジを指定する Cursor リストです。

この入力は必須です。

iNewNodeID​

新しい節点のIDを指定する Integer です。

デフォルト値は最大節点ID + 1 です。

bImprint​

作成した節点をフェースに印刷するかどうかを指定する Boolean です。

デフォルト値は False です。

crFace​

節点が印刷されるフェースを指定する Cursor です。

デフォルト値は [] です。

戻り値​

作成された浮遊または印刷された節点を指定する Cursor リストです。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Edge.Circle(veclPositions=[[0.005555555555555556, 0.005555555555555556, 0.01]], 
                                    crlTargetFace=[Face(26)], dOutRadius=1.5)

# 円の中心節点を作成する
newNode = MeshEdit.CreateNode.CircleCenter(crlEdges=[Edge(55)], iNewNodeID=540)
JPT.Debugger(newNode) # 戻り値を確認するため
