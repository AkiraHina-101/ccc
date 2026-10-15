# Plastic

Plastic

Description​

This is an instance of a Plastic class, represents Plastic characteristic of material.

Properties​

 | Attribute | Description

 | plastic | A List of Tuple specifying all data of Plastic characteristic.

 | harden | An Integer specifying the hardening type.

 | curve | An Integer specifying the curve type.

 | curve_ForCombined | An Integer specifying the curve type that used for Combined Hardening.

 | dataType | An Integer specifying data type that used for Combined Hardening.

 | temperatureDependency | A Boolean specifying whether to use temperature-dependent data.

 | dependencies | An Integer specifying the number of field variables.

 | useStrain | A Boolean specifying whether to use Strain-Range-Dependent data for Isotropic/Combined Hardening.

 | exportAdvc | A Boolean specifying whether to export as mises (ADVC).

 | backStress | An Integer specifying the number of back stresses for Combined Hardening.

 | subOption_Type | An Integer specifying the type of sub option

 | subOption_FieldNum | An Integer specifying the number of fields used for sub option.

 | subOption_UseTempDependent | A Boolean specifying the whether to use temperature-dependent data for sub option.

 | subOption_UseParameter | A Boolean specifying whether to use parameter for sub option.

Plastic Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: PRESSURE_FORCE_LOADING is equal to ID = 63.

 harden = Isotropic 

 | INT Notation | Key Name | Description

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 41 | STRAIN | A Tuple specifying the plastic train data.

 | 140 | STRAIN_RATE | A Tuple specifying the strain-rate-dependent data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

 | 60 | EQUIV_STRESS | A Tuple specifying the equivalent stress data.

 | 62 | Q_INFINITY | A Tuple specifying the Q infinity data.

 | 68 | HARDENING_B | A Tuple specifying the hardening B data.

 | 133 | TEMPERATURE_SUB | A Tuple specifying the temperature sub option data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Plastic(plastic=[
                                        (STRESS, [0.0005]), 
                                        (STRAIN, [0.2]), 
                                        (STRAIN_RATE, [0.2]), 
                                        (TEMPERATURE, [100.0])], 
                                        temperatureDependency=True, 
                                        useStrain=True, 
                                        exportAdvc=True, 
                                        subOption_Type=1)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value

 harden = Kinematic 

 | INT Notation | Key Name | Description

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 41 | STRAIN | A Tuple specifying the plastic train data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 60 | EQUIV_STRESS | A Tuple specifying the equivalent stress data.

 | 62 | Q_INFINITY | A Tuple specifying the Q infinity data.

 | 68 | HARDENING_B | A Tuple specifying the hardening B data.

 | 133 | TEMPERATURE_SUB | A Tuple specifying the temperature sub option data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Plastic(plastic=[
                                        (STRESS, [0.0005]), 
                                        (STRAIN, [0.2]), 
                                        (TEMPERATURE, [1000.0])], 
                                        harden=1, 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value

 harden = Johnson_Cook 

 | INT Notation | Key Name | Description

 | 42 | A | A Tuple specifying the A data.

 | 43 | B | A Tuple specifying the B data.

 | 44 | M | A Tuple specifying the M data.

 | 45 | N | A Tuple specifying the N data.

 | 46 | MELTING_TEMP | A Tuple specifying the melting temperature data.

 | 47 | TRANSITION_TEMP | A Tuple specifying transition temperature data.

 | 60 | EQUIV_STRESS | A Tuple specifying the equivalent stress data.

 | 62 | Q_INFINITY | A Tuple specifying the Q infinity data.

 | 68 | HARDENING_B | A Tuple specifying the hardening B data.

 | 133 | TEMPERATURE_SUB | A Tuple specifying the temperature sub option data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                listMaterialProperty=[Plastic(plastic=[
                                    (A, [10.0]),
                                    (B, [20.0]), 
                                    (M, [30.0]), 
                                    (N, [40.0]), 
                                    (MELTING_TEMP, [50.0]), 
                                    (TRANSITION_TEMP, [60.0])], 
                                    harden=2)], 
                                    iMaterialID=1, 
                                    iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value

 harden = User 

 | INT Notation | Key Name | Description

 | 48 | HARDENING_PROP | A Tuple specifying the hardening properties data.

 | 60 | EQUIV_STRESS | A Tuple specifying the equivalent stress data.

 | 62 | Q_INFINITY | A Tuple specifying the Q infinity data.

 | 68 | HARDENING_B | A Tuple specifying the hardening B data.

 | 133 | TEMPERATURE_SUB | A Tuple specifying the temperature sub option data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                listMaterialProperty=[Plastic(plastic=[
                                    (HARDENING_PROP, [10.0])], 
                                    harden=3)], 
                                    iMaterialID=1, 
                                    iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value

 harden = Combined 



 | INT Notation | Key Name | Description

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 41 | STRAIN | A Tuple specifying the plastic train data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 60 | EQUIV_STRESS | A Tuple specifying the equivalent stress data.

 | 62 | Q_INFINITY | A Tuple specifying the Q infinity data.

 | 68 | HARDENING_B | A Tuple specifying the hardening parameter b data.

 | 133 | TEMPERATURE_SUB | A Tuple specifying the temperature-dependent for sub option data.

 | 49 | GAMMA | A Tuple specifying the gamma data.

 | 50 | HARD_PARAM | A Tuple specifying the hardening parameter data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Plastic(plastic=[
                                        (STRESS, [0.0005]), 
                                        (STRAIN, [200.0]), 
                                        (TEMPERATURE, [500.0]), 
                                        (EQUIV_STRESS, [200.0]), 
                                        (Q_INFINITY, [10.0]), 
                                        (HARDENING_B, [11.0]), 
                                        (TEMPERATURE_SUB, [22.0])], 
                                        harden=4, 
                                        temperatureDependency=True, 
                                        backStress=2, 
                                        subOption_Type=3, 
                                        subOption_UseTempDependent=True, 
                                        subOption_UseParameter=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973)
JPT.Debugger(sample_Mat) #for checking return value
