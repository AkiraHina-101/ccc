# HyperElastic

HyperElastic

Description​

This is an instance of a Hyperelastic class, represents Hyperelastic characteristic of material.

Properties​

 | Attribute | Description

 | hyperElastic | A List of Tuple specifying all data of Hyperelastic characteristic. 

 | hyperElasticType | A String specifying the type of Hyperelastic.

 | moduli | A String specifying the moduli time scale type (for ViscoElasticity).

 | inputSource | An Integer specifying the source input.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

 | strainEnergyPotentialOrder | An Integer specifying the strain energy potential order.

 | beta | A String specifying the beta parameter.

 | compressible | A Boolean specifying the use of compressible option.

 | properties | An Integer specifying the use of properties.

 | deviatoricResponse | A String specifying the deviatoric response.

 | volumetricResponse | A String specifying the volumetric response.

 | poissonRatio | A Float specifying the poisson ratio.

 | shearModulusDamping | A Float specifying the shear modulus damping.

 | limiStressDamping | A Float specifying the limit stress damping.

 | dependencies | An Integer specifying the number of field variables.

 | applySmooth | A Boolean the use of smooth applying.

 | smoothing | An Integer specifying the smoothing.

 | includeLateralNormalStrain | A Boolean specifying the including lateral normal strain.

 | uniaxialTemperatureDependency | A Boolean specifying the use of uniaxial temperature dependency.

 | uniaxialDependencies | An Integer specifying the uniaxial dependencies.

 | bstart | A Float specifying the BSTART in test data editor.

 | tramp | A Float specifying the TRAMP in test data editor.

Hyperelastic Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: PRESSURE_FORCE_LOADING is equal to ID = 63.\

 strainEnergyPotentialOrder = ARRUDA_BOYCE 

 | INT Notation | Key Name | Description

 | 92 | MU | A Tuple specifying the MU data.

 | 93 | LAMDA_M | A Tuple specifying the lamda data.

 | 94 | D | A Tuple specifying the D data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature data.

 | 110 | NOMIAL_STRESS | A Tuple specifying the nomial stress data.

 | 111 | NOMIAL_STRAIN | A Tuple specifying the nomial strain data.

 | 112 | LATERAL_NOMIAL_STRAIN | A Tuple specifying the lateral nomial strain data.

 | 136 | TEMPERATURE_UNIAXIAL | A Tuple specifying the uniaxial temperature data.

 | 149 | EXTRA_FIELDS_UNIAXIAL | A Tuple specifying the extra uniaxial fields data.

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 113 | TIME | A Tuple specifying the time data.

Sample Code

structure_steel = Properties.Material.Modify(strMaterialName="Structural_Steel", 
    dictMaterialProperty={'HyperElastic': {'hyperElasticType': 'ARRUDA_BOYCE', 'moduli': 'LONG_TERM', 
    'inputSource': 1, 'hyperElastic': {'MU': [3.5e-07], 'LAMDA_M': [1.2], 'D': [3000000.0], 
    'TEMPERATURE': [423.15], 'NOMIAL_STRESS': [0.000112], 'NOMIAL_STRAIN': [130.0], 
    'LATERAL_NOMIAL_STRAIN': [50.0], 'TEMPERATURE_UNIAXIAL': [288.15], 
    'EXTRA_FIELDS_UNIAXIAL': [[80.0], [70.0]], 'STRESS': [0.00032], 'TIME': [124.0]}, 
    'temperatureDependency': 'True', 'volumetricResponse': 'POISSON_RATIO', 'applySmooth': True, 
    'smoothing': 3, 'includeLateralNormalStrain': True, 'uniaxialTemperatureDependency': True, 
    'uniaxialDependencies': 2, 'bstart': 25.0, 'tramp': 15.0}}, iMaterialID=1, iMaterialColor=1415085)

JPT.Debugger(structure_steel) #for checking return value

 strainEnergyPotentialOrder = MARLOW 

 | INT Notation | Key Name | Description

 | 110 | NOMIAL_STRESS | A Tuple specifying the nomial stress data.

 | 111 | NOMIAL_STRAIN | A Tuple specifying the nomial strain data.

 | 112 | LATERAL_NOMIAL_STRAIN | A Tuple specifying the lateral nomial strain data.

 | 136 | TEMPERATURE_UNIAXIAL | A Tuple specifying the uniaxial temperature data.

 | 149 | EXTRA_FIELDS_UNIAXIAL | A Tuple specifying the extra uniaxial fields data.

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 113 | TIME | A Tuple specifying the time data.

