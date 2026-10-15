# JPT.GetMaterialFromProperty()

JPT.GetMaterialFromProperty()

説明​

入力された特性IDから使用されている材料情報（名前、IDなど）を取得します（存在する場合）。

構文​

JPT.GetMaterialFromProperty(propertyID)

入力​

propertyID​

材料特性IDを指定する Integer です。

これは必須の入力です。

戻り値​

入力された特性に使用されている材料の情報を含む DItem オブジェクトです。

サンプルコード​

# モデルを準備
Geometry.Part.Cube(iPartColor=7731061)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=11908427)
JPT.ViewFitToModel()
Meshing.SolidMeshing(crlParts=[Part(2)], bTet10=True, dGradingFactor=1.05, dStretchLimit=0.1, iSpeedVsQual=1,
    iRegion=1, bSafeMode=False, iParallel=4, bInternalMeshOnly=False, iPartColor=65280)
Properties.Material.Add("Concrete", [Density([(DENSITY, 2.3e-09)]), Elastic([(YOUNGS_MODULUS, 30000.0),
    (POISSONS_RATIO, 0.18)])])
Properties.Material.Add("Magnesium_Alloy", [Density([(DENSITY, 1.8e-09)]), Elastic([(YOUNGS_MODULUS, 45000.0),
    (POISSONS_RATIO, 0.35)])])
Properties.Shell(crlTargets=[Face(26, 25)], strName="Shell Property 1", iPropertyColor=16131973,
    crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1), dMatOrient1=DFLT_DBL,
    dThickness=0.001, dBendStiff=DFLT_DBL, dThickRatio=DFLT_DBL, dNSM=DFLT_DBL, dFiberDist1=DFLT_DBL,
    dFiberDist2=DFLT_DBL, dPlateOff=DFLT_DBL, iItgPts=DFLT_INT)
Properties.Solid(crlTargets=[Part(2)], strName="Solid Property 2", iPropertyId=2, iPropertyColor=4955455,
    crMaterial=Material(2), iCordM=-2, dDynaRemeshVal1=DFLT_DBL, dDynaRemeshVal2=DFLT_DBL, dDispHG=DFLT_DBL,
    iFLG=-1)

# ID = 1（シェル）の特性の材料情報を取得
dItemShellMat = JPT.GetMaterialFromProperty(1)
JPT.Debugger(dItemShellMat)
print("シェルに適用された材料: ")
print("--- 名前: %s" %str(dItemShellMat.name))
print("--- ID: %s" %str(dItemShellMat.id))

# ID = 2（ソリッド）の特性の材料情報を取得
dItemSolidlMat = JPT.GetMaterialFromProperty(2)
JPT.Debugger(dItemSolidlMat)
print("ソリッドに適用された材料: ")
print("--- 名前: %s" %str(dItemSolidlMat.name))
print("--- ID: %s" %str(dItemSolidlMat.id))
