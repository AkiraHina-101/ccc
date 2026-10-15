# ACM_CloseHoleMultiEdgeFace()

ACM_CloseHoleMultiEdgeFace()

説明​

ACM_CloseHole_MultiEdgeFace

構文​

ACM_CloseHoleMultiEdgeFace(cursor[] FaceCursor, cursor[] EdgeCursor, bool bNewBody,
    string newBodyname, bool bRemesh, double dAvgMeshSize)

入力​

1. Cursor[]​

フェースリスト

2. Cursor[]​

エッジリスト

3. Bool​

新しい パートを作成

4. string​

新しい パート名

5. Bool​

リメッシュ

6. Double​

平均リメッシュサイズ

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CloseHoleMultiEdgeFace([6:13049, 6:13059], [5:290520], 1, "NewBody", 1, 0.008)
