# MeasureVolumeParts()

MeasureVolumeParts()

説明​

体積を計測します。

構文​

MeasureVolumeParts(cursor[] Part cursor,Integer N)

入力​

1. Cursor[]​

パートのカーソル（[3,*]、*=パートID）

2. Int N​

小数点以下の桁数を指定します（0<=N<=30）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeasureVolumeParts([3:1,3:2],6)
