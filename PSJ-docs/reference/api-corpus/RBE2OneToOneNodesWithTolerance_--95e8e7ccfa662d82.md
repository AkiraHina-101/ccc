# RBE2OneToOneNodesWithTolerance()

RBE2OneToOneNodesWithTolerance()

説明​

許容節点を持つ1対1（RBE2（剛体要素）接続）を作成します。

構文​

RBE2OneToOneNodesWithTolerance(int iMethod, cursor[] taMasterTarget, cursor[] taSlaveTarget, int eType, string strName,
    cursor crCoordSys, double dTol, int ulDofs, double[3] virtualNodePos, int iSurfaceDef,
    cursor crEdit, int iEnableUpdateDispCS, int iEnableCornerOnly, int iEnableCheckDuplicate, int iDuplicatedMode)

入力​

1. Int​

RBE2メソッドの作成

21: 1対1（許容節点を持つ）

2. Cursor[]​

ターゲットマスターエンティティのカーソル

3. Cursor[]​

ターゲットスレーブエンティティのカーソル

4. Int​

RBE2タイプの作成

RBE2タイプ = 2

5. String​

RBE2の名前

6. Cursor​

ローカル座標を使用するかどうか：True = 27:*、False = 0:0

7. Double​

検索エリアの許容範囲

8. Int​

参照DOF属性

9. Double[3]​

任意のエンティティの中心や円の中心周囲に使用

10. Int​

表面定義の出力

0: 節点セットによる

1: 要素セットによる

11. Cursor​

編集カーソル

12. Int​

変位座標系を更新する

13. Int​

角の節点のみを有効にする

14. Int​

複製チェックを有効にする

15. Int​

複製モード

戻り値​

"1": 関数は実行可能です

"0": 関数は実行できません

サンプルコード​

RBE2OneToOneNodesWithTolerance(21, [10:934, 10:438], [10:934, 10:438], 2, "RBE2_2", 0:0, 0.025, 63, [0, 0, 0], 0, 0:0, 1, 0, 1, 0)
