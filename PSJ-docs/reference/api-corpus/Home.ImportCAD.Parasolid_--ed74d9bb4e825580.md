# Home.ImportCAD.Parasolid()

Home.ImportCAD.Parasolid()

説明​

Jupiter データベースにパラソリッドファイル（*.x_t）をインポートします。

構文​

Home.ImportCAD.Parasolid(...)

リボン: Home » Import CAD » Parasolid

入力​

strlPaths​

インポートに使用するパラソリッドファイル（*.x_tファイル）のリストを指定する String のリストです。

これは必須の入力です。

dChordHeightTolerance​

実際の表面からファセット面までの最大距離を指定する Double です。コード高さが小さいほど、面の曲率がより正確に表現されます。

デフォルト値は 0.0 です。

dAngleToleranceDegree​

数に比べて半径が小さい曲線のテッセレーションに影響を与える角度許容度を指定する Double です。

デフォルト値は 7.0 です。

dSurfacePlaneTolerance​

元の表面をファセット面に変換する際の最大発散距離を指定する Double です。

デフォルト値は 0.0 です。

dSurfacePlaneAngle​

ジオメトリのファセット面の角度との角度よりも大きい設定角度を指定する Double です。

デフォルト値は 20.0 です。

dMaxFacetWidth​

1 つのファセットエッジの最大サイズを指定する Double です。

デフォルト値は 0.1 です。

dMinFacetWidth​

1 つのファセットエッジの最小サイズを指定する Double です。

デフォルト値は 0.0 です。

dScale​

ファイルの単位からドキュメントの単位への比率を指定する Double です。

デフォルト値は 0.001 です。

戻り値​

関数が正常に実行されたかどうかを示す Boolean です：

True: パラソリッドファイル（*.x_tファイル）が正常にインポートされます。

False: パラソリッドファイル（*.x_tファイル）をインポートできません。

サンプルコード​

imported_status = Home.ImportCAD.Parasolid(strlPaths=[JPT.GetProgramPath() +
                                                      "SampleData/CAD_Model/Parasolid/BWM_GRABCAD.x_t"],
                                           dAngleToleranceDegree=7.0,
                                           dScale=0.001)
JPT.Debugger(imported_status)
