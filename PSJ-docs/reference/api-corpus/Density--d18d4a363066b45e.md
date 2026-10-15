# Density

Density

Description​

This is an instance of a Density class, represents Density characteristic of material.

Properties​

 | Attribute | Description

 | density | A List of Tuple specifying all data of Density characteristic. 
 The data includes DENSITY, TEMPERATURE, and EXTRA_FIELDS.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

 | dependencies | An Integer specifying the number of dependencies in temperature.

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName="Structural_Steel", 
    listMaterialProperty=[Density(density=[(DENSITY, [7900.0, 7900.0]), (TEMPERATURE, [373.15, 393.15]), \
    (EXTRA_FIELDS, [[150.0, 200.0], [200.0, 300.0]])], temperatureDependency=True, dependencies=2), 
    Elastic(elastic=[(YOUNGS_MODULUS, [200000000000.0]), (POISSONS_RATIO, [0.3])]), 
    Expansion(expansion=[(ALPHA, [1.2e-05])]), Conductivity(conductivity=[(CONDUCTIVITY, [59.0])]), 
    SpecificHeat(specificHeat=[(SPECIFIC_HEAT, [461.0])])], iMaterialID=5, iMaterialColor=10264731)

JPT.Debugger(structure_steel) #for checking return value
