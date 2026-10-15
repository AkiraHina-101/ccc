# JPT.GetScreenPositionOfEntities()

JPT.GetScreenPositionOfEntities()

説明​

メインウィンドウ内の指定されたアイテムの位置を画面座標系[min_x, min_y, max_x, max_y]で取得します。

構文​

JPT.GetScreenPositionOfEntities(...)

入力​

DItemVector​

メインウィンドウ上の位置を取得するアイテムを表す DItemVector オブジェクトです。

この入力は必須です。

戻り値​

領域の左上と右下の座標を表す [int] のリストです。メインウィンドウにアイテムが見つからない場合、空のリストを返します。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=13290083)
Geometry.Part.Cube(dlOrigin=[0.012, 0.0, 0.0], strName="Cube_2", iPartColor=6149981)
JPT.ViewFitToModel()

# メインウィンドウ内のパートの画面位置を確認します。
ditem_list=JPT.GetAllByTypeID(JPT.DItemType.BODY)
pos=JPT.GetScreenPositionOfEntities(ditem_list)
JPT.Debugger(pos)
