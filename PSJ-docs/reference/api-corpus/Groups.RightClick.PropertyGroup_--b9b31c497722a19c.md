# Groups.RightClick.PropertyGroup()

Groups.RightClick.PropertyGroup()

説明​

グループウィンドウのグループツリーにプロパティグループを作成します。

構文​

Groups.RightClick.PropertyGroup(...)

リボン：Groups » RightClick » PropertyGroup

入力​

この関数は入力値を必要としません。

戻り値​

作成されたすべてのグループを指定する Cursor のリストです。

サンプルコード​

Geometry.Part.Cube()

Meshing.SolidMeshing(crlParts=[Part(1)], 
                     bTet10=True, 
                     dGradingFactor=1.05, 
                     dStretchLimit=0.1,
                     iSpeedVsQual=1, 
                     iRegion=1, 
                     bSafeMode=False, 
                     iParallel=8, 
                     bInternalMeshOnly=False, 
                     iPartColor=65280)

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

Properties.Shell(strName="Shell Property 1", 
                 crMatMembrane=Material(1), 
                 crMatBend=Material(1), 
                 crMatShear=Material(1), 
                 dMatOrient1=DFLT_DBL,  
                 dThickness=0.001, 
                 dBendStiff=DFLT_DBL, 
                 dThickRatio=DFLT_DBL, 
                 dNSM=DFLT_DBL,
                 dFiberDist1=DFLT_DBL, 
                 dFiberDist2=DFLT_DBL, 
                 dPlateOff=DFLT_DBL, 
                 iItgPts=DFLT_INT, 
                 crlTargets=[Face(21)])

created_groups = Groups.RightClick.PropertyGroup()

JPT.Debugger(created_groups)
