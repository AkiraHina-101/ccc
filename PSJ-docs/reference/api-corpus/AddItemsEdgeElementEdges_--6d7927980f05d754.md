# AddItemsEdgeElementEdges()

AddItemsEdgeElementEdges()

説明​

要素エッジからエッジアイテムを追加します。

構文​

AddItemsEdgeElementEdges(elemEdge[] ElemEdge, bool BreakFace)

入力​

1. ElemEdge[]​

新しいエッジの作成対象となる要素エッジ

2. Bool​

フェースを分割するか。true = 1、false = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateEdgeByElemEdge([10:172-10:180, 10:180-10:188, 10:188-10:196], 1)
