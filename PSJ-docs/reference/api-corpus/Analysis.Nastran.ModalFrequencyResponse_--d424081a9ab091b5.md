# Analysis.Nastran.ModalFrequencyResponse()

Analysis.Nastran.ModalFrequencyResponse()

説明​

Nastranモーダル周波数応答解析（SOL 111）用の入力ファイルをエクスポートします。

構文​

Analysis.Nastran.ModalFrequencyResponse(...)

リボン: Analysis » Nastran » Modal Frequency Response(SOL 111)

入力​

strName​

Nastran解析のジョブ名を指定する String です。

デフォルト値は "Job_1" です。

strDescription​

Nastran解析ジョブの説明を指定する String です。

デフォルト値は "" です。

crlTargets​

ターゲットパートのリストを指定する Cursor のリストです。

デフォルト値は [] です。

nastranAnalysis​

Nastran解析入力パラメータを指定する NASTRAN_ANALYSIS です。

デフォルト値は NASTRAN_ANALYSIS です。

bDummyPropAutoAssign​

オートダミープロパティ作成オプションを有効または無効にする Boolean です。

デフォルト値は False です。

iDummyPropMaterialID​

ダミープロパティ割り当てに使用する素材IDを指定する Integer です。

デフォルト値は 0 です。

crEdit​

既存のNastranジョブを指定する Cursor です。

このパラメータを使用すると、指定したジョブが変更されます。

None のままにしておくと、新しいジョブが作成されます。

デフォルト値は None です。

strPath​

bdfファイルのエクスポートパスを指定する String です。

デフォルト値は "" です。

iModelCheckAnswer​

モデルチェックオプションを指定する Integer です。

0：ダミープロパティを探すために使用されるモデルチェックオプションを無効にする。

1：ダミープロパティを探すために使用されるモデルチェックオプションを有効にする。

デフォルト値は 0 です。

iDeleteSlaveNodesAnswer​

スレーブ節点の削除オプションを指定する Integer です。

0：スレーブ節点の削除チェックオプションを無効にする。

1：スレーブ節点の削除チェックオプションを有効にする。

デフォルト値は 0 です。

戻り値​

新しく作成されたまたは修正されたNastranジョブを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()
Meshing.SolidMeshing(crlParts=[Part(1)], bTet10=True, dGradingFactor=1.05,
     dStretchLimit=0.1, iSpeedVsQual=1, iRegion=1, bSafeMode=False,
     iParallel=12, bInternalMeshOnly=False, iPartColor=65280)

Properties.Material.Add("Structural_Steel", [Density([(DENSITY, 7.85e-09)]),
     Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])
Properties.Solid(crMaterial=Material(1), dDynaRemeshVal1=DFLT_DBL,
     dDynaRemeshVal2=DFLT_DBL, dDispHG=DFLT_DBL, crlTargets=[Part(1)], iFLG=-1)

BoundaryConditions.FixedConstraint(crlTargets=[Face(25)])
BoundaryConditions.Pressure.General(dPressure=10.0, dlDirection=[0.0, 0.0, -1.0],
     crlTargets=[Face(26)])

nastran_param = NASTRAN_ANALYSIS(iSolverType=1, iGridFormatType=1, dEpsilon=DFLT_DBL,
     iMaxNumOfIter=DFLT_INT, iMemory=DFLT_INT, iNcpu=1, iSolNo=111,
     nastranFreqTimestep=NASTRAN_FREQ_TIMESTEP(iDampingType=1),
     nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iValueSdisplacement=DFLT_INT,
     iValueAcceleration=DFLT_INT, iValueVelocity=DFLT_INT, iTypeStress=0, iTypeStrain=0),
     nastranSettings=NASTRAN_SETTINGS(iMEFFMASS=2))
Analysis.Nastran.ModalTransientResponse(nastranAnalysis= nastran_param, strPath="D:/Job_1.bdf")
