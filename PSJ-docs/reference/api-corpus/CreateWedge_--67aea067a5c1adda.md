# CreateWedge()

CreateWedge()

Description​

Create Wedge Body

Syntax​

CreateWedge(double[3] vdOriginXYZ, double[3] vdLength, int[3] vlNodeCnt,
    string strBodyName, color colBody, cursor crCoord)

Inputs​

1. Double[3]​

Origin coordinate Point([x, y, z])

2. Double[3]​

Length along the coordinate axis Length([x_length, y_length, z_length])

3. int[3]​

Number of node along the coordinate axis Node([x_node, y_node, z_node])

4. String​

Part name

5. Color​

Part color

6. Cursor​

Whether use local coordinate or not True = 27:*, False = 0:0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateWedge([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Wedge_1", 14276960, 0:0)
