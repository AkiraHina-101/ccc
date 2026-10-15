# ViscoElastic

ViscoElastic

説明​

これは材料の粘弾性特性を表す Viscoelastic クラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | viscoElastic | 粘弾性特性のすべてのデータを指定する Tuple のリストです。

 | timeShiftTempDepend | 温度依存データの使用を指定する Boolean です。

 | timeShiftDependencies | 時間依存データの使用を指定する Integer です。

粘弾性特性​

材料特性を定義するために KEY NAME または ID を使用できます。

機能で主に使用されている材料特性の ID は、Int Notation 列で参照できます。

ただし、材料特性の意味を明示的に記述するために、ユーザーは ID を指定する代わりに KEY NAME を使用できます。

例えば：PRESSURE_FORCE_LOADING は ID = 63 と等しいです。



 | INT 表記 | Key Name | 説明

 | 2 | SHEAR_MODULUS | せん断弾性データを指定する Tuple です。

 | 76 | BULK_MODULUS | 體積弾性データを指定する Tuple です。

 | 77 | TIME_DELAY | 時間遅れデータを指定する Tuple です。

 | 78 | SHIFT_FACTOR | シフトファクターデータを指定する Tuple です。

 | 130 | TEMPERATURE | 温度依存データを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[ViscoElastic(viscoElastic=[
                                        (SHEAR_MODULUS, [180.0]), 
                                        (BULK_MODULUS, [100.0]), 
                                        (TIME_DELAY, [10.0]), 
                                        (SHIFT_FACTOR, [5.0]), 
                                        (TEMPERATURE, [300.0])], 
                                        timeShiftTempDepend=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973)
JPT.Debugger(sample_Mat) # 戻り値を確認するため
