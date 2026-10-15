# JPT.GetGroupFromSubGroup()

JPT.GetGroupFromSubGroup()

説明​

特定のグループ名の下にある グループのリスト を取得します。

構文​

JPT.GetGroupFromSubGroup(groupName)

入力​

groupName​

既存のグループの名前を指定する String。

これは必須の入力です。

戻り値​

指定されたグループ名の下にあるグループを指定する DItemVector オブジェクトまたは List of DItem オブジェクト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0],
                   strName="Cube_2",
                   iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0],
                   strName="Cube_3",
                   iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0],
                   strName="Cube_4",
                   iPartColor=7697908)
Geometry.Part.Cube(dlOrigin=[0.04, 0.0, 0.0],
                   strName="Cube_5",
                   iPartColor=7463537)
Geometry.Part.Cube(dlOrigin=[0.05, 0.0, 0.0],
                   strName="Cube_6",
                   iPartColor=7434735)
Geometry.Part.Cube(dlOrigin=[0.06, 0.0, 0.0],
                   strName="Cube_7",
                   iPartColor=14903267)
Geometry.Part.Cube(dlOrigin=[0.07, 0.0, 0.0],
                   strName="Cube_8",
                   iPartColor=15658599)
JPT.ViewFitToModel()

Meshing.SetMeshAttribute(crlParts=[Part(5, 6, 7, 8)],
                         surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                  iPerformanceMode=1,
                                                  dAutoMergeTinyFacesAngle=0.5235987756,
                                                  bOutputQuadMesh=True,
                                                  bGeomApprox=True,
                                                  iNextEntityOffsetId=0))
Meshing.SurfaceMeshing(crlParts=[Part(5, 6, 7, 8)],
                       surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634,
                                                iPerformanceMode=1,
                                                dAutoMergeTinyFacesAngle=0.5235987756,
                                                bOutputQuadMesh=True,
                                                bGeomApprox=True,
                                                iNextEntityOffsetId=0),
                                                iThreadNum=12)
MeshEdit.SurfaceMesh(crlParts=[Part(2, 4, 8, 6)])
Meshing.SolidMeshing(crlParts=[Part(8, 4, 7, 3)],
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)
Meshing.SolidMeshing(crlParts=[Part(4)],
                     bTet10=True,
                     dGradingFactor=1.05,
                     dStretchLimit=0.1,
                     iSpeedVsQual=1,
                     iRegion=1,
                     bSafeMode=False,
                     iParallel=12,
                     bInternalMeshOnly=False,
                     iPartColor=65280)

del_faces = [208, 182, 178, 204, 206, 177, 203, 179, 205, 180]
extrude_faces = [207, 181]

Geometry.DeleteEntity.Face(crlFaces=[Face(*del_faces)])

HexModeling.Linear(crlFaces=[Face(*extrude_faces)],
                   dLength=0.01,
                   iLayer=2,
                   vecSweepDirection=[0.0,
                                      0.0,
                                      1.0],
                   iLinearMethod=4)

MeshEdit.SolidMesh(crlParts=[Part(8)])

Properties.Material.Add(strMaterialName="Copper_Alloy",
                        listMaterialProperty=[Density([(DENSITY,
                                                        8.3e-09)]),
                                              Elastic([(YOUNGS_MODULUS,
                                                        110000.0),
                                                       (POISSONS_RATIO,
                                                        0.34)])])
Properties.Material.Add(strMaterialName="Magnesium_Alloy",
                        listMaterialProperty=[Density([(DENSITY,
                                                        1.8e-09)]),
                                              Elastic([(YOUNGS_MODULUS,
                                                        45000.0),
                                                       (POISSONS_RATIO,
                                                        0.35)])])
Properties.Material.Add(strMaterialName="Concrete",
                        listMaterialProperty=[Density([(DENSITY,
                                                        2.3e-09)]),
                                              Elastic([(YOUNGS_MODULUS,
                                                        30000.0),
                                                       (POISSONS_RATIO,
                                                        0.18)])])
Properties.Material.Add(strMaterialName="Polyethylene",
                        listMaterialProperty=[Density([(DENSITY,
                                                        9.5e-10)]),
                                              Elastic([(YOUNGS_MODULUS,
                                                        1100.0),
                                                       (POISSONS_RATIO,
                                                        0.42)])])
Properties.Material.Add(strMaterialName="Structural_Steel",
                        listMaterialProperty=[Density([(DENSITY,
                                                        7.85e-09)]),
                                              Elastic([(YOUNGS_MODULUS,
                                                        200000.0),
                                                       (POISSONS_RATIO,
                                                        0.3)])])
Properties.Material.Add(strMaterialName="Stainless_Steel",
                        listMaterialProperty=[Density([(DENSITY,
                                                        7.75e-09)]),
                                              Elastic([(YOUNGS_MODULUS,
                                                        193000.0),
                                                       (POISSONS_RATIO,
                                                        0.31)])])
Properties.Material.Add(strMaterialName="Titanium_Alloy",
                        listMaterialProperty=[Density([(DENSITY,
                                                        4.62e-09)]),
                                              Elastic([(YOUNGS_MODULUS,
                                                        96000.0),
                                                       (POISSONS_RATIO,
                                                        0.36)])])
