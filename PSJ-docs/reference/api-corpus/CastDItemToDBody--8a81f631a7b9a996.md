# CastDItemToDBody

CastDItemToDBody CastDItemToDBody Description Cast a DItem object to DBody object Inputs DItem object (DItem class) Return Code DBody object (DBody class) Sample Code listDItemObject = JPT.GetAllByType(JPT.DItemType.BODY) ditemObject = listDItemObject[0] dbodyObject = JPT.CastDItemToDBody(ditemObject)
