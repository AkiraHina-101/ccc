# MeasureDistanceBy2Nodes

MeasureDistanceBy2Nodes MeasureDistanceBy2Nodes Description Measure the distance between two nodes Syntax MeasureDistanceBy2Nodes(cursor[] Cursors,String Target,Integer N) Inputs cursor[] Nodes Cursor([10:*,10:**]*,** = Node ID) String Target(Dist or X or Y or Z or ALL) Integer N specify the number of decimal places (0 Return Code distance (Input = Dist,X,Y,Z) [Dist,X,Y,Z](Input = All) Succeeded FAILED Failed Sample Code MeasureDistanceBy2Nodes([10:447,10:468],"X",6) or MeasureDistanceBy2Nodes([10:447,10:468],"Dist",6)
