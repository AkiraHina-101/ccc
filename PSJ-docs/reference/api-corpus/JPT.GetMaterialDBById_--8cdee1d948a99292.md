# JPT.GetMaterialDBById()

JPT.GetMaterialDBById()

Description​

Check whether the inputted material ID is existing in the user material database or not.

Syntax​

JPT.GetMaterialDBById(userMaterialID)

Inputs​

userMaterialID​

An Integer specifying the material ID wants to check in user material database.

This is a required input.

Return Code​

An Integer specifying the ID of the checked material if it exists in user material database.
It will return the value as below:

0: if the checked material ID does not exist in user material database.

userMaterialID: return back the inputted ID if the checked material ID is existing in user material database.

Sample Code​

# Create user material data base
Properties.Material.Add("Copper_Alloy", [Density([(DENSITY, 8.3e-09)]),
                        Elastic([(YOUNGS_MODULUS, 110000.0), (POISSONS_RATIO, 0.34)])])
                        # User material ID = 1 (Existing in the Library material database)

# Check the ID of the created material whether it's existing in the
# user material database or not

# Return 1 - The checked material is existing in the user material database and
# return the ID of its which is the same as inputted ID
firstMat = JPT.GetMaterialDBById(1)
JPT.Debugger(firstMat)

# Return 0 - Does not exist in the user material database
# with inputted material ID = 2
secondMat = JPT.GetMaterialDBById(2)
JPT.Debugger(secondMat)
