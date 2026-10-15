# JPT.SelectionByType()

JPT.SelectionByType()

Description​

Select all the existing entities by type.

Syntax​

JPT.SelectionByType(DItemType, BoolType)

Inputs​

DItemType​

An Enum specifying the DItemType of entity in Jupiter.

This is a required input.

BoolType​

An Enum specifying the BoolType describing the selection mode:

True: Select the inputted entity with its ID.

False: Deselect the inputted entity with its ID.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=6974164)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=7599987)

# Select all the created parts
JPT.SelectionByType(JPT.DItemType.BODY, JPT.BoolType.TRUE_VAL)
