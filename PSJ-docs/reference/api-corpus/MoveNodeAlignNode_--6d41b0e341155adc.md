# MoveNodeAlignNode()

MoveNodeAlignNode()

説明​

節点を節点から要素の平面に移動します。

構文​

MoveNodeAlignNode(int[] taRefNodeKeys, int[] taObjNodeKeys, int iType)

入力​

1. Int[]​

参照節点キー カーソル（節点ID）

2. Int[]​

オブジェクト節点キー カーソル（節点ID）

3. Int​

アライン節点を検索するタイプ

1: 最短経路上

2: 参照節点の方向に

3: 選択されたエンティティ上

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MoveNodeAlignNode([150, 140, 148], [141], 2)
