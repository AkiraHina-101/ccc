# JPT.ConvertJPTColorToRGB()

JPT.ConvertJPTColorToRGB()

Description​

Convert color value in Jupiter to a String specifying RGB (Red, Green, Blue) code.

Syntax​

JPT.ConvertJPTColorToRGB(colorValue)

Inputs​

colorValue​

An Integer specifying the color value in Jupiter.

This is a required input.

Return Code​

A String specifying the converted RGB code with value = RGB(redCode,greenCode,blueCode)

Sample Code​

# Convert the color code = 255 in Jupiter to RGB color code
stringRGB = JPT.ConvertJPTColorToRGB(255) # Return RGB(255,0,0)
# Split the RGB code and store it as Red Green Blue color code
r, g, b = stringRGB[4:-1].strip().split(",") # String = RGB(255,0,0) -> List = [255, 0, 0]
print(f"Output value of this function: {stringRGB}")
print(f"It means: Red = {r} | Green = {g} | Blue = {b}")
