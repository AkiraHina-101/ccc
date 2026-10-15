# MainWindow.RightClick.SetPartAppearance()

MainWindow.RightClick.SetPartAppearance()

説明​

選択したパートの外観を設定します。

構文​

MainWindow.RightClick.SetPartAppearance(...)

マクロ: SetPartAppearance

リボン: MainWindow » RightClick » SetPartAppearance

入力​

crlParts​

指定する Cursor のリスト

この入力は必須です。

strType​

外観の対象を指定する String

"Surface"

"Mesh"

"Edge"

"Node"

この入力は必須です。

bShow​

表示または非表示を指定する Boolean 型

デフォルト値は True (表示) です。

戻り値​

成功した場合は 1 の文字列、失敗した場合は 0 の文字列。

サンプルコード​

# モデルの準備
JPT.Exec('ViewShowMesh(1)')
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=7697908)

MainWindow.RightClick.SetPartAppearance(crlParts=[Part(1)], strType="Surface", bShow=False)
MainWindow.RightClick.SetPartAppearance(crlParts=[Part(2)], strType="Edge", bShow=False)
MainWindow.RightClick.SetPartAppearance(crlParts=[Part(3)], strType="Mesh", bShow=False)
MainWindow.RightClick.SetPartAppearance(crlParts=[Part(4)], strType="Node", bShow=False)
MainWindow.RightClick.SetPartAppearance(crlParts=[Part(4)], strType="Surface", bShow=False)
MainWindow.RightClick.SetPartAppearance(crlParts=[Part(4)], strType="Mesh", bShow=False)

JPT.ViewFitToModel()
