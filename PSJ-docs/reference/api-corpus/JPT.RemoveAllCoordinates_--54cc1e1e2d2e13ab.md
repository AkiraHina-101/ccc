# JPT.RemoveAllCoordinates()

JPT.RemoveAllCoordinates()

説明​

すべての既存のローカル座標系を削除します。

構文​

JPT.RemoveAllCoordinates()

入力​

このユーティリティ機能には入力値は必要ありません。

戻り値​

このユーティリティ機能には出力値はありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Tools.Coordinates.ThreeNode(crlNodes=[Node(436, 452, 438)])
Tools.Coordinates.ThreeNode(strName="CRect2", crlNodes=[Node(7, 93, 86)])
Tools.Coordinates.ThreeNode(strName="CCyl1", iCoordType=1, crlNodes=[Node(22, 3, 31)])
Tools.Coordinates.ThreeNode(strName="CSph1", iCoordType=2, crlNodes=[Node(4, 26, 39)])

# 作成したすべての座標を削除
JPT.RemoveAllCoordinates()
