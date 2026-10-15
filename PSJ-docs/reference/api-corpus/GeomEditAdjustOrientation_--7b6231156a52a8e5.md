# GeomEditAdjustOrientation()

GeomEditAdjustOrientation()

説明​

向きの調整

構文​

GeomEditAdjustOrientation(cursor[] taBody, cursor[] taFace, cursor[] taElem)

入力​

1. Cursor[]​

ターゲット パートのカーソル（[3:パートID]）

2. Cursor[]​

ターゲットフェースのカーソル（[6:フェースID]）

3. Cursor[]​

ターゲット要素のカーソル（[11:要素ID]）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

GeomEditAdjustOrientation([], [6:40], [11:182])
