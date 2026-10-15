# Damping

Damping

Description​

This is an instance of a Damping class, represents Damping characteristic of material.

Properties​

 | Attribute | Description

 | damping | A List of Tuple specifying all data of Damping characteristic.

 | alpha | A Float specifying the alpha parameter.

 | beta | A Float specifying the beta parameter.

 | composite | A Float specifying the composite data.

 | structure | A Float specifying the structural data.

Damping Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: PRESSURE_FORCE_LOADING is equal to ID = 63.

 | INT Notation | Key Name | Description

 | 127 | DAMPING | A Tuple specifying the damping data.

 | 129 | FREQUENCY | A Tuple specifying the frequency data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Damping(damping=[
                                    (DAMPING, [100.0]), 
                                    (FREQUENCY, [50.0])], 
                                    alpha=0.2, 
                                    beta=0.8, 
                                    composite=200.0, 
                                    structural=500.0)], 
                                    iMaterialID=1, 
                                    iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value
