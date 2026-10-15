# Damping

Damping

説明​

これはマテリアルのダンピング特性を表す、ダンピングクラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | damping | ダンピング特性 のすべてのデータを指定する Tuple のリスト。

 | alpha | アルファパラメータを指定する Float 型。

 | beta | ベータパラメータを指定する Float 型。

 | composite | 複合データを指定する Float 型。

 | structure | 構造データを指定する Float 型。

ダンピング特性​

マテリアルプロパティを定義するために KEY NAME または ID を使用することができます。
機能で主に使用されたマテリアルプロパティのIDは、Int Notation 列で参照できます。
ただし、マテリアルプロパティの意味を明示的に説明するために、ID を指定する代わりに KEY NAME を使用することができます。
例えば: PRESSURE_FORCE_LOADING は ID = 63 と等しいです。

 | INT Notation | Key Name | 説明

 | 127 | DAMPING | ダンピングデータを指定する Tuple。

 | 129 | FREQUENCY | 周波数データを指定する Tuple。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Damping(damping=[
                                    (DAMPING, [100.0]), 
                                    (FREQUENCY, [50.0])], 
                                    alpha=0.2, 
                                    beta=0.8, 
                                    composite=200.0, 
                                    structural=500.0)], 
                                    iMaterialID=1, 
                                    iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value
