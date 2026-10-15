# JPT.GetCurrentDeformation()

JPT.GetCurrentDeformation()

Description​

Get all current settings of Deformation.

Syntax​

JPT.GetCurrentDeformation()

Inputs​

This utility function does not require any input value.

Return Code​

A Dictionary specifying all settings of the currently displaying Deformation.

Sample Code​

# Get all currently settings of Deformation
deformDict = JPT.GetCurrentDeformation()

# Dump out result
pprint(deformDict)

# Print out the Edge color
colorRGB = JPT.ConvertJPTColorToRGB(deformDict["EdgeColor"])
print("Edge Color: " + colorRGB)
