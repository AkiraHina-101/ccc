# ElementConvert

ElementConvert ElementConvert Description Element Conversion Syntax ElementConvert(cursor[] taBody, int iType) Inputs Cursor[] Target body cursor([3:Part ID]) Int Conversion Type* *0: To Linear(Tri3/Quad4) &ensp;1: To Quadratic(Tri6/Quad8) &ensp;2: Tri3 &ensp;7: Split(Tri6to4Tri3s/Quad8to4Quad4s) Return Code 1 Succeeded 0 Failed Sample Code ElementConvert([3:2], 3)
