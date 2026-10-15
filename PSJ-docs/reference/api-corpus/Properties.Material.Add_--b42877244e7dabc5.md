# Properties.Material.Add()

Properties.Material.Add()

Description​

Create a new material to the current User database library.

Syntax​

Properties.Material.Add(...)

Ribbon: Properties » Material » Add

Inputs​

strMaterialName​

A String specifying the material name.

This is a required input.

listMaterialProperty​

A List of MATERIAL PROPERTY specifying all attributes of property such as density, elasticity, etc.

This is a required input.

Return Code​

A Cursor specifying the new material created.

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName = "Structural_Steel",
    listMaterialProperty = [Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])
JPT.Debugger(structure_steel) #for checking return value
