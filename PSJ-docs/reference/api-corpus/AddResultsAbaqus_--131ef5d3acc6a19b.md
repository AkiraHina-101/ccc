# AddResultsAbaqus()

AddResultsAbaqus()

Description​

Add Abaqus .odb results to the current Jupiter Database.

Syntax​

AddResultsAbaqus(str strlPaths, bool bMergeTree, int iVersion)

Inputs​

1. str[]​

A List of String specifying a list of the Abaqus files (*.odb files) which will be used for importing.

2. bool​

A Boolean specifying whether or not the differences not included in the existing document will be added.

3. int​

An Integer specifying version of Abaqus file.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

AddResultsAbaqus(["path/to/the/file"], 1, 2019)
