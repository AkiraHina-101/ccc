# CloseHoleEdgeFace()

CloseHoleEdgeFace()

説明​

ACM_CloseHole_EdgeFace

構文​

CloseHoleEdgeFace(cursor[] crBody, cursor[] crFace, cursor[] crEdge, bool bSelBelPart,
    bool SpecPart, bool bNewPart, string strName, bool bRemesh, double dElemSize)

入力​

1. Cursor[]​

対象 パートのカーソル（[3: パートID]）

2. Cursor[]​

対象フェースのカーソル（[6:フェースID]）

3. Cursor[]​

対象エッジのカーソル（[5:エッジID]）

4. Bool​

属する部分を選択するためのブールフラグ True = 1、False = 0

5. Bool​

指定された部分を示すためのブールフラグ True = 1、False = 0

6. Bool​

新規部分を示すためのブールフラグ True = 1、False = 0

7. String​

新規部分の名前

8. Bool​

リメッシュを示すブールフラグ True = 1、False = 0

9. Double​

要素サイズ

戻り値​

"1": 関数は実行可能です

"0": 関数を実行できません

サンプルコード​

CloseHoleEdgeFace([], [6:62], [5:10000157], 0, 0, 0, "", 1, 0.008)
