# JPT.GetAppPathInfo()

JPT.GetAppPathInfo()

Description​

Get all the working path of the current Jupiter program.

Syntax​

JPT.GetAppPathInfo(PathType)

Inputs​

PathType​

An Enum specifying the PathType describing the type of paths which are available for using.

This is a required input.

Return Code​

A String specifying the path relating to the inputted PathType.

Sample Code​

# Path to the installation folder
print(JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH))
