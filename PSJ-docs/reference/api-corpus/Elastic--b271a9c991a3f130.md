# Elastic

Elastic

Description​

This is an instance of an Elastic class, represents Elastic characteristic of material.

Properties​

 | Attribute | Description

 | elastic | A List of Tuple specifying all data of Elastic characteristic.

 | elasticType | An Integer specifying the type of elastic modulus. 
According to the selected type, there will be corresponding elastic parameters.

 | temperatureDependency | A Boolean specifying whether to use the temperature-dependent data.

 | frequencyDependency | A Boolean specifying whether to use the material frequency dependent (Nastran).
 This key name was only used in case of the elasticType = 0

 | dependencies | An Integer specifying the number of dependencies in temperature.

 | moduli | A String specifying the moduli time scale type (for ViscoElasticity).

 | subOption | A String specifying the sub option.

 | noCompression | A Boolean specifying to use in case of incompressibility.

 | noTension | A Boolean specifying to use in case of non-stretchability.

Elastic Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: YOUNGS_MODULUS is equal to ID = 1.

 elasticType = ISOTROPIC 

 | INT Notation | Key Name | Description

 | 1 | YOUNGS_MODULUS | A Tuple specifying the young modulus data.

 | 2 | SHEAR_MODULUS | A Tuple specifying the shear modulus data.

 | 3 | POISSONS_RATIO | A Tuple specifying the poisson ratio data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependence data.

 | 139 | FREQUENCY_DEPENDENCE | A Tuple specifying the frequency-dependence data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

 | 4 | NASTRAN_FAILURE_INDEX_TENSION | A Tuple specifying the Nastran failure index tension data.

 | 5 | NASTRAN_FAILURE_INDEX_COMPRESSION | A Tuple specifying the Nastran failure index compression data.

 | 6 | NASTRAN_FAILURE_INDEX_SHEAR | A Tuple specifying the Nastran failure index shear data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (YOUNGS_MODULUS, [200000000000.0]), 
                                        (SHEAR_MODULUS, [80000000000.0]), 
                                        (POISSONS_RATIO, [0.3]), 
                                        (TEMPERATURE, [100.0]), 
                                        (FREQUENCY_DEPENDENCE, [150.0]), 
                                        (NASTRAN_FAILURE_INDEX_TENSION, [100000.0]), 
                                        (NASTRAN_FAILURE_INDEX_COMPRESSION, [80000.0]), 
                                        (NASTRAN_FAILURE_INDEX_SHEAR, [50000.0])], 
                                        temperatureDependency=True, 
                                        frequencyDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=16131973, 
                                        strDescription="Elastic-ISOTROPIC")
JPT.Debugger(sample_Mat) #for checking return value

 elasticType = ORTHOTROPIC(2D) 

 | INT Notation | Key Name | Description

 | 7 | E1 | A Tuple specifying the E1 data.

 | 8 | E2 | A Tuple specifying the E2 data.

 | 13 | G12 | A Tuple specifying the G12 data.

 | 14 | G1Z | A Tuple specifying the G1z data.

 | 15 | G2Z | A Tuple specifying the G2z data.

 | 18 | NU12 | A Tuple specifying the Nu12 data.

 | 21 | XT | A Tuple specifying the Xt data.

 | 22 | XC | A Tuple specifying the Xc data.

 | 23 | YT | A Tuple specifying the Yt data.

 | 24 | YC | A Tuple specifying the Yc data.

 | 25 | S | A Tuple specifying the S data.

 | 26 | F12 | A Tuple specifying the F12 data.

 | 27 | STRN | A Tuple specifying the STRN data.