Sample Code

structure_steel = Properties.Material.Modify(strMaterialName="Structural_Steel", 
    dictMaterialProperty={'HyperElastic': {'hyperElasticType': 'MARLOW', 'moduli': 'LONG_TERM', 
    'inputSource': 0, 'hyperElastic': {'NOMIAL_STRESS': [0.00011], 'NOMIAL_STRAIN': [75.0], 
    'LATERAL_NOMIAL_STRAIN': [100.0], 'TEMPERATURE_UNIAXIAL': [318.15], 
    'EXTRA_FIELDS_UNIAXIAL': [[150.0], [180.0]], 'STRESS': [2e-05], 'TIME': [45.0]}, 
    'deviatoricResponse': 'UNIAXIAL', 'volumetricResponse': 'VOLUMETRIC_DATA', 'applySmooth': True, 
    'smoothing': 3, 'includeLateralNormalStrain': True, 'uniaxialTemperatureDependency': True, 
    'uniaxialDependencies': 2, 'bstart': 15.0, 'tramp': 36.0}}, iMaterialID=1, iMaterialColor=13770132)

JPT.Debugger(structure_steel) #for checking return value

 strainEnergyPotentialOrder = MOONEY_RIVLIN 

 | INT Notation | Key Name | Description

 | 110 | NOMIAL_STRESS | A Tuple specifying the nomial stress data.

 | 111 | NOMIAL_STRAIN | A Tuple specifying the nomial strain data.

 | 112 | LATERAL_NOMIAL_STRAIN | A Tuple specifying the lateral nomial strain data.

 | 136 | TEMPERATURE_UNIAXIAL | A Tuple specifying the uniaxial temperature data.

 | 149 | EXTRA_FIELDS_UNIAXIAL | A Tuple specifying the extra uniaxial fields data.

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 113 | TIME | A Tuple specifying the time data.

Sample Code

structure_steel = Properties.Material.Modify(strMaterialName="Structural_Steel", 
    dictMaterialProperty={'HyperElastic': {'hyperElasticType': 'MOONEY_RIVLIN', 
    'moduli': 'LONG_TERM', 'inputSource': 0, 'hyperElastic': {'NOMIAL_STRESS': [7.999999999999999e-05], 
    'NOMIAL_STRAIN': [110.0], 'LATERAL_NOMIAL_STRAIN': [30.0], 'TEMPERATURE_UNIAXIAL': [343.15], 
    'EXTRA_FIELDS_UNIAXIAL': [[120.0], [100.0]], 'STRESS': [1.5e-05], 'TIME': [360.0]}, 
    'volumetricResponse': 'VOLUMETRIC_DATA', 'strainEnergyPotentialOrder': 1, 'applySmooth': True, 
    'smoothing': 3, 'includeLateralNormalStrain': True, 'uniaxialTemperatureDependency': True, 
    'uniaxialDependencies': 2, 'bstart': 10.0, 'tramp': 25.0}}, iMaterialID=1, iMaterialColor=12901750)

JPT.Debugger(structure_steel) #for checking return value

 strainEnergyPotentialOrder = NEO_HOOKE 

 | INT Notation | Key Name | Description

 | 110 | NOMIAL_STRESS | A Tuple specifying the nomial stress data.

 | 111 | NOMIAL_STRAIN | A Tuple specifying the nomial strain data.

 | 112 | LATERAL_NOMIAL_STRAIN | A Tuple specifying the lateral nomial strain data.

 | 136 | TEMPERATURE_UNIAXIAL | A Tuple specifying the uniaxial temperature data.

 | 149 | EXTRA_FIELDS_UNIAXIAL | A Tuple specifying the extra uniaxial fields data.

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 113 | TIME | A Tuple specifying the time data.

Sample Code

