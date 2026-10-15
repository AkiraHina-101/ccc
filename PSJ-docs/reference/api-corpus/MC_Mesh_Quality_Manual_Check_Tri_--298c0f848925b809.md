# MC_Mesh_Quality_Manual_Check_Tri()

MC_Mesh_Quality_Manual_Check_Tri()

Description​

Mesh_Quality_Manual_Check_Tri

Syntax​

MC_Mesh_Quality_Manual_Check_Tri(cursor[] crEntities, int iElemType, int iCond, double dDispValue)

Inputs​

1. Cursor[]​

Target entity cursor([CursorType: CursorType ID])

2. Int​

Element quality metric type

0: Stretch

1: Aspect Ratio

2: Edge Length

3: Area

4: Node Valence

5: Interior angle

6: Duplicate Elements

7: Node free edges

3. Int​

Condition Display

0: <=

1: >=

2: <

3: >

4. Double​

Display value

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MC_Mesh_Quality_Manual_Check_Tri([3:1], 0, 0, 0.1)
