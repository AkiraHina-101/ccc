# AddResultsActran()

AddResultsActran()

Description​

Add Actran Op2 results to the current Jupiter Database. The Jupiter document should be Post document.

Syntax​

AddResultsActran(str[] strlPaths, bool bMergeTree)

Inputs​

1. str[]​

A List of String specifying a list of the Actran files (*.op2 files) which will be used for importing.

2. bool​

A Boolean specifying whether or not the differences not included in the existing document will be added.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

AddResultsActran(["path/to/the/file"], 1)
