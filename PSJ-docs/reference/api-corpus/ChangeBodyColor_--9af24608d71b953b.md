# ChangeBodyColor()

ChangeBodyColor()

説明​

選択した部分の色を変更します。

構文​

ChangeBodyColor([Cursor, color][] bool bResetFaceColor)

入力​

1. [Cursor, color][]​

パートとその色のペアのリストです。

2. bool​

フェースの色をリセットするかどうかを指定します。

"1": フェースの色をリセットします。

"0": フェースの色を維持します。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ChangeBodyColor([[3:1, 16777193]], 0)
