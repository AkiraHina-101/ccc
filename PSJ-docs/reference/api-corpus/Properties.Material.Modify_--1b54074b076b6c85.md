# Properties.Material.Modify()

Properties.Material.Modify()

Description​

Modify an existing material in the User database library by inputting all information of the modifying material.

Syntax​

Properties.Material.Modify(...)

Ribbon: Properties » Material » Modify

Inputs​

iMaterialID​

A Integer specifying the material identification number (ID).

This is a required input.

dictMaterialProperty​

A dictionary specifying  dictMatProps.

This is a required input.

listMaterialProperty​

A List of MATERIAL PROPERTY specifying the list of all attributes of property such as density, elasticity, etc.

caution

This input is discarded from V5.1. Please use dictMaterialProperty instead.

Return Code​

A Boolean specifying whether the material is modified or not.

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName = "Structural_Steel",
    listMaterialProperty = [Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])

mod_mat = Properties.Material.Modify(iMaterialID = 1,
    listMaterialProperty = [Density([(DENSITY, 7.85e-05)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])
JPT.Debugger(mod_mat) #for checking return value
