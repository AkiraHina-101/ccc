# JPT.SelectionByID()

JPT.SelectionByID()

Description​

Select an entity by using its ID.

Syntax​

JPT.SelectionByID(DItemType, entityID, BoolType)

Inputs​

DItemType​

An Enum specifying the DItemType of entity in Jupiter.

This is a required input.

entityID​

An Integer specifying ID of the selecting entity.

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

# Select face with ID = 51
JPT.SelectionByID(JPT.DItemType.FACE, 51, JPT.BoolType.TRUE_VAL)
