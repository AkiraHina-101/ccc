# AddResultsPermas()

AddResultsPermas()

Description​

Add permas result to the current Jupiter Database.

Syntax​

AddResultsPermas(str[] strlPaths, bool bMergeTree)

Inputs​

1. str[]​

A List of String specifying permas result files.

2. bool​

A Boolean specifying whether or not the differences not included in the existing document will be added.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

AddResultsPermas(["path/to/the/file"], 1)