structure_steel = Properties.Material.Add(strMaterialName="Structural_Steel", 
    dictMaterialProperty={'HyperElastic': {'hyperElasticType': 'NEO_HOOKE', 'moduli': 'LONG_TERM', 
    'inputSource': 0, 'hyperElastic': {'NOMIAL_STRESS': [9.999999999999999e-05], 'NOMIAL_STRAIN': [45.0], 
    'LATERAL_NOMIAL_STRAIN': [25.0], 'TEMPERATURE_UNIAXIAL': [343.15], 
    'EXTRA_FIELDS_UNIAXIAL': [[150.0], [300.0]], 'STRESS': [1.2e-05], 'TIME': [36.0]}, 
    'volumetricResponse': 'VOLUMETRIC_DATA', 'strainEnergyPotentialOrder': 1, 'applySmooth': True, 
    'smoothing': 3, 'includeLateralNormalStrain': True, 'uniaxialTemperatureDependency': True, 
    'uniaxialDependencies': 2, 'bstart': 5.0, 'tramp': 45.0}}, iMaterialID=1, iMaterialColor=16131973)

JPT.Debugger(structure_steel) #for checking return value

 strainEnergyPotentialOrder = OGDEN 

 | INT Notation | Key Name | Description

 | 110 | NOMIAL_STRESS | A Tuple specifying the nomial stress data.

 | 111 | NOMIAL_STRAIN | A Tuple specifying the nomial strain data.

 | 112 | LATERAL_NOMIAL_STRAIN | A Tuple specifying the lateral nomial strain data.

 | 136 | TEMPERATURE_UNIAXIAL | A Tuple specifying the uniaxial temperature data.

 | 149 | EXTRA_FIELDS_UNIAXIAL | A Tuple specifying the extra uniaxial fields data.

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 113 | TIME | A Tuple specifying the time data.

Sample Code

structure_steel = Properties.Material.Modify(strMaterialName="Structural_Steel", 
    dictMaterialProperty={'HyperElastic': {'hyperElasticType': 'OGDEN', 'moduli': 'LONG_TERM', 
    'inputSource': 0, 'hyperElastic': {'NOMIAL_STRESS': [5.999999999999999e-05], 'NOMIAL_STRAIN': [15.0], 
    'LATERAL_NOMIAL_STRAIN': [130.0], 'TEMPERATURE_UNIAXIAL': [358.15], 
    'EXTRA_FIELDS_UNIAXIAL': [[80.0], [150.0]], 'STRESS': [5.5e-05], 'TIME': [25.0]}, 
    'volumetricResponse': 'VOLUMETRIC_DATA', 'strainEnergyPotentialOrder': 1, 'applySmooth': True, 
    'smoothing': 3, 'includeLateralNormalStrain': True, 'uniaxialTemperatureDependency': True, 
    'uniaxialDependencies': 2, 'bstart': 50.0, 'tramp': 20.0}}, iMaterialID=1, iMaterialColor=16131973)

JPT.Debugger(structure_steel) #for checking return value

 strainEnergyPotentialOrder = POLYNOMIAL 

 | INT Notation | Key Name | Description

 | 95 | C10 | A Tuple specifying the C10 data.

 | 96 | C01 | A Tuple specifying the C10 data.

 | 107 | D1 | A Tuple specifying the D1 data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature data.

 | 110 | NOMIAL_STRESS | A Tuple specifying the nomial stress data.

 | 111 | NOMIAL_STRAIN | A Tuple specifying the nomial strain data.

 | 112 | LATERAL_NOMIAL_STRAIN | A Tuple specifying the lateral nomial strain data.

 | 136 | TEMPERATURE_UNIAXIAL | A Tuple specifying the uniaxial temperature data.

 | 149 | EXTRA_FIELDS_UNIAXIAL | A Tuple specifying the extra uniaxial fields data.

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 113 | TIME | A Tuple specifying the time data.

Sample Code

structure_steel = Properties.Material.Modify(strMaterialName="Structural_Steel", 
    dictMaterialProperty={'HyperElastic': {'hyperElasticType': 'POLYNOMIAL', 'moduli': 'LONG_TERM', 
    'inputSource': 1, 'hyperElastic': {'C10': [3.5e-05], 'C01': [1.5e-05], 'D1': [30000000.0], 
    'TEMPERATURE': [473.15], 'NOMIAL_STRESS': [0.000112], 'NOMIAL_STRAIN': [130.0], 
    'LATERAL_NOMIAL_STRAIN': [50.0], 'TEMPERATURE_UNIAXIAL': [288.15], 
    'EXTRA_FIELDS_UNIAXIAL': [[80.0], [70.0]], 'STRESS': [0.00032], 'TIME': [124.0]}, 
    'temperatureDependency': 'True', 'volumetricResponse': 'POISSON_RATIO', 
    'strainEnergyPotentialOrder': 1, 'applySmooth': True, 'smoothing': 3, 
    'includeLateralNormalStrain': True, 'uniaxialTemperatureDependency': True, 'uniaxialDependencies': 2, 
    'bstart': 25.0, 'tramp': 15.0}}, iMaterialID=1, iMaterialColor=1415085)

