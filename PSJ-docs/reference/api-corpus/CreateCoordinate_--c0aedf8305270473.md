# CreateCoordinate()

CreateCoordinate()

Description​

Create coordinate

Syntax​

CreateCoordinate(string name, int type, point point1, point point2, point point3, TCursor crRefCoord, TCursor crEdit)

Inputs​

1. String​

Coordinate name

2. Int​

Coordinate type (0: Rectangular, 1: Cylindrical, 2: Spherical)

3. Point​

Coordinate definition point 1

4. Point​

Coordinate definition point 2

5. Point​

Coordinate definition point 3

6. TCursor​

Reference coordinate

7. TCursor​

Edit target coordinate

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateCoordinateThreeNode("CRect3", 0, 0, [10:466, 10:467, 10:475], [], 0:0, 0:0)
