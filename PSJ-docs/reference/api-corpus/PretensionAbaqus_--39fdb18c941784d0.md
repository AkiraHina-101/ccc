# PretensionAbaqus()

PretensionAbaqus()

説明​

Pretension Abaqusを作成します。

構文​

PretensionAbaqus(string strName, bool bFixedLength, cursor crTable, double dValue,
    int iLocalUnit, string stNormal, double[3] dNodePos, cursor crEdit, cursor[] taTarget)

入力​

1. String​

Pretension Abaqusの名前

2. Bool​

ボルト固定長真偽値フラグ True = 1、False = 0

3. Cursor​

テーブルカーソル

4. Double​

Pretension_1の力の値

5. Int​

入力単位

0: N

1: MN

2: kgf

3: Lbf

4: Tf

6. String​

法線

7. Double[3]​

制御節点の座標

8. Cursor​

編集カーソル

9. Cursor[]​

ターゲットエンティティのカーソル: フェース/1D要素

戻り値​

"1": 関数を実行できます。

"0": 関数を実行できません。

サンプルコード​

PretensionAbaqus("PreTensionAbaqus1", 1, 0:0, 100, 0, "1,0,0", [0.0083333, 0.015556, 0.025], 0:0, [6:180])
