# JPT.GetEntitiesByAssociation()

JPT.GetEntitiesByAssociation()

Description​

Get List of Objects by associating from the inputted entity ID and its type.

Syntax​

JPT.GetEntitiesByAssociation(DItemType, AssociateType, entityID)

Inputs​

DItemType​

An Enum specifying the DItemType of entity in Jupiter.

This is a required input.

AssociateType​

An Enum specifying the AssociateType describing the association type in Jupiter.

This is a required input.

entityID​

An Integer specifying the ID of which is used as a starting entity.

This is a required input.

Return Code​

A DItemVector object or List of DItem objects containing all the information of associated entities.

Sample Code​

# Prepare model
Geometry.Part.Cube()
JPT.ViewFitToModel()

# Get all the associating faces existing on the part with ID = 1
listAssociatedEntities = JPT.GetEntitiesByAssociation(JPT.DItemType.BODY, JPT.AssociateType.AS_FACE, 1)
JPT.Debugger(listAssociatedEntities) # return value is a list DItem has size = 6
