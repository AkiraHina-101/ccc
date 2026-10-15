# ScaleBody()

ScaleBody()

Description​

Scale Body

Syntax​

ScaleBody(cursor[] taBody, double[3] scaleVector, double[3] scaleCentre, cursor crCoord,
    bool createNew, bool copyLBC, bool usePartCenter)

Inputs​

1. Cursor[]​

Target part cursor([3:Part ID])

2. Double[3]​

Scale vector(x, y, z)

3. Double[3]​

Scale center(x, y, z)

4. Cursor​

Whether use local coordinate or not True = 27:*, False = 0:0

5. Bool​

Create new part bool flag True = 1, False = 0

6. Bool​

LBC copy bool flag True = 1, False = 0

7. Bool​

Use part center bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ScaleBody([3:1], [1, 5, 1], [0, 0, 0], 0:0, 1, 0, 1)