JPT.Debugger(structure_steel) #for checking return value

 strainEnergyPotentialOrder = REDUCED_POLYNOMIAL 

 | INT Notation | Key Name | Description

 | 95 | C10 | A Tuple specifying the C10 data.

 | 107 | D1 | A Tuple specifying the D1 data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature data.

 | 110 | NOMIAL_STRESS | A Tuple specifying the nomial stress data.

 | 111 | NOMIAL_STRAIN | A Tuple specifying the nomial strain data.

 | 112 | LATERAL_NOMIAL_STRAIN | A Tuple specifying the lateral nomial strain data.

 | 136 | TEMPERATURE_UNIAXIAL | A Tuple specifying the uniaxial temperature data.

 | 149 | EXTRA_FIELDS_UNIAXIAL | A Tuple specifying the extra uniaxial fields data.

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 113 | TIME | A Tuple specifying the time data.

Sample Code

structure_steel = Properties.Material.Modify(strMaterialName="Structural_Steel", 
    dictMaterialProperty={'HyperElastic': {'hyperElasticType': 'REDUCED_POLYNOMIAL', 
    'moduli': 'LONG_TERM', 'inputSource': 1, 'hyperElastic': {'C10': [9.999999999999999e-06], 
    'D1': [15000000.0], 'TEMPERATURE': [473.15], 'NOMIAL_STRESS': [0.000112], 
    'NOMIAL_STRAIN': [130.0], 'LATERAL_NOMIAL_STRAIN': [50.0], 'TEMPERATURE_UNIAXIAL': [288.15], 
    'EXTRA_FIELDS_UNIAXIAL': [[80.0], [70.0]], 'STRESS': [0.00032], 'TIME': [124.0]}, 
    'temperatureDependency': 'True', 'volumetricResponse': 'POISSON_RATIO', 'strainEnergyPotentialOrder': 1, 
    'applySmooth': True, 'smoothing': 3, 'includeLateralNormalStrain': True, 
    'uniaxialTemperatureDependency': True, 'uniaxialDependencies': 2, 'bstart': 25.0, 'tramp': 15.0}}, 
    iMaterialID=1, iMaterialColor=1415085)

JPT.Debugger(structure_steel) #for checking return value

 strainEnergyPotentialOrder = USER 

 | INT Notation | Key Name | Description

 | 110 | NOMIAL_STRESS | A Tuple specifying the nomial stress data.

 | 111 | NOMIAL_STRAIN | A Tuple specifying the nomial strain data.

 | 112 | LATERAL_NOMIAL_STRAIN | A Tuple specifying the lateral nomial strain data.

 | 136 | TEMPERATURE_UNIAXIAL | A Tuple specifying the uniaxial temperature data.

 | 149 | EXTRA_FIELDS_UNIAXIAL | A Tuple specifying the extra uniaxial fields data.

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 113 | TIME | A Tuple specifying the time data.

Sample Code

structure_steel = Properties.Material.Modify(strMaterialName="Structural_Steel", 
    dictMaterialProperty={'HyperElastic': {'hyperElasticType': 'USER', 'moduli': 'LONG_TERM', 
    'inputSource': 1, 'hyperElastic': {'NOMIAL_STRESS': [0.000112], 'NOMIAL_STRAIN': [130.0], 
    'LATERAL_NOMIAL_STRAIN': [50.0], 'TEMPERATURE_UNIAXIAL': [288.15], 
    'EXTRA_FIELDS_UNIAXIAL': [[80.0], [70.0]], 'STRESS': [0.00032], 'TIME': [124.0]}, 
    'temperatureDependency': 'True', 'compressible': True, 'properties': 10, 'applySmooth': True, 
    'smoothing': 3, 'includeLateralNormalStrain': True, 'uniaxialTemperatureDependency': True, 
    'uniaxialDependencies': 2, 'bstart': 25.0, 'tramp': 15.0}}, iMaterialID=1, iMaterialColor=1415085)

