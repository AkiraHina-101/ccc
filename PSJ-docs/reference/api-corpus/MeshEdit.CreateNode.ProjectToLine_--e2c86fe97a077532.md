# MeshEdit.CreateNode.ProjectToLine()

MeshEdit.CreateNode.ProjectToLine()

説明​

3つ目に選択された節点/フローティング節点を、2つ前に選択された節点/フローティング節点の最短距離に射影して、節点を作成します。

構文​

MeshEdit.CreateNode.ProjectToLine(crlTa)

マクロ: CreateNodeProjectToLine

リボン: MeshEdit » CreateNode » ProjectToLine

入力​

crlNodes​

選択された節点を指定する Cursor のリスト。

これは必須の入力です。

戻り値​

作成されたフローティング節点を指定する Cursor 。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()

# ラインを射影した節点を作成
newNode = MeshEdit.CreateNode.ProjectToLine(crlNodes=[Node(7, 8, 76)])
JPT.Debugger(newNode) # 戻り値を確認するため
