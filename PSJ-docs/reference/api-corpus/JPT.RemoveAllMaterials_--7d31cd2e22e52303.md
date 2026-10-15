# JPT.RemoveAllMaterials()

JPT.RemoveAllMaterials()

Description​

Remove all the existing material in the User material database.

Syntax​

JPT.RemoveAllMaterials()

Inputs​

This utility function does not require any input value.

Return Code​

This utility function does not have output value.

Sample Code​

# Create materials
Properties.Material.Add("Copper_Alloy", [Density([(DENSITY, 8.3e-09)]),
                                         Elastic([(YOUNGS_MODULUS, 110000.0),
                                                  (POISSONS_RATIO, 0.34)])])
Properties.Material.Add("Stainless_Steel", [Density([(DENSITY, 7.75e-09)]),
                                            Elastic([(YOUNGS_MODULUS, 193000.0),
                                                     (POISSONS_RATIO, 0.31)])])
Properties.Material.Add("Titanium_Alloy", [Density([(DENSITY, 4.62e-09)]),
                                           Elastic([(YOUNGS_MODULUS, 96000.0),
                                                    (POISSONS_RATIO, 0.36)])])

# Remove all the created materials in the User material database
JPT.RemoveAllMaterials()
