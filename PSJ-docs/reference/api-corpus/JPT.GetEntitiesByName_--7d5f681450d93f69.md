# JPT.GetEntitiesByName()

JPT.GetEntitiesByName()

Description​

Get information of the inputted entity name.

Syntax​

JPT.GetEntitiesByName(DTableType, itemName, BoolType)

Inputs​

DTableType​

An Enum specifying the DTableType of entity in Jupiter.

This is a required input.

itemName​

A String specifying the name of the target entity.

This is a required input.

BoolType​

An Enum specifying the BoolType describing the matching type:
False: Approximate match.

True: Exact match.

This is a required input.

Return Code​

A DItemVector object or List of DItem objects containing the information of the entities have the inputted name.

Sample Code​

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# Get the information of the part with name = "_" and store it to a list
listParts = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, "_", JPT.BoolType.FALSE_VAL)
print(listParts[0].name) # Cube_1
print(listParts[2].name) # Cube_3
print(listParts[2].id) # 3
