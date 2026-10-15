# ViscoElastic

ViscoElastic

Description​

This is an instance of a Viscoelastic class, represents Viscoelastic characteristic of material.

Properties​

 | Attribute | Description

 | viscoElastic | A List of Tuple specifying all data of Viscoelastic characteristic.

 | timeShiftTempDepend | A Boolean specifying the use of temperature-dependent data.

 | timeShiftDependencies | A Integer specifying the use of time-dependent data.

Viscoelastic Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: PRESSURE_FORCE_LOADING is equal to ID = 63.



 | INT Notation | Key Name | Description

 | 2 | SHEAR_MODULUS | A Tuple specifying the shear modulus data.

 | 76 | BULK_MODULUS | A Tuple specifying the bulk modulus data.

 | 77 | TIME_DELAY | A Tuple specifying the time delay data.

 | 78 | SHIFT_FACTOR | A Tuple specifying the shift factor data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[ViscoElastic(viscoElastic=[
                                        (SHEAR_MODULUS, [180.0]), 
                                        (BULK_MODULUS, [100.0]), 
                                        (TIME_DELAY, [10.0]), 
                                        (SHIFT_FACTOR, [5.0]), 
                                        (TEMPERATURE, [300.0])], 
                                        timeShiftTempDepend=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value
