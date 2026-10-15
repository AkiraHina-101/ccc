# MeshEditExtractSurfaces()

MeshEditExtractSurfaces()

説明​

表面を抽出します

構文​

MeshEditExtractSurfaces(Cursor[] Face Cursor, double Angle, string New Body Name)

入力​

1. Cursor[]​

抽出対象のフェース

2. Double​

隣接するフェースの抽出角度

3. String​

抽出された パートの名前

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeshEditExtractSurfaces([6:22, 6:23, 6:26], 1.0472, "新しい パート")
