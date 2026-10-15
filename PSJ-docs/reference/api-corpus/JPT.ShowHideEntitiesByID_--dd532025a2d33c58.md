# JPT.ShowHideEntitiesByID()

JPT.ShowHideEntitiesByID()

Description​

Show or Hide an entity by inputted its ID.

Syntax​

JPT.ShowHideEntitiesByID(DTableType, itemID, BoolType)

Inputs​

DTableType​

An Enum specifying the DTableType of the entities which will be shown/hidden.

This is a required input.

itemID​

An Integer specifying the ID of the target entity.

This is a required input.

BoolType​

An Enum specifying the BoolType describing the display mode:

False: Hide the inputted part.

True: Show the inputted part.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Hide all parts
JPT.ShowHideAllParts(JPT.BoolType.FALSE_VAL)

# Show Cube_1
JPT.ShowHideEntitiesByID(JPT.DTableType.DTABLE_BODY, 1, JPT.BoolType.TRUE_VAL)
