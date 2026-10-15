# Home.AddResults.Universal()

Home.AddResults.Universal()

Description​

Add result written in Universal file (*.unv) to the current Jupiter-Post Database.

Syntax​

Home.AddResults.Universal(...)

Macro: AddResultsUniversal

Ribbon: Home » AddResults » Universal

Inputs​

strlPaths​

A List of String specifying .unv file path.

This is a required input.

bMergeTree​

A Boolean specifying whether or not the differences not included in the existing document will be added.

The default value is True.

Return Code​

A Boolean specifyingthe the function is executed successfully or not:

True: The Universal file (*.unv file) is added successfully.

False: The Universal file (*.unv file) cannot be added.

Sample Code​

# Put your sample files
Mesh = "C:/Temp/mesh.bdf"
Result = "C:/Temp/result.unv"

# Import mesh file
Home.ImportResults.ImportMesh.Nastran(Mesh, bReadLoadAndConstraint=True, bReadConnection=True)
# Add result to the mesh file.
Home.AddResults.Universal(strlPaths=[Result], bMergeTree=False)
