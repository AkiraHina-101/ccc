# CloseHoleMultiEdgeFace()

CloseHoleMultiEdgeFace()

説明​

CloseHoleMultiEdgeFace

構文​

CloseHoleMultiEdgeFace(cursor[] crBody, cursor[] crFace, cursor[] crEdge, bool bSelBelPart,
    bool SpecPart, bool bNewPart, string strName, bool bRemesh, double dElemSize))

入力​

1. Cursor[]​

対象 パートのカーソル（[3：Body ID]）

2. Cursor[]​

対象フェースのカーソル（[6：Face ID]）

3. Cursor[]​

対象エッジのカーソル（[5：Edge ID]）

4. Bool​

所属部分を選択するブールフラグ True = 1、False = 0

5. Bool​

特定された部分を示すブールフラグ True = 1、False = 0

6. Bool​

新しい部分を示すブールフラグ True = 1、False = 0

7. String​

新しい部分の名前

8. Bool​

再メッシュを行うかどうかを示すブールフラグ True = 1、False = 0

9. Double​

要素サイズ

戻り値​

"1": 関数を実行できる

"0": 関数を実行できない

サンプルコード​

CloseHoleMultiEdgeFace([], [6:62], [5:10000162, 5:10000153], 0, 0, 0, "", 1, 0.008)
