# DNode

DNode DNode Description 節点アイテムクラスです。 Properties 属性 説明 typeID アイテムの種類のID(=3)です。 #EntityのItemTypeの整数値を取得、戻り値 int(DItemw::GetItemTypeInt) key アイテムの内部IDです。各TypeID内での一意のIDです。ユーザーによる変更は不可。 #Entityの内部Key取得、戻り値Id（int) id アイテムの外部IDです。各TypeID内で重複可能ですが、推奨はされません。一部のエンティティIDは、リナンバー機能で変更可能です。 #Entityの外部ID取得、戻り値Id（int) isFloating 浮遊節点の場合、Trueを返します。 pos TVector3d型で節点の位置座標を保持します。
