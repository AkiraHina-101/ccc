# MC_FreeEdge()

MC_FreeEdge()

Description​

Free Edge

Syntax​

MC_FreeEdge(cursor[] crBody, int iNolayer, bool bFreeEdge, bool bcheckFreeEdge,
    bool bNonman, int iNonThres, bool bErrText)

Inputs​

1. Cursor[]​

Target body cursor([3:Part ID])

2. Int​

Number of layers display

3. Bool​

Free edges bool flag True = 1, False = 0

4. Bool​

Check Free edges by Part bool flag True = 1, False = 0

5. Bool​

Nonmanifold bool flag True = 1, False = 0

6. Int​

Nonmanifold Threshold value

7. Bool​

Error text bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​
