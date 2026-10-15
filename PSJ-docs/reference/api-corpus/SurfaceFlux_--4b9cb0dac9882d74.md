# SurfaceFlux()

SurfaceFlux()

説明​

表面フラックスを作成します。

構文​

SurfaceFlux(string strName, double dFlux, int iDistributionMethod, cursor crTable, cursor[] taTarget, cursor crEdit)

入力​

1. String​

表面フラックスの名前

2. 二重数​

表面フラックスの値

3. Int​

入力単位タイプ*

0: MW/mm^2

1: W/m^2

2: MiuW/mm^2

3: kcal/mm^2*h

4: Lbf/ft*s

5: Lbf/in*s

4. Cursor​

テーブルフィールドデータカーソル（81:FieldData ID）

5. Cursor[]​

ターゲットエンティティのカーソル

6. Cursor​

編集用カーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

SurfaceFlux("SurfaceHeatFlux1", 1000, 1, 81:4, [6:3, 11:693], 0:0)
