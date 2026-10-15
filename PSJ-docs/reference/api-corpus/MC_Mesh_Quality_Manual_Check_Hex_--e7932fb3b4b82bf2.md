# MC_Mesh_Quality_Manual_Check_Hex()

MC_Mesh_Quality_Manual_Check_Hex()

Description​

Mesh_Quality_Manual_Check_Hex

Syntax​

MC_Mesh_Quality_Manual_Check_Hex(cursor[] crBody, cursor[] crFace, cursor[] crElem,
    int iElemType, int elemQualityType, int iCond, double dSafeFact, double dDispValue)

Inputs​

1. Cursor[]​

Target part cursor([3:Part ID])

2. Cursor[]​

Target face cursor([6:Face ID])

3. Cursor[]​

Target element cursor([11:Elem ID])

4. Int​

Element type (3-Hex Element)

5. Int​

Element quality metric type

0: Stretch

1: Aspect Ratio

2: Edge Length

3: Volume

4: Unstable

5: Time Step (Abaqus)

6. Int​

Condition Display

7. double​

Safety factor

8. double​

Display value

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MC_Mesh_Quality_Manual_Check_Hex([3:1], [], [], 3, 0, 0, 1, 0.1)
