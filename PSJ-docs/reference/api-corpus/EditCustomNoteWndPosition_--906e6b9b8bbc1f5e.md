# EditCustomNoteWndPosition()

EditCustomNoteWndPosition()

説明​

画面座標系で指定された位置にカスタムノートを移動します。
位置はノートの中心位置を指定します。

画面座標系は、主要ウィンドウの左上隅に原点（0,0）を持つ二次元座標で表されます。

構文​

EditCustomNoteWndPosition(cursor customNote, double x, double y)

入力​

1. cursor ​

移動するカスタムノートを指定します。

2. double ​

画面座標での x 座標を指定します。

3. bool ​

画面座標での y 座標を指定します。

戻り値​

なし。

サンプルコード​

EditCustomNoteWndPosition(270:1,100,200)
