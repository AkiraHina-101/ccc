# JPT.GetUndoCount()

JPT.GetUndoCount()

説明​

実行可能なアンドゥアクションの合計数を取得します。

構文​

JPT.GetUndoCount()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

アンドゥ操作の数を指定する Integer です。

サンプルコード​

# モデルとアンドゥ手順を準備します
Geometry.Part.Cube(strName="Cube_11", iPartColor=11842649)
Geometry.Part.Cube(strName="Cube_12", iPartColor=14968422)
Geometry.Part.Cube(strName="Cube_13", iPartColor=6250447)
Geometry.Part.Cube(strName="Cube_14", iPartColor=12734402)
Geometry.Part.Cube(strName="Cube_15", iPartColor=16579696)
Geometry.Part.Cube(strName="Cube_16", iPartColor=7666683)
Geometry.Part.Cube(strName="Cube_17", iPartColor=12867524)

# 利用可能なアンドゥの数を取得します
iUndoSteps = JPT.GetUndoCount()
JPT.Debugger(iUndoSteps) # 値が 7 の整数オブジェクトを返します
