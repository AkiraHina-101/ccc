# Properties.Material.Modify()

Properties.Material.Modify()

説明​

ユーザーデータベースライブラリ内の既存の材料を修正し、修正する材料のすべての情報を入力します。

構文​

Properties.Material.Modify(...)

リボン: Properties » Material » Modify

入力​

iMaterialID​

材料識別番号（ID）を指定する Integer 。

これは必須の入力です。

dictMaterialProperty​

dictMatProps を指定する dictionary 型。

これは必須の入力です。

listMaterialProperty​

density、 elasticity などのプロパティのすべての属性を指定する MATERIAL PROPERTY のリスト。

これは必須の入力です。

:::注意
この入力はV5.1から廃止されました。代わりに dictMaterialProperty を使用してください。
:::

戻り値​

材料が修正されたかどうかを指定する Boolean 型。

サンプルコード​

structure_steel = Properties.Material.Add(strMaterialName = "Structural_Steel",
    listMaterialProperty = [Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])

mod_mat = Properties.Material.Modify(iMaterialID = 1,
    listMaterialProperty = [Density([(DENSITY, 7.85e-05)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])
JPT.Debugger(mod_mat) #戻り値を確認するため
