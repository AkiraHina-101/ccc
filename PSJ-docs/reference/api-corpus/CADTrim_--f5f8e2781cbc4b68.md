# CADTrim()

CADTrim()

Description​

CAD Trim

Syntax​

CADTrim(Cursor[] Face Cursor, Cursor[] Body Cursor, double Trim Size, double Trim Angle)

Inputs​

1. Cursor[]​

Target Faces for CAD Trim

2. Cursor[]​

Target Bodies for CAD Trim

3. Double​

Trim Size

4. Double​

Trim Angle

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

GeometryCADTrim([], [3:8], 0.001, 15)
