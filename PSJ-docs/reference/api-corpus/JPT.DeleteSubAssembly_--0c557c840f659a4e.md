# JPT.DeleteSubAssembly()

JPT.DeleteSubAssembly()

Description​

Delete the inputted sub assembly.

Syntax​

JPT.DeleteSubAssembly(subAssembly)

Inputs​

subAssembly​

A DItem object specifying the sub assembly which will be deleted.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Create 2 sub assemblies under All Parts assemly
JPT.CreateSubAssembly('CreateSubAsm0',JPT.DItem())
JPT.CreateSubAssembly('CreateSubAsm1',JPT.DItem())

# Delete the created CreateSubAsm1
subAssem = JPT.FindSubAssemblyByID(2)
JPT.DeleteSubAssembly(subAssem)
