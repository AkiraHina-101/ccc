# Home.AddResults.Abaqus()

Home.AddResults.Abaqus()

Description​

Add Abaqus .odb results to the current Jupiter Database.

Syntax​

Home.AddResults.Abaqus(...)

Macro: AddResultsAbaqus

Ribbon: Home » AddResults » Abaqus

Inputs​

strlPaths​

A List of String specifying a list of the Abaqus files (*.odb files) which will be used for importing.

This is a required input.

bMergeTree​

A Boolean specifying whether or not the differences not included in the existing document will be added.

The default value is True.

iVersion​

An Integer specifying version of Abaqus file.

The default value is 2019.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Abaqus result is added to the document successfully.

False: The Abaqus result is not added to the document.

Sample Code​

# Put your sample files
Mesh = "C:/Temp/mesh.inp"
Result = "C:/Temp/result.odb"

# Import mesh file
Home.ImportResults.ImportMesh.Abaqus(Mesh, bReadLoadAndConstraint=True, bReadConnection=True)
# Add result to the mesh file.
Home.AddResults.Abaqus(strlPaths=[Result], bMergeTree=False)
