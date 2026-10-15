# DamageforTractionSeparationLaws

DamageforTractionSeparationLaws

Description​

This is an instance of a Expansion class, represents Expansion characteristic of material.

Properties​

 | Attribute | Description

 | expansion | A List of Tuple specifying all data of Expansion characteristic. 
 The data includes ALPHA11, ALPHA22, TEMPERATURE, and EXTRA_FIELDS.

 | expansionType | An Integer specifying the type of Expansion.

 | temperatureReference | A Double specifying data of temperature reference.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

 | dependencies | An Integer specifying the number of dependencies in temperature.

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName="Structural_Steel",
    listMaterialProperty=[Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])],
    iMaterialID=5)

JPT.Debugger(structure_steel) #for checking return value
