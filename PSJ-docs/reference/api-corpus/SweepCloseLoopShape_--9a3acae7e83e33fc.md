# SweepCloseLoopShape()

SweepCloseLoopShape()

説明​

カーブスイープによるヘックスメッシュを作成します。

構文​

SweepCloseLoopShape(cursor crFace, cursor[] vcrEdges, cursor[] vcrRefEdges, double dMeshSize)

入力​

1. Cursor​

対象のフェースカーソル（6：フェースID）

2. Cursor[]​

対象のエッジカーソル（[5：エッジID]）

3. Cursor[]​

参照エッジのカーソル（[14：RefEdge ID]）

4. Double​

メッシュサイズの値

戻り値コード​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

SweepCloseLoopShape(6:6, [5:3, 5:1, 5:2], [], 0.0001)
