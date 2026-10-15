# AddResultsLSDyna()

AddResultsLSDyna()

Description​

Add LS-Dyna's d3plot results to the current Jupiter Database.

Syntax​

AddResultsLSDyna(str[] strlPaths, bool bMergeTree)

Inputs​

1. str[]​

A List of String specifying specifying a list of the d3plot files which will be used for importing.

2. bool​

A Boolean specifying whether or not the differences not included in the existing document will be added.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

AddResultsLSDyna(["path/to/the/file"], 1)
