# Properties.Material.Delete()

Properties.Material.Delete()

Description​

Delete an existing material in the User database by inputting its ID.

Syntax​

Properties.Material.Delete(...)

Ribbon: Properties » Material » Delete

Inputs​

iMaterialID​

A Integer specifying the material identification number (ID).

This is a required input.

Return Code​

A Boolean specifying whether the inputted material is deleted successfully or not.

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName = "Structural_Steel",
                                          listMaterialProperty = [Density([(DENSITY, 
                                                                            7.85e-09)]),
                                                                  Elastic([(YOUNGS_MODULUS, 
                                                                            200000.0), 
                                                                           (POISSONS_RATIO, 
                                                                            0.3)])])

del_mat = Properties.Material.Delete(1) # 1 is the ID of the created material

JPT.Debugger(del_mat) # For checking return value
