# Expansion

Expansion

Description​

This is an instance of an Expansion class, represents Expansion characteristic of material.

Properties​

 | Attribute | Description

 | expansion | A List of Tuple specifying all data of Expansion characteristic.

 | expansionType | An Integer specifying the type of Expansion.
 According to the selected type, there will be corresponding elastic parameters.

 | temperatureReference | A Double specifying data of temperature reference.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

 | dependencies | An Integer specifying the number of dependencies in temperature.

Expansion Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: ALPHA is equal to ID = 69.

 expansionType = ISOTROPIC 

 | INT Notation | Key Name | Description

 | 69 | ALPHA | A Tuple specifying the expansion coefficient alpha data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Expansion(expansion=[
                                        (ALPHA, [1.2e-05]), 
                                        (TEMPERATURE, [100.0])], 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=11399605, 
                                        strDescription=Expansion-ISOTROPIC)
JPT.Debugger(sample_Mat) #for checking return value

 expansionType = ORTHOTROPIC(2D) 

 | INT Notation | Key Name | Description

 | 70 | ALPHA11 | A Tuple specifying the Alpha11(A1) data.

 | 71 | ALPHA22 | A Tuple specifying the Alpha22(A2) data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Expansion(expansion=[
                                        (ALPHA11, [1.2e-05]), 
                                        (ALPHA22, [1.5e-05]), 
                                        (TEMPERATURE, [100.0])], 
                                        expansionType=1, 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=11399605, 
                                        strDescription=Expansion-ISOTROPIC(2D))
JPT.Debugger(sample_Mat) #for checking return value

 expansionType = ORTHOTROPIC(3D) 

 | INT Notation | Key Name | Description

 | 70 | ALPHA11 | A Tuple specifying the Alpha11(A1) data.

 | 71 | ALPHA22 | A Tuple specifying the Alpha22(A2) data.

 | 72 | ALPHA33 | A Tuple specifying the Alpha33(A3) data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Expansion(expansion=[
                                        (ALPHA11, [1.2e-05]), 
                                        (ALPHA22, [1.5e-05]), 
                                        (ALPHA33, [2e-05]), 
                                        (TEMPERATURE, [100.0])], 
                                        expansionType=2, 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=11399605, 
                                        strDescription=Expansion-ORTHOTROPIC(3D))
JPT.Debugger(density) #for checking return value

 expansionType = ANISOTROPIC(2D) 

 | INT Notation | Key Name | Description

 | 70 | ALPHA11 | A Tuple specifying the Alpha11(A1) data.

 | 71 | ALPHA22 | A Tuple specifying the Alpha22(A2) data.

 | 73 | ALPHA12 | A Tuple specifying the Alpha12(A3) data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Expansion(expansion=[
                                        (ALPHA11, [1.2e-05]), 
                                        (ALPHA22, [1.5e-05]), 
                                        (ALPHA12, [2e-05]), 
                                        (TEMPERATURE, [100.0])], 
                                        expansionType=4, 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=11399605, 
                                        strDescription=Expansion-ANISOTROPIC(2D))
JPT.Debugger(sample_Mat) #for checking return value

 expansionType = ANISOTROPIC(3D) 

 | INT Notation | Key Name | Description

 | 70 | ALPHA11 | A Tuple specifying the Alpha11(A1) data.

 | 71 | ALPHA22 | A Tuple specifying the Alpha22(A2) data.

 | 72 | ALPHA33 | A Tuple specifying the Alpha33(A3) data.

 | 73 | ALPHA12 | A Tuple specifying the Alpha12(A4) data.

 | 74 | ALPHA23 | A Tuple specifying the Alpha12(A5) data.

 | 75 | ALPHA13 | A Tuple specifying the Alpha12(A6) data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Expansion(expansion=[
                                        (ALPHA11, [1e-05]), 
                                        (ALPHA22, [2e-05]), 
                                        (ALPHA33, [3e-05]), 
                                        (ALPHA12, [4e-05]), 
                                        (ALPHA13, [5e-05]), 
                                        (ALPHA23, [6e-05]), 
                                        (TEMPERATURE, [100.0])], 
                                        expansionType=5, 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=11399605, 
                                        strDescription=Elastic-LAMINA)
JPT.Debugger(sample_Mat) #for checking return value
