# MergeNode()

MergeNode()

説明​

節点の統合

構文​

MergeNode(double dTol, int iMergeType, cursor[] vcrTarget, bool createGroup, bool equivalenceNode)

入力​

1. Double​

許容値

2. Int​

節点の統合タイプ

0: 最初のエンティティ

1: 2番目のエンティティ

2: 最大ID

3: 最小ID

3. Cursor[]​

対象エンティティのカーソル

4. Bool​

グループを作成するかのフラグ True = 1、False = 0

5. Bool​

等価節点を示すフラグ True = 1、False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MergeNode(0.001, 2, [3:1, 10:217, 11:471, 5:28, 6:18], 1, 1)
