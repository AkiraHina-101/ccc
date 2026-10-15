# CreateEdgeByElemEdge()

CreateEdgeByElemEdge()

Description​

Create Edge By Element Edge

Syntax​

CreateEdgeByElemEdge(ElemEdge[] elem_edge,bool break_face)

Inputs​

1. ElemEdge[]​

Select (multiple) element edges cursor([10:Node ID-10:Node ID])

2. Bool​

Whether break edge or not True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateEdgeByElemEdge([10:59-10:227, 10:219-10:227, 10:211-10:219, 10:203-10:211], 1)
