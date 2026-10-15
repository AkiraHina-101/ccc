# Pressure2Nodes()

Pressure2Nodes()

説明​

Pressure 2 節点を作成します。

構文​

Pressure2Nodes(string strName, cursor crNodeA, double dPressureA, int iNodeAUnit,
    cursor crNodeB, double dPressureB, int iNodeBUnit, cursor[] taTarget, cursor crEdit)

入力​

1. String​

Pressure 2 節点の名前

2. Cursor​

節点Aのキーカーソル（10: 節点ID）

3. Double​

Pressure A の値

4. Int​

節点Aのユニットタイプ

5. Cursor​

節点Bのキーカーソル（10: 節点ID）

6. Double​

Pressure B の値

7. Int​

節点Bのユニットタイプ

8. Cursor[]​

対象エンティティのカーソル

9. Cursor​

編集カーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Pressure2Nodes("PressureLinear1", 10:351, 2000, 0, 10:350, 4000, 0, 2, [6:5, 11:553, 11:554, 10:351, 10:350], 0:0)