Properties.Material.Add(strMaterialName="Aluminum_Alloy",
                        listMaterialProperty=[Density([(DENSITY,
                                                        2.7699999999999997e-09)]),
                                              Elastic([(YOUNGS_MODULUS,
                                                        71000.0),
                                                       (POISSONS_RATIO,
                                                        0.33)])])

Properties.Solid(crlTargets=[Part(3)],
                 strName="Cube_3",
                 iPropertyColor=16131973,
                 crMaterial=Material(1),
                 iCordM=-2,
                 dDynaRemeshVal1=DFLT_DBL,
                 dDynaRemeshVal2=DFLT_DBL,
                 dDispHG=DFLT_DBL,
                 iFLG=-1)
Properties.Solid(crlTargets=[Part(4)],
                 strName="Cube_4",
                 iPropertyId=2,
                 iPropertyColor=10176523,
                 crMaterial=Material(2),
                 iCordM=-2,
                 dDynaRemeshVal1=DFLT_DBL,
                 dDynaRemeshVal2=DFLT_DBL,
                 dDispHG=DFLT_DBL,
                 iFLG=-1)
Properties.Solid(crlTargets=[Part(7)],
                 strName="Cube_7",
                 iPropertyId=3,
                 iPropertyColor=4185823,
                 crMaterial=Material(3),
                 iCordM=-2,
                 dDynaRemeshVal1=DFLT_DBL,
                 dDynaRemeshVal2=DFLT_DBL,
                 dDispHG=DFLT_DBL,
                 iFLG=-1)
Properties.Solid(crlTargets=[Part(8)],
                 strName="Cube_8",
                 iPropertyId=4,
                 iPropertyColor=14470647,
                 crMaterial=Material(4),
                 iCordM=-2,
                 dDynaRemeshVal1=DFLT_DBL,
                 dDynaRemeshVal2=DFLT_DBL,
                 dDispHG=DFLT_DBL,
                 iFLG=-1)

Properties.Shell(crlTargets=[Part(1)],
                 strName="Cube_1",
                 iPropertyId=5,
                 iPropertyColor=6438968,
                 crMatMembrane=Material(5),
                 crMatBend=Material(5),
                 crMatShear=Material(5),
                 dMatOrient1=DFLT_DBL,
                 dThickness=0.001,
                 dBendStiff=DFLT_DBL,
                 dThickRatio=DFLT_DBL,
                 dNSM=DFLT_DBL,
                 dFiberDist1=DFLT_DBL,
                 dFiberDist2=DFLT_DBL,
                 dPlateOff=DFLT_DBL,
                 iItgPts=DFLT_INT)
Properties.Shell(crlTargets=[Part(2)],
                 strName="Cube_2",
                 iPropertyId=6,
                 iPropertyColor=12901905,
                 crMatMembrane=Material(6),
                 crMatBend=Material(6),
                 crMatShear=Material(6),
                 dMatOrient1=DFLT_DBL,
                 dThickness=0.001,
                 dBendStiff=DFLT_DBL,
                 dThickRatio=DFLT_DBL,
                 dNSM=DFLT_DBL,
                 dFiberDist1=DFLT_DBL,
                 dFiberDist2=DFLT_DBL,
                 dPlateOff=DFLT_DBL,
                 iItgPts=DFLT_INT)
Properties.Shell(crlTargets=[Part(5)],
                 strName="Cube_5",
                 iPropertyId=7,
                 iPropertyColor=13102932,
                 crMatMembrane=Material(7),
                 crMatBend=Material(7),
                 crMatShear=Material(7),
                 dMatOrient1=DFLT_DBL,
                 dThickness=0.001,
                 dBendStiff=DFLT_DBL,
                 dThickRatio=DFLT_DBL,
                 dNSM=DFLT_DBL,
                 dFiberDist1=DFLT_DBL,
                 dFiberDist2=DFLT_DBL,
                 dPlateOff=DFLT_DBL,
                 iItgPts=DFLT_INT)
Properties.Shell(crlTargets=[Part(6)],
                 strName="Cube_6",
                 iPropertyId=8,
                 iPropertyColor=652495,
                 crMatMembrane=Material(7),
                 crMatBend=Material(7),
                 crMatShear=Material(7),
                 dMatOrient1=DFLT_DBL,
                 dThickness=0.001,
                 dBendStiff=DFLT_DBL,
                 dThickRatio=DFLT_DBL,
                 dNSM=DFLT_DBL,
                 dFiberDist1=DFLT_DBL,
                 dFiberDist2=DFLT_DBL,
                 dPlateOff=DFLT_DBL,
                 iItgPts=DFLT_INT)

Groups.RightClick.CreateMatGroup()
Groups.RightClick.PropertyGroup()

mat_group = JPT.GetGroupFromSubGroup("Material Group 1")
JPT.Debugger(mat_group)

prop_group = JPT.GetGroupFromSubGroup("Property Group 1")
JPT.Debugger(prop_group)
