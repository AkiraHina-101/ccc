# Home.ImportMesh.Universal()

Home.ImportMesh.Universal()

説明​

Jupiterデータベース（Mesh、境界条件など）にUniversalファイル（*.unv）をインポートします。

構文​

Home.ImportMesh.Universal(...)

マクロ：ImportUnv, ImportUniversalMesh

リボン：Home » ImportMesh » Universal

入力​

strlPaths​

インポートに使用されるUniversalファイル（*.unvファイル）のリストを指定する String のリストです。

この入力は必須です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean です：

True：Universalファイル（*.unvファイル）が正常にインポートされました。

False：Universalファイル（*.unvファイル）をインポートできません。

サンプルコード​

from os import environ

unv_file_path = environ["Temp"] + "/TechnoStar/Exported_Universal_File_EXPORT_unv.bdf"

Geometry.Part.Cube(ilAxialNodes=[3, 3, 3])
Meshing.SolidMeshing(crlParts=[Part(1)], bTet10=True, 
                    dGradingFactor=1.0, 
                    dStretchLimit=0.1, 
                    iSpeedVsQual=1, 
                    bSafeMode=False, 
                    iParallel=8, 
                    bInternalMeshOnly=False, 
                    iPartColor=65280)

Home.EXPORT_UNIVERSAL(strFileName=unv_file_path, crlParts=[Part(1)])

JPT.CreateNewDocument()

import_status = Home.ImportMesh.Universal(strlPaths=[unv_file_path])

JPT.Debugger(import_status)
