# JPT.GetSuppressedParts()

JPT.GetSuppressedParts()

説明​

全ての抑制されたパートの情報を取得します。

構文​

JPT.GetSuppressedParts()

入力​

このユーティリティ関数は入力値を必要としません。

戻り値​

抑制されたパートの情報を含む BodyVector オブジェクトまたは List of DBody オブジェクトが返されます（アセンブリツリーで抑制されており、アクセスできないパート）。

サンプルコード​

# モデルを準備
Geometry.Part.Cube(iPartColor=7138156)
Geometry.Part.Cube(strName="Cube_2", iPartColor=5921475)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6678117)
Geometry.Part.Cube(strName="Cube_4", iPartColor=11908427)
Geometry.Part.Cube(strName="Cube_5", iPartColor=15429611)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7531634)
Geometry.Part.Cube(strName="Cube_7", iPartColor=12434775)
Assembly.RightClick.Suppress(crlParts=[Part(3, 5, 4)])
JPT.ViewFitToModel()

# 選択された全てのパートの情報を取得
listSuppressedParts = JPT.GetSuppressedParts()
JPT.Debugger(listSuppressedParts) # リストのサイズは3です
JPT.Debugger(listSuppressedParts[0]) #DBodyアイテム: Cube 3
