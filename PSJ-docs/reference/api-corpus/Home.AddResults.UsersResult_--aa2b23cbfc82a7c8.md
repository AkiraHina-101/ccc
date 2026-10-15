# Home.AddResults.UsersResult()

Home.AddResults.UsersResult()

Description​

Add user result to the current Jupiter Database.

Syntax​

Home.AddResults.UsersResult(...)

Macro: AddUserResultDefine

Ribbon: Home » AddResults » UsersResult

Inputs​

strlPath​

A List of String specifying user result files.

This is a required input.

bExportLog​

-A Boolean specifying whether or not

The default value is False.

Return Code​

A Boolean specifying whether or not the function is executed successfully or not:

True: The user result is added to the document successfully.

False: The user result is not added to the document.

Sample Code​

# Put your sample files
mesh = "C:/Temp/mesh.bdf"
result = "C:/Temp/result.csv"

# Import mesh file
Home.ImportResults.ImportMesh.Nastran(mesh)
# Add result to the mesh file.
Home.AddResults.UsersResult(strlPath=result)
