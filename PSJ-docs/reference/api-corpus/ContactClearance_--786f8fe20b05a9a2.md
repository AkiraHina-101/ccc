# ContactClearance()

ContactClearance()

説明​

接点クリアランスを作成します

構文​

ContactClearance(string strName, double dClearanceVal, int iLocalUnit,
    int iSolverType, cursor[] taTarget, cursor crEdit)

入力​

1. String​

構造名

2. Double​

クリアランス値

3. Int​

入力単位

0: ミリメートル

1: メートル

2: フィート

3: インチ

4: センチメートル

4. Int​

ソルバータイプ

5. Cursor[]​

ターゲットエンティティのカーソル

6. Cursor​

編集カーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ContactClearance("ContactClearance1", 0.002, 0, 0, [10:452, 6:26], 0:0)
