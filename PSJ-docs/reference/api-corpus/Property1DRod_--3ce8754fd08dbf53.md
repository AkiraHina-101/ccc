# Property1DRod()

Property1DRod()

説明​

1Dロッドプロパティ

構文​

Property1DRod(string strName, int ID, color propertyColor, cursor crSection, cursor DataMat,
    double dAreaVal, double dTorsConst, double dTorsStress, double dNonstMass,
    int dLocalLengthUnit, int iLocalMassUnit, cursor[] taTarget, cursor crEdit)

入力​

1. String​

1Dロッド名

2. Int​

1D ID入力

3. 色​

プロパティの色。

4. Cursor​

セクションカーソル（93：セクション一般 ID）

5. Cursor​

データ素材カーソル（22：素材 ID）

6. 浮動小数​

面積値

7. 浮動小数​

ねじれ定数値

8. 浮動小数​

ねじれ応力係数

9. 浮動小数​

非構造質量

10. Int​

入力長さ単位

0：mm

1：m

2：ft

3：in

4：cm

11. Int​

入力質量単位

1：空白

0：t

1：kg

2：kgf*s^2/mm

3：lbf*s^2/in

12. Cursor[]​

ターゲットエンティティカーソル

13. Cursor​

編集カーソル

戻り値​

"1"：機能を実行できます

"0"：機能を実行できません

サンプルコード​

Property1DRod("ROD10", 8, 10239814, 93:1, 22:6, 1e-05, 2e-12, 4, 3e+06, 0, 0, [5:53], 0:0)
