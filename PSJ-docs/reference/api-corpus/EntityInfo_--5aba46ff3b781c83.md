# EntityInfo()

EntityInfo()

Description​

Get Entity Information from Cursor

Syntax​

EntityInfo(cursor Entity,string Target)

Inputs​

1. Cursor​

Entity Cursor [?:*](?=Item Number,*=ID)

2. String​

Target( CENTER = Part,Face,Edge,Elem NORMAL = Face,Elem COORD = Node XMAX = Part,Face,Edge,Elem XMIN = Part,Face,Edge,Elem YMAX = Part,Face,Edge,Elem YMIN = Part,Face,Edge,Elem ZMAX = Part,Face,Edge,Elem ZMIN = Part,Face,Edge,Elem MATNAME = Part,Face,Edge,Elem MATERIAL= Part,Face,Edge,Elem)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

EntityInfo(3:1,"CENTER")

or

EntityInfo(6:26,"NORMAL")
