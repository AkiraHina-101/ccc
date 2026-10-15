# ACM_CloseHoleEdgeFace()

ACM_CloseHoleEdgeFace()

説明​

ACM_CloseHole_EdgeFace

構文​

ACM_CloseHoleEdgeFace(cursor[] FaceCursor, cursor[] EdgeCursor, bool bNewBody,
    string newBodyname, bool bRemesh, double dAvgMeshSize)

入力​

1. Cursor[]​

フェースリスト

2. Cursor[]​

エッジリスト

3. Bool​

新しいパートを作成

4. string​

新しいパート名

5. Bool​

リメッシュ

6. Double​

平均リメッシュサイズ

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CloseHoleEdgeFace([6:13049, 6:13059], [5:290520], 1, "NewBody", 1, 0.008)
