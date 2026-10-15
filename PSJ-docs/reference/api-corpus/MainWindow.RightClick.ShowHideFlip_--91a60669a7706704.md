# MainWindow.RightClick.ShowHideFlip()

MainWindow.RightClick.ShowHideFlip()

説明​

現在のドキュメントで非表示になっているパートやフェースの表示を切り替えます。

構文​

MainWindow.RightClick.ShowHideFlip(...)

マクロ: ShowHideFlip

リボン: MainWindow » RightClick » ShowHideFlip

入力​

iType​

表示を切り替える対象のタイプを指定する Integer の値です。対象はパートまたはフェースです。

デフォルト値は0です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型の値です：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=7697908)
JPT.ViewFitToModel()

# パートの表示切り替え
flipPart = MainWindow.RightClick.ShowHideFlip(iType=0)
print(flipPart)
