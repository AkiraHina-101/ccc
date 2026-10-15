# JPT.GetRedoCount()

JPT.GetRedoCount()

説明​

実行可能な Redo の総数を取得します。

構文​

JPT.GetRedoCount()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

Redo 操作の数を指定する Integer です。

サンプルコード​

# モデルと Redo ステップを準備
Geometry.Part.Cube(strName="Cube_11", iPartColor=11842649)
Geometry.Part.Cube(strName="Cube_12", iPartColor=14968422)
Geometry.Part.Cube(strName="Cube_13", iPartColor=6250447)
Geometry.Part.Cube(strName="Cube_14", iPartColor=12734402)
Geometry.Part.Cube(strName="Cube_15", iPartColor=16579696)
Geometry.Part.Cube(strName="Cube_16", iPartColor=7666683)
Geometry.Part.Cube(strName="Cube_17", iPartColor=12867524)
Toolbar.Undo(iCntUndo=3)

# 利用可能な Redo の数を取得
iRedoSteps = JPT.GetRedoCount()
JPT.Debugger(iRedoSteps) # 値が 3 である整数オブジェクトを返します
