# Analysis.ModifyLbcToStep()

Analysis.ModifyLbcToStep()

説明​

Abaqusステップの負荷や境界条件の追加/修正を行います。

構文​

Analysis.ModifyLbcToStep(...)

Ribbon: Analysis » ModifyLbcToStep

入力​

listAbaqusLbcStepInfo​

負荷境界条件情報からAbaqusステップのリストを指定する ABAQUS_LBC_STEP_INFO list。

デフォルト値は[]です。

戻り値​

作成/修正プロセスのステータスを指定する Boolean 型:

True: 指定されたステップが正常に変更/作成されました。

False: 指定されたステップは変更/作成できません。

サンプルコード​

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

BoundaryConditions.FixedConstraint(crlTargets=[Face(24)])
BoundaryConditions.Pressure.General(dPressure=1000000.0,
                                    crlTargets=[Face(21,
                                                     23)])

Analysis.AbaqusStep.StaticStep(strName="Step1",
                               iMaxInc=100,
                               dInitSize=1.0,
                               dMinSize=1e-05,
                               dMaxSize=1.0,
                               iAllowIter=8,
                               dAdjustFactor=1.0,
                               iMaxContactIteration=30,
                               dDampingFactor=0.0002,
                               iUseAdaptive=1,
                               dMaxRationOfEnergyStrain=0.05,
                               dTimePeriod=1.0,
                               iRamp=1,
                               iExtrapolateMethod=1,
                               strlFullPlasticRegion=[""])

creating_status = Analysis.ModifyLbcToStep(listAbaqusLbcStepInfo=[ABAQUS_LBC_STEP_INFO(crStep=AbaqStepsStructStatic(1),
                                                                                       crLbc=LbcConstraint(1),
                                                                                       iCurflag=2),
                                                                  ABAQUS_LBC_STEP_INFO(crStep=AbaqStepsStructStatic(1),
                                                                                       crLbc=LbcGPressure(1),
                                                                                       iCurflag=3,
                                                                                       iPreflag=2)])

JPT.Debugger(creating_status)
