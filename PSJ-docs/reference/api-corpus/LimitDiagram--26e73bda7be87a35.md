# LimitDiagram

LimitDiagram

Description​

This is an instance of a Limit Diagram class, represents Limit Diagram characteristic of material.

Properties​

 | Attribute | Description

 | limitDiagram | A List of Tuple specifying all data of Limit Diagram characteristic. 

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

 | dependencies | An Integer specifying the number of dependencies in temperature.

Limit Diagram Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: PRESSURE_FORCE_LOADING is equal to ID = 63.

 | INT Notation | Key Name | Description

 | 125 | MEAN_STRESS | A Tuple specifying the mean stress data.

 | 126 | STRESS_AMPLITUDE | A Tuple specifying the stress amplitude data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[FatigueLimitDiagram(limitDiagram=[
                                        (MEAN_STRESS, [0.8]), 
                                        (STRESS_AMPLITUDE, [10.0]), 
                                        (TEMPERATURE, [300.0])], 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=1415085)

JPT.Debugger(sample_Mat) #for checking return value
