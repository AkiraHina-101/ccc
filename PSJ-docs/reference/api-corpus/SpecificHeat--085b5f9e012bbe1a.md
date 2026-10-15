# SpecificHeat

SpecificHeat

Description​

This is an instance of a SpecificHeat class, represents SpecificHeat characteristic of material.

Properties​

 | Attribute | Description

 | specificHeat | A List of Tuple specifying all data of SpecificHeat characteristic. 
 The data includes SPECIFIC_HEAT, TEMPERATURE, and EXTRA_FIELDS.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

 | dependencies | An Integer specifying the number of dependencies in temperature.

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName="Structural_Steel",
    listMaterialProperty=[Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])],
    iMaterialID=5)

JPT.Debugger(structure_steel) #for checking return value
