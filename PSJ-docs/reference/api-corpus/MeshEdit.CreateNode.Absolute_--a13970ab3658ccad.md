# MeshEdit.CreateNode.Absolute()

MeshEdit.CreateNode.Absolute()

説明​

直接の座標値を入力して、節点を作成します。

構文​

MeshEdit.CreateNode.Absolute(...)

マクロ: CreateNode

リボン: MeshEdit » CreateNode » Absolute

入力​

dlCoordinate​

節点の座標を指定する Double 型のリスト

デフォルト値は[]です。

iNewNodeID​

新しい節点のIDを指定する Integer の値

デフォルト値は最大節点ID + 1です。

戻り値​

作成された浮動節点を指定する Cursor

サンプルコード​

# 絶対節点の作成
newNode = MeshEdit.CreateNode.Absolute(dlCoordinate=[0.01, 0.0, 0.0], iNewNodeID=489)
JPT.Debugger(newNode) # 戻り値を確認するため
