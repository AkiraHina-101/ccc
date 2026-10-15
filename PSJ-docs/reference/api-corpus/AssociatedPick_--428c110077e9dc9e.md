# AssociatedPick()

AssociatedPick()

Description​

Execute of Associated Pick

Syntax​

AssociatedPick(Cursor[] tacursor,String str2,String str3)

Inputs​

1. Cursor[]​

Target cursors

2. String​

Target Entity Name(BarBody,Part,Face,Edge,Elem,SolidElem,Node,CornerNode,MidNodes,MidNodesNoBoundary,Connection,Mass,Contact)

3. String​

Use only str2=Connection.(UNKNOWN,MPC,RBE2,RBE3,SPRING,MASS,BOLT,CONM,PROD,RBAR,BARBEAM,BUSH,MOMENT,GAP,WELD,DAMPER)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

AssociatedPick([6:26], "Node", "UNKNOWN")
