# CmdMarkupSearchElementsFromMultiPoints()

CmdMarkupSearchElementsFromMultiPoints()

説明​

指定された位置から最も近い要素を検索し、要素にノートを追加します。

構文​

CmdMarkupSearchElementsFromMultiPoints(vector[] positions)

入力​

1. vector[] ​

検索位置のリスト [x,y,z] です。

戻り値​

1. bool []​

成功（1）または失敗（0）のリストです。

サンプルコード​

CmdMarkupSearchElementsFromMultiPoints([0.000000, 0.000000, 0.000000],[0.000000, 5.000000, 0.000000],[10.000000, 5.000000, 0.000000],[10.000000, 10.000000, 5.000000])
>> [1,1,1,1]
