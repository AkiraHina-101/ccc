# ViewSelectByAttached()

ViewSelectByAttached()

説明​

コンテキストメニューによって、非表示ターゲットを反転させます。

構文​

ViewSelectByAttached(int TargetType, cursor[] Targets)

入力​

1. Int​

選択するターゲットタイプを指定する整数です。

2. Cursor[]​

アタッチされたものを選択するためのターゲットを指定する Cursor のリストです。

戻り値​

選択された部分（フェースまたは2D要素）を指定する Cursor リストです。

サンプルコード​

ViewSelectByAttached(3,[])
