# Resistivity

Resistivity

説明​

これは、材料の抵抗率特性を表す抵抗率クラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | resistivity | 抵抗率特性 のすべてのデータを指定する Tuple のリストです。

 | temperatureDependency | 温度依存データの使用を指定する Boolean です。

抵抗率特性​

材料の特性を定義するために KEY NAME または ID を使用できます。
機能で主に使用される材料特性のIDは、Int Notation 列で参照できます。
ただし、材料特性の意味を明示的に説明するために、ユーザーは ID を指定する代わりに KEY NAME を使用することができます。
例えば: PRESSURE_FORCE_LOADING は、ID = 63 と等しいです。

 | INT 記法 | Key Name | 説明

 | 128 | RESISTIVITY | 抵抗率データを指定する Tuple です。

 | 130 | TEMPERATURE | 温度依存データを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Resistivity(resistivity=[
                                        (RESISTIVITY, [0.0005]), 
                                        (TEMPERATURE, [573.15])], 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=3742001)
JPT.Debugger(sample_Mat) #戻り値を確認するために使用
