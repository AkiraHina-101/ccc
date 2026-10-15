# Analysis.Nastran.Transient()

Analysis.Nastran.Transient()

説明​

Nastran定常熱伝達解析（SOL 159）の入力ファイルをエクスポートします。

構文​

Analysis.Nastran.Transient(...)

リボン：Analysis » Nastran » Transient

入力​

strName​

Nastran解析のジョブ名を指定する String です。

デフォルト値は「Job_1」です。

strDescription​

Nastran解析ジョブの説明を指定する String です。

デフォルト値は""です。

crlTargets​

ターゲットパートのリストを指定する Cursor リストです。

デフォルト値は[]です。

nastranAnalysis​

Nastran解析入力パラメータを指定する NASTRAN_ANALYSIS です。

デフォルト値は NASTRAN_ANALYSIS です。

bDummyPropAutoAssign​

オートダミープロパティ作成オプションを有効または無効にする Boolean です。

デフォルト値は False です。

iDummyPropMaterialID​

ダミープロパティ割り当てに使用される材料IDを指定する Integer です。

デフォルト値は0です。

crEdit​

既存のNastranジョブを指定する Cursor です。

このパラメータを使用すると、指定されたジョブが修正されます。

None のままにしておくと、新しいジョブが作成されます。

デフォルト値は None です。

strPath​

bdfファイルのエクスポートパスを指定する String です。

これは必須の入力です。

iModelCheckAnswer​

モデルチェックオプションを指定する Integer です。

0：ダミープロパティを探すために使用されるモデルチェックオプションを無効にします。

1：ダミープロパティを探すために使用されるモデルチェックオプションを有効にします。

デフォルト値は0です。

iDeleteSlaveNodesAnswer​

スレーブ節点の削除オプションを指定する Integer です。

0：スレーブ節点のチェックオプションを無効にします。

1：スレーブ節点のチェックオプションを有効にします。

デフォルト値は0です。

戻り値​

作成されたジョブを指定する Cursor です。

サンプルコード​

from os import environ
import re

Geometry.Part.Cube()
Meshing.SolidMeshing(crlParts=[Part(1)], 
                     bTet10=True, 
                     dGradingFactor=1.05, 
                     dStretchLimit=0.1, 
                     iSpeedVsQual=1, 
                     iRegion=1, 
                     bSafeMode=False, 
                     iParallel=12, 
                     bInternalMeshOnly=False, 
                     iPartColor=65280)

Properties.Material.Add("Concrete", 
                        [Density([(DENSITY, 2.3e-09)]), 
                        Elastic([(YOUNGS_MODULUS, 30000.0), 
                                 (POISSONS_RATIO, 0.18)])])

Properties.Solid(crlTargets=[Part(1)], 
                 strName="Solid Property 1", 
                 iPropertyColor=16131973, 
                 crMaterial=Material(1), 
                 iCordM=-2, 
                 dDynaRemeshVal1=DFLT_DBL, 
                 dDynaRemeshVal2=DFLT_DBL, 
                 dDispHG=DFLT_DBL, 
                 iFLG=-1)

BoundaryConditions.BoundaryTemperature.Constant(dFTemp=373.15, 
                                                crlTargets=[Face(24)])
BoundaryConditions.HeatFlux.SurfaceFlux(strName="SurfaceHeatFlux1", 
                                        dFflux=150000.0,
                                        iDistributionMethod=1, 
                                        crTable=None, 
                                        crlTargets=[Face(23)])

nastran_param = NASTRAN_ANALYSIS(iSolverType=1, 
                                 iGridFormatType=1, 
                                 dEpsilon=DFLT_DBL,
                                 iMaxNumOfIter=DFLT_INT, 
                                 iMemory=DFLT_INT, 
                                 iNcpu=1, 
                                 iSolNo=159,
                                 nastranFreqTimestep=NASTRAN_FREQ_TIMESTEP(iDampingType=2, 
                                                                           iModalDampingTableId=0),
                                 nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeThermal=1),
                                 nastranNonlinear=NASTRAN_NONLINEAR(iKMETHOD=3, 
                                                                    iMAXITER=1, 
                                                                    bUseEPSW=True))

exported_job = Analysis.Nastran.Transient(nastranAnalysis = nastran_param, 
                                          iDummyPropMaterialID=1, 
                                          strPath=re.sub(re.escape("\\"), "/", environ["Temp"]) + \
                                                  "/TechnoStar/Test.bdf")

JPT.Debugger(exported_job)
