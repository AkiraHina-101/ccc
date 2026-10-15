# MainWindow.RightClick.FlipElement()

MainWindow.RightClick.FlipElement()

説明​

表面（フェースまたは要素）の法線を反転します。

構文​

MainWindow.RightClick.FlipElement(...)

リボン: MainWindow » RightClick » FlipElement

入力​

crlTargets​

ターゲットを指定する Cursor のリストです。

これは必須の入力です。

戻り値​

成功した場合は1の文字列、失敗した場合は0です。

サンプルコード​

Geometry.Part.Cube()
MainWindow.RightClick.FlipElement(crlTargets=[Face(21, 23, 26)])
MainWindow.RightClick.FlipElement(crlTargets=[Elem(1009, 1025, 968)])
