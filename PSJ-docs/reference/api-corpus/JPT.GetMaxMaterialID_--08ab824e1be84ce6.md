# JPT.GetMaxMaterialID()

JPT.GetMaxMaterialID()

説明​

ユーザーマテリアルデータベース内のユーザーマテリアルの最大IDを取得します。

構文​

JPT.GetMaxMaterialID()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

ユーザーマテリアルデータベース内のユーザーマテリアルの最大IDを指定する Integer です。

サンプルコード​

# ユーザーマテリアルデータベース作成
Properties.Material.Add("Stainless_Steel", [Density([(DENSITY, 7.75e-09)]),
                        Elastic([(YOUNGS_MODULUS, 193000.0), (POISSONS_RATIO, 0.31)])])
Properties.Material.Add("Titanium_Alloy", [Density([(DENSITY, 4.62e-09)]),
                        Elastic([(YOUNGS_MODULUS, 96000.0), (POISSONS_RATIO, 0.36)])])
Properties.Material.Add("Aluminum_Alloy", [Density([(DENSITY, 2.7699999999999997e-09)]),
                        Elastic([(YOUNGS_MODULUS, 71000.0), (POISSONS_RATIO, 0.33)])])

# ユーザーマテリアルデータベース内のユーザーマテリアルの最大IDを取得
iMaxMaterialID = JPT.GetMaxMaterialID()
JPT.Debugger(iMaxMaterialID) # 値が3の整数オブジェクトを返します
