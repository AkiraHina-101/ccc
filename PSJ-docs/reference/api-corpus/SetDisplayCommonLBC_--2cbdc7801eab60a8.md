# SetDisplayCommonLBC()

SetDisplayCommonLBC()

Description​

Set common LBCs' display.

Syntax​

SetDisplayCommonLBC(int DisplayTargetEntity, int MarkerDensity, int ValueDisplay, int PartConnection, int OpacityColor, int MasterColor, int SlaveColor, int Enable3DMarker)

Inputs​

1. int​

Display target entity.

0: OFF

1: Always

2: Selected

2. int​

Marker Density.

0: One per target entity

1: Low

2: Middle

3: High

4: Effective area only

5: One per condition

3. int​

Value Display.

0: OFF

1: On screen

2: On 3D

3: On 3D with unit

4. int​

Part Connection.

0: ON

1: OFF

5. int​

Opacity color described by color value in Jupiter.

6. int​

Master color described by color value in Jupiter.

7. int​

Slave color described by color value in Jupiter.

8. bool​

Enable 3D Marker

0: ON

1: OFF

Return Code​

No return code.

Sample Code​

SetDisplayCommonLBC(0, 0, 1, 1, 255, 255, 16711680, 0)
