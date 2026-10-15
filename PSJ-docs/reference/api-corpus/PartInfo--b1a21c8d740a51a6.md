# PartInfo

PartInfo PartInfo Description Count the number of in a part Syntax PartInfo(Cursor Part,String Target) Inputs Cursor Part Cursor [3:*](*=ID) String Target(FACE,EDGE,NODE,LINE2,LINE3,TRI3,TRI6,QUAD4,QUAD8,TET4,TET10,HEX8,HEX20,PRISM6,PRISM15,PYRAMID5,PYRAMID13,QUAD6,QUAD9,PRISM12,HEX18) Return Code The number of targets in a part Succeeded FAILED Failed Sample Code PartInfo(3:1,"FACE") or PartInfo(3:1,"TRI3")
