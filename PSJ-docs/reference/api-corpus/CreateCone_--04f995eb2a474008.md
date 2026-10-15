# CreateCone()

CreateCone()

Description​

Create Cone Body

Syntax​

CreateCone(double[3] vdOriginXYZ, double bottomRadius, double height, int circleNodeCount,
    int axisNodeCount, string bodyName, color bodyColor, cursor crCoord)

Inputs​

1. Double[3]​

Point [x,y,z]

2. Double​

Bottom Radius

3. Double​

Height

4. Int​

Circle Node Count

5. Int​

Axis Node Count

6. String​

Body Name

7. Color​

Body Color

8. Cursor​

Coordinate Cursor

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateCone([0, 0, 0], 0.01, 0.02, 100, 5, "Cone_1", 7138156, 0:0)
