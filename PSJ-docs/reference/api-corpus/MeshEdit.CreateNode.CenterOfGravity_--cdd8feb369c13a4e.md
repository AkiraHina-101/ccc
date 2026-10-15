# MeshEdit.CreateNode.CenterOfGravity()

MeshEdit.CreateNode.CenterOfGravity()

説明​

節点重心を作成します。

構文​

MeshEdit.CreateNode.CenterOfGravity(...)

リボン: MeshEdit » CreateNode » CenterOfGravity

入力​

iCreationType​

作成タイプを指定する Integer の値です。

0: 重力

1: 形状

デフォルト値は1です。

iNewNodeID​

新しい節点 ID を指定する Integer の値です。

デフォルト値は最大節点 ID + 1 です。

crlParts​

選択したパートを指定する Cursor のリストです。

デフォルト値は[]です。

crlBarPart​

選択したバーパートを指定する Cursor のリストです。

デフォルト値は[]です。

crlFaces​

選択したフェースを指定する Cursor のリストです。

デフォルト値は[]です。

戻り値​

作成された浮動節点を指定する Cursor です。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()

# 節点重心を作成
newNode = MeshEdit.CreateNode.CenterOfGravity(iNodeID=489, crlTargets=[Part(1)])
JPT.Debugger(newNode) # 戻り値を確認するため
