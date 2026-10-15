# Home.AddResults.Sysnoise()

Home.AddResults.Sysnoise()

Description​

Add sysnoise result to the current Jupiter Database.

Syntax​

Home.AddResults.Sysnoise(...)

Macro: AddResultsSysnoise

Ribbon: Home » AddResults » Sysnoise

Inputs​

strlPaths​

A List of String specifying sysnoise result files.

This is a required input.

bMergeTree​

A Boolean specifying whether or not the differences not included in the existing document will be added.

The default value is True.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The sysnoise result is added to the document successfully.

False: The sysnoise result is not added to the document.

Sample Code​

# Put your sample files
Mesh = "C:/Temp/mesh.bdf"
Result = "C:/Temp/result"

# Import mesh file
Home.ImportResults.ImportMesh.Nastran(Mesh, bReadLoadAndConstraint=True, bReadConnection=True)
# Add result to the mesh file.
Home.AddResults.Sysnoise(strlPaths=[Result], bMergeTree=False)
