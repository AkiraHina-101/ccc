# JPT.Debugger()

JPT.Debugger()

Description​

Console debugger for PSJ. This utility will show all the related information of the inputted value to the Python API window.

Syntax​

JPT.Debugger(inputValue)

Inputs​

inputValue​

A value needing to know its information.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Prepare model
Geometry.Part.Cube()
# Get the information of all existing parts
allParts = JPT.GetAllParts()
# Print all the related information of the first part to the screen
JPT.Debugger(allParts[0])
