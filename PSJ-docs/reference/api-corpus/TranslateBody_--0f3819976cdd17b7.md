# TranslateBody()

TranslateBody()

Description​

Translate Body

Syntax​

TranslateBody(cursor[] taBody, double[] tavdTranslate, cursor crCoord, bool bCreateNewBody,
    bool bcopyLBC, int iCopyCount)

Inputs​

1. Cursor[]​

Target part cursor([3:Part ID])

2. Double[]​

Translation vector list

3. Cursor​

Whether use local coordinate or not True = 27:*, False = 0:0

4. Bool​

Create New Part bool flag True = 1, False = 0

5. Bool​

LBC Copy bool flag True = 1, False = 0

6. Int​

Copy count

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

TranslateBody([3:1], [[0.01, 0, 0]], 0:0, 1, 0, 1)
