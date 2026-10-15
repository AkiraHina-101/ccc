# LaunchOperation()

LaunchOperation()

Description​

Launch indicated command dialog

Syntax​

LaunchOperation(string strCommandID, int iPattern)

Inputs​

1. String​

Command ID (name of the command)

2. int​

Indicate pattern if the command has several display pattern.

Return Code​

"1": The function can be executed

"FAILED": The function cannot be executed

Sample Code​

LaunchOperation("GEOMETRY_CREATE_ENTITY_PARTS_CUBE", 0)
