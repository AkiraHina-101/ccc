# CmdMarkupSearchPoint()

CmdMarkupSearchPoint()

説明​

位置から要素を検索します。

構文​

CmdMarkupSearchPoint(実数 x, 実数 y, 実数 z, 実数 許容差, 真偽値 DisplayPartOnly)

入力​

1. 実数​

X 座標

2. 実数​

Y 座標

3. 実数​

Z 座標

4. 実数​

検索範囲の許容差。

5. Bool​

検索対象を表示されているパートのみに制限します。true = 1, false = 0

戻り値​

"1": 要素が見つかった場合。

"FALSE": 要素が見つからなかった場合。

サンプルコード​

CmdMarkupSearchPoint(29.300000, 27.000000, 7.186000, 0.010000, 0)
