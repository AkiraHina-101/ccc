# Creep

Creep

説明​

これは、材料の特性であるクリープ特性を表すCreepクラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | creep | クリープ特性のすべてのデータを指定する Tuple のリストです。

 | lawType | 法律オプションを指定する Integer です。

 | suboption | 従属オプションを指定する Integer です。

 | advcHardenType | ADVCハーデンオプションを指定する Integer です。

 | advcLawType | ADVC法律オプションを指定する Integer です。

 | temperatureDependency | 温度依存データを使用するかどうかを指定する Boolean です。

クリープ特性​

材料の特性を定義するには、KEY NAMEまたはIDのどちらかを使用できます。
関数で主に使用されていた材料特性のIDは、Int Notation列で参照できます。
ただし、材料特性の意味を明示的に説明するために、ユーザーはIDを指定する代わりにKEY NAMEを使用できます。
たとえば、PRESSURE_FORCE_LOADINGはID = 63と等しいです。

 lawType = Strain-Hardening 

 | INT Notation | Key Name | 説明

 | 118 | POWER_LAW_MULTIPLIER | パワーローマルチプライヤーデータを指定する Tuple です。

 | 121 | EQ_STRESS_ORDER | Eq応力順序データを指定する Tuple です。

 | 124 | TIME_ORDER | 時間順序データを指定する Tuple です。

 | 130 | TEMPERATURE | 温度依存データを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Creep(creep=      
                                        [(POWER_LAW_MULTIPLIER, [2.0]), 
                                        (EQ_STRESS_ORDER, [1.0]), 
                                        (TIME_ORDER, [1.0]), 
                                        (TEMPERATURE, [300.0])], 
                                        lawType=0, 
                                        suboption=0, 
                                        advcHardenType=1, advcLawType=0, 
                                        temperatureDependency=1)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973)
JPT.Debugger(sample_Mat) # 戻り値を確認するため

 lawType = Time-Hardening 

 | INT Notation | Key Name | 説明

 | 118 | POWER_LAW_MULTIPLIER | パワーローマルチプライヤーデータを指定する Tuple です。

 | 121 | EQ_STRESS_ORDER | Eq応力順序データを指定する Tuple です。

 | 124 | TIME_ORDER | 時間順序データを指定する Tuple です。

 | 130 | TEMPERATURE | 温度依存データを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material",     
                                        listMaterialProperty=[Creep(creep=
                                            [(POWER_LAW_MULTIPLIER, [2.0]), 
                                            (EQ_STRESS_ORDER, [1.0]), 
                                            (TIME_ORDER, [1.0]), 
                                            (TEMPERATURE, [300.0])], 
                                            lawType=1, 
                                            suboption=0, 
                                            advcHardenType=1, 
                                            advcLawType=0, 
                                            temperatureDependency=1)], 
                                            iMaterialID=1, iMaterialColor=16131973)
JPT.Debugger(sample_Mat) # 戻り値を確認するため

 lawType = Hyperbolic-Sine 

 | INT Notation | Key Name | 説明

 | 118 | POWER_LAW_MULTIPLIER | パワーローマルチプライヤーデータを指定する Tuple です。

 | 119 | HYPER_LAW_MULTIPLIER | ハイパーローマルチプライヤーデータを指定する Tuple です。

 | 121 | EQ_STRESS_ORDER | Eq応力順序データを指定する Tuple です。

 | 123 | ACTIVATION_ENERGY | 活性化エネルギーデータを指定する Tuple です。

 | 122 | UNIVERSAL_GAS_CONST | ユニバーサルガス定数データを指定する Tuple です。

 | 130 | TEMPERATURE | 温度依存データを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[Creep(creep=
                                            [(POWER_LAW_MULTIPLIER, [2.0]), 
                                            (HYPER_LAW_MULTIPLIER, [2.0]), 
                                            (EQ_STRESS_MULTIPLIER, [1.0]), 
                                            (ACTIVATION_ENERGY, [500.0]), 
                                            (UNIVERSAL_GAS_CONST, [10.0]), 
                                            (TEMPERATURE, [300.0])], 
                                            lawType=2, 
                                            suboption=0, 
                                            advcHardenType=1, 
                                            advcLawType=0, 
                                            temperatureDependency=1)], 
                                            iMaterialID=1, 
                                            iMaterialColor=16131973)
JPT.Debugger(sample_Mat) # 戻り値を確認するため

 lawType = ADVC-Law 

 | INT Notation | Key Name | 説明

 | 101 | C0 | C0データを指定する Tuple です。

 | 102 | C1 | C1データを指定する Tuple です。

 | 103 | C2 | C2データを指定する Tuple です。

 | 104 | C3 | C3データを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[Creep(creep=
                                            [(C0, [100.0]), 
                                            (C1, [200.0]), 
                                            (C2, [100.0]), 
                                            (C3, [300.0])], 
                                            lawType=4, 
                                            suboption=0, 
                                            advcHardenType=1, 
                                            advcLawType=0, 
                                            temperatureDependency=1)], 
                                            iMaterialID=1, 
                                            iMaterialColor=16131973)
JPT.Debugger(sample_Mat) # 戻り値を確認するため
