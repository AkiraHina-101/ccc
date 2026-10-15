# LowDensityFoam

LowDensityFoam

Description​

This is an instance of a Low Density Foam class, represents Low Density Foam characteristic of material.

Properties​

 | Attribute | Description

 | lowDensityFoam | A List of Tuple specifying all data of Low Density Foam characteristic. 

 | mu0 | A Float specifying the first parameter mu.

 | mu1 | A Float specifying the second parameter mu.

 | alpha | A Float specifying the parameter alpha.

 | dependenciesTension | An Integer specifying the dependencies tension.

 | dependenciesCompression | A String specifying the dependencies compression.

Low Density Foam characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: PRESSURE_FORCE_LOADING is equal to ID = 63.



 | INT Notation | Key Name | Description

 | 115 | STRESS_TENSION | A Tuple specifying the stress tension data.

 | 117 | STRAIN_TENSION | A Tuple specifying the strain tension data.

 | 142 | STRAIN_RATE_TENSION | A Tuple specifying the strain rate tension.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[LowDensityFoam(lowDensityFoam=[
                                        (STRESS_TENSION, [5e-07]), 
                                        (STRAIN_TENSION, [0.2]), 
                                        (STRAIN_RATE_TENSION, [3.0])], 
                                        mu0=0.0001, 
                                        mu1=0.005, 
                                        alpha=2.0)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value
