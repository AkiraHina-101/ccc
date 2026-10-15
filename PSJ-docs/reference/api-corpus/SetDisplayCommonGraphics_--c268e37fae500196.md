# SetDisplayCommonGraphics()

SetDisplayCommonGraphics()

説明​

共通のグラフィックス表示を設定します。

構文​

SetDisplayCommonGraphics(int GraphicMode, int EnableLight, int DisplayFPS, int SynchronizeConnectedFloatingNodes)

入力​

1. int​

グラフィックモード

0: 要素シェーディング

1: スムーズシェーディング

2. int​

ライトを有効にする

0: OFF

1: ON

3. int​

FPSを表示

0: OFF

1: ON

4. int​

接続されたフローティング節点を同期する

0: ON

1: OFF

戻り値​

戻り値なし。

サンプルコード​

SetDisplayCommonGraphics(0, 0, 1, 1)
