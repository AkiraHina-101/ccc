# MeasureMassByManual()

MeasureMassByManual()

Description​

Measure the Volume

Syntax​

MeasureMassByManual(cursor[] Part cursor,String Density,String Target,Integer N)

Inputs​

1. cursor[]​

Part cursor(s)([3,*],*=part Id)

2. String​

Density Value or Material Name

3. String​

Target(Mass,Gravity Center X,Gravity Center Y,Gravity Center Z,Moment Inertial XX,Moment Inertial YY,Moment Inertial ZZ,Moment Inertial XY,Moment Inertial XZ,Moment Inertial YZ,Principal Moment X,Principal Moment Y,Principal Moment Z,Traits Vector XX,Traits Vector XY,Traits Vector XZ,Traits Vector YX,Traits Vector YY,Traits Vector YZ,Traits Vector ZX,Traits Vector ZY,Traits Vector ZZ,Euler Angle X,Euler Angle Y,Euler Angle Z,ALL)

4. Integer N​

specify the number of decimal places (0<=N<=30)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MeasureMassByManual([3:1,3:2],"1.0","ALL",6) or MeasureMassByManual([3:1,3:2],"Copper_Alloy","ALL",6)
