# Imprint_OffsetLine()

Imprint_OffsetLine()

説明​

インプリントオフセットラインを作成します

構文​

Imprint_OffsetLine(int[] FaceID, int[] EdgeID, double Offset, bool Flag_Extend, bool BreakFace,Cursor[] BodyCursor)

入力​

1. Int[]​

フェースID

2. Int[]​

エッジID

3. Double​

オフセット値

4. Bool​

フラグ拡張 true = 1, false=0

5. Bool​

フラグブレーク true = 1, false=0

6. Cursor[]​

パートカーソル([3:*]*= パートID)

戻り値​

"1": 関数を実行できる

"0": 関数を実行できません

サンプルコード​

Imprint_OffsetLine([26], [18], 0.005, 1, 1, [3:1])
