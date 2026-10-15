# Lbc_Bolt_Modeling_Type_D()

Lbc_Bolt_Modeling_Type_D()

説明​

Lbc TypeD ボルトを作成します。

構文​

Lbc_Bolt_Modeling_Type_D(cursor[] taEdgeTop, cursor[] taEdgeBot, string strMPCName, double dConnRadius, double dPlaneTol)

入力​

1. Cursor[]​

対象の上部エッジカーソル（[5:エッジID]）

2. Cursor[]​

対象の下部エッジカーソル（[5:エッジID]）

3. String​

MPC 名

4. Double​

接続半径

5. Double​

面許容値

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Lbc_Bolt_Modeling_Type_D([5:1], [5:7], "MPC", 5e-15, 2.42929e-08)
