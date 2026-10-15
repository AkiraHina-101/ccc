# CadProject_Part()

CadProject_Part()

Description​

Project nodes in Meshed Part toward CAD Part   

Syntax​

CadProject_Part(int method, cursor taCadBody, cursor meshedBody, bool bForceProject,
    bool bProjectCornerNodes, bool bProjectMidNodes, bool bIDCheck)

Inputs​

1. Int​

Method = 1

2. Cursor​

Target reference CAD body (12:RefPart ID)

3. Cursor​

Target meshed body (3:Part ID)

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

CadProject_Part(1, 12:1, 3:1, 0, 0, 1, 1)
