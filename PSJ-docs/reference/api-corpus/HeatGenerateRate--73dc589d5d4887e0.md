# HeatGenerateRate

HeatGenerateRate

Description​

This is an instance of a HeatGenerateRate class, represents HeatGenerateRate characteristic of material.

Properties​

 | Attribute | Description

 | heatGenerateRate | A List of Tuple specifying all data of HeatGenerateRate characteristic.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

HeatGenerateRate Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: HEAT_GENERATE_RATE is equal to ID = 59.

 | INT Notation | Key Name | Description

 | 59 | HEAT_GENERATE_RATE | A Tuple specifying the heat generate rate data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[HeatGenerateRate(heatGenerateRate=[
                                        (HEAT_GENERATE_RATE, [0.1]), 
                                        (TEMPERATURE, [200.0])], 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973, 
                                        strDescription="HeatGenerateRate")
JPT.Debugger(sample_Mat) #for checking return value
