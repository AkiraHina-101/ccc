# GasketMembraneElastic

GasketMembraneElastic

説明​

これは、GasketMembraneElastic クラスのインスタンスであり、材料の GasketMembraneElastic 特性を表します。

プロパティ​

 | 属性 | 説明

 | gasketMembraneElastic | GasketMembraneElastic特性 のすべてのデータを指定する Tuple のリスト。

 | temperatureDependency | 温度依存性データの使用の可否を指定する Boolean 型。

 | dependencies | フィールド変数の数を指定する Integer 。

GasketMembraneElastic特性​

材料特性を定義する際に KEY NAME または ID を使用することができます。
関数で主に使用される材料特性の ID は、Int Notation 列で参照することができます。
ただし、材料特性の意味を明示的に説明するためには、ID を明示せずに KEY NAME を使用することが可能です。
たとえば、YOUNGS_MODULUS は ID = 1 と等しいです。

 | INT Notation | Key Name | 説明

 | 1 | YOUNGS_MODULUS | ヤング率データを指定する Tuple。

 | 3 | POISSONS_RATIO | ポアソン比データを指定する Tuple。

 | 130 | TEMPERATURE | 温度依存性データを指定する Tuple。

 | 143 | EXTRA_FIELDS | 追加フィールドデータを指定する Tuple。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[GasketMembraneElastic(gasketMembraneElastic=[
                                        (YOUNGS_MODULUS, [200000000000.0]), 
                                        (POISSONS_RATIO, [80000.0]), 
                                        (TEMPERATURE, [100.0])], 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=11399605, 
                                        strDescription="GasketMembraneElastic")
JPT.Debugger(sample_Mat) # 戻り値を確認するため
