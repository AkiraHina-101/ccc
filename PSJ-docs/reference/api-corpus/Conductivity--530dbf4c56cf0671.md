# Conductivity

Conductivity

Description​

This is an instance of a Conductivity class, represents Conductivity characteristic of material.

Properties​

 | Attribute | Description

 | conductivity | A List of Tuple specifying all data of Conductivity characteristic. 
 The data includes CONDUCTIVITY, TEMPERATURE, and EXTRA_FIELDS.

 | conductivityType | An Integer specifying the type of conductivity.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

 | dependencies | An Integer specifying the number of dependencies in temperature.

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName="Structural_Steel",
    listMaterialProperty=[Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])],
    iMaterialID=5)

JPT.Debugger(structure_steel) #for checking return value
