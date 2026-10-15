# MeshEdit.CreateNode.CenterOfSphere()

MeshEdit.CreateNode.CenterOfSphere()

説明​

4つの節点の中心球または曲率中心に節点を作成します。

構文​

MeshEdit.CreateNode.CenterOfSphere(...)

マクロ：MeshEditCreateNodeSphereCenter

リボン：MeshEdit » CreateNode » CenterOfSphere

入力​

iNewNodeID​

新しい節点IDを指定する Integer。

デフォルト値は最大節点ID + 1 です。

crlTargets​

球面フェースまたは4つの節点を指定する Cursor のリスト。

デフォルト値は [] です。

戻り値​

作成された浮動節点を指定する Cursor。

サンプルコード​

# モデルの準備
Geometry.Part.Sphere(iPartColor=6409934)

# 球の中心節点を作成
newNode = MeshEdit.CreateNode.CenterOfSphere(crlTargets=[Face(1)], iNewNodeID=383)
JPT.Debugger(newNode) # 戻り値をチェックするため
