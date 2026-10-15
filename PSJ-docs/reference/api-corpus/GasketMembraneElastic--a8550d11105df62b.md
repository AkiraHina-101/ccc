# GasketMembraneElastic

GasketMembraneElastic

Description​

This is an instance of a GasketMembraneElastic class, represents GasketMembraneElastic characteristic of material.

Properties​

 | Attribute | Description

 | gasketMembraneElastic | A List of Tuple specifying all data of GasketMembraneElastic characteristic.

 | temperatureDependency | A Boolean specifying whether to use the temperature-dependent data.

 | dependencies | An Integer specifying the number of field variables.

GasketMembraneElastic Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: YOUNGS_MODULUS is equal to ID = 1.

 | INT Notation | Key Name | Description

 | 1 | YOUNGS_MODULUS | A Tuple specifying the young modulus data.

 | 3 | POISSONS_RATIO | A Tuple specifying the poisson ratio data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra field data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[GasketMembraneElastic(gasketMembraneElastic=[
                                        (YOUNGS_MODULUS, [200000000000.0]), 
                                        (POISSONS_RATIO, [80000.0]), 
                                        (TEMPERATURE, [100.0])], 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=11399605, 
                                        strDescription="GasketMembraneElastic")
JPT.Debugger(sample_Mat) #for checking return value
