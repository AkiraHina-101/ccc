# DEmem

DEmem DElem Description 要素アイテムクラスです。 Properties typeID アイテムの種類のID(=11)です。DItemTypeです。 #EntityのItemTypeの整数値を取得、戻り値 int(DItemw::GetItemTypeInt) key アイテムの内部IDです。各TypeID内での一意のIDです。ユーザーによる変更は不可。 #Entityの内部Key取得、戻り値Id（int) id アイテムの外部IDです。各TypeID内で重複可能ですが、推奨はされません。一部のエンティティIDは、リナンバー機能で変更可能です。 #Entityの外部ID取得、戻り値Id（int) type アイテムの名称です。 #ElementのTypeを取得 、戻り値ELEM_TYPE kind 要素の種類（ElemKind型）です。 #Elementの種類を取得、0、1、2、3、戻り値ELEM_KIND nodes アイテムに含まれる節点（NodeVectorクラスの配列）です。 #Elementに設定されている、節点情報取得。戻り値DNodeW配列 color アイテムの色情報です。 #ElementのColor設定
