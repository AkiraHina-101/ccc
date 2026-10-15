# JPT.GetJPTTempPath()

JPT.GetJPTTempPath()

Description​

Get the path to the temporary folder of the current Jupiter program.

Syntax​

JPT.GetJPTTempPath()

Inputs​

This utility function does not require any input value.

Return Code​

A String specifying the path to the current Jupiter temporary folder.

Sample Code​

# Get the current Jupiter temporary folder
path = JPT.GetJPTTempPath()
JPT.Debugger(path)
