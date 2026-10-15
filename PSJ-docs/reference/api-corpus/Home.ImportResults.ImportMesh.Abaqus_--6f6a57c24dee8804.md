# Home.ImportResults.ImportMesh.Abaqus()

Home.ImportResults.ImportMesh.Abaqus()

説明​

Abaqus メッシュファイル（*.inp）を Jupiter データベース（メッシュ、境界条件など）にインポートして、結果をメッシュに追加する Post ドキュメントを追加します。

構文​

Home.ImportResults.ImportMesh.Abaqus(...)

マクロ: ImportInpToPost

リボン: Home » ImportResults » ImportMesh » Abaqus

入力​

strPath​

インポートに使用される Abaqus ファイル（*.inp ファイル）を指定する String 。

この入力は必須です。

dFaceAngle​

フェースの分割を決定する角度許容範囲を指定する Double 。

指定された値よりも小さい角度を持つ隣接要素間にエッジを作成します。

デフォルト値は 60.0（度）です。

dEdgeAngle​

エッジの分割を決定する角度許容範囲を指定する Double 。

指定された値よりも大きい角度を持つ隣接エッジ要素に頂点を作成します。

デフォルト値は 60.0（度）です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型:

True: Abaqus ファイル（*.inp ファイル）が正常にインポートされました。

False: Abaqus ファイル（*.inp ファイル）をインポートできませんでした。

サンプルコード​

from os import environ

abaqus_file_path = environ["Temp"] + "/TechnoStar/Exported_Abaqus_File_EXPORT_INP.inp"

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

JPT.Exec('CreateAbaqusJob("Job_1", 0, 0, 0, 0, 1, 0, "", \
                          [], 0:0, [], 0, 1, 0, 0, 1, 22:1, 1, 0, 0, 0)')

Analysis.ExportAbaqus(crAbaJob=AbaqusJob(1),
                      strInpPath=abaqus_file_path)

JPT.Exec('New Document()')
import_status = Home.ImportResults.ImportMesh.Abaqus(strPath=abaqus_file_path,
                                          dFaceAngle=3.000001285727965,
                                          dEdgeAngle=3.000001285727965,
                                          iImportType=0)
JPT.Debugger(import_status)
