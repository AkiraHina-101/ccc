# AssociatedPick

AssociatedPick AssociatedPick Description Execute of Associated Pick Syntax AssociatedPick(Cursor[] tacursor,String str2,String str3) Inputs Cursor[] Target cursors String Target Entity Name(BarBody,Part,Face,Edge,Elem,SolidElem,Node,CornerNode,MidNodes,MidNodesNoBoundary,Connection,Mass,Contact) String Use only str2=Connection.(UNKNOWN,MPC,RBE2,RBE3,SPRING,MASS,BOLT,CONM,PROD,RBAR,BARBEAM,BUSH,MOMENT,GAP,WELD,DAMPER) Return Code The found cursor[*:*,*:*] Succeeded FAILED Failed Sample Code AssociatedPick([6:26], "Node", "UNKNOWN")
