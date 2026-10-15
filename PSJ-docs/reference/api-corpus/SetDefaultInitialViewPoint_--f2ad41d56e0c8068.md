# SetDefaultInitialViewPoint()

SetDefaultInitialViewPoint()

Description​

Set default view point when a document opened.

Syntax​

SetDefaultInitialViewPoint(int Flag, int Type)

Inputs​

1. int​

Enable or disable initial view point.

0: Disable

1: Enable

2. int​

Specify the viewpoint.

0: XY Plane (+Z axis)

1: XY Plane (-Z axis)

2: XZ Plane (+Y axis)

3: XZ Plane (-Y axis)

4: YZ Plane (-X axis)

5: YZ Plane (+X axis)

6: ISO-view (+Z1)

7: ISO-view (+Z2)

8: ISO-view (+Y1)

9: ISO-view (+Y2)

10: ISO-view (+X1)

11: ISO-view (+X2)

Return Code​

No return code.

Sample Code​

SetDefaultInitialViewPoint(0,1)
