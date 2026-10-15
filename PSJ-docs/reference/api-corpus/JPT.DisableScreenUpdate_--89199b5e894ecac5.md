# JPT.DisableScreenUpdate()

JPT.DisableScreenUpdate()

Description​

Disable updating data render on the display window.

注記

The data render will be enabled after finishing executing the PSJ code.

Syntax​

JPT.DisableScreenUpdate()

Inputs​

This utility function does not require any input value.

Return Code​

This utility function does not have output value.

Sample Code​

# Disable data render on the display window
JPT.DisableScreenUpdate()

# Create a cube and check the data render
# The data render is disabled
Geometry.Part.Cube(iPartColor=7011837)
