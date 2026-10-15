# JPT.GetCurrentDiagram()

JPT.GetCurrentDiagram()

Description​

Get all current settings of Diagram.

Syntax​

JPT.GetCurrentDiagram()

Inputs​

This utility function does not require any input value.

Return Code​

A Dictionary specifying all settings of the currently displaying Diagram.

Sample Code​

# Get all currently settings of Diagram
diagramDict = JPT.GetCurrentDiagram()

# Dump out result
pprint(diagramDict)

# Print out the Positive color
colorRGB = JPT.ConvertJPTColorToRGB(diagramDict["PositiveColor"])
print("Positive Color: " + colorRGB)
