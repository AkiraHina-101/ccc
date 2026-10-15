# Home.ImportCAD.VRML()

Home.ImportCAD.VRML()

説明​

Jupiter データベースに Virtual Reality Modeling Language ファイル（*.wrl）をインポートします。

構文​

Home.ImportCAD.VRML(...)

リボン: Home » ImportCAD » VRML

入力​

strlPaths​

インポートに使用される Virtual Reality Modeling Language ファイル（*.wrl ファイル）のリストを指定する String のリストです。

これは必須の入力です。

iVRMLColorGroups​

色情報を使用するオプションを指定する Integer です

0: 使用しない

1: 色情報を使用する

デフォルト値は 0 です。

dScale​

ファイルの単位からドキュメントの単位にインポートされる単位比率を指定する Double です。

デフォルト値は 1.0 です。

戻り値​

機能が正常に実行されたかどうかを指定する Boolean です：

True: Virtual Reality Modeling Language ファイル（*.wrl ファイル）が正常にインポートされました。

False: Virtual Reality Modeling Language ファイル（*.wrl ファイル）をインポートできませんでした。

サンプルコード​

imported_status = Home.ImportCAD.VRML(strlPaths=[JPT.GetProgramPath() +
                                                 "SampleData/CAD_Model/WRML/GrabCAD 2-SHIP.wrl"],
                                      iVRMLColorGroups=1,
                                      dScale=0.001)
JPT.Debugger(imported_status)
