# MC_Mesh_Quality_Manual_Check_TriQuad()

MC_Mesh_Quality_Manual_Check_TriQuad()

Description​

Mesh_Quality_Manual_Check_TriQuad

Syntax​

MC_Mesh_Quality_Manual_Check_TriQuad(Cursor[] targetBody, Cursor[] targetFace,
    Cursor[] targetElements, int nElemType, int nElemQuality, int nCheckConditionTri,
    double dLimitValueTri, double TSSFACTri, int nCheckConditionQuad, dLimitValueQuad,
    double TSSFACQuad, bool bIncludeDiagobalQuad, int nNonPrimary)

Inputs​

1. Cursor[]​

Part Cursor([3:Part ID])

2. Cursor[]​

Face Cursor([6:Face ID])

3. Cursor[]​

Element Cursor([11:Element ID])

4. Int​

Elements type, default elements TriQuad = 4

5. Int​

Elemenets Quality: Stretch = 0, Aspect Ratio = 1, Edge Length = 2, Area = 3. Node Valence = 4, Interior Angle = 5, Unstable = 6, Time Step (LS-Dyna) = 7, Time Step (Abaqus) = 8

6. Int​

Check condition Tri "<=" = 0, "<" = 1, ">=" = 2, ">" = 3

7. Double​

Limit value Tri

8. Double​

TSSFAC tri value

9. Int​

Check condition Quad "<=" = 0, "<" = 1, ">=" = 2, ">" = 3

10. Double​

Limit value for Quad

11. Double​

TSSFAC quad value

12. Bool​

Include diagonal flag true = 1, false = 0

13. Bool​

Nonprimary

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MC_Mesh_Quality_Manual_Check_TriQuad([3:1], [], [], 4, 0, 0, 0.1, 1, 0, 0.1, 1, 1, 0)
