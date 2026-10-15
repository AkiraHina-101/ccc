# MirrorBody()

MirrorBody()

Description​

Mirror Body

Syntax​

MirrorBody(cursor[] taBody, double[] scaleVector, double dOffset, bool bCreateNewBody,
    bool bCopyLBC, bool bCopyProperty, bool bRemoveDupFace, bool bMergeNode, double dTolerance)

Inputs​

1. Cursor[]​

Target part cursor([3:Part ID])

2. Double[]​

Mirror plane point ([xi, yi, zi])

3. Double​

Mirror offset value

4. Bool​

Create new part bool flag True = 1, False = 0

5. Bool​

LBC Copy bool flag True = 1, False = 0

6. Bool​

Copy property info bool flag True = 1, False = 0

7. Bool​

Remove duplicate faces bool flag True = 1, False = 0

8. Bool​

Equivalence nodes bool flag True = 1, False = 0

9. Double​

Equivalence nodes tolerance value

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MirrorBody([3:2], [[0, 0.004999999888241291, 0], [0.004999999888241291, 0.004999999888241291, 0],
    [0, 0, 0]], 0.002, 1, 0, 0, 0, 0, 1e-08)
