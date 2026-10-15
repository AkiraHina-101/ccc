# JPT.GetMaxMaterialID()

JPT.GetMaxMaterialID()

Description​

Get the maximum ID of the user material in the user material database.

Syntax​

JPT.GetMaxMaterialID()

Inputs​

This utility function does not require any input value.

Return Code​

An Integer specifying the maximum ID of the user material in the user material database.

Sample Code​

# Create user material data base
Properties.Material.Add("Stainless_Steel", [Density([(DENSITY, 7.75e-09)]),
                        Elastic([(YOUNGS_MODULUS, 193000.0), (POISSONS_RATIO, 0.31)])])
Properties.Material.Add("Titanium_Alloy", [Density([(DENSITY, 4.62e-09)]),
                        Elastic([(YOUNGS_MODULUS, 96000.0), (POISSONS_RATIO, 0.36)])])
Properties.Material.Add("Aluminum_Alloy", [Density([(DENSITY, 2.7699999999999997e-09)]),
                        Elastic([(YOUNGS_MODULUS, 71000.0), (POISSONS_RATIO, 0.33)])])

# Get the maximum ID of the user material in the User material Database
iMaxMaterialID = JPT.GetMaxMaterialID()
JPT.Debugger(iMaxMaterialID) # Return an integer object with value = 3
