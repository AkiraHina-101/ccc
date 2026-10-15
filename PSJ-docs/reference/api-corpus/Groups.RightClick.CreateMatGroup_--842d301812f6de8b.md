# Groups.RightClick.CreateMatGroup()

Groups.RightClick.CreateMatGroup()

説明​

Groupウィンドウ内のGroupツリーに既存の素材に基づいてグループを作成します。

構文​

Groups.RightClick.CreateMatGroup(...)

リボン：Groups » RightClick » CreateMatGroup

入力​

この機能には入力値は必要ありません。

戻り値​

作成されたすべてのグループを指定する Cursor のリスト。

サンプルコード​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6409934)

Meshing.SolidMeshing(crlParts=[Part(2, 1)], 
                     bTet10=True, 
                     dGradingFactor=1.05, 
                     dStretchLimit=0.1,
                     iSpeedVsQual=1, 
                     iRegion=1, 
                     bSafeMode=False, 
                     iParallel=8, 
                     bInternalMeshOnly=False, 
                     iPartColor=65280)

Properties.Material.Add("Magnesium_Alloy", 
                        [Density([(DENSITY, 
                                   1.8e-09)]),
                        Elastic([(YOUNGS_MODULUS, 
                                  45000.0), 
                                 (POISSONS_RATIO, 
                                  0.35)])])
Properties.Material.Add("Structural_Steel", 
                        [Density([(DENSITY, 
                                   7.849999999999999e-09)]),
                        Elastic([(YOUNGS_MODULUS, 
                                  200000.0), 
                                 (POISSONS_RATIO, 
                                  0.3)])])

Properties.Solid(strName="Solid Property 1", 
                 crMaterial=Material(1), 
                 iCordM=-2, 
                 dDynaRemeshVal1=DFLT_DBL, 
                 dDynaRemeshVal2=DFLT_DBL, 
                 dDispHG=DFLT_DBL, 
                 crlTargets=[Part(1)], 
                 iFLG=-1)

Properties.Solid(strName="Solid Property 2", 
                 crMaterial=Material(2), 
                 iCordM=-2, 
                 dDynaRemeshVal1=DFLT_DBL, 
                 dDynaRemeshVal2=DFLT_DBL, 
                 dDispHG=DFLT_DBL, 
                 crlTargets=[Part(2)], 
                 iFLG=-1)

作成したグループ = Groups.RightClick.CreateMatGroup()

JPT.Debugger(作成したグループ)
