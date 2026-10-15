# MoveNodeOffset

MoveNodeOffset MoveNodeOffset Description Move node(s) to an offset position Syntax MoveNodeOffset(double dDeltaX, double dDeltaY, double dDeltaZ, cursor crCoord, int[] taNodeKey) Inputs Double X coordinate to move the node Double Y coordinate to move the node Double Z coordinate to move the node Cursor Whether use local coordinate or not True = 27:*, False = 0:0 Int[] Node key cursor([Node ID]) Return Code 1 Succeeded 0 Failed Sample Code MoveNodeOffset(0, 0, 0.0005, 0:0, [1068])
