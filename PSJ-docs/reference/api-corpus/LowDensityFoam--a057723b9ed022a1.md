# LowDensityFoam

LowDensityFoam

説明​

これは材料の性質である、低密度フォームクラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | lowDensityFoam | 低密度フォームの特性を指定する Tuple のリスト。低密度フォーム特性 のすべてのデータを指定する。 

 | mu0 | muを指定する Float 型の最初のパラメータ。

 | mu1 | muを指定する Float 型の2番目のパラメータ。

 | alpha | パラメータalphaを指定する Float 型。

 | dependenciesTension | 依存関係テンションを指定する Integer 。

 | dependenciesCompression | 依存関係圧縮を指定する String 。

低密度フォーム特性​

材料のプロパティを定義するには、KEY NAME または ID を使用できます。
関数で主に使用されていた材料プロパティのIDは、Int Notation 列で参照できます。
ただし、材料プロパティの意味を明示的に説明するために、ユーザーは ID を指定する代わりに KEY NAME を使用できます。
例えば： PRESSURE_FORCE_LOADING は、ID = 63 と等価です。



 | INT Notation | Key Name | 説明

 | 115 | STRESS_TENSION | ストレステンションデータを指定する Tuple。

 | 117 | STRAIN_TENSION | ストレインテンションデータを指定する Tuple。

 | 142 | STRAIN_RATE_TENSION | ストレインレートテンションを指定する Tuple。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[LowDensityFoam(lowDensityFoam=[
                                        (STRESS_TENSION, [5e-07]), 
                                        (STRAIN_TENSION, [0.2]), 
                                        (STRAIN_RATE_TENSION, [3.0])], 
                                        mu0=0.0001, 
                                        mu1=0.005, 
                                        alpha=2.0)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #戻り値を確認するため
