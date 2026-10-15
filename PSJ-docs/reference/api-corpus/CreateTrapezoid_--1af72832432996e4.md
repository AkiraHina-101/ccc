# CreateTrapezoid()

CreateTrapezoid()

Description​

Create Trapezoid Body

Syntax​

CreateTrapezoid(double[3] vdOriginXYZ, double[3] vdLength, double dTopXLength, double dRadius,
    int[3] vlNodeCnt, string strBodyName, color colBody, cursor crCoord)

Inputs​

1. Double[3]​

Origin coordinate Point([x, y, z])

2. Double[3]​

Length along the coordinate axis Length([x_length, y_length, z_length])

3. Double​

Length in X (Top)

4. Double​

Radius corresponding to bool flag Circle Segment

5. Int[3]​

Number of node along the coordinate axis Node([x_node, y_node, z_node])

6. String​

Part name

7. Color​

Part color

8. Cursor​

Whether use local coordinate or not True = 27:*, False = 0:0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateTrapezoid([0, 0, 0], [0.01, 0.015, 0.02], 0.007, 0.005, [10, 10, 10], "Trapezoid_1", 5000371, 0:0)
