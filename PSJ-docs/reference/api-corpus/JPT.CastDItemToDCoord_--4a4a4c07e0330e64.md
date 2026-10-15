# JPT.CastDItemToDCoord()

JPT.CastDItemToDCoord()

説明​

選択した座標系の情報を取得するために、 DItem オブジェクトを DCoord オブジェクトに変換します。

構文​

JPT.CastDItemToDCoord(DItemオブジェクト)

入力​

DItemオブジェクト​

変換に使用される DItem オブジェクト。

これは必須の入力です。

戻り値​

関連する情報が含まれる DCoord オブジェクト（座標系）。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6118844)
Tools.Coordinates.ThreeNode(crlNodes=[Node(454, 461, 462)])
Tools.Coordinates.ThreeNode(strName="CRect2", crlNodes=[Node(428, 436, 430)])
Tools.Coordinates.ThreeNode(strName="CCyl1", iCoordType=1, crlNodes=[Node(457, 474, 473)])
Tools.Coordinates.ThreeNode(strName="CSph1", iCoordType=2, crlNodes=[Node(316, 340, 333)])
Tools.Coordinates.ThreeNode(strName="CSph2", iCoordType=2, iOrder=3, crlNodes=[Node(190, 216, 204)])
JPT.ViewFitToModel()

# 作成されたDItemオブジェクトのリストからDItemオブジェクトを取得
listDItemCoords = JPT.GetAllByTypeID(JPT.DItemType.COORD)
dItemCoord = listDItemCoords[0]
JPT.Debugger(dItemCoord)

# 上記のDItemオブジェクトからDCoordオブジェクトに変換
dCoord = JPT.CastDItemToDCoord(dItemCoord)
JPT.Debugger(dCoord)
