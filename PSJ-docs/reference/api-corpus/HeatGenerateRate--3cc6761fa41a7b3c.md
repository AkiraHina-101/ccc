# HeatGenerateRate

HeatGenerateRate

説明​

これは、材料の熱発生率特性を表すHeatGenerateRateクラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | heatGenerateRate | HeatGenerateRate特性のすべてのデータを指定する Tuple のリスト。

 | temperatureDependency | 温度依存性データの使用を指定する Boolean。

HeatGenerateRate特性​

キー名またはIDのどちらかを使用して、材料特性を定義できます。
関数で主に使用された材料特性のIDは、Int Notation列に参照することができます。
ただし、材料特性の意味を明確に説明するために、ユーザーはIDを指定する代わりにキー名を使用することができます。
例：HEAT_GENERATE_RATEはID = 59と等しいです。

 | INT表記 | キー名 | 説明

 | 59 | HEAT_GENERATE_RATE | 熱生成率データを指定する Tuple。

 | 130 | TEMPERATURE | 温度依存性データを指定する Tuple。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[HeatGenerateRate(heatGenerateRate=[
                                        (HEAT_GENERATE_RATE, [0.1]), 
                                        (TEMPERATURE, [200.0])], 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973, 
                                        strDescription="HeatGenerateRate")
JPT.Debugger(sample_Mat) #戻り値のチェック用
