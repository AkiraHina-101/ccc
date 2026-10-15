# GasketAdditionalBehavior

GasketAdditionalBehavior

Description​

This is an instance of a GasketAdditionalBehavior class, represents GasketAdditionalBehavior characteristic of material.

Properties​

 | Attribute | Description

 | initialGap | A Float specifying the initial gap value.

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName="Structural_Steel",
    listMaterialProperty=[Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])],
    iMaterialID=5)

JPT.Debugger(structure_steel) #for checking return value
