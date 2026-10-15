# CmdMarkupSearchNodesFromMultiPoints()

CmdMarkupSearchNodesFromMultiPoints()

説明​

指定された位置に最も近い節点を検索し、節点に注釈を追加します。

構文​

CmdMarkupSearchNodesFromMultiPoints(vector[] positions)

入力​

1. vector[]​

検索位置[x,y,z]のリスト。

戻り値​

1. bool[]​

成功（1）または失敗（0）のリスト。

サンプルコード​

CmdMarkupSearchNodesFromMultiPoints([0.000000, 0.000000, 0.000000],[0.000000, 5.000000, 0.000000],[10.000000, 5.000000, 0.000000],[10.000000, 10.000000, 5.000000])
>> [1,1,1,1]
