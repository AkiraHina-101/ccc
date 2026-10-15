# AddResultsSysnoise()

AddResultsSysnoise()

Description​

Add sysnoise result to the current Jupiter Database.

Syntax​

AddResultsSysnoise(str[]strlPaths, bool bMergeTree)

Inputs​

1. str[]​

A List of String specifying sysnoise result files.

2. bool​

A Boolean specifying whether or not the differences not included in the existing document will be added.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

AddResultsSysnoise(["path/to/the/file"], 1)
