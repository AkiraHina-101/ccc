# JPT.ShowHideAllParts()

JPT.ShowHideAllParts()

Description​

Show or Hide all part existing on the screen.

Syntax​

JPT.ShowHideAllParts(BoolType)

Inputs​

BoolType​

An Enum specifying the BoolType describing the display mode:
False: Hide all parts.

True: Show all parts.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Show all parts
JPT.ShowHideAllParts(JPT.BoolType.TRUE_VAL)
