# CastToDItem

CastToDItem CastToDItem Description Cast an entity object to DItem object Inputs any kind of objects (DBody, DFace, DElem, DEdge, DGroup, DNode,...) Return Code DItem object (DItem class) Sample Code listDbodyObject = JPT.GetAllParts() dbodyObject = listDbodyObject[0] ditemObject = JPT.CastToDItem(dbodyObject)
