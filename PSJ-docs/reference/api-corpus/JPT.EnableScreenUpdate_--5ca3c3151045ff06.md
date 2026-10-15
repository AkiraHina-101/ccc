# JPT.EnableScreenUpdate()

JPT.EnableScreenUpdate()

Description​

Enable data render on the screen.

This utility is used to enable the data render after using the JPT.DisableScreenUpdate() utility.

Syntax​

JPT.EnableScreenUpdate()

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

# Enable the data render after using JPT.DisableScreenUpdate()
JPT.EnableScreenUpdate()

# Create a cube and check data render
# The data render will be enabled
Geometry.Part.Cube(iPartColor=7011837)
