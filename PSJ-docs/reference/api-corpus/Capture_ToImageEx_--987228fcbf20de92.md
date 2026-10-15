# Capture_ToImageEx()

Capture_ToImageEx()

説明​

画像ファイルにキャプチャします。

構文​

Capture_ToImageEx(string strNamePath, bool WhiteBG, bool TransparentBG,
    bool FixedSize, int exportWidth, int exportHeight, bool bAutoCapture, int[] listAdjust)

入力​

1. String​

インポートファイルパス

2. Bool​

白背景ブールフラグがtrueの場合は1、falseの場合は0

3. Bool​

透明背景フラグがtrueの場合は1、falseの場合は0

4. Bool​

サイズ固定フラグがtrueの場合は1、falseの場合は0

5. Int​

エクスポート幅

6. Int​

エクスポート高さ

7. Bool​

表示されるエンティティ範囲に画像を切り取るかどうかを指定します。

8. Int[]​

最小化されたエリアからの左、上、右、下のマージンを指定します。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Capture_ToImageEx("D:/Test.jpg", 0, 0, 0, 1200, 900, 0, [0, 0, 0, 0])
