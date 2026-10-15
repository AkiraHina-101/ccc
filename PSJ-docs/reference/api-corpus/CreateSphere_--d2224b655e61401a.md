# CreateSphere()

CreateSphere()

Description​

Create Sphere Body

Syntax​

CreateSphere(double[3] vdOriginXYZ, double dRadius, int nLatitudeNodeCnt, int nLongitudeNodeCnt,
    string strBodyName, color colBody, cursor crCoord)

Inputs​

1. Double[3]​

Origin coordinate Point([x, y, z])

2. Double​

Sphere radius value (m)

3. Int​

Latitude node count

4. Int​

Longitude node count

5. String​

Part name

6. Color​

Part color

7. Cursor​

Whether use local coordinate or not True = 27:*, False = 0:0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateSphere([0, 0, 0], 0.005, 50, 100, "Sphere_1", 11908427, 0:0)