Sample Code

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[Elastic(elastic=[
                                            (E1, [10000000.0]), 
                                            (E2, [20000000.0]), 
                                            (G12, [30000000.0]), 
                                            (G1Z, [40000000.0]), 
                                            (G2Z, [50000000.0]), 
                                            (NU12, [60.0]), 
                                            (XT, [10.0]), 
                                            (XC, [20.0]), 
                                            (YT, [30.0]), 
                                            (YC, [40.0]), 
                                            (S, [50.0]), 
                                            (F12, [60.0]), 
                                            (STRN, [70.0])], 
                                            elasticType=1)], 
                                            iMaterialID=1, 
                                            iMaterialColor=1415085, 
                                            strDescription=Elastic-ORTHOTROPIC(2D))
JPT.Debugger(sample_Mat) #for checking return value

 elasticType = ORTHOTROPIC(3D Type1) 

 | INT Notation | Key Name | Description

 | 7 | E1 | A Tuple specifying the E1 data.

 | 8 | E2 | A Tuple specifying the E2 data.

 | 9 | E3 | A Tuple specifying the E3 data.

 | 18 | NU12 | A Tuple specifying the Nu12 data.

 | 19 | NU13 | A Tuple specifying the Nu13 data.

 | 20 | NU23 | A Tuple specifying the Nu23 data.

 | 13 | G12 | A Tuple specifying the Nu12 data.

 | 16 | G13 | A Tuple specifying the Nu13 data.

 | 17 | G23 | A Tuple specifying the Nu23 data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Data", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (E1, [10.0]), 
                                        (E2, [20.0]), 
                                        (E3, [30.0]), 
                                        (NU12, [40.0]), 
                                        (NU13, [50.0]), 
                                        (NU23, [60.0]), 
                                        (G12, [70.0]), 
                                        (G13, [80.0]), 
                                        (G23, [90.0]), 
                                        (TEMPERATURE, [100.0])], 
                                        elasticType=2, 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=13770132, 
                                        strDescription="Elastic-ORTHOTROPIC(3DType1)")
JPT.Debugger(sample_Mat) #for checking return value

 elasticType = ORTHOTROPIC(3D Type2) 

 | INT Notation | Key Name | Description

 | 28 | D1111 | A Tuple specifying the D1111 data.

 | 29 | D1122 | A Tuple specifying the D1122 data.

 | 30 | D2222 | A Tuple specifying the D2222 data.

 | 31 | D1133 | A Tuple specifying the D1133 data.

 | 32 | D2233 | A Tuple specifying the D2233 data.

 | 33 | D3333 | A Tuple specifying the D3333 data.

 | 34 | D1212 | A Tuple specifying the D1212 data.

 | 35 | D1313 | A Tuple specifying the D1313 data.

 | 36 | D2323 | A Tuple specifying the D2323 data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (D1111, [10.0]), 
                                        (D1122, [20.0]), 
                                        (D2222, [30.0]), 
                                        (D1133, [40.0]), 
                                        (D2233, [50.0]), 
                                        (D3333, [50.0]), 
                                        (D1212, [70.0]), 
                                        (D1313, [80.0]), 
                                        (D2323, [90.0]), 
                                        (TEMPERATURE, [100.0])], 
                                        elasticType=3, 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=12901750, 
                                        strDescription="Elastic-ORTHOTROPIC(3DType2)")
JPT.Debugger(sample_Mat) #for checking return value

 elasticType = ANISOTROPIC(2D) 

 | INT Notation | Key Name | Description

 | 7 | E1 | A Tuple specifying the E1 data.

 | 8 | E2 | A Tuple specifying the E2 data.

 | 9 | E3 | A Tuple specifying the E3 data.

 | 4 | NASTRAN_FAILURE_INDEX_TENSION | A Tuple specifying the Nastran failure index tension data.

 | 5 | NASTRAN_FAILURE_INDEX_COMPRESSION | A Tuple specifying the Nastran failure index compression data.

 | 6 | NASTRAN_FAILURE_INDEX_SHEAR | A Tuple specifying the Nastran failure index shear data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (E1, [100000000000.0, None, None]), 
                                        (E2, [150000000000.0, 250000000000.0, None]), 
                                        (E3, [200000000000.0, 300000000000.0, 350000000000.0]), 
                                        (NASTRAN_FAILURE_INDEX_TENSION, [100000.0]), 
                                        (NASTRAN_FAILURE_INDEX_COMPRESSION, [80000.0]), 
                                        (NASTRAN_FAILURE_INDEX_SHEAR, [50000.0])], 
                                        elasticType=4)], 
                                        iMaterialID=1, 
                                        iMaterialColor=3742001, 
                                        strDescription="Elastic-ANISOTROPIC(2D)")
