# Home.ImportResults.ImportMesh.Nastran()

Home.ImportResults.ImportMesh.Nastran()

説明​

Nastranメッシュファイル（*.bdf、*.nas、*.dat）をJupiterデータベースにインポートして、結果をメッシュに追加するためのPostドキュメントです。

構文​

Home.ImportResults.ImportMesh.Nastran(...)

マクロ: CmdImportTSVBdfPost

リボン: Home » ImportResults » ImportMesh » Nastran

入力​

strPath​

インポートに使用するNastranファイル（*.bdf、*.nas、*.datファイル）を指定する String です。

これは必須の入力です。

iImportType​

インポートタイプを指定する Integer です。ここでは常に1に設定されています。

デフォルトの値は1です。

dFaceAngle​

フェース分割を決定するための角度許容度を指定する Double 型です（隣接要素間の角度が指定値より小さい場合、エッジを作成します）。

デフォルトの値は60.0度です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double 型です（隣接するエッジ要素において、指定値より大きい角度で頂点を作成します）。

デフォルトの値は60.0度です。

bReadLoadAndConstraint​

負荷と拘束条件を読み込むかどうかを指定する Boolean です。

デフォルトの値は False です。

bReadConnection​

接続を読み込むかどうかを指定する Boolean です。

デフォルトの値は False です。

戻り値​

関数が正常に実行されたかどうかを示す Boolean 型です：

True: Nastranファイル（*.bdfファイル）が正常にインポートされました。

False: Nastranファイル（*.bdfファイル）をインポートできません。

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
                                                               nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iValueBcresults=DFLT_INT,
                                                                                                           iValueBgresults=DFLT_INT,
                                                                                                           iTypeStrain=0),
                                                               nastranNonlinear=NASTRAN_NONLINEAR(bUseEPSW=True)),
                              iDummyPropMaterialID=1,
                              strPath=nastran_file_path)

JPT.Exec('New Document()')
import_status = Home.ImportResults.ImportMesh.Nastran(strPath=nastran_file_path)
JPT.Debugger(import_status)
