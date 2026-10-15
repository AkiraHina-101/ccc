# CalculateMPCAtTime()

CalculateMPCAtTime()

説明​

モデル参加度要素ダイアログで特定の時間のMPC結果を表示します。

構文​

CalculateMPCAtTime(cursor crResponse, double dTime)

入力​

1. cursor​

MPCを計算する応答を指定するCursorです。

2. double​

MPCを計算する時間を指定するDoubleです。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CalculateMPCAtTime(0:0, 0.0)
