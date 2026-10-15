# SplitElement()

SplitElement()

Description​

Split Element

Syntax​

SplitElement(cursor[] taElems, cursor datum0, cursor datum1, int iMethod, bool bAutoExecute,
    bool AutoTransition, bool bCADProject, bool bMergeNodes)

Inputs​

1. Cursor[]​

Target element cursor([11:Element ID])

2. Cursor​

datum0 = 0:0

3. Cursor​

datum1 = 0:0

4. Int​

Method = 0

5. Bool​

Auto execution bool flag True = 1, False = 0

6. Bool​

Auto transition bool flag True = 1, False = 0

7. Bool​

CAD Projection bool flag True = 1, False = 0

8. Bool​

Merge Nodes bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

SplitElement([11:1090], 0:0, 0:0, 0, 1, 0, 0, 1)
