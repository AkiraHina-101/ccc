# FixedConstraint()

FixedConstraint()

Description​

固定制約を作成します。

Syntax​

FixedConstraint(string name, int dof, Cursor crCoord, int functionType, int USETType,
    bool bAbqOpt,Cursor crTable, Cursor[] targets, Cursor crEdit)

Inputs​

1. String​

名前

2. Int​

dof

3. Cursor​

座標系

4. Int​

機能タイプ（0: 制約、1: サポート、2: USET）

5. Int​

USETタイプ（0: なし、1: U1、2: U2、3: U3、4: U4、5: U5、6: U6）

6. Bool​

固定Abaqusオプションブールフラグ True = 1、False = 0

7. Cursor​

テーブル

8. Cursor[]​

ターゲット

9. Cursor​

編集対象

Return Code​

"1": 関数を実行できます

"0": 関数を実行できません

Sample Code​

FixedConstraint("Constraint1", 7, 0:0, 0, 0, 0:0, [6:26], 0:0)
