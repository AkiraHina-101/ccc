# RemoveEntitiesByID

RemoveEntitiesByID RemoveEntitiesByID Description Remove entities from model by id Inputs DItem enum type (JPT.DItemType) id of entity (int) Return Code None Sample Code listbody = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, "Cube", JPT.BoolType.FALSE_VAL) idbody = listbody[0].id JPT.RemoveEntitiesByID(JPT.DItemType.BODY, idbody)
