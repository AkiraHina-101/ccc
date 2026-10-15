# MainWindow.RightClick.InverseHideAll()

MainWindow.RightClick.InverseHideAll()

説明​

指定されたフェース以外のターゲットを非表示にします。（指定されたフェースのみ表示します）

構文​

MainWindow.RightClick.InverseHideAll(...)

マクロ：ViewInverseHideAll

リボン：MainWindow » RightClick » InverseHideAll

入力​

crlTargets​

表示するターゲットフェースを指定する Cursor のリスト。

デフォルト値は[]です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
JPT.ViewFitToModel()

# パート（1）を非表示にする
target = MainWindow.RightClick.InverseHideAll(crlTargets=[Face(26)])
JPT.Debugger(target)
