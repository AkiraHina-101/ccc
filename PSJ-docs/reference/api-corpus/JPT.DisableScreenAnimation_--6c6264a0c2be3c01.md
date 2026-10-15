# JPT.DisableScreenAnimation()

JPT.DisableScreenAnimation()

Description​

Disable screen animation effect.

The screen animation effect will be enabled after finishing executing the PSJ code.
Or using JPT.EnableScreenAnimation() to turn it on again.

Syntax​

JPT.DisableScreenAnimation()

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
