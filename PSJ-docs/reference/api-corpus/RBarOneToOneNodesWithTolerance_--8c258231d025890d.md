# RBarOneToOneNodesWithTolerance()

RBarOneToOneNodesWithTolerance()

説明​

1対1（許容範囲を持つ節点）RBAR（剛性要素）接続を作成します

構文​

RBarOneToOneNodesWithTolerance(string strName, cursor[] taMasterTarget, cursor[] taSlaveTarget, int iMethod, int ulDofs, double dTol,
            cursor crCoord, bool bUpdateDispCS, cursor crEdit)

入力​

1. String​

RBARの名前

2. Cursor[]​

対象マスターエンティティのカーソル

3. Cursor[]​

対象スレーブエンティティのカーソル

4. Int​

RBE2メソッドの作成

21：1対1（許容範囲を持つ節点）

5. Int​

参照DOF属性

6. Double​

検索エリアの許容範囲

7. Cursor​

ローカル座標を使用するかどうか：True = 27:*、False = 0:0

8. Bool​

変位座標系を更新するかどうか、ブールフラグ：True = 1、False = 0

9. Cursor​

編集用カーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

RBarOneToOneNodesWithTolerance("RBar_1", [10:970, 10:356], [], 21, 63, 0.025, 0:0, 1, 0:0)
```  ​​​
