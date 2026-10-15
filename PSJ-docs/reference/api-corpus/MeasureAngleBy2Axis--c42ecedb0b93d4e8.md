# MeasureAngleBy2Axis

MeasureAngleBy2Axis MeasureAngleBy2Axis Description Measure the angle created by 2 Axis. Syntax MeasureAngleBy2Axis(Axis xyz1,Axis xyz2,String Target,Integer N) Inputs Axis unit vector([x,y,z]) Axis unit vector([x,y,z]) String Target (Angle or XY or YZ or ZX or ALL) Integer N specify the number of decimal places (0 Return Code Angle value(Target = Angle,XY,YZ,ZX), [Angle,XY,YZ,ZX] (Target = ALL) Succeeded FAILED Failed Sample Code MeasureAngleBy2Axis([0,0,1],[1,1,1],"ALL",6) or MeasureAngleBy2Axis([0,0,1],[1,1,1],"Angle",6)
