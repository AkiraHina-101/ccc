# MeasureAngleByProjected_Node

MeasureAngleByProjected_Node MeasureAngleByProjected_Node Description Measure the angle between the node and the plane of coordinate system. Syntax MeasureAngleByProjected_Node(cursor node,String Target,Integer N) Inputs cursor node cursor(10:*;*=node id) String Target (XY or YZ or ZX or ALL) Integer N specify the number of decimal places (0 Return Code Angle value(Target = XY,YZ,ZX), [XY,YZ,ZX] (Target = ALL) Succeeded FAILED Failed Sample Code MeasureAngleByProjected_Node(10:331,"XY",6) or MeasureAngleByProjected_Node(10:331,"ALL",6)
