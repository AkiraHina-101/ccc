# Home.ImportMesh.Nastran()

Home.ImportMesh.Nastran()

説明​

Nastranファイル（*.bdf）をJupiterデータベース（メッシュ、境界条件など）にインポートします。

構文​

Home.ImportMesh.Nastran(...)

マクロ: ImportBdf

リボン: Home » ImportMesh » Nastran

入力​

strlPaths​

インポートに使用するNastranファイル（*.bdfファイル）のリストを指定する String のリスト。

この入力は必須です。

iImportType​

インポートタイプを指定する Integer :

0: 標準的なNastranBDF - BDFモデルのジオメトリのみをインポートします。

1: プロパティ付きの標準的なNastranBDF、1D2D3Dパート - BDFモデルのジオメトリと材料プロパティをインポートします。すべての材料パートは各パートに適用されます。

2: プロパティ付きの標準的なNastranBDF、1D-エッジ、2D-フェース、3D-パート - BDFモデルのジオメトリと材料プロパティをインポートします。各材料プロパティに対してパートが作成されます。1D、2D材料プロパティは、単一パートのエッジやフェースに適用されます。3D材料プロパティは各パートに適用されます。（中空の1D材料プロパティは各パートに適用されます。）

5: NX-Nastranから出力したBDFファイルのコメント内のパート分割を参照し、コメント内の名称を使用して各パート、プロパティ、材料を作成します。

デフォルト値は、2です。

dFaceAngle​

フェース分割を決定するための角度許容度を指定する Double 。

デフォルト値は、60.0です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double 。

デフォルト値は、60.0です。

bReadJPTComment​

Jupiterの名前コメントを読み取るオプションを指定する Boolean 型。

デフォルト値は、False です。

iCreateDup1DElemAnswer​

重複する1D要素を作成するオプションを指定する Integer 。

-1: 不明

0: いいえ

1: はい

デフォルト値は、-1です。

bReadHMComment​

HMコメントを読み取るオプションを指定する Boolean 型。

デフォルト値は、False です。

戻り値​

関数の実行が正常に行われたかどうかを指定する Boolean 型。

True: Nastranファイル（*.bdfファイル）が正常にインポートされました。

False: Nastranファイル（*.bdfファイル）がインポートできません。

サンプルコード​

from os import environ

nastran_file_path = environ["Temp"] + "/TechnoStar/Exported_Nastran_File_EXPORT_BDF.bdf"

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

Analysis.Nastran.LinearStatic(nastranAnalysis=NASTRAN_ANALYSIS(iSolverType=1,
                                                               iGridFormatType=1,
                                                               bDeleteFloatingNodes=True,
                                                               dEpsilon=DFLT_DBL,
                                                               iMaxNumOfIter=DFLT_INT,
                                                               iMemory=DFLT_INT,
                                                               iNcpu=1,
                                                               iSolNo=101,
                                                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(
                                                                iValueBcresults=DFLT_INT,
                                                                iValueBgresults=DFLT_INT,
                                                                iTypeStrain=0),
                                                               nastranNonlinear=NASTRAN_NONLINEAR(bUseEPSW=True)),
                              iDummyPropMaterialID=1,
                              strPath=nastran_file_path)

JPT.Exec('New Document()')
import_status = Home.ImportMesh.Nastran(strlPaths=[nastran_file_path])
JPT.Debugger(import_status)
