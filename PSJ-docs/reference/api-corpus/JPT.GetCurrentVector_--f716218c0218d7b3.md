# JPT.GetCurrentVector()

JPT.GetCurrentVector()

Description​

Get all current settings of Vector.

Syntax​

JPT.GetCurrentVector()

Inputs​

This utility function does not require any input value.

Return Code​

A Dictionary specifying all settings of the currently displaying Vector.

Sample Code​

# Get all currently settings of Vector
vectorDict = JPT.GetCurrentVector()

# Dump out result
pprint(vectorDict)

# Print out the Positive color
colorRGB = JPT.ConvertJPTColorToRGB(vectorDict["PositiveColor"])
print("Positive Color: " + colorRGB)
