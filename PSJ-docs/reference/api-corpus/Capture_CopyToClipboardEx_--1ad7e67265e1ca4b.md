# Capture_CopyToClipboardEx()

Capture_CopyToClipboardEx()

説明​

メインウィンドウの画像をクリップボードにコピーします。

構文​

Capture_CopyToClipboardEx(bool WhiteBG, bool TransparentBG, bool FixedSize, int exportWidth, int exportHeight, bool bAutoCapture, int[] listAdjust)

入力​

1. Bool​

ホワイトバックグラウンドの bool フラグ true = 1、false = 0

2. Bool​

透明バックグラウンドのフラグ true = 1、false = 0

3. Bool​

固定サイズのフラグ true = 1、false = 0

4. Int​

エクスポート幅

5. Int​

エクスポート高さ

6. Bool​

表示されるエンティティ範囲に画像をクロップするかどうかを指定します。

7. int[]​

最小化された領域からの左上右下のマージンを指定します。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Capture_CopyToClipboardEx(0, 0, 0, 1200, 900, 0, [0, 0, 0, 0])
