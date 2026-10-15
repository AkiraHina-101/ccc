# JPT.ConvertRGBToJPTColor()

JPT.ConvertRGBToJPTColor()

Description​

Convert RGB (Red, Green, Blue) color code to color value in Jupiter.

Syntax​

JPT.ConvertRGBToJPTColor(redValue, greenValue, blueValue)

Inputs​

redValue​

An Integer specifying the red color code.

This is a required input.

greenValue​

An Integer specifying the green color code.

This is a required input.

blueValue​

An Integer specifying the blue color code.

This is a required input.

Return Code​

An Integer specifying color code in Jupiter.

Sample Code​

# Convert the RGB color code to the color code in Jupiter
newColor = JPT.ConvertRGBToJPTColor(255,100,213) # Pink color
JPT.Debugger(newColor)
