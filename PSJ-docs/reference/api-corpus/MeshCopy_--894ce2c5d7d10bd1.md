# MeshCopy()

MeshCopy()

説明​

メッシュのコピー

構文​

MeshCopy(cursor[] taFace, cursor[] taNode)

入力​

1. Cursor[]​

ターゲットフェースカーソル([6:Face ID])

2. Cursor[]​

ターゲット節点カーソル([10:Node ID])

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeshCopy([6:58, 6:22], [10:500, 10:8])
