# Imprint_ProjectionLine()

Imprint_ProjectionLine()

説明​

インプリントプロジェクションラインを作成します

構文​

Imprint_ProjectionLine(int[] EdgeID, int[] FaceID, bool BreakFace, Cursor[] BodyCursor)

入力​

1. int[]​

エッジID

2. int[]​

フェースID

3. bool​

フラッグ フェースを分割する 場合はtrue = 1、そうでない場合はfalse=0

4. Cursor[]​

パートーカーソル([3:*]*= パートーID)

戻り値​

"1": 関数が実行可能です

"0": 関数が実行できません

サンプルコード​

Imprint_ProjectionLine([35], [26], 1, [3:1, 3:2])
