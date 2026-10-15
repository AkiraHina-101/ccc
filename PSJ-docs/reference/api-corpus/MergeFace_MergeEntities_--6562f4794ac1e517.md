# MergeFace_MergeEntities()

MergeFace_MergeEntities()

説明​

フェースのマージ

構文​

MergeFace_MergeEntities(cursor[] taFace, bool bMergeEdge)

入力​

1. Cursor[]​

対象フェースのカーソル([6:Face ID])

2. Bool​

エッジをマージするかどうか True = 1, False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MergeFace_MergeEntities([6:22, 6:47], 1)
