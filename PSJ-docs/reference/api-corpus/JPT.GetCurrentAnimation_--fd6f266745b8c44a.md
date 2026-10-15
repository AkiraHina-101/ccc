# JPT.GetCurrentAnimation()

JPT.GetCurrentAnimation()

Description​

Get all current settings of Animation.

Syntax​

JPT.GetCurrentAnimation()

Inputs​

This utility function does not require any input value.

Return Code​

A Dictionary specifying all current settings of Animation.

Sample Code​

# Get all currently settings of Animation
animationDict = JPT.GetCurrentAnimation()

# Dump out result
pprint(animationDict)

# Print out the Frame number
print("Frame Number: " + str(animationDict["FrameNumber"]))
