# JPT.GetMaterialXML()

JPT.GetMaterialXML()

説明​

XML形式ですべてのユーザー素材の情報を取得します。

構文​

JPT.GetMaterialXML()

入力​

このユーティリティ関数には入力値は不要です。

戻り値​

XML形式で作成されたすべてのユーザー素材を含む String です。

サンプルコード​

# ユーザー素材データベースを作成
Properties.Material.Add("Copper_Alloy", [密度([(DENSITY, 8.3e-09)]),
                        弾性係数([(YOUNGS_MODULUS, 110000.0), (POISSONS_RATIO, 0.34)])])

# 作成されたすべてのユーザー素材を取得し、XML形式で保存
createdMat = JPT.GetMaterialXML()
pprint(createdMat)
