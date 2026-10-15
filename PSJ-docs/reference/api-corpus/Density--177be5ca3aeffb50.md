# Density

Density

Description​

This is an instance of a Density class, represents Density characteristic of material.

Properties​

 | Attribute | Description

 | density | A List of Tuple specifying all data of Density characteristic.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

 | dependencies | An Integer specifying the number of dependencies in temperature.

Density Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: DENSITY is equal to ID = 0.

 | INT Notation | Key Name | Description

 | 0 | DENSITY | A Tuple specifying the density data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra field data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                listMaterialProperty=[Density(density=[
                                    (DENSITY, [7850.000000000001]), 
                                    (TEMPERATURE, [100.0]), 
                                    (EXTRA_FIELDS, [[200.0], [300.0]])], 
                                    temperatureDependency=True, 
                                    dependencies=2)], 
                                iMaterialID=5, 
                                iMaterialColor=10264731)
JPT.Debugger(sample_Mat) #for checking return value
