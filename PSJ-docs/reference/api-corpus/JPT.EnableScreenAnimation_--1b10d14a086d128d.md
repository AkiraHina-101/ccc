# JPT.EnableScreenAnimation()

JPT.EnableScreenAnimation()

Description​

Enable screen animation effect.

This utility is used to enable the screen animation effect after using the JPT.DisableScreenAnimation() utility.

Syntax​

JPT.EnableScreenAnimation()

Inputs​

This utility function does not require any input value.

Return Code​

This utility function does not have output value.

Sample Code​

# Disable the screen animation
JPT.DisableScreenAnimation()

# Create a cube and check the screen animation
# The animation effect is disabled
Geometry.Part.Cube(iPartColor=7011837)

# Enable the screen animation effect after using JPT.DisableScreenAnimation()
JPT.EnableScreenAnimation()

# Create a cube and check the screen animation
# The animation effect will be enabled
Geometry.Part.Cube(iPartColor=7011837)
