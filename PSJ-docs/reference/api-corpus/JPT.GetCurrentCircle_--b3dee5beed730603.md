# JPT.GetCurrentCircle()

JPT.GetCurrentCircle()

Description​

Get all current settings of Circle.

Syntax​

JPT.GetCurrentCircle()

Inputs​

This utility function does not require any input value.

Return Code​

A Dictionary specifying all settings of the currently displaying Circle.

Sample Code​

# Get all currently settings of Circle
circleDict = JPT.GetCurrentCircle()

# Dump out result
pprint(circleDict)

# Print out the Highlight color
colorRGB = JPT.ConvertJPTColorToRGB(circleDict["HighlightColor"])
print("Highlight Color: " + colorRGB)
