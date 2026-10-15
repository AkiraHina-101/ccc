# MoveNodeAlignNode

MoveNodeAlignNode MoveNodeAlignNode Description Move Nodes from Node to Element plane Syntax MoveNodeAlignNode(int[] taRefNodeKeys, int[] taObjNodeKeys, int iType) Inputs Int[] Reference node key cursor(Node ID) Int[] Object node key cursor(Node ID) Int Type of searching align node* *1: On shortest pass &ensp;2: On the direction the reference nodes &ensp;3: On selected entity Return Code 1 Succeeded 0 Failed Sample Code MoveNodeAlignNode([150, 140, 148], [141], 2)
