# RBarOneToOne()

RBarOneToOne()

説明​

1対1のRBAR（剛体要素）接続を作成します。

構文​

RBarOneToOne(string strName, cursor[] taMasterTarget, cursor[] taSlaveTarget, int iMethod, int ulDofs, double dTol,
            cursor crCoord, bool bUpdateDispCS, cursor crEdit)

入力​

1. String​

RBAR名

2. Cursor[]​

ターゲットマスターエンティティカーソル

3. Cursor[]​

ターゲットスレイブエンティティカーソル

4. Int​

Rbe2メソッド作成

17：1対1

5. Int​

参照DOF属性

6. 浮動小数​

検索エリアの許容差

7. Cursor​

ローカル座標を使用するかどうか：True = 27:*、False = 0:0

8. Bool​

変位座標系を更新します。真偽フラグ：True = 1、False = 0

9. Cursor​

編集カーソル

戻り値​

"1"：関数が実行可能です

"0"：関数を実行できません

サンプルコード​

RBarOneToOne("RBar_1", [10:957], [10:179], 17, 63, 0, 0:0, 1, 0:0)
