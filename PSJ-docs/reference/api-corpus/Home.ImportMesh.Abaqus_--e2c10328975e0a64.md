# Home.ImportMesh.Abaqus()

Home.ImportMesh.Abaqus()

説明​

Abaqusファイル（*.inp）をJupiterデータベース（メッシュ、境界条件など）にインポートします。

構文​

Home.ImportMesh.Abaqus(...)

マクロ: ImportInp

リボン: Home » ImportMesh » Abaqus

入力​

strlPaths​

インポートに使用するAbaqusファイル（*.inpファイル）のリストを指定する String のリストです。

この入力は必須です。

dFaceAngle​

フェースの分割を決定するための角度許容度を指定する Double です。指定された値よりも小さな角度で隣接要素間にエッジを作成してフェースを定義します。

デフォルト値は60.0です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double です。指定された値よりも小さな角度で隣接エッジ要素に頂点を作成してエッジを分割します。

デフォルト値は60.0です。

iImportType​

インポートタイプを指定する Integer です。

0: 標準Abaqus Inp - モデルのジオメトリのみをインポートします。

1: プロパティ別の標準Abaqus Inp - モデルのジオメトリと材料プロパティをインポートします。各材料プロパティに対して パートが作成されます。

デフォルト値は1です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean です：

True: Abaqusファイル（*.inpファイル）が正常にインポートされました。

False: Abaqusファイル（*.inpファイル）をインポートできませんでした。

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
import_status = Home.ImportMesh.Abaqus(strlPaths=[abaqus_file_path],
                                          dFaceAngle=3.000001285727965,
                                          dEdgeAngle=3.000001285727965,
                                          iImportType=0)
JPT.Debugger(import_status)
