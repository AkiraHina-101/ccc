# JPT.GetCenterOfEntities()

JPT.GetCenterOfEntities()

説明​

選択されたエンティティの中心座標を取得します。

構文​

JPT.GetCenterOfEntities(DItemVector)

入力​

DItemVector​

中心座標を取得するターゲットを指定する DItemVector オブジェクトまたは DItem オブジェクトのリストです。

この入力は必須です。

戻り値​

入力されたエンティティの中心の座標値[x、y、z]を含む DoubleVector オブジェクトまたは Double 値のリストです。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# 入力されたエンティティの中心座標を取得
listParts = JPT.GetAllByTypeID(3)
JPT.Debugger(JPT.GetCenterOfEntities(listParts))
