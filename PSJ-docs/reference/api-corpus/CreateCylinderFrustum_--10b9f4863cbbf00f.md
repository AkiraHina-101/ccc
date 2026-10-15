# CreateCylinderFrustum()

CreateCylinderFrustum()

Description​

Create Frustum Body

Syntax​

CreateCylinderFrustum(double[3] vdOriginXYZ, double TopRadius, double bottomRadius, double height, int circleNodeCount,
    int axisNodeCount, string bodyName, color bodyColor, cursor crCoord)

Inputs​

1. Double[3]​

Point [x,y,z]

2. Double​

Top Radius

3. Double​

Bottom Radius

4. Double​

Height

5. Int​

Circle Node Count

6. Int​

Axis Node Count

7. String​

Body Name

8. Color​

Body Color

9. Cursor​

Coordinate Cursor

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateCylinderFrustum([0, 0, 0], 0.003, 0.01, 0.02, 20, 20, "Frustum_1", 14903267, 0:0)
