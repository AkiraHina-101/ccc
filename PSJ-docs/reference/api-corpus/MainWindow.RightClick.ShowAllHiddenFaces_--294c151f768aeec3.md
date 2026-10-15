# MainWindow.RightClick.ShowAllHiddenFaces()

MainWindow.RightClick.ShowAllHiddenFaces()

説明​

表示されている パートのすべての非表示フェースを表示します

構文​

MainWindow.RightClick.ShowAllHiddenFaces(...)

マクロ：ViewShowAllHiddenFaces

リボン：MainWindow » RightClick » ShowAllHiddenFaces

入力​

この関数には入力値が必要ありません。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=7697908)
JPT.ViewFitToModel()

# 一部のフェースを非表示
JPT.Exec("Show_Entity([6:52, 6:78], 0)")

# すべての非表示フェースを表示
MainWindow.RightClick.ShowAllHiddenFaces()
