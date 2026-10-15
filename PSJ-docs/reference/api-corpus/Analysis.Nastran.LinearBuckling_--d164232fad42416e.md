# Analysis.Nastran.LinearBuckling()

Analysis.Nastran.LinearBuckling()

説明​

Nastran線形弾性解析（SOL 105）の入力ファイルをエクスポートします。

構文​

Analysis.Nastran.LinearBuckling(...)

リボン: Analysis » Nastran » LinearBuckling

入力​

strName​

Nastran解析のジョブ名を指定します（_String_型）。

デフォルト値は "Job_1" です。

strDescription​

Nastran解析ジョブの説明を指定します（_String_型）。

デフォルト値は "" です。

crlTargets​

ターゲットパートのリストを指定します（_Cursor_型のリスト）。

デフォルト値は [] です。

nastranAnalysis​

Nastran解析の入力パラメータを指定します（_NASTRAN_ANALYSIS_型）。

デフォルト値は NASTRAN_ANALYSIS です。

bDummyPropAutoAssign​

オートダミープロパティの作成オプションを有効または無効にするか指定します（_Boolean_型）。

デフォルト値は False です。

iDummyPropMaterialID​

ダミープロパティ割り当てに使用する材料IDを指定します（_Integer_型）。

デフォルト値は 0 です。

crEdit​

既存のNastranジョブを指定します（_Cursor_型）。

このパラメータを使用すると、指定されたジョブが変更されます。

もし None のままにすると、新しいジョブが作成されます。

デフォルト値は None です。

strPath​

bdfファイルのエクスポートパスを指定します（_String_型）。

デフォルト値は "" です。

iModelCheckAnswer​

モデルチェックオプションを指定します（_Integer_型）。

0: ダミープロパティを検索するために使用されるモデルチェックオプションを無効にします。

1: ダミープロパティを検索するために使用されるモデルチェックオプションを有効にします。

デフォルト値は 0 です。

iDeleteSlaveNodesAnswer​

スレーブ節点の削除オプションを指定します（_Integer_型）。

0: スレーブ節点のチェックオプションを無効にします。

1: スレーブ節点のチェックオプションを有効にします。

デフォルト値は 0 です。

戻り値​

新しく作成されたまたは変更されたNastranジョブを指定する Cursor。

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
     iMaxNumOfIter=DFLT_INT, iMemory=DFLT_INT, iNcpu=1, iSolNo=105,
    nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeStress=0, iTypeStrain=0),
    nastranNonlinear=NASTRAN_NONLINEAR(bUseEPSW=True))
Analysis.Nastran.LinearBuckling(nastranAnalysis= nastran_param,strPath="D:/Job_1.bdf")
