# Viscosity

Viscosity

概要​

これは、材料の粘度特性を表す粘度クラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | viscosity | 粘度特性のすべてのデータを指定する Tuple のリスト。

 | viscosityType | 粘度の種類を指定する Integer 。

 | temperatureDependency | 温度依存データの使用を指定する Boolean。

 | dependencies | 温度依存関係の数を指定する Integer。

粘度特性​

素材の特性を定義するには、 KEY NAME または ID を使用できます。
関数で主に使用される素材特性のIDは、Int Notation 列で参照できます。
ただし、素材特性の意味を明確に説明するために、ユーザーは ID の代わりに KEY NAME を指定できます。
例: PRESSURE_FORCE_LOADING は ID = 63 と等しいです。

 viscosityType = NewTonian 

 | INT Notation | Key Name | 説明

 | 79 | VISCOSITY | 粘度データを指定する Tuple。

 | 130 | TEMPERATURE | 温度依存データを指定する Tuple。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[StructuralViscosity(viscosity=[
                                        (VISCOSITY, [100.0]), 
                                        (TEMPERATURE, [300.0])], 
                                        temperatureDependency=True)], iMaterialID=1, 
                                        iMaterialColor=12901750)
JPT.Debugger(sample_Mat) #戻り値を確認するために使用
