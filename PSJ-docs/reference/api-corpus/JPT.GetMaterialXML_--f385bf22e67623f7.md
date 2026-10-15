# JPT.GetMaterialXML()

JPT.GetMaterialXML()

Description​

Get the information of all user material in xml format.

Syntax​

JPT.GetMaterialXML()

Inputs​

This utility function does not require any input value.

Return Code​

A String containing all the created user material in XML format.

Sample Code​

# Create user material data base
Properties.Material.Add("Copper_Alloy", [Density([(DENSITY, 8.3e-09)]),
                        Elastic([(YOUNGS_MODULUS, 110000.0), (POISSONS_RATIO, 0.34)])])

# Get all the created user material and store it in XML format
createdMat = JPT.GetMaterialXML()
pprint(createdMat)
