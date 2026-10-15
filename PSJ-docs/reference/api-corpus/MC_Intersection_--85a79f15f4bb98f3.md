# MC_Intersection()

MC_Intersection()

Description​

Intersection

Syntax​

MC_Intersection(cursor[] crBody, double dTol, int iDispType, int iNoLayer, bool bErrText)

Inputs​

1. Cursor[]​

Target body cursor([3:Part ID])

2. Double​

Number of edges tolerance

3. Int​

Display intersection type

0: Body intersection only

1: All intersection

2: Between bodies intersection

4. Int​

Number of intersection layer

5. Bool​

Error text bool flag True = 1, False = 0

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MC_Intersection([3:1], 0, 0, 1, 0)
