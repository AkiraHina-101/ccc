# Pretension()

Pretension()

説明​

プリテンションを作成します。

構文​

Pretension(string strName, int iDir, double dValue, bool bFixLength, cursor crTable,
    cursor crCoord, int iLocalUnit, cursor[] taFace, cursor crEdit, bool bIfCreate2ADVCStatic)

入力​

1. String​

プリテンションの名前

2. Int​

プリテンションの方向

0: UX

1: UY

2: UZ

3. Double​

プリテンションの力の値

4. Bool​

ボルトの固定長フラグ True = 1、False = 0

5. Cursor​

テーブルのカーソル

6. Cursor​

ローカル座標を使用するかどうか True = 27:*、False = 0:0

7. Int​

単位のインデックス

8. Cursor[]​

対象フェースのカーソル（[6:Face ID]）

9. Cursor​

編集用カーソル

10. Bool​

2つの ADVC Static を作成するかどうかのフラグ True = 1、False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Pretension("BoltLoad007", 2, 0.05, 1, 0:0, 27:1, 0, [6:180, 6:178], 0:0, 0)
