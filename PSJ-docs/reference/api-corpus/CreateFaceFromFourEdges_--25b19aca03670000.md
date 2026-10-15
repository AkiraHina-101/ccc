# CreateFaceFromFourEdges()

CreateFaceFromFourEdges()

説明​

4つのエッジからフェースを作成します。

構文​

CreateFaceFromFourEdges(cursor[] vcrEdges)

入力​

1. Cursor[]​

対象エッジのカーソル（[5:エッジID]）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateFaceFromFourEdges([5:35, 5:38, 5:37, 5:32])
