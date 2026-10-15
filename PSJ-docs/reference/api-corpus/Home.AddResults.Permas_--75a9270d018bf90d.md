# Home.AddResults.Permas()

Home.AddResults.Permas()

Description​

Add permas result to the current Jupiter Database.

Syntax​

Home.AddResults.Permas(...)

Macro: AddResultsPermas

Ribbon: Home » AddResults » Permas

Inputs​

strlPaths​

A List of String specifying permas result files.

This is a required input.

bMergeTree​

A Boolean specifying whether or not the differences not included in the existing document will be added.

The default value is True.

Return Code​

A Boolean specifying whether or not the function is executed successfully or not:

True: The permas result is added to the document successfully.

False: The permas result is not added to the document.

Sample Code​

# Put your sample files
mesh = "C:/Temp/mesh.dat"
result = "C:/Temp/result.post.gz"

# Import mesh file
Home.ImportResults.Permas(mesh)
# Add result to the mesh file.
Home.AddResults.Permas(strlPaths=[result], bMergeTree=False)
