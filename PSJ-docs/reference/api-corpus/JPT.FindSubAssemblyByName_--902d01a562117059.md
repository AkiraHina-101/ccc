# JPT.FindSubAssemblyByName()

JPT.FindSubAssemblyByName()

Description​

Get the related information of the target sub assembly by its name.

Syntax​

JPT.FindSubAssemblyByName(subAssemName)

Inputs​

subAssemName​

A String specifying the name of the target sub assembly.

This is a required input.

Return Code​

A DItemVector object or a List of DItem specifying found sub assemblies.

Sample Code​

# Create 2 sub assemblies under All Parts assembly
JPT.CreateSubAssembly('CreateSubAsm0',JPT.DItem())
JPT.CreateSubAssembly('CreateSubAsm1',JPT.DItem())
JPT.ViewFitToModel()

# Get the information of the sub assembly with name = CreateSubAsm0
JPT.Debugger(JPT.FindSubAssemblyByName('CreateSubAsm0'))
