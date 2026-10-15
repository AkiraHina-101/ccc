# CadProject_Face()

CadProject_Face()

Description​

Project nodes in Meshed Face toward CAD Part

Syntax​

CadProject_Face(int method, cursor taCadBody, cursor[] meshedFaces, bool bForceProject,
    bool bProjectCornerNodes, bool bProjectMidNodes, bool bIDCheck)

Inputs​

1. Int​

Method = 2

2. Cursor​

Target reference CAD body (12:RefPart ID)

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

CadProject_Face(2, 12:1, [6:5], 0, 0, 1, 1)
