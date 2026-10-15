# JPT.MacroTCursorPairToDItemPair()

JPT.MacroTCursorPairToDItemPair()

説明​

カーソルペア（マクロ文字列タイプ）を DItem オブジェクトのペアに変換します。

構文​

JPT.MacroTCursorPairToDItemPair(cursorPair)

入力​

cursorPair​

マクロ文字列タイプを指定する String です。

この入力は必須です。

戻り値​

DItemPair オブジェクト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=7730934)
JPT.ViewFitToModel()

# 作成した2つのキューブのすべての情報を取得
dItemPair = JPT.Debugger(JPT.MacroTCursorPairToDItemPair("3:1-3:2"))
JPT.Debugger(dItemPair.firstDItem)
JPT.Debugger(dItemPair.secondDItem)
