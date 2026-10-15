# BreakEdge()

BreakEdge()

Description​

Break selected edge

Syntax​

BreakEdge(int[] taBodyKey, int[] taFacekey, int[] taEdgeKey, int[] taNodeKey, bool bAutoByAngle, double dEdgeAngle)

Inputs​

1. Int[]​

Part IDs

2. Int[]​

Face IDs

3. Int[]​

Edge IDs

4. Int[]​

Node IDs

5. Bool​

Whether use Auto By Angle True = 1, False = 0

6. Double​

Enter edge angle

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

BreakEdge([], [], [], [27169, 27160], 0, 1.0472)
