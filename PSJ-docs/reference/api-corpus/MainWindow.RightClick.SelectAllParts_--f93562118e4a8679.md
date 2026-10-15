# MainWindow.RightClick.SelectAllParts()

MainWindow.RightClick.SelectAllParts()

説明​

現在のドキュメント内のすべてのパートを選択します

構文​

MainWindow.RightClick.SelectAllParts(...)

マクロ: ViewSelectAllParts

リボン: MainWindow » RightClick » SelectAllParts

入力​

この機能には入力値は必要ありません。

戻り値​

選択したパートを指定する Cursor のリストです。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=7697908)
JPT.Exec("View Fit To Model()")

# すべてのパートを選択
listParts = MainWindow.RightClick.SelectAllParts()
print(listParts)
