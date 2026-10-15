# Home.ImportMesh.LsDyna()

Home.ImportMesh.LsDyna()

説明​

Jupiter データベース（メッシュ、境界条件など）に LS-Dyna ファイル (*.k) をインポートします。

構文​

Home.ImportMesh.LsDyna(...)

マクロ: ImportLsDyna

リボン: Home » ImportMesh » LsDyna

入力​

strlPaths​

インポートに使用される LS-Dyna ファイル (*.k ファイル) のリストを指定する String のリスト です。

これは必須の入力です。

dFaceAngle​

フェース分割を決定するための角度許容度を指定する Double です（隣接要素間の角度が指定値より小さい場合にエッジを作成します）。

デフォルト値は 60.0 です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double です（隣接エッジ要素間の角度が指定値より大きい場合に頂点を作成します）。

デフォルト値は 60.0 です。

戻り値​

関数が正常に実行されたかどうかを示す Boolean です：

True: LS-Dyna ファイル (*.k ファイル) が正常にインポートされました。

False: LS-Dyna ファイル (*.k ファイル) をインポートできません。

サンプルコード​

from os import environ

lsdyna_file_path = environ["Temp"] + "/TechnoStar/Exported_LSDyna_File_EXPORT_K.k"

Geometry.Part.Cube()
Meshing.SolidMeshing(crlParts=[Part(1)],
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

BoundaryConditions.FixedConstraint(crlTargets=[Face(24)])
BoundaryConditions.Pressure.General(dPressure=5000000.0,
                                    crlTargets=[Face(23)])

Properties.Material.Add("Stainless_Steel",
                        [Density([(DENSITY, 7.75e-09)]),
                         Elastic([(YOUNGS_MODULUS, 193000.0),
                                  (POISSONS_RATIO, 0.31)])])
Properties.Solid(crlTargets=[Part(1)],
                 strName="Cube_for_testing",
                 iPropertyColor=16131973,
                 crMaterial=Material(1),
                 iCordM=-2,
                 dDynaRemeshVal1=DFLT_DBL,
                 dDynaRemeshVal2=DFLT_DBL,
                 dDispHG=DFLT_DBL,
                 iFLG=-1)

Analysis.LSDYNAJob()
Analysis.ExportLsdyna(strPath=lsdyna_file_path, 
                    crJob=LSDynaJob(1))

JPT.Exec('New Document()')
import_status = Home.ImportMesh.LSDyna(strlPaths=[lsdyna_file_path])
JPT.Debugger(import_status)
