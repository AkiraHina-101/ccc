# Home.AddResults.Actran()

Home.AddResults.Actran()

Description​

Add Actran Op2 results to the current Jupiter Database. The Jupiter document should be Post document.

Syntax​

Home.AddResults.Actran(...)

Macro: AddResultsActran

Ribbon: Home » AddResults » Actran

Inputs​

strlPaths​

A List of String specifying a list of the Actran files (*.op2 files) which will be used for importing.

This is a required input.

bMergeTree​

A Boolean specifying whether or not the differences not included in the existing document will be added.

The default value is True.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Actran result is added to the document successfully.

False: The Actran result is not added to the document.

Sample Code​

# Please put mesh and actran file below path
meshfile='C:/Sample/mesh.bdf'
actrandatafile= 'C:/Sample/actran.op2'

Home.ImportResults.ImportMesh.Nastran(meshfile, bReadLoadAndConstraint=True, bReadConnection=True)
Home.AddResults.Actran(strlPaths=[actrandatafile], bMergeTree=False)
