# MeshEdit.CreateNode.Point()

MeshEdit.CreateNode.Point()

説明​

任意の点の座標値を参照して、節点を作成します。

構文​

MeshEdit.CreateNode.Point(...)

マクロ: MeshEditCreateNodePoint

リボン: MeshEdit » CreateNode » Point

入力​

iNewNodeID​

新しい節点のIDを指定する Integer です。

デフォルト値は最大節点ID + 1 です。

posPoint​

指定された点の座標を指定する Double 型のリストです。

デフォルト値は [0,0,0] です。

bImprint​

フェースに節点を印刷するかどうかを指定する Boolean 型 です。

デフォルト値は True です。

crTarget​

節点を作成する対象を指定する Cursor です。対象はフェースまたはエッジです。

デフォルト値は指定されていません。

戻り値​

作成されたフローティングまたは印刷された節点を指定する Cursor です。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()

# 点に節点を作成
newNode = MeshEdit.CreateNode.Point(iNewNodeID=490, 
                                    posPoint=[0.008331683464348316, 0.003326606005430222, 0.009999999776482582], 
                                    bImprint=False, crTarget=Face(26))
JPT.Debugger(newNode) # 戻り値を確認するため
