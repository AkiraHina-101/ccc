# JPT.RemoveEntitiesByID()

JPT.RemoveEntitiesByID()

Description​

Remove specified entity by inputting its DItem type and its ID.

Syntax​

JPT.RemoveEntitiesByID(DItemType, itemID)

Inputs​

DItemType​

An Enum specifying the DItemType of entity in Jupiter.

This is a required input.

itemID​

An Integer specifying the ID of the target entity to be removed.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Prepare model
Geometry.Part.Cube(iPartColor=12829526)
Geometry.Part.Cube(strName="Cube_2", iPartColor=8060538)
Geometry.Part.Cube(strName="Cube_3", iPartColor=13787489)
JPT.ViewFitToModel()

# Delete Cube_2 part
JPT.RemoveEntitiesByID(JPT.DItemType.BODY, 2)
