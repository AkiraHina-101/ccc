# MainWindow.RightClick.SelectReverse()

MainWindow.RightClick.SelectReverse()

説明​

表示中の パートの選択を反転します。

構文​

MainWindow.RightClick.SelectReverse(...)

マクロ：ViewSelectReverse

リボン：MainWindow » RightClick » SelectReverse

入力​

iTargetType​

選択したエンティティを逆に選択する対象タイプを指定する Integer です。対象はフェースまたは2D要素のみです。

これは必須の入力です。

crlTargets​

選択を反転する対象を指定する Cursor リストです。

デフォルト値は[]です。

戻り値​

選択したエンティティを反転した Cursor リストです。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
JPT.ViewFitToModel()

# フェース(26)から選択を反転
revertFaces = MainWindow.RightClick.SelectReverse(iTargetType=3, crlTargets=[Face(26)])
print(revertFaces)
