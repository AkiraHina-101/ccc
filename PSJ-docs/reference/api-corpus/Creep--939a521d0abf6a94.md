# Creep

Creep

Description​

This is an instance of a Creep class, represents Creep characteristic of material.

Properties​

 | Attribute | Description

 | creep | A List of Tuple specifying all data of Creep characteristic.

 | lawType | An Integer specifying the law option.

 | suboption | An Integer specifying the subordinate option.

 | advcHardenType | An Integer specifying the ADVC harden option.

 | advcLawType | An Integer specifying the ADVC law option.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

Creep Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: PRESSURE_FORCE_LOADING is equal to ID = 63.

 lawType = Strain-Hardening 

 | INT Notation | Key Name | Description

 | 118 | POWER_LAW_MULTIPLIER | A Tuple specifying the power law multiplier data.

 | 121 | EQ_STRESS_ORDER | A Tuple specifying the Eq stress order data.

 | 124 | TIME_ORDER | A Tuple specifying the time order data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Creep(creep=      
                                        [(POWER_LAW_MULTIPLIER, [2.0]), 
                                        (EQ_STRESS_ORDER, [1.0]), 
                                        (TIME_ORDER, [1.0]), 
                                        (TEMPERATURE, [300.0])], 
                                        lawType=0, 
                                        suboption=0, 
                                        advcHardenType=1, advcLawType=0, 
                                        temperatureDependency=1)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value

 lawType = Time-Hardening 

 | INT Notation | Key Name | Description

 | 118 | POWER_LAW_MULTIPLIER | A Tuple specifying the power law multiplier data.

 | 121 | EQ_STRESS_ORDER | A Tuple specifying the Eq stress order data.

 | 124 | TIME_ORDER | A Tuple specifying the time order data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

Sample Code

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material",     
                                        listMaterialProperty=[Creep(creep=
                                            [(POWER_LAW_MULTIPLIER, [2.0]), 
                                            (EQ_STRESS_ORDER, [1.0]), 
                                            (TIME_ORDER, [1.0]), 
                                            (TEMPERATURE, [300.0])], 
                                            lawType=1, 
                                            suboption=0, 
                                            advcHardenType=1, 
                                            advcLawType=0, 
                                            temperatureDependency=1)], 
                                            iMaterialID=1, iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value

 lawType = Hyperbolic-Sine 

 | INT Notation | Key Name | Description

 | 118 | POWER_LAW_MULTIPLIER | A Tuple specifying the power law multiplier data.

 | 119 | HYPER_LAW_MULTIPLIER | A Tuple specifying the hyper law multiplier data.

 | 121 | EQ_STRESS_ORDER | A Tuple specifying the Eq stress order data.

 | 123 | ACTIVATION_ENERGY | A Tuple specifying the activation energy data.

 | 122 | UNIVERSAL_GAS_CONST | A Tuple specifying the Universal gas const data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

Sample Code

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[Creep(creep=
                                            [(POWER_LAW_MULTIPLIER, [2.0]), 
                                            (HYPER_LAW_MULTIPLIER, [2.0]), 
                                            (EQ_STRESS_MULTIPLIER, [1.0]), 
                                            (ACTIVATION_ENERGY, [500.0]), 
                                            (UNIVERSAL_GAS_CONST, [10.0]), 
                                            (TEMPERATURE, [300.0])], 
                                            lawType=2, 
                                            suboption=0, 
                                            advcHardenType=1, 
                                            advcLawType=0, 
                                            temperatureDependency=1)], 
                                            iMaterialID=1, 
                                            iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value

 lawType = ADVC-Law 

 | INT Notation | Key Name | Description

 | 101 | C0 | A Tuple specifying the C0 data.

 | 102 | C1 | A Tuple specifying the C1 data.

 | 103 | C2 | A Tuple specifying the C2 data.

 | 104 | C3 | A Tuple specifying the C3 data.

Sample Code

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[Creep(creep=
                                            [(C0, [100.0]), 
                                            (C1, [200.0]), 
                                            (C2, [100.0]), 
                                            (C3, [300.0])], 
                                            lawType=4, 
                                            suboption=0, 
                                            advcHardenType=1, 
                                            advcLawType=0, 
                                            temperatureDependency=1)], 
                                            iMaterialID=1, 
                                            iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value
