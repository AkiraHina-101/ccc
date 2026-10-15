# MainWindow.RightClick.InverseHide()

MainWindow.RightClick.InverseHide()

説明​

コンテキストメニューによる非表示ターゲットの反転

構文​

MainWindow.RightClick.InverseHide(...)

マクロ: ViewInverseHide

リボン: MainWindow » RightClick » InverseHide

入力​

crlTargets​

非表示を反転させる対象を指定する Cursor のリスト。 対象は Part または Face にすることができます。

デフォルト値は [] です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean :

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
JPT.ViewFitToModel()

# Part(1) を非表示に反転させる
target = MainWindow.RightClick.InverseHide(crlTargets=[Part(1)])
JPT.Debugger(target)
