# DamageforTractionSeparationLaws

DamageforTractionSeparationLaws

説明​

これは物質の膨張特性を表す Expansion クラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | expansion | 膨張特性のすべてのデータを指定する Tuple リスト。 
 データには ALPHA11、ALPHA22、TEMPERATURE、EXTRA_FIELDS が含まれます。

 | expansionType | 膨張のタイプを指定する Integer 。

 | temperatureReference | 温度基準のデータを指定する Double 。

 | temperatureDependency | 温度依存データの使用を指定する Boolean 型。

 | dependencies | 温度の依存関係の数を指定する Integer 。

サンプルコード​

structure_steel = Properties.Material.Add(strMaterialName="Structural_Steel",
    listMaterialProperty=[Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])],
    iMaterialID=5)

JPT.Debugger(structure_steel) # 戻り値を確認するため
