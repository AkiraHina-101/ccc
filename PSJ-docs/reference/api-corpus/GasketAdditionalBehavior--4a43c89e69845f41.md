# GasketAdditionalBehavior

GasketAdditionalBehavior

Description​

This is an instance of a GasketAdditionalBehavior class, represents GasketAdditionalBehavior characteristic of material.

Properties​

 | Attribute | Description

 | initialGap | A Float specifying the initial gap value.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[GasketAdditionalBehavior(initialGap=0.2)], 
                                    iMaterialID=1, 
                                    iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value
