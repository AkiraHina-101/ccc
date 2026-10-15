# ViewSelectMethod()

ViewSelectMethod()

説明​

選択フィルターを変更します。

構文​

ViewSelectMethod(int FilterType, int Option)

入力​

1. Int​

FilterType: 選択フィルターの種類。

0: なし

1: パート

2: バーパート

3: フェース

4: エッジ

5: 頂点

6: ソリッド要素

7: 2D要素

8: 1D要素

9: 要素エッジ

10: 節点

11: LBC

12: 座標

13: グループ

15: フェースポイント

16: エッジポイント

30: Tet4

31: Tet10

32: Hex8

33: Hex20

34: Penta6

35: Penta15

36: Pyramid5

38: Tri3

39: Tri6

40: Quad4

41: Quad8

2. Int​

Optionは、FilterType:10 のときにのみ機能します。

0: （オプション無しと同じ。節点フィルターのみを有効にします。）

1: 中間節点フィルターも有効にします。

戻り値​

"1": 関数を実行できます。

"0": 関数を実行できません。

サンプルコード​

ViewSelectMethod(1)
