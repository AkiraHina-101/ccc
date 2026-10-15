# JPT.GetOutputLog()

JPT.GetOutputLog()

説明​

出力ウィンドウに存在するテキストを取得します。

構文​

JPT.GetOutputLog()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

出力ウィンドウに存在するすべてのテキストを含む String です。

サンプルコード​

# 出力ログにすべてのテキストを書き込むためにモデルを準備
Geometry.Part.Cube(strName="Cube_5", iPartColor=7463537)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7434735)
Geometry.Part.Cube(strName="Cube_7", iPartColor=14903267)
Geometry.Part.Cube(strName="Cube_8", iPartColor=15658599)
Geometry.Part.Cube(strName="Cube_9", iPartColor=7961077)
Geometry.Part.Cube(strName="Cube_10", iPartColor=7829501)
JPT.ViewFitToModel()

# 出力ウィンドウの印刷されたテキストを取得
log = JPT.GetOutputLog()
JPT.Debugger(log)
