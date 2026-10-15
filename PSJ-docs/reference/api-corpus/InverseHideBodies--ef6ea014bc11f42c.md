# InverseHideBodies

InverseHideBodies InverseHideBodies Description Inverse hide parts in view Inputs id of part (int) Return Code None Sample Code listbody = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, "Cube1", 1) idbody = listbody[0].id JPT.InverseHideBodies(idbody)
