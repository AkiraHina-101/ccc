# JPT.UpdateCheckboxAssembly()

JPT.UpdateCheckboxAssembly()

Description​

Set the state of checkbox of item in Assembly Tree.

Syntax​

JPT.UpdateCheckboxAssembly(DItemType, entityID, BoolType)

Inputs​

DItemType​

An Enum specifying the DItemType of the entity.

This is a required input.

entityID​

An Integer specifying the ID of the target entity.

This is a required input.

BoolType​

An Enum specifying the BoolType describing the state of checkbox:

True: Check the checkbox of item in Assembly Tree.

False: Uncheck the checkbox of item in Assembly Tree.

This is a required input.

tip

You also can input 1 instead of inputting JPT.BoolType.TRUE_VAL,
or input 0 instead of inputting JPT.BoolType.FALSE_VAL.

Return Code​

This utility function does not have output value.

Sample Code​

# prepare model...
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0, 0.02, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')

parts = JPT.GetAllParts()

# update checkbox from assembly tree
for part in parts:
    JPT.UpdateCheckboxAssembly(JPT.DItemType.BODY, part.id, 1) # turn on checkbox
    JPT.UpdateCheckboxAssembly(JPT.DItemType.BODY, part.id, 0) # turn off checkbox
