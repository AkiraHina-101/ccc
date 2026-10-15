# DItemToMacroTCursorPair

DItemToMacroTCursorPair DItemToMacroTCursorPair Description Convert pair of DItem object to cursor pair macro string Inputs DItem object 1 (DItem class) DItem object 2 (DItem class) Return Code Cursor pair macro string (string) Sample Code listDNodeObject = JPT.GetAllNodes() ditemObject1 = JPT.CastToDItem(listDNodeObject[0]) ditemObject2 = JPT.CastToDItem(listDNodeObject[1]) strElemEdge = JPT.DItemToMacroTCursorPair(ditemObject1, ditemObject2) // 10:1-10:2
