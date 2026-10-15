# MeshEdit.CreateNode.Offset()

MeshEdit.CreateNode.Offset()

説明​

選択された節点または浮動小数点からのオフセット距離により新しい節点を作成します。

構文​

MeshEdit.CreateNode.Offset(...)

マクロ: CreateNodeOffset

リボン: MeshEdit » CreateNode » Offset

入力​

vecOffset​

オフセットベクトルを指定する Double のリストです。

デフォルト値は[]です。

iRepeat​

繰り返し回数を指定する Integer です。

デフォルト値は1です。

crlNodes​

オフセット節点を作成する選択された節点を指定する Cursor のリストです。

デフォルト値は[]です。

crCoord​

座標を指定する Cursor です。

デフォルト値はNoneです。

戻り値​

作成された浮動節点を指定する Cursor のリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()

# オフセット節点を作成
newNode = MeshEdit.CreateNode.Offset(vecOffset=[0.003, 0.0, 0.0], crlNodes=[Node(7)])
JPT.Debugger(newNode) # 戻り値を確認するため
