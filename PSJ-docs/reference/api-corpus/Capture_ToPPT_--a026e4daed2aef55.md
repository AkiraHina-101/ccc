# Capture_ToPPT()

Capture_ToPPT()

説明​

Jupiterの表示ウィンドウをpptx形式の画像ファイルに保存します。

構文​

Capture_CopyToClipboardEx(bool bAutoCapture, int[] listAdjust)

入力​

1. Bool​

表示されるエンティティ範囲に画像をクロップするかどうかを指定します。

2. int[]​

最小化された領域から左、上、右、下のマージンを指定します。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Capture_ToPPT(0, [0,0,0,0])
