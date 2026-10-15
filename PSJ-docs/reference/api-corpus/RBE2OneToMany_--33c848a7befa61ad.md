# RBE2OneToMany()

RBE2OneToMany()

説明​

1対多のRBE2（剛体要素）接続を作成します。

構文​

RBE2OneToMany(int iMethod, cursor[] taMasterTarget, cursor[] taSlaveTarget, int eType, string strName,
    cursor crCoordSys, double dTol, int ulDofs, double[3] virtualNodePos, int iSurfaceDef,
    cursor crEdit, int iEnableUpdateDispCS, int iEnableCornerOnly, int iEnableCheckDuplicate, int iDuplicatedMode)

入力​

1. Int​

Rbe2メソッドの作成

16: 1対多

2. Cursor[]​

ターゲットマスターエンティティのカーソル

3. Cursor[]​

ターゲットスレーブエンティティのカーソル

4. Int​

Rbe2タイプの作成

RBE2タイプ = 2

5. String​

RBE2名

6. Cursor​

ローカル座標を使用するかどうか：True = 27:*, False = 0:0

7. Double​

検索エリアの許容差

8. Int​

参照DOF属性

9. Double[3]​

任意のエンティティの中心と円の中心周囲で使用されます

10. Int​

表面定義出力

0: 節点セットによる

1: 要素セットによる

11. Cursor​

編集カーソル

12. Int​

変位座標系の更新

13. Int​

角節点のみを有効にする

14. Int​

重複チェックを有効にする

15. Int​

重複モード

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

RBE2OneToMany(16, [10:947], [10:455, 10:470, 10:475], 2, "RBE2_1", 0:0, 0, 63, [0, 0, 0], 0, 0:0, 1, 0, 1, 0)
