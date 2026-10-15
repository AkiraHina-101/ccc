# CadProject_NodeToFace()

CadProject_NodeToFace()

Description​

Project nodes in Meshed Face toward CAD Faces   

Syntax​

CadProject_NodeToFace(cursor[] taCadFaces, cursor[] taNodes, int Direction, bool bImproveQuality,
    double tolerance, bool bNearest3Nodes)

Inputs​

1. Cursor[]​

Target reference CAD Faces (15:RefFace ID)

2. Cursor[]​

Target nodes ([10:Node IDs])

3. int​

Direction Min=0, X=1, Y=2, Z=3, -X=4, -Y=5, -Z=6

4. Bool​

Improve Quality check flag True = 1, False = 0

5. Double​

Tolerance. If it set to -1, it means Auto setting (search based on mesh size).

7. Bool​

Nearest Three Nodes check flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CadProject_NodeToFace([15:5], [10:377, 10:378, 10:390], 0, 0, 0.003, 1)
