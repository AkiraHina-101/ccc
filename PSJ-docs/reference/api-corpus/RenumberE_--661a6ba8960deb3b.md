# RenumberE()

RenumberE()

説明​

RenumberE

構文​

RenumberE(renumberItem[] Item, bool AssignProperty, bool SurfaceCornerFirst)

入力​

1. RenumberItem[]​

RenumberItemは以下のリストです:

Cursor Target

int Begin

int NodeOrElem

int Counter

int Increasement

int Order

int Method

Cursor CoordinateReference

int[] CoordinateOrder

int[] Offset

double[] CoordinateTolerance

int ConflictStrategy

int Solver

bool Enable

2. Bool​

プロパティ割り当てフラグ True = 1、False = 0

3. Bool​

サーフェスの隅を最初にするフラグ True = 1、False = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

RenumberE([(3:1, 1, 0, 7743, 0, 0, 0, 0:0, [0, 0, 0], [10000, 100, 1], [0.1, 0.1, 0.1], 0, 0, 1)], 1, 0)
