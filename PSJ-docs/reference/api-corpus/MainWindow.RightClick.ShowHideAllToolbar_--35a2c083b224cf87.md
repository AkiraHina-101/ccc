# MainWindow.RightClick.ShowHideAllToolbar()

MainWindow.RightClick.ShowHideAllToolbar()

説明​

メインウィンドウ上のツールバーを表示/非表示します。

構文​

MainWindow.RightClick.ShowHideAllToolbar(...)

マクロ：ShowHideAllToolbar

リボン：MainWindow » RightClick » ShowHideAllToolbar

入力​

iType​

ツールバータイプを指定する Integer ：

0: 選択ツールバー。

1: メインウィンドウツールバー。

デフォルト値は 0 です。

bShow​

ツールバーを表示/非表示にするかを指定する Boolean 型。

デフォルト値は True です。

戻り値​

プロセスが正常に実行されたかどうかを示す Boolean 型：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

MainWindow.RightClick.ShowHideAllToolbar(bShow=True)
