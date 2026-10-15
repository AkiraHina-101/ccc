# Viscosity

Viscosity

Description​

This is an instance of a Viscosity class, represents Viscosity characteristic of material.

Properties​

 | Attribute | Description

 | viscosity | A List of Tuple specifying all data of Viscosity characteristic.

 | viscosityType | An Integer specifying the type of Viscosity.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

 | dependencies | An Integer specifying the number of dependencies in temperature.

Viscosity Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: PRESSURE_FORCE_LOADING is equal to ID = 63.

 viscosityType = NewTonian 

 | INT Notation | Key Name | Description

 | 79 | VISCOSITY | A Tuple specifying the viscosity data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[StructuralViscosity(viscosity=[
                                        (VISCOSITY, [100.0]), 
                                        (TEMPERATURE, [300.0])], 
                                        temperatureDependency=True)], iMaterialID=1, 
                                        iMaterialColor=12901750)
JPT.Debugger(sample_Mat) #for checking return value
