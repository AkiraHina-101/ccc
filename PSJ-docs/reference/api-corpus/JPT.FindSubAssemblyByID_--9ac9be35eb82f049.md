# JPT.FindSubAssemblyByID()

JPT.FindSubAssemblyByID()

Description​

Get the related information of the target sub assembly by its ID.

Syntax​

JPT.FindSubAssemblyByID(subAssemID)

Inputs​

subAssemID​

An Integer specifying the ID of the target sub assembly.

This is a required input.

Return Code​

A DItem object specifying the information of the target sub assembly.

Sample Code​

# Create 2 sub assemblies under All Parts assembly
JPT.CreateSubAssembly('CreateSubAsm0',JPT.DItem())
JPT.CreateSubAssembly('CreateSubAsm1',JPT.DItem())
JPT.ViewFitToModel()

# Get the information of the sub assembly with ID = 1
JPT.Debugger(JPT.FindSubAssemblyByID(1))
