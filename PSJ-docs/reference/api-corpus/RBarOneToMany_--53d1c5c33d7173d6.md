# RBarOneToMany()

RBarOneToMany()

説明​

1対多のRBAR（剛性要素）接続を作成します。

構文​

RBarOneToMany(string strName, cursor[] taMasterTarget, cursor[] taSlaveTarget, int iMethod, int ulDofs, double dTol,
            cursor crCoord, bool bUpdateDispCS, cursor crEdit)

入力​

1. String​

RBAR名

2. Cursor[]​

ターゲットマスターエンティティのカーソル

3. Cursor[]​

ターゲットスレーブエンティティのカーソル

4. Int​

Rbe2メソッドの作成

16：1対多

5. Int​

参照DOF属性

6. Double​

検索エリアの許容値

7. Cursor​

ローカル座標を使用するかどうか：True = 27:*、False = 0:0

8. Bool​

変位座標系を更新するかどうか、ブール値：True = 1、False = 0

9. Cursor​

編集用カーソル

戻り値​

"1"：関数を実行できます

"0"：関数を実行できません

サンプルコード​

RBarOneToMany("RBar_1", [10:493], [10:6, 10:2, 10:3], 16, 63, 0, 0:0, 1, 0:0)
