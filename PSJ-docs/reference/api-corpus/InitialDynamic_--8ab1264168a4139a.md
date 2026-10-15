# InitialDynamic()

InitialDynamic()

説明​

初期条件を作成します。

構文​

InitialDynamic(string m_strName, int m_Type, double[] fVel, BOOL bSelNodeSet, Cursor crNodeSet,
    Cursor crTable, Cursor curCoord, Cursor[] m_taTarget, Cursor m_crEdit)

入力​

1. string​

条件名

2. Int​

条件タイプ[0-変位 1-速度 2-回転角度 3-角速度]

3. Double[]​

条件値

4. Bool​

選択された節点セット

5. Cursor​

選択された節点セットカーソル

6. Cursor​

選択されたテーブルカーソル

7. Cursor​

座標カーソル

8. Cursor[]​

選択されたエンティティ

9. Cursor​

編集モード

戻り値​

"1": 関数が実行可能です

"0": 関数を実行できません

サンプルコード​

InitialDynamic("InitialAngularVelocity1", 3, [1, 2, 3], 0, 0:0, 0:0, 0:0, [3:1], 0:0)
