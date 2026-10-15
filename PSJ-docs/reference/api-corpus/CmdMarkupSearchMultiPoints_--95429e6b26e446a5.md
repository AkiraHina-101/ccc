# CmdMarkupSearchMultiPoints()

CmdMarkupSearchMultiPoints()

説明​

位置を検索し、その位置にノートを配置します。

構文​

CmdMarkupSearchMultiPoints(vector[] positions, float dTolerance, bool bVisible)

入力​

1. vector[]​

検索位置のリスト [x、y、z]。

2. double​

満足する要素を検索する許容度を指定する Double です。この引数は、入力位置に最も近い要素を見つけるのに役立ちます。

3. bool​

検索モードを指定する Boolean です。

True: 画面に表示されている要素のみを検索します

False: 非表示の要素を検索できます

戻り値​

1. bool[]​

成功（1）または失敗（0）のリスト。

サンプルコード​

CmdMarkupSearchMultiPoints([[15.459201、15.559538、7.877257]、[101.999998、30.057640、10.221649]、[-0.827893、23.017937、9.930871]、[66.764768、24.950984、7.866127]]、0.010000、0)
>> [1、1、0、1]
