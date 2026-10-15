# JPT.GetCurrentDocumentPath()

JPT.GetCurrentDocumentPath()

Description​

Get the path of the current working Jupiter file.

Syntax​

JPT.GetCurrentDocumentPath()

Inputs​

This utility function does not require any input value.

Return Code​

A String specifying the full path to the current Jupiter file.

Sample Code​

# Open an existing Jupiter file (*.jtdb) or (*.jth5) before running the below code
path = JPT.GetCurrentDocumentPath()
print(path)
