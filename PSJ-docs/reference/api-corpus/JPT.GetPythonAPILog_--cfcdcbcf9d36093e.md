# JPT.GetPythonAPILog()

JPT.GetPythonAPILog()

説明​

Python APIウィンドウに存在するテキストを取得します。

構文​

JPT.GetPythonAPILog()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

Python APIウィンドウに存在するすべてのテキストを含む String のデータです。

サンプルコード​

# Python APIログにすべてのテキストを書き込むモデルを準備します
Geometry.Part.Cube(strName="Cube_5", iPartColor=7463537)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7434735)
Geometry.Part.Cube(strName="Cube_7", iPartColor=14903267)
Geometry.Part.Cube(strName="Cube_8", iPartColor=15658599)
Geometry.Part.Cube(strName="Cube_9", iPartColor=7961077)
Geometry.Part.Cube(strName="Cube_10", iPartColor=7829501)
JPT.ViewFitToModel()

# Python APIウィンドウに表示されたテキストを取得します
log = JPT.GetPythonAPILog()
JPT.Debugger(log)
