# JPT.GetCurrentViewPoint()

JPT.GetCurrentViewPoint()

Description​

Get all current settings of ViewPoint.

Syntax​

JPT.GetCurrentViewPoint()

Inputs​

This utility function does not require any input value.

Return Code​

A Dictionary specifying all settings of the currently displaying ViewPoint.

Sample Code​

# Get all currently settings of ViewPoint
viewDict = JPT.GetCurrentViewPoint()

# Dump out result
pprint(viewDict)

# Print out the Scale factor
print("Scale Factor: " + str(viewDict["ScaleFactor"]))
