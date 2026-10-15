# Conductivity

Conductivity

Description​

This is an instance of a Conductivity class, represents Conductivity characteristic of material.

Properties​

 | Attribute | Description

 | conductivity | A List of Tuple specifying all data of Conductivity characteristic.

 | conductivityType | An Integer specifying the type of conductivity.
 According to the selected type, there will be corresponding conductivity parameters.

 | temperatureDependency | A Boolean specifying whether to use the temperature-dependence data.

 | dependencies | An Integer specifying the number of field variables.

Conductivity Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: CONDUCTIVITY is equal to ID = 51.

 conductivityType = ISOTROPIC 

 | Int Notation | Key Name | Description

 | 51 | CONDUCTIVITY | A Tuple specifying the conductivity data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[Conductivity(conductivity=[
                                            (CONDUCTIVITY, [59.0]), 
                                            (TEMPERATURE, [200.0])], 
                                            temperatureDependency=True)], 
                                            iMaterialID=1, 
                                            iMaterialColor=13708224, 
                                            strDescription=Conductivity)
JPT.Debugger(sample_Mat) #for checking return value

 conductivityType = ORTHOTROPIC 

 | Int Notation | Key Name | Description

 | 52 | K11 | A Tuple specifying the K11 data.

 | 53 | K22 | A Tuple specifying the K22 data.

 | 54 | K33 | A Tuple specifying the K33 data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[Conductivity(conductivity=[
                                            (K11, [10.0]), (K22, [20.0]), (K33, [30.0]), 
                                            (TEMPERATURE, [100.0])], 
                                            conductivityType=1, 
                                            temperatureDependency=True)], 
                                            iMaterialID=1, 
                                            iMaterialColor=1506702, 
                                            strDescription=Conductivity)
JPT.Debugger(sample_Mat) #for checking return value

 conductivityType = ANISOTROPIC 

 | Int Notation | Key Name | Description

 | 52 | K11 | A Tuple specifying the K11 data.

 | 53 | K22 | A Tuple specifying the K22 data.

 | 54 | K33 | A Tuple specifying the K33 data.

 | 55 | K12 | A Tuple specifying the K12 data.

 | 56 | K13 | A Tuple specifying the K13 data.

 | 57 | K23 | A Tuple specifying the K23 data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[Conductivity(conductivity=[
                                            (K11, [10.0]), (K12, [20.0]), (K22, [30.0]), 
                                            (K13, [40.0]), (K23, [50.0]), (K33, [60.0]), 
                                            (TEMPERATURE, [100.0])], 
                                            conductivityType=2, 
                                            temperatureDependency=True)], 
                                            iMaterialID=1, 
                                            iMaterialColor=4738715, 
                                            strDescription=Conductivity)
JPT.Debugger(sample_Mat) #for checking return value
