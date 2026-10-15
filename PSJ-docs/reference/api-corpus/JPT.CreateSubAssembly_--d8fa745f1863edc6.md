# JPT.CreateSubAssembly()

JPT.CreateSubAssembly()

Description​

Create a new sub assembly under the indicated parent sub assembly.

Syntax​

JPT.CreateSubAssembly(subAssemName, parentAssem)

Inputs​

subAssemName​

A String specifying the name of the creating sub assembly.

This is a required input.

parentAssem​

A DItem object specifying the parent sub assembly of the creating sub assembly.

If the parent sub assembly is All Parts assembly, assigns an instance object JPT.DItem().

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Create 2 sub assemblies under All Parts assembly
JPT.CreateSubAssembly('CreateSubAsm0',JPT.DItem())
JPT.CreateSubAssembly('CreateSubAsm1',JPT.DItem())

# Create a sub assembly under CreateSubAsm0 (ID = 1)
JPT.CreateSubAssembly('CreateSubAsm2',JPT.FindSubAssemblyByID(1))
