# JPT.GetCurrentContour()

JPT.GetCurrentContour()

Description​

Get all current settings of Contour.

Syntax​

JPT.GetCurrentContour()

Inputs​

This utility function does not require any input value.

Return Code​

A Dictionary specifying all settings of the currently displaying Contour.

Sample Code​

# Get all currently settings of Contour
contourDict = JPT.GetCurrentContour()

# Dump out result
pprint(contourDict)

# Print out the Upper color
colorRGB = JPT.ConvertJPTColorToRGB(contourDict["UpperColor"])
print("Upper Color: " + colorRGB)
