# RotateCoordinate()

RotateCoordinate()

Description​

Rotate coordinate

Syntax​

CreateCoordinateRotate(string strName, int iCoordType, vector vecRotate, bool bCreateNew, cursor crRefCoord, position posCenterRot, cursor crEdit)

Inputs​

1. String​

Coordinate name

2. Int​

Coordinate type (0: Rectangular, 1: Cylindrical, 2: Spherical)

3. Vector​

Coordinate rotation

4. Bool​

New creation bool flag True = 1, False = 0

5. TCursor​

Reference coordinate

6. Position​

Position of rotation center

7. TCursor​

Edit target coordinate

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateCoordinateRotate("CRect_2", 0, [1.570796326794412, 1.047197551196275, 1.570796326794412], 1, 27:1, [0.01, 0, 0.01], 27:1)
