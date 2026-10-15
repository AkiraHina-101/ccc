# MeasureRadiusBy3Nodes()

MeasureRadiusBy3Nodes()

説明​

3つの節点で作成された角度を測定します。

構文​

MeasureRadiusBy3Nodes(カーソル節点1, カーソル節点2, カーソル節点3, 整数 N)

入力​

1. Cursor​

節点1のカーソル(10:,=節点ID)

2. Cursor​

節点2のカーソル(10:,=節点ID)

3. Cursor​

節点3のカーソル(10:,=節点ID)

4. Int N​

小数点以下の桁数を指定します（0<=N<=30）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeasureRadiusBy3Nodes(10:16, 10:2, 10:58, 6)
