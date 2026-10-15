# JPT.GetCurrentCrossSection()

JPT.GetCurrentCrossSection()

Description​

Get all current settings of Cross Section.

Syntax​

JPT.GetCurrentCrossSection()

Inputs​

This utility function does not require any input value.

Return Code​

A Dictionary specifying all settings of the currently displaying Cross Section.

Sample Code​

# Get all currently settings of Cross Section
crossDict = JPT.GetCurrentCrossSection()

# Dump out result
pprint(crossDict)

# Print out the current position
print("Current Position: " + str(crossDict["CurrentPosition"]))
