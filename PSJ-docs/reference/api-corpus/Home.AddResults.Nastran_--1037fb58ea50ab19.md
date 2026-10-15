# Home.AddResults.Nastran()

Home.AddResults.Nastran()

Description​

Add Nastran Op2 results to the current Jupiter Database. The Jupiter document should be Post document.

Syntax​

Home.AddResults.Nastran(...)

Macro: AddResultsNastran

Ribbon: Home » AddResults » Nastran

Inputs​

strlPaths​

A List of String specifying a list of the Nastran files (*.op2 files) which will be used for importing.

This is a required input.

bMergeTree​

A Boolean specifying whether or not the differences not included in the existing document will be added.

The default value is True.

bCreateResultAtMidNode​

A Boolean specifying whether or not create result at Mid Nodes.

The default value is True.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Nastran result is added to the document successfully.

False: The Nastran result is not added to the document.

Sample Code​

# Put your sample files
Mesh = "C:/Temp/mesh.bdf"
Result = "C:/Temp/result.op2"

# Import mesh file
Home.ImportResults.ImportMesh.Nastran(Mesh, bReadLoadAndConstraint=True, bReadConnection=True)
# Add result to the mesh file.
Home.AddResults.Nastran(strlPaths=[Result], bMergeTree=False)
