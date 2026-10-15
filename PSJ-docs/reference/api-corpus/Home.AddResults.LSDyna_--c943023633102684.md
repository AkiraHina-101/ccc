# Home.AddResults.LSDyna()

Home.AddResults.LSDyna()

Description​

Add LS-Dyna's d3plot results to the current Jupiter Database.

Syntax​

Home.AddResults.LSDyna(...)

Macro: AddResultsLSDyna

Ribbon: Home » AddResults » LSDyna

Inputs​

strlPaths​

A List of String specifying specifying a list of the d3plot files which will be used for importing.

This is a required input.

bMergeTree​

A Boolean specifying whether or not the differences not included in the existing document will be added.

The default value is True.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The LS-Dyna result is added to the document successfully.

False: The LS-Dyna result is not added to the document.

Sample Code​

# Put your sample files
Mesh = "C:/Temp/mesh.bdf"
Result = "C:/Temp/d3plot"

# Import mesh file
Home.ImportResults.ImportMesh.Nastran(Mesh, bReadLoadAndConstraint=True, bReadConnection=True)
# Add result to the mesh file.
Home.AddResults.LSDyna(strlPaths=[Result], bMergeTree=False)
