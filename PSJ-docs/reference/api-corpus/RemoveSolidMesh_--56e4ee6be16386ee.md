# RemoveSolidMesh()

RemoveSolidMesh()

説明​

ソリッドメッシュを削除します。

構文​

RemoveSolidMesh(カーソル[] taBody, 真偽値 bConvToFirst)

入力​

1. Cursor[]​

対象 パートのカーソル([3:Part ID])

2. Bool​

ファーストオーダーに変換する真偽フラグ True = 1, False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

RemoveSolidMesh([3:1], 0)
