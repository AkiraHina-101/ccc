# MainWindow.RightClick.SelectAll()

MainWindow.RightClick.SelectAll()

説明​

指定されたターゲットタイプに従って、すべてのフェースまたはシェル要素を選択します。

構文​

MainWindow.RightClick.SelectAll(...)

マクロ: ViewSelectAll

リボン: MainWindow » RightClick » SelectAll

入力​

iTargetType​

選択するターゲットタイプを指定する Integer の変数。ターゲットはフェースまたは2D要素のみです。

この入力は必須です。

戻り値​

選択されたターゲットを指定する Cursor のリスト。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
JPT.ViewFitToModel()

# すべてのフェースを選択
listFaces = MainWindow.RightClick.SelectAll(iTargetType=3)
print(listFaces)

# すべての2D要素を選択
listElems= MainWindow.RightClick.SelectAll(iTargetType=7)
print(listElems)