JPT.Debugger(density) #for checking return value

 elasticType = ANISOTROPIC(3D) 

 | INT Notation | Key Name | Description

 | 7 | E1 | A Tuple specifying the E1 data.

 | 8 | E2 | A Tuple specifying the E2 data.

 | 9 | E3 | A Tuple specifying the E3 data.

 | 10 | E4 | A Tuple specifying the E4 data.

 | 11 | E5 | A Tuple specifying the E5 data.

 | 12 | E6 | A Tuple specifying the E6 data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (E1, [10000000.0, None, None, None, None, None]), 
                                        (E2, [20000000.0, 70000000.0, None, None, None, None]), 
                                        (E3, [30000000.0, 80000000.0, 120000000.0, None, None, None]), 
                                        (E4, [40000000.0, 90000000.0, 130000000.0, 160000000.0, None, None]), 
                                        (E5, [50000000.0, 100000000.0, 140000000.0, 170000000.0, 190000000.0, None]), 
                                        (E6, [60000000.0, 110000000.0, 150000000.0, 180000000.0, 200000000.0, 210000000.0])], 
                                        elasticType=5)], 
                                        iMaterialID=1, 
                                        iMaterialColor=3742001, 
                                        strDescription=Elastic-ANISOTROPIC(3D))
JPT.Debugger(sample_Mat) #for checking return value

 elasticType = LAMINA 

 | INT Notation | Key Name | Description

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (TEMPERATURE, [100.0])], 
                                        elasticType=6, 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=11399605, 
                                        strDescription="Elastic-LAMINA")
JPT.Debugger(sample_Mat) #for checking return value

 elasticType = TRACTION 

 | INT Notation | Key Name | Description

 | 37 | EKNN | An Tuple specifying the E/Knn data.

 | 38 | G1KSS | A Tuple specifying the G1/Kss data.

 | 39 | G2KTT | A Tuple specifying the G2/Ktt data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[Elastic(elastic=[
                                        (EKNN, [0.1]), 
                                        (G1KSS, [0.2]), 
                                        (G2KTT, [0.3]), 
                                        (TEMPERATURE, [100.0])], 
                                        elasticType=7, 
                                        temperatureDependency=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=11399605, 
                                        strDescription=Elastic-LAMINA)
JPT.Debugger(sample_Mat) #for checking return value

 elasticType = COUPLE_TRACTION 

 | INT Notation | Key Name | Description

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[Elastic(elastic=[
                                            (TEMPERATURE, [100.0])], 
                                            elasticType=8, 
                                            temperatureDependency=True)], 
                                            iMaterialID=1, 
                                            iMaterialColor=11399605, 
                                            strDescription=Elastic-LAMINA)
JPT.Debugger(sample_Mat) #for checking return value

 elasticType = SHORT_FIBER 

 | INT Notation | Key Name | Description

 | 130 | TEMPERATURE | A Tuple specifying the temperature-dependent data.

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data.

Sample Code

sample_Mat = Properties.Material.Modify(strMaterialName="Sample_Material", 
                                        listMaterialProperty=[Elastic(elastic=[
                                            (TEMPERATURE, [100.0])], 
                                            elasticType=9, 
                                            temperatureDependency=True)], 
                                            iMaterialID=1, 
                                            iMaterialColor=11399605, 
                                            strDescription=Elastic-LAMINA)
JPT.Debugger(sample_Mat) #for checking return value
