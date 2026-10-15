# PartInfo()

PartInfo()

説明​

パート内の数量を数えます

構文​

PartInfo(Cursor Part,String Target)

入力​

1. Cursor​

パートのカーソル [3:*] (* = ID)

2. String​

対象(FACE,EDGE,NODE,LINE2,LINE3,TRI3,TRI6,QUAD4,QUAD8,TET4,TET10,HEX8,HEX20,PRISM6,PRISM15,PYRAMID5,PYRAMID13,QUAD6,QUAD9,PRISM12,HEX18)

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

PartInfo(3:1,"FACE") or PartInfo(3:1,"TRI3")
