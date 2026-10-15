# HeatGenerateRate

HeatGenerateRate

Description​

This is an instance of a HeatGenerateRate class, represents HeatGenerateRate characteristic of material.

Properties​

 | Attribute | Description

 | heatGenerateRate | A List of Tuple specifying all data of HeatGenerateRate characteristic. 
 The data includes HEAT_GENERATE_RATE, and TEMPERATURE.

 | temperatureDependency | A Boolean specifying the use of temperature-dependent data.

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName="Structural_Steel",
    listMaterialProperty=[Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])],
    iMaterialID=5)

JPT.Debugger(structure_steel) #for checking return value
