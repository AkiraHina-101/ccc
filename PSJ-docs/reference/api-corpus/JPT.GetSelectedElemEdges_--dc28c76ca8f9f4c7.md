# JPT.GetSelectedElemEdges()

JPT.GetSelectedElemEdges()

説明​

選択した要素のエッジのすべての情報を取得します。

構文​

JPT.GetSelectedElemEdges()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

選択した要素のエッジの情報を含む DItemPairVector オブジェクトまたは DItem フォーマットの DItemPair オブジェクトのリスト。

サンプルコード​

# 選択した要素のエッジ情報を取得します。
# この関数は、DItem形式の要素エッジの情報を格納したDItemPairオブジェクトまたはDItemPairVetorオブジェクトのリストを返します。
# 要素エッジは実際のエンティティではなく、2つの節点の接続によって定義されています。

listSelElemEdges = JPT.GetSelectedElemEdges()
for i in listSelElemEdges:
    print ('第1節点: {}'.format(i.firstDItem.id))
    print ('第2節点: {}'.format(i.secondDItem.id))
