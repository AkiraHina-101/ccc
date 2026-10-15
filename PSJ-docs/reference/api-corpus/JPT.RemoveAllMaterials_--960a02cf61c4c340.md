# JPT.RemoveAllMaterials()

JPT.RemoveAllMaterials()

説明​

ユーザーマテリアルデータベース内のすべての既存素材を削除します。

構文​

JPT.RemoveAllMaterials()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

このユーティリティ関数には出力値はありません。

サンプルコード​

# 素材を作成する
Properties.Material.Add("Copper_Alloy", [Density([(DENSITY, 8.3e-09)]),
                                         Elastic([(YOUNGS_MODULUS, 110000.0),
                                                  (POISSONS_RATIO, 0.34)])])
Properties.Material.Add("Stainless_Steel", [Density([(DENSITY, 7.75e-09)]),
                                            Elastic([(YOUNGS_MODULUS, 193000.0),
                                                     (POISSONS_RATIO, 0.31)])])
Properties.Material.Add("Titanium_Alloy", [Density([(DENSITY, 4.62e-09)]),
                                           Elastic([(YOUNGS_MODULUS, 96000.0),
                                                    (POISSONS_RATIO, 0.36)])])

# ユーザーマテリアルデータベース内で作成されたすべての素材を削除
JPT.RemoveAllMaterials()
