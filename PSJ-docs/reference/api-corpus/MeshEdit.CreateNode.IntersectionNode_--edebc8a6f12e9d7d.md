# MeshEdit.CreateNode.IntersectionNode()

MeshEdit.CreateNode.IntersectionNode()

説明​

部分または面と、2つの節点によって定義されるエッジまたは線分の交差点に浮遊節点を作成します。

構文​

MeshEdit.CreateNode.IntersectionNode(...)

マクロ: CreateNodeIntersectionNode

リボン: MeshEdit » CreateNode » IntersectionNode

入力​

crlFaces​

面を指定する Cursor のリストです。

この入力は必須です。

crlParts​

パートを指定する Cursor のリストです。

この入力は必須です。

crEdge​

エッジを指定する Cursor です。

この入力は必須です。

crlNodes​

線を作成するために2つの節点を指定する Cursor のリストです。

この入力は必須です。

戻り値​

作成した浮遊節点を指定する Cursor のリストです。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=7697908)
MeshEdit.CreateNode.Offset(vecOffset=[0.003, 0.0, 0.0], crlNodes=[Node(324)])
MeshEdit.CreateNode.Offset(vecOffset=[-0.003, 0.0, 0.0], crlNodes=[Node(259)])

# 交差点節点の作成
newNode = MeshEdit.CreateNode.IntersectionNode(crlFaces=[Face(24, 23)], crlParts=[], crlEdges=[], 
                                                crlNodes=[Node(489, 490)])
JPT.Debugger(newNode) # 戻り値を確認するため
