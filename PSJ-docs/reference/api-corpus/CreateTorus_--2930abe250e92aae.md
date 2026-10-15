# CreateTorus()

CreateTorus()

Description​

Create Torus Body

Syntax​

CreateTorus(double[3] vdOriginXYZ, double dInnerRadius, double dRingRadius, int nLatitudeNodeCnt,
    int nLongitudeNodeCnt,string strBodyName, color colBody, cursor crCoord)

Inputs​

1. Double[3]​

Origin coordinate Point([x, y, z])

2. Double​

Inner radius value (m)

3. Double​

Ring radius value (m)

4. Int​

Latitude node count

5. Int​

Longitude node count

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

CreateTorus([0, 0, 0], 0.015, 0.02, 20, 20, "Torus_1", 11882677, 0:0)
