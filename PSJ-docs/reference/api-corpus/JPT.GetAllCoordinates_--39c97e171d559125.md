# JPT.GetAllCoordinates()

JPT.GetAllCoordinates()

説明​

すべての既存の座標系の情報を取得します。

構文​

JPT.GetAllCoordinates()

入力​

このユーティリティ関数には入力値は不要です。

戻り値​

すべての既存の座標系の情報を含む CoordVector オブジェクトまたは List of DCoord オブジェクト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6118844)
Tools.Coordinates.ThreeNode(crlNodes=[Node(454, 461, 462)])
Tools.Coordinates.ThreeNode(strName="CRect2", crlNodes=[Node(428, 436, 430)])
Tools.Coordinates.ThreeNode(strName="CCyl1", iCoordType=1, crlNodes=[Node(457, 474, 473)])
Tools.Coordinates.ThreeNode(strName="CSph1", iCoordType=2, crlNodes=[Node(316, 340, 333)])
Tools.Coordinates.ThreeNode(strName="CSph2", iCoordType=2, iOrder=3, crlNodes=[Node(190, 216, 204)])
JPT.ViewFitToModel()

# すべての既存の座標系を取得
listDCoords = JPT.GetAllCoordinates()
JPT.Debugger(listDCoords)

# リスト内の各既存座標系の関連情報をすべて出力
for coord in listDCoords:
    JPT.Debugger(coord)
