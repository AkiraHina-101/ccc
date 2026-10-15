# Elastic

Elastic

Description​

This is an instance of a Elastic class, represents Elastic characteristic of material.

Properties​

 | Attribute | Description

 | elastic | A List of Tuple specifying all data of Elastic characteristic. 
 The data includes YOUNG_MODULUS, SHEAR_MODULUS, POISSONS_RATIO, TEMPERATURE, FREQUENCY_DEPENDENCE, EXTRA_FIELDS, NASTRAN_FAILURE_INDEX_TENSION, NASTRAN_FAILURE_INDEX_COMPRESSION, and NASTRAN_FAILURE_INDEX_SHEAR.

 | elasticType | An Integer specifying the type of Elastic.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

 | frequencyDependency | A Boolean specifying the use of material frequency dependent (Nastran).

 | dependencies | An Integer specifying the number of dependencies in temperature.

 | moduli | A String specifying the moduli time scale type (for ViscoElasticity).

 | subOption | A String specifying the use of sub option.

 | noCompression | A Boolean specifying the use of compression.

 | noTension | An Boolean specifying the use of tension.

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName="Structural_Steel", 
    listMaterialProperty=[Density(density=[(DENSITY, [7900.0])]), 
    Elastic(elastic=[(YOUNGS_MODULUS, [200000000000.0, None]), \
    (SHEAR_MODULUS, [80000000000.0, None]), (POISSONS_RATIO, [0.3, None]), \
    (TEMPERATURE, [473.15, None]), (FREQUENCY_DEPENDENCE, [50.0, None]), \
    (EXTRA_FIELDS, [[100.0, None], [150.0, None]])], \
    temperatureDependency=True, frequencyDependency=True, dependencies=2), 
    Expansion(expansion=[(ALPHA, [1.2e-05])]), Conductivity(conductivity=[(CONDUCTIVITY, [59.0])]), 
    SpecificHeat(specificHeat=[(SPECIFIC_HEAT, [461.0])])], iMaterialID=5, iMaterialColor=10264731)

JPT.Debugger(structure_steel) #for checking return value
