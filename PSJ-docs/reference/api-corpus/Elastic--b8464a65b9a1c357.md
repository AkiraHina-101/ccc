# Elastic

Elastic

説明​

これは材料の弾性特性を表すElasticクラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | elastic | 弾性特性のすべてのデータを指定する Tuple のリストです。

 | elasticType | 弾性率の種類を指定する Integer です。
選択した種類に応じて、対応する弾性パラメータがあります。

 | temperatureDependency | 温度依存データの使用設定を指定する Boolean です。

 | frequencyDependency | 材料の周波数依存性（Nastran）の使用設定を指定する Boolean です。
このキー名は、elasticType = 0の場合にのみ使用されます。

 | dependencies | 温度の依存性の数を指定する Integer です。

 | moduli | モジュラスの時間スケールタイプを指定する String です（ViscoElasticity用）。

 | subOption | サブオプションを指定する String です。

 | noCompression | 圧縮不能の場合に使用設定を指定する Boolean です。

 | noTension | 伸縮不可能の場合に使用設定を指定する Boolean です。

弾性特性​

材料プロパティを定義する際には、KEY NAMEまたはIDのいずれかを使用できます。
関数で主に使用された材料プロパティのIDは、Int Notation列で参照できます。
ただし、材料プロパティの意味を明確に記述するために、IDを指定する代わりにKEY NAMEを使用できます。
例えば：YOUNGS_MODULUS は ID = 1 と等しいです。

 elasticType = ISOTROPIC 

 | INT表記 | キー名 | 説明

 | 1 | YOUNGS_MODULUS | ヤング率データを指定する Tuple です。

 | 2 | SHEAR_MODULUS | せん断率データを指定する Tuple です。

 | 3 | POISSONS_RATIO | ポアソン比データを指定する Tuple です。

 | 130 | TEMPERATURE | 温度依存データを指定する Tuple です。

 | 139 | FREQUENCY_DEPENDENCE | 周波数依存データを指定する Tuple です。

 | 143 | EXTRA_FIELDS | 追加フィールドデータを指定する Tuple です。

 | 4 | NASTRAN_FAILURE_INDEX_TENSION | Nastran引張り破壊指数データを指定する Tuple です。

 | 5 | NASTRAN_FAILURE_INDEX_COMPRESSION | Nastran圧縮破壊指数データを指定する Tuple です。

 | 6 | NASTRAN_FAILURE_INDEX_SHEAR | Nastranせん断破壊指数データを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (YOUNGS_MODULUS, [200000000000.0]), 
                                        (SHEAR_MODULUS, [80000000000.0]), 
                                        (POISSONS_RATIO, [0.3]), 
                                        (TEMPERATURE, [100.0]), 
                                        (FREQUENCY_DEPENDENCE, [150.0]), 
                                        (NASTRAN_FAILURE_INDEX_TENSION, [100000.0]), 
                                        (NASTRAN_FAILURE_INDEX_COMPRESSION, [80000.0]), 
                                        (NASTRAN_FAILURE_INDEX_SHEAR, [50000.0])], 
                                        temperatureDependency=True, 
                                        frequencyDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973, 
                                        strDescription="Elastic-ISOTROPIC")
JPT.Debugger(sample_Mat) #戻り値の確認

 elasticType = ORTHOTROPIC(2D) 

 | INT表記 | キー名 | 説明

 | 7 | E1 | E1データを指定する Tuple です。

 | 8 | E2 | E2データを指定する Tuple です。

 | 13 | G12 | G12データを指定する Tuple です。

 | 14 | G1Z | G1zデータを指定する Tuple です。

 | 15 | G2Z | G2zデータを指定する Tuple です。

 | 18 | NU12 | Nu12データを指定する Tuple です。

 | 21 | XT | Xtデータを指定する Tuple です。

 | 22 | XC | Xcデータを指定する Tuple です。

 | 23 | YT | Ytデータを指定する Tuple です。

 | 24 | YC | Ycデータを指定する Tuple です。

 | 25 | S | Sデータを指定する Tuple です。

 | 26 | F12 | F12データを指定する Tuple です。

 | 27 | STRN | STRNデータを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[Elastic(elastic=[
                                            (E1, [10000000.0]), 
                                            (E2, [20000000.0]), 
                                            (G12, [30000000.0]), 
                                            (G1Z, [40000000.0]), 
                                            (G2Z, [50000000.0]), 
                                            (NU12, [60.0]), 
                                            (XT, [10.0]), 
                                            (XC, [20.0]), 
                                            (YT, [30.0]), 
                                            (YC, [40.0]), 
                                            (S, [50.0]), 
                                            (F12, [60.0]), 
                                            (STRN, [70.0])], 
                                            elasticType=1)], 
                                            iMaterialID=1, 
                                            iMaterialColor=1415085, 
                                            strDescription="Elastic-ORTHOTROPIC(2D)")
