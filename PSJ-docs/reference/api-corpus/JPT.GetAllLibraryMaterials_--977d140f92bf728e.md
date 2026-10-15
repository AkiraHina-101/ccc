# JPT.GetAllLibraryMaterials()

JPT.GetAllLibraryMaterials()

Description​

Get all the information of all library materials.

Syntax​

JPT.GetAllLibraryMaterials()

Inputs​

This utility function does not require any input value.

Return Code​

A MaterialLibVector object or List of DMaterialLib objects containing all the information of all the existing user materials.

Sample Code​

# Get all library materials
libMat = JPT.GetAllLibraryMaterials()
print(f"There are {len(libMat)} materials in the library")
JPT.Debugger(libMat)
JPT.Debugger(libMat[0])
