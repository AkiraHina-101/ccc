# SurfaceLoads()

SurfaceLoads()

説明​

表面荷重を作成します。

構文​

SurfaceLoads(string strName, cursor[] crPressure, int arrowDir, cursor coordinate, cursor[] taTarget, cursor crEdit)

入力​

1. String​

表面荷重名

2. Cursor[]​

力 R、θ、Z カーソル

3. Int​

矢印の方向

0: 節点で始まる

1: 節点で終わる

4. Cursor​

テーブルフィールドデータカーソル(81:FieldData ID)

5. Cursor[]​

対象エンティティのカーソル

6. Cursor​

編集中のカーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

SurfaceLoads("SurfaceLoads3", [1, 2, 3], 1, 27:1, [6:5, 11:771, 11:772], 0:0)