JPT.Debugger(sample_Mat) #戻り値の確認

 elasticType = ORTHOTROPIC(3D Type1) 

 | INT表記 | キー名 | 説明

 | 7 | E1 | E1データを指定する Tuple です。

 | 8 | E2 | E2データを指定する Tuple です。

 | 9 | E3 | E3データを指定する Tuple です。

 | 18 | NU12 | Nu12データを指定する Tuple です。

 | 19 | NU13 | Nu13データを指定する Tuple です。

 | 20 | NU23 | Nu23データを指定する Tuple です。

 | 13 | G12 | Nu12データを指定する Tuple です。

 | 16 | G13 | Nu13データを指定する Tuple です。

 | 17 | G23 | Nu23データを指定する Tuple です。

 | 130 | TEMPERATURE | 温度依存データを指定する Tuple です。

 | 143 | EXTRA_FIELDS | 追加フィールドデータを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Data", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (E1, [10.0]), 
                                        (E2, [20.0]), 
                                        (E3, [30.0]), 
                                        (NU12, [40.0]), 
                                        (NU13, [50.0]), 
                                        (NU23, [60.0]), 
                                        (G12, [70.0]), 
                                        (G13, [80.0]), 
                                        (G23, [90.0]), 
                                        (TEMPERATURE, [100.0])], 
                                        elasticType=2, 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=13770132, 
                                        strDescription="Elastic-ORTHOTROPIC(3DType1)")
JPT.Debugger(sample_Mat) #戻り値の確認

 elasticType = ORTHOTROPIC(3D Type2) 

 | INT表記 | キー名 | 説明

 | 28 | D1111 | D1111データを指定する Tuple です。

 | 29 | D1122 | D1122データを指定する Tuple です。

 | 30 | D2222 | D2222データを指定する Tuple です。

 | 31 | D1133 | D1133データを指定する Tuple です。

 | 32 | D2233 | D2233データを指定する Tuple です。

 | 33 | D3333 | D3333データを指定する Tuple です 。

 | 34 | D1212 | D1212データを指定する Tuple です。

 | 35 | D1313 | D1313データを指定する Tuple です。

 | 36 | D2323 | D2323データを指定する Tuple です。

 | 130 | TEMPERATURE | 温度依存データを指定する Tuple です。

 | 143 | EXTRA_FIELDS | 追加フィールドデータを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (D1111, [10.0]), 
                                        (D1122, [20.0]), 
                                        (D2222, [30.0]), 
                                        (D1133, [40.0]), 
                                        (D2233, [50.0]), 
                                        (D3333, [50.0]), 
                                        (D1212, [70.0]), 
                                        (D1313, [80.0]), 
                                        (D2323, [90.0]), 
                                        (TEMPERATURE, [100.0])], 
                                        elasticType=3, 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=12901750, 
                                        strDescription="Elastic-ORTHOTROPIC(3DType2)")
JPT.Debugger(sample_Mat) #戻り値の確認

 elasticType = ANISOTROPIC(2D) 

 | INT表記 | キー名 | 説明

 | 7 | E1 | E1データを指定する Tuple です。

 | 8 | E2 | E2データを指定する Tuple です。

 | 9 | E3 | E3データを指定する Tuple です。

 | 4 | NASTRAN_FAILURE_INDEX_TENSION | Nastran引張り破壊指数データを指定する Tuple です。

 | 5 | NASTRAN_FAILURE_INDEX_COMPRESSION | Nastran圧縮破壊指数データを指定する Tuple です。

 | 6 | NASTRAN_FAILURE_INDEX_SHEAR | Nastranせん断破壊指数データを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (E1, [100000000000.0, None, None]), 
                                        (E2, [150000000000.0, 250000000000.0, None]), 
                                        (E3, [200000000000.0, 300000000000.0, 350000000000.0]), 
                                        (NASTRAN_FAILURE_INDEX_TENSION, [100000.0]), 
                                        (NASTRAN_FAILURE_INDEX_COMPRESSION, [80000.0]), 
                                        (NASTRAN_FAILURE_INDEX_SHEAR, [50000.0])], 
                                        elasticType=4)], 
                                        iMaterialID=1, 
                                        iMaterialColor=3742001, 
                                        strDescription="Elastic-ANISOTROPIC(2D)")
JPT.Debugger(density) #戻り値の確認

 elasticType = ANISOTROPIC(3D) 

 | INT表記 | キー名 | 説明

 | 7 | E1 | E1データを指定する Tuple です。

 | 8 | E2 | E2データを指定する Tuple です。

 | 9 | E3 | E3データを指定する Tuple です。

 | 10 | E4 | E4データを指定する Tuple です。

 | 11 | E5 | E5データを指定する Tuple です。

 | 12 | E6 | E6データを指定する Tuple です。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (E1, [10000000.0, None, None, None, None, None]), 
                                        (E2, [20000000.0, 70000000.0, None, None, None, None]), 
                                        (E3, [30000000.0, 80000000.0, 120000000.0, None, None, None]), 
                                        (E4, [40000000.0, 90000000.0, 130000000.0, 160000000.0, None, None]), 
                                        (E5, [50000000.0, 100000000.0, 140000000.0, 170000000.0, 190000000.0, None]), 
                                        (E6, [60000000.0, 110000000.0, 150000000.0, 180000000.0, 200000000.0, 210000000.0])], 
                                        elasticType=5)], 
                                        iMaterialID=1, 
                                        iMaterialColor=3742001, 
                                        strDescription=Elastic-ANISOTROPIC(3D))
JPT.Debugger(sample_Mat) #for checking return value
