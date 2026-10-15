# AddResultsNastran()

AddResultsNastran()

Description​

Add Nastran Op2 results to the current Jupiter Database. The Jupiter document should be Post document.

Syntax​

AddResultsNastran(str[] strlPaths, bool bMergeTree, bool bCreateResultAtMidNode)

Inputs​

1. str[]​

A List of String specifying a list of the Nastran files (*.op2 files) which will be used for importing.

2. bool​

A Boolean specifying whether or not the differences not included in the existing document will be added.

3. bool​

A Boolean specifying whether or not create result at Mid Nodes.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

AddResultsNastran(["path/to/the/file"], 1, 1)
