# SpecificHeat

SpecificHeat

Description​

This is an instance of a SpecificHeat class, represents SpecificHeat characteristic of material.

Properties​

 | Attribute | Description

 | specificHeat | A List of Tuple specifying all data of SpecificHeat characteristic.

 | temperatureDependency | A Boolean specifying whether tp use the temperature-dependent data.

 | dependencies | An Integer specifying the number of field variables.

SpecificHeat Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: SPECIFIC_HEAT is equal to ID = 58.

 | INT Notation | Key Name | Description

 | 58 | SPECIFIC_HEAT | A Tuple specifying the specific heat data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra field data.

Sample Code

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[SpecificHeat(specificHeat=[
                                            (SPECIFIC_HEAT, [461.0]), 
                                            (TEMPERATURE, [100.0])], 
                                            temperatureDependency=True)], 
                                            iMaterialID=1, 
                                            iMaterialColor=16059195, 
                                            strDescription=SpecificHeat)
JPT.Debugger(sample_Mat) #for checking return value
