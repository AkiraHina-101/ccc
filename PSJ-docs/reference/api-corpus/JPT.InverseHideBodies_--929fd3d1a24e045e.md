# JPT.InverseHideBodies()

JPT.InverseHideBodies()

説明​

入力したIDの部分のみを表示します。

構文​

JPT.InverseHideBodies(partID)

入力​

partID​

Integer を指定し、表示される部分のIDです。

これは必須の入力です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(strName="Cube_11", iPartColor=11842649)
Geometry.Part.Cube(strName="Cube_12", iPartColor=14968422)
Geometry.Part.Cube(strName="Cube_13", iPartColor=6250447)
Geometry.Part.Cube(strName="Cube_14", iPartColor=12734402)
Geometry.Part.Cube(strName="Cube_15", iPartColor=16579696)

# ID = 3（Cube_13）の部分のみを表示
selAllParts = JPT.GetAllParts()
showPart = selAllParts[2].id
JPT.Debugger(selAllParts[2])
JPT.InverseHideBodies(showPart)
