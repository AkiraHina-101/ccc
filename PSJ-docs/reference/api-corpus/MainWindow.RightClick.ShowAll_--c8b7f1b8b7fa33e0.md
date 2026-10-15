# MainWindow.RightClick.ShowAll()

MainWindow.RightClick.ShowAll()

説明​

すべての非表示エンティティを表示します。

構文​

MainWindow.RightClick.ShowAll(...)

マクロ: ViewShowAll

リボン: MainWindow » RightClick » ShowAll

入力​

この機能には入力値は必要ありません。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型:

True: プロセスが正常に実行されました。

False: 機能を実行できません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=7697908)
JPT.ViewFitToModel()

# 一部を非表示にします
JPT.Exec("Show_Entity([3:2, 3:3], 0)")
# 再びすべてのパートを表示します
MainWindow.RightClick.ShowAll()
