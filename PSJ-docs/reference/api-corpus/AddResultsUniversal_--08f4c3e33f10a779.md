# AddResultsUniversal()

AddResultsUniversal()

Description​

Add result written in Universal file (*.unv) to the current Jupiter-Post Database.

Syntax​

AddResultsUniversal(str[] strlPaths, bool bMergeTree)

Inputs​

1. str[]​

A List of String specifying .unv file path.

2. bool​

A Boolean specifying whether or not the differences not included in the existing document will be added.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

AddResultsUniversal(["path/to/the/file"], 1)
