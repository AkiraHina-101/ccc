# GetSelectedElems

GetSelectedElems GetSelectedElems Description Get selected element information Syntax GetSelectedElems() Inputs None No input value Return Code Python Output ElemVector Selected element information (typeID, type, id, key, kind) Sample Code Input: elems = JPT.GetSelectedElems() for e in elems: print(str(e.typeID)+' '+str(e.type)+' '+str(e.id)+' '+str(e.key)+' '+str(e.kind)) Output: > 11 ELEMTYPE_TRI3 1161 1161 ELEMKIND_2D > 11 ELEMTYPE_TRI3 1171 1171 ELEMKIND_2D > 11 ELEMTYPE_TRI3 1173 1173 ELEMKIND_2D
