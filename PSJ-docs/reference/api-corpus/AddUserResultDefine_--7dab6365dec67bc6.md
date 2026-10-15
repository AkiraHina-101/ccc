# AddUserResultDefine()

AddUserResultDefine()

Description​

Add user result to the current Jupiter Database.

Syntax​

UsersResult(str[] strlPath, bool bExportLog)

Inputs​

1. str[]​

A List of String specifying user result files.

2. bool​

A Boolean specifying whether or not

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

UsersResult(["path/to/the/file"], 1)
