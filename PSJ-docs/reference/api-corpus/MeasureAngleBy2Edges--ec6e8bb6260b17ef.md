# MeasureAngleBy2Edges

MeasureAngleBy2Edges MeasureAngleBy2Edges Description Measure the angle created by 2 Edges. Syntax MeasureAngleBy2Edges(cursor edge1,cursor edge2,String Target,Integer N) Inputs cursor edge cursor(5:*;*=edge id) cursor edge cursor(5:*;*=edge id) String Target (Angle or XY or YZ or ZX or ALL) Integer N specify the number of decimal places (0 Return Code Angle value(Target = Angle,XY,YZ,ZX), [Angle,XY,YZ,ZX] (Target = ALL) Succeeded FAILED Failed Sample Code MeasureAngleBy2Edges(5:27,5:32,"Angle",6) or MeasureAngleBy2Edges(5:27,5:32,"ALL",6)
