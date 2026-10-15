# Prop3DGasket()

Prop3DGasket()

説明​

プロパティ3Dガスケットを作成します。

構文​

Prop3DGasket(string strName, color propertyColor, cursor crMaterial, double dThickX, double dThickY,
    double dThickZ, cursor taTarget, cursor crEdit, bool bUniAxial, int FLG)

入力​

1. String​

Prop3DGasket 名

2. Color​

プロパティの色。

3. Cursor​

材料カーソル（22：材料ID）

4. Double​

厚さのX方向

5. Double​

厚さのY方向

6. Double​

厚さのZ方向

7. Cursor​

対象エンティティのカーソル

8. Cursor​

編集カーソル

9. Bool​

ユニアクシャルブールフラグ True = 1、False = 0

10. イント​

FLG

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Prop3DGasket("ガスケットプロパティ1", 13642735, 22:6, 1, 2, 3, [3:1], 0:0, 1, 1)
