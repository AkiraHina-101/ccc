# MeasureTotalLoad()

MeasureTotalLoad()

説明​

負荷を計測します。

構文​

MeasureTotalLoad(cursor[] target items, cursor coordinate, string target string, Integer N)

入力​

1. Cursor[]​

対象アイテムカーソル[]

2. Cursor​

座標カーソル

3. String​

出力対象文字列 X/Y/Z/合計/全体

4. Integer N​

小数点以下桁数を指定します（0<=N<=30）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeasureTotalLoad([],0:0,"ALL",6)