JPT.Debugger(structure_steel) #for checking return value

 strainEnergyPotentialOrder = VAN_DER_WAALS 

 | INT Notation | Key Name | Description

 | 92 | MU | A Tuple specifying the MU data.

 | 93 | LAMDA_M | A Tuple specifying the lamda data.

 | 69 | ALPHA | A Tuple specifying the Alpha data.

 | 100 | BETA | A Tuple specifying the Beta data.

 | 94 | D | A Tuple specifying the D data.

 | 130 | TEMPERATURE | A Tuple specifying the temperature data.

 | 110 | NOMIAL_STRESS | A Tuple specifying the nomial stress data.

 | 111 | NOMIAL_STRAIN | A Tuple specifying the nomial strain data.

 | 112 | LATERAL_NOMIAL_STRAIN | A Tuple specifying the lateral nomial strain data.

 | 136 | TEMPERATURE_UNIAXIAL | A Tuple specifying the uniaxial temperature data.

 | 149 | EXTRA_FIELDS_UNIAXIAL | A Tuple specifying the extra uniaxial fields data.

 | 40 | STRESS | A Tuple specifying the yield stress data.

 | 113 | TIME | A Tuple specifying the time data.

Sample Code

structure_steel = Properties.Material.Modify(strMaterialName="Structural_Steel", 
    dictMaterialProperty={'HyperElastic': {'hyperElasticType': 'VAN_DER_WAALS', 'moduli': 'LONG_TERM', 
    'inputSource': 1, 'hyperElastic': {'MU': [3e-07], 'LAMDA_M': [0.5], 'ALPHA': [3.0], 'BETA': [2.5], 
    'D': [10000000.0], 'TEMPERATURE': [423.15], 'NOMIAL_STRESS': [0.000112], 'NOMIAL_STRAIN': [130.0], 
    'LATERAL_NOMIAL_STRAIN': [50.0], 'TEMPERATURE_UNIAXIAL': [288.15], 
    'EXTRA_FIELDS_UNIAXIAL': [[80.0], [70.0]], 'STRESS': [0.00032], 'TIME': [124.0]}, 
    'temperatureDependency': 'True', 'volumetricResponse': 'POISSON_RATIO', 'beta': {'100': [2.5]}, 
    'applySmooth': True, 'smoothing': 3, 'includeLateralNormalStrain': True, 
    'uniaxialTemperatureDependency': True, 'uniaxialDependencies': 2, 'bstart': 25.0, 'tramp': 15.0}}, 
    iMaterialID=1, iMaterialColor=1415085)

JPT.Debugger(structure_steel) #for checking return value

 strainEnergyPotentialOrder = YEOH 

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

structure_steel = Properties.Material.Modify(strMaterialName="Structural_Steel", 
    dictMaterialProperty={'HyperElastic': {'hyperElasticType': 'YEOH', 'moduli': 'LONG_TERM', 
    'inputSource': 1, 'hyperElastic': {'C00': [0.00012], 'C20': [5e-05], 'C30': [2e-06], 
    'D1': [15000000.0], 'D2': [20000000.0], 'D3': [10000000.0], 'TEMPERATURE': [423.15], 
    'NOMIAL_STRESS': [0.000112], 'NOMIAL_STRAIN': [130.0], 'LATERAL_NOMIAL_STRAIN': [50.0], 
    'TEMPERATURE_UNIAXIAL': [288.15], 'EXTRA_FIELDS_UNIAXIAL': [[80.0], [70.0]], 'STRESS': [0.00032], 
    'TIME': [124.0]}, 'temperatureDependency': 'True', 'volumetricResponse': 'POISSON_RATIO', 
    'strainEnergyPotentialOrder': 1, 'applySmooth': True, 'smoothing': 3, 
    'includeLateralNormalStrain': True, 'uniaxialTemperatureDependency': True, 'uniaxialDependencies': 2, 
    'bstart': 25.0, 'tramp': 15.0}}, iMaterialID=1, iMaterialColor=1415085)

JPT.Debugger(structure_steel) #for checking return value
