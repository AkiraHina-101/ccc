# JPT.RemoveEntitiesByName()

JPT.RemoveEntitiesByName()

Description​

Remove entities by using the inputted name.

Syntax​

JPT.RemoveEntitiesByName(DTableType, itemName, BoolType)

Inputs​

DTableType​

An Enum specifying the DTableType of entity in Jupiter.

This is a required input.

itemName​

A String specifying the name of the target entity to be removed.

This is a required input.

BoolType​

An Enum specifying the BoolType describing the matching type:
False: Approximate match.

True: Exact match.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Remove all the parts with their name have the "_" character inside
JPT.RemoveEntitiesByName(JPT.DTableType.DTABLE_BODY, "_", JPT.BoolType.FALSE_VAL)
