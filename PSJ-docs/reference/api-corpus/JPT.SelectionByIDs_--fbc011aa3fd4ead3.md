# JPT.SelectionByIDs()

JPT.SelectionByIDs()

Description​

Select entities by using their list of IDs.

Syntax​

JPT.SelectionByIDs(DItemType, entityIDs, BoolType)

Inputs​

DItemType​

An Enum specifying the DItemType of entity in Jupiter.

This is a required input.

entityIDs​

An List of Integer specifying the list of ID of the selecting entites.

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
JPT.ViewFitToModel()

# Select face with IDs = [50, 51, 52]
JPT.SelectionByIDs(JPT.DItemType.FACE, [50, 51, 52], JPT.BoolType.TRUE_VAL)
