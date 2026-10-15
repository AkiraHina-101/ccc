# GetEntitiesByName

GetEntitiesByName GetEntitiesByName Description Get list of object entity by name Inputs DTableType enum type (JPT.DItemType) name of entity (string) match with name option (1,0 or JPT.BoolType) Return Code list of object entity (ItemVector) Sample Code listbody = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, "Cube1", 1)
