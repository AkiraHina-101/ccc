# LimitDiagram

LimitDiagram

説明​

これは、材料の限界図表特性を表す Limit Diagram クラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | limitDiagram | 限界図特性の全データを指定する Tuple のリスト。

 | temperatureDependency | 温度依存データの使用を指定する Boolean 型。

 | dependencies | 温度における依存関係の数を指定する Integer 。

限界図特性​

材料プロパティを定義するために KEY NAME または ID のいずれかを使用できます。
関数内で主に使用された材料プロパティの ID は、Int Notation 列で参照できます。
ただし、材料プロパティの意味を明確に記述するために、ユーザーは ID を指定する代わりに KEY NAME を使用できます。
例えば：PRESSURE_FORCE_LOADING は ID = 63 に等しいです。

 | INT 表記 | Key Name | 説明

 | 125 | MEAN_STRESS | 平均応力データを指定する Tuple。

 | 126 | STRESS_AMPLITUDE | 応力振幅データを指定する Tuple。

 | 130 | TEMPERATURE | 温度依存データを指定する Tuple。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[FatigueLimitDiagram(limitDiagram=[
                                        (MEAN_STRESS, [0.8]), 
                                        (STRESS_AMPLITUDE, [10.0]), 
                                        (TEMPERATURE, [300.0])], 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=1415085)

JPT.Debugger(sample_Mat) #戻り値を確認するため
