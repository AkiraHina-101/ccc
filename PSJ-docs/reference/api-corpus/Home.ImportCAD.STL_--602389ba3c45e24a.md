# Home.ImportCAD.STL()

Home.ImportCAD.STL()

説明​

Jupiter データベースに標準テッセレーション言語ファイル（*.stl）をインポートします。

構文​

Home.ImportCAD.STL(...)

リボン: Home » ImportCAD » STL

入力​

strlPath​

インポートに使用される標準テッセレーション言語ファイル（*.stl ファイル）のリストを指定する String のリストです。

これは必須入力です。

dScale​

インポートされるファイルの単位とドキュメントの単位の比率を指定する Double です。

デフォルト値は 0.001 です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean です:

True: 標準テッセレーション言語ファイル（*.stl ファイル）が正常にインポートされました。

False: 標準テッセレーション言語ファイル（*.stl ファイル）をインポートできませんでした。

サンプルコード​

imported_status = Home.ImportCAD.STL(strlPaths=[JPT.GetProgramPath() +
                                                "SampleData/CAD_Model/STL/Macbook Pro 15.stl"],
                                     dScale=0.001)
JPT.Debugger(imported_status)
