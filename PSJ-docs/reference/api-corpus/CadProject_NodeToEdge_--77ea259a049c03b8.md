# CadProject_NodeToEdge()

CadProject_NodeToEdge()

Description​

Project nodes in Meshed Nodes toward a CAD Edge   

Syntax​

CadProject_NodeToFace(cursor taCadEdge, cursor[] taNodes, int Direction)

Inputs​

1. Cursor​

Target reference CAD Edge (14:RefFace ID)

2. Cursor[]​

Target nodes ([10:Node IDs])

3. int​

Direction Min=0, X=1, Y=2, Z=3, -X=4, -Y=5, -Z=6

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CadProject_NodeToEdge(14:2, [10:378, 10:377, 10:376], 0)
