# GasketAdditionalBehavior

GasketAdditionalBehavior

説明​

これは、材料のGasketAdditionalBehavior特性を表すGasketAdditionalBehaviorクラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | initialGap | 初期ギャップ値を指定する Float です。

サンプルコード

sample_Mat = Properties.Material.Add(strMaterialName="サンプル材料", 
                                    listMaterialProperty=[GasketAdditionalBehavior(initialGap=0.2)], 
                                    iMaterialID=1, 
                                    iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #戻り値を確認するため
