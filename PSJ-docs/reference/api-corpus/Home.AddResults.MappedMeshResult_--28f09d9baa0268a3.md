# Home.AddResults.MappedMeshResult()

Home.AddResults.MappedMeshResult()

Description​

Add mapped mesh result to the current Jupiter Database.

Syntax​

Home.AddResults.MappedMeshResult(...)

Macro: AddResultsMappedMeshFile

Ribbon: Home » AddResults » MappedMeshResult

Inputs​

strlPaths​

A List of String specifying mapped mesh files.

This is a required input.

bMergeTree​

A Boolean specifying whether or not the differences not included in the existing document will be added.

The default value is True.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The mapped mesh result is added to the document successfully.

False: The mapped mesh result is not added to the document.

Sample Code​

# Put your sample files
Mesh = "C:/Temp/mesh.bdf"
Result = "C:/Temp/result.dat"

# Import mesh file
Home.ImportResults.ImportMesh.Nastran(Mesh, bReadLoadAndConstraint=True, bReadConnection=True)
# Add result to the mesh file.
Home.AddResults.MappedMeshResult(strlPaths=[Result], bMergeTree=False)
