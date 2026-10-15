# CadProject_FaceToFace()

CadProject_FaceToFace()

Description​

Project nodes in Meshed Faces toward CAD Faces

Syntax​

CadProject_Face(int method, cursor[] taCadFaces, cursor[] meshedFaces, bool bForceProject,
    bool bProjectCornerNodes, bool bProjectMidNodes, bool bIDCheck)

Inputs​

1. Int​

Method = 3

2. Cursor[]​

Target reference CAD faces ([15:RefFace ID])

3. Cursor[]​

Target meshed faces ([6:Face ID])

4. Bool​

Force project = 0

5. Bool​

Project corner nodes bool flag True = 1, False = 0

6. Bool​

Project mid nodes bool flag True = 1, False = 0

7. Bool​

ID check bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CadProject_FaceToFace(3, [15:5], [6:5], 1, 0, 1, 1)
