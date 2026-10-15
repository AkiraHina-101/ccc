# MirrorBody()

MirrorBody()

説明​

パートをミラーリングします。

構文​

MirrorBody(cursor[] taBody, double[] scaleVector, double dOffset, bool bCreateNewBody,
    bool bCopyLBC, bool bCopyProperty, bool bRemoveDupFace, bool bMergeNode, double dTolerance)

入力​

1. Cursor[]​

ターゲットパートのカーソル（[3：パートID]）

2. Double[]​

ミラー平面の点（[xi、yi、zi]）

3. Double​

ミラーのオフセット値

4. Bool​

新しいパートを作成するかどうか（True = 1、False = 0）

5. Bool​

LBCをコピーするかどうか（True = 1、False = 0）

6. Bool​

プロパティ情報をコピーするかどうか（True = 1、False = 0）

7. Bool​

重複するフェースを削除するかどうか（True = 1、False = 0）

8. Bool​

同等の節点を作成するかどうか（True = 1、False = 0）

9. Double​

同等の節点の許容差値

戻り値​

"1"：関数を実行できます。

"0"：関数を実行できません。

サンプルコード​

MirrorBody([3:2], [[0, 0.004999999888241291, 0], [0.004999999888241291, 0.004999999888241291, 0],
    [0, 0, 0]], 0.002, 1, 0, 0, 0, 0, 1e-08)
