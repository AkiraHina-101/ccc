# SpecificHeat

SpecificHeat

説明​

これは、材料の特性である熱容量を表すSpecificHeatクラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | specificHeat | 全てのデータを指定する Tuple リストである特性。

 | temperatureDependency | 温度依存データを使用するかを指定する Boolean 。

 | dependencies | フィールド変数の数を指定する Integer 。

SpecificHeat 特性​

材料プロパティを定義する際には、'KEY NAME' または 'ID' のどちらかを使用できます。
関数で主に使用されていた材料プロパティのIDは、Int Notation 列で参照できます。
ただし、材料プロパティの意味を明確に説明するためには、 'ID' を指定する代わりに 'KEY NAME' を使用することができます。
例: SPECIFIC_HEAT は、ID = 58 と等しい。

 | INT Notation | Key Name | 説明

 | 58 | SPECIFIC_HEAT | 特定の熱容量データを指定する Tuple 。

 | 130 | TEMPERATURE | 温度依存データを指定する Tuple。

 | 143 | EXTRA_FIELDS | 追加フィールドデータを指定する Tuple。

サンプルコード

sample_Mat = Properties.Material.Modify(strMaterialName="サンプル材料", 
                                        listMaterialProperty=[SpecificHeat(specificHeat=[
                                            (SPECIFIC_HEAT, [461.0]), 
                                            (TEMPERATURE, [100.0])], 
                                            temperatureDependency=True)], 
                                            iMaterialID=1, 
                                            iMaterialColor=16059195, 
                                            strDescription=SpecificHeat)
JPT.Debugger(sample_Mat) # 戻り値を確認するために使用
