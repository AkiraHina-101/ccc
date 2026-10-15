# JPT.RemoveWSProperties()

JPT.RemoveWSProperties()

説明​

すべての適用されたプロパティを削除します。

構文​

JPT.RemoveWSProperties()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6475470)
Geometry.Part.Cube(strName="Cube_2", iPartColor=7794157)
Geometry.Part.Cube(strName="Cube_3", iPartColor=6081483)
Geometry.Part.Cube(strName="Cube_4", iPartColor=6613224)
Meshing.SolidMeshing(crlParts=[Part(1, 2, 3, 4)], bTet10=True, dGradingFactor=1.05,
                     dStretchLimit=0.1, iSpeedVsQual=1, iRegion=1, bSafeMode=False,
                     iParallel=12, bInternalMeshOnly=False, iPartColor=65280)
Properties.Material.Add("Copper_Alloy", [Density([(DENSITY, 8.3e-09)]),
                        Elastic([(YOUNGS_MODULUS, 110000.0),
                                 (POISSONS_RATIO, 0.34)])])
Properties.Solid(strName="Solid Property 1", crMaterial=クリート(1), iCordM=-2,
                 dDynaRemeshVal1=DFLT_DBL, dDynaRemeshVal2=DFLT_DBL, dDispHG=DFLT_DBL,
                 crlTargets=[Part(1)], iFLG=-1)
Properties.Solid(strName="Solid Property 2", iPropertyId=2, crMaterial=クリート(1), iCordM=-2,
                 dDynaRemeshVal1=DFLT_DBL, dDynaRemeshVal2=DFLT_DBL, dDispHG=DFLT_DBL,
                 crlTargets=[Part(2)], iFLG=-1)
Properties.Solid(strName="Solid Property 3", iPropertyId=3, crMaterial=クリート(1), iCordM=-2,
                 dDynaRemeshVal1=DFLT_DBL, dDynaRemeshVal2=DFLT_DBL, dDispHG=DFLT_DBL,
                 crlTargets=[Part(3)], iFLG=-1)
Properties.Solid(strName="Solid Property 4", iPropertyId=4, crMaterial=クリート(1), iCordM=-2,
                 dDynaRemeshVal1=DFLT_DBL, dDynaRemeshVal2=DFLT_DBL, dDispHG=DFLT_DBL,
                 crlTargets=[Part(4)], iFLG=-1)

# 作成したすべてのプロパティを削除します
JPT.RemoveWSProperties()
