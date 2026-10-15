# JPT.ConvertCoordinateFromGlobalToLocal()

JPT.ConvertCoordinateFromGlobalToLocal()

説明​

選択されたDItem Typeのグローバル座標を指定されたローカル座標に変換します。

構文​

JPT.ConvertCoordinateFromGlobalToLocal(DItemType, itemID, DCoord)

入力​

DItemType​

_Enum_で、JupiterのBODY、FACE、ELEMENT、EDGE、またはNODEエンティティの DItemType を指定します。

これは必須の入力です。

itemID​

ターゲットエンティティのIDを指定する Integer です。

これは必須の入力です。

DCoord​

コンバートに使用する座標系を指定する DCoord オブジェクトです。

これは必須の入力です。

戻り値​

コンバートされた座標系に基づくターゲットエンティティの情報を指定する DItemPair オブジェクト。

firstDItem はターゲットエンティティのNode IDを指定する _integer_型です。

secondDItem はコンバートされた座標系に応じた対応する節点の座標を指定する TVector3d オブジェクトです。

サンプルコード​

# モデルとローカル座標の準備
Geometry.Part.Cube()
JPT.ViewFitToModel()
Tools.Coordinates.ThreeNode(crlNodes=[Node(488, 96, 88)])

# すべてのローカル座標を取得
# そして、指定されたDItemType.NODEのグローバル座標を選択したローカル座標に変換します
listCoords = JPT.GetAllCoordinates()
convertCoord = JPT.ConvertCoordinateFromGlobalToLocal(JPT.DItemType.NODE, 8, listCoords[0])

# コンバートされた座標系に基づくDItem.NODEオブジェクトのNode IDと座標を取得
JPT.Debugger(convertCoord[0].first)
JPT.Debugger(convertCoord[0].second)
