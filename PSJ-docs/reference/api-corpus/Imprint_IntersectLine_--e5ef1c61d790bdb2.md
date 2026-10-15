# Imprint_IntersectLine()

Imprint_IntersectLine()

説明​

印刷インターセクション ラインを作成します。

構文​

Imprint_IntersectLine(int[] FaceID, bool BreakFace, Cursor[] BodyCursor)

入力​

1. Int[]​

フェースID

2. Bool​

フラグ true = 1, false = 0

3. Cursor[]​

パートカーソル（[3:*]*= パートID）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Imprint_IntersectLine([26, 49], 1, [3:1, 3:2])
