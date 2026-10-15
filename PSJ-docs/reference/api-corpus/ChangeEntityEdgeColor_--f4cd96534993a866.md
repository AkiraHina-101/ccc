# ChangeEntityEdgeColor()

ChangeEntityEdgeColor()

説明​

選択したエンティティのエッジの色を変更します。

構文​

ChangeEntityEdgeColor(Cursor[] crParts, COLORREF col, bool bRandom)

入力​

1. Cursor[]​

パートのリストです。

2. color​

設定する色を指定します。

2. bool​

ランダムな色のフラグ

"1": エッジの色がランダムで設定されます。

"0": 指定された色でエッジの色が設定されます。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ChangeEntityEdgeColor([3:1], 16711746, 0)
