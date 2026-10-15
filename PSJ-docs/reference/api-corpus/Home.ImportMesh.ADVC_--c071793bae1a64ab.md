# Home.ImportMesh.ADVC()

Home.ImportMesh.ADVC()

説明​

ADVCファイル（*.adx）をJupiterデータベースにインポートします（メッシュ、境界条件など）。

構文​

Home.ImportMesh.ADVC(...)

マクロ: ImportAdxList

リボン: Home » ImportMesh » ADVC

入力​

strlPaths​

インポートに使用するADVCファイル（*.adxファイル）のリストを指定する String のリストです。

この入力は必須です。

dFaceAngle​

フェースの分割を決定するための角度許容度を指定する Double です（指定された値よりも小さい角度で隣接要素間にエッジを作成します）。

デフォルト値は60.0です。

dEdgeAngle​

エッジの分割を決定するための角度許容度を指定する Double です（指定された値よりも大きい角度で隣接エッジ要素に頂点を作成します）。

デフォルト値は60.0です。

bReadCommentsForJupiter​

JupiterがMaterial、Property、LBC、Contact、Job名、関連グループ名を読み取るかどうかを指定するBoolです。

デフォルト値は False です。

戻り値​

関数の実行が成功したかどうかを指定する Boolean です：

True: ADVCファイル（*.adxファイル）が正常にインポートされました。

False: ADVCファイル（*.adxファイル）をインポートできません。

サンプルコード​

from os import environ

advc_file_path = environ["Temp"] + "/TechnoStar/Exported_ADVC_File_EXPORT_ADX.adx"

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

JPT.Exec('AdvcStaticProcess("ADVC_DEFAULT_PROCESS", 0, 0, 1, 1, 1, 1e-05, \
                            -1, -1, 2147483647, -1, 2147483647, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 0, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 2147483647, \
                            2147483647, 1.79769e+308, 2147483647, 0, -1, 2147483647, \
                            2147483647, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 2147483647, 0, 1.79769e+308, 1.79769e+308, \
                            0, 0, 2147483647, 2147483647, 2147483647, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 2147483647, 2147483647, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 119:1, \
                            [(37:1, 0:0, 1), (40:1, 0:0, 1)], [], [], [], -1, "", [], "", 2147483647)')

JPT.Exec('AdvcStaticProcess("ADVC_DEFAULT_PROCESS", 0, 0, 1, 1, 1, 1e-05, -1, \
                            -1, 2147483647, -1, 2147483647, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 2147483647, \
                            2147483647, 1.79769e+308, 2147483647, 0, -1, 2147483647, \
                            2147483647, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 2147483647, 0, 1.79769e+308, 1.79769e+308, \
                            0, 0, 2147483647, 2147483647, 2147483647, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 2147483647, 2147483647, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 119:1, [], [], [], [], \
                            -1, "", [], "", 2147483647)')

JPT.Exec('AdvcStaticProcess("ADVC_DEFAULT_PROCESS", 0, 0, 1, 1, 1, 1e-05, -1, -1, \
                            2147483647, -1, 2147483647, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 2147483647, \
                            2147483647, 1.79769e+308, 2147483647, 0, -1, 2147483647, \
                            2147483647, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 2147483647, 0, 1.79769e+308, 1.79769e+308, \
                            0, 0, 2147483647, 2147483647, 2147483647, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 2147483647, 2147483647, \
                            1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
                            1.79769e+308, 1.79769e+308, 119:1, [], [], [], [], \
                            -1, "", [], "", 2147483647)')

JPT.Exec('ADVC_Structure("Job_1", "", 0, [119:1], [], [], 0, 0:0, 0, 0, 0, 0, 0, 0, 0, \
                         [3:1], 1, 1, 1, 1, 0, 1, 22:1, 0, "", 2147483647, 2147483647, \
                         0, 1, [], 0, 0, {}, 0, 10, 10, 1, 0, "", 1)'.format(advc_file_path))

JPT.Exec('New Document()')
import_status = Home.ImportMesh.ADVCADX(strlPaths=[advc_file_path])
JPT.Debugger(import_status)
