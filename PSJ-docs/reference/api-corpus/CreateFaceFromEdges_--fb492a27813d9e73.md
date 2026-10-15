# CreateFaceFromEdges()

CreateFaceFromEdges()

Description​

Create Face From Edges

Syntax​

CreateFaceFromEdges(cursor[] edgeList, cursor[] part, cursor[] nodeList, bool sharedFace,
    bool smoothFace, bool createPart, bool improved, bool barsOnly, bool onlyOnePart, bool useMidNodes)

Inputs​

1. Cursor[]​

Target edge cursor([5:Edge ID])

2. Cursor[]​

Target part cursor([3:Part ID])

3. Cursor[]​

Target node cursor([10:Node ID])

4. Bool​

Share face bool flag True = 1, False = 0

5. Bool​

Smooth face bool flag True = 1, False = 0

6. Bool​

New part bool flag True = 1, False = 0

7. Bool​

Improved bool flag True = 1, False = 0

8. Bool​

Bars bool flag True = 1, False = 0

9. Bool​

Only one part bool flag True = 1, False = 0

10. Bool​

use mid nodes bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateFaceFromEdges([5:57, 5:38], [3:3], [], 0, 0, 1, 0, 0, 0, 0)
