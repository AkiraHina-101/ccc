# MC_Mesh_Quality_Manual_Check_Quad()

MC_Mesh_Quality_Manual_Check_Quad()

Description​

Mesh_Quality_Manual_Check_Quad

Syntax​

MC_Mesh_Quality_Manual_Check_Quad(cursor[] crBody, cursor[] crFace, cursor[] crElem,
    int iElemType, int iCond, int dSafeFact, double dDispValue)

Inputs​

1. Cursor[]​

Target part cursor([3:Part ID])

2. Cursor[]​

Target face cursor([6:Face ID])

3. Cursor[]​

Target element cursor([11:Elem ID])

4. Int​

Element type (1-Quad Element)

5. Int​

Element quality metric type

0: Stretch

1: Aspect Ratio

2: Warping

3: Skewness

4: Edge length

5: Area

6: Node Valence

7: Interior angle

8: Taper

9: Duplicate Elements

10: Node free edges

6. Int​

Condition Display

0: <=

1: >=

2: <

3: >

7. double​

Display value

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MC_Mesh_Quality_Manual_Check_Quad([3:1], [], [], 1, 0, 0, 0.1)
