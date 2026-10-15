# Lbc_Bolt_Modeling_Type_D()

Lbc_Bolt_Modeling_Type_D()

Description​

Create Lbc TypeD Bolt

Syntax​

Lbc_Bolt_Modeling_Type_D(cursor[] taEdgeTop, cursor[] taEdgeBot, string strMPCName, double dConnRadius, double dPlaneTol)

Inputs​

1. Cursor[]​

Target top part edge cursor([5:Edge ID])

2. Cursor[]​

Target bottom part edge cursor([5:Edge ID])

3. String​

MPC name

4. Double​

Connection Radius

5. Double​

Plane Tolerance

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Lbc_Bolt_Modeling_Type_D([5:1], [5:7], "MPC", 5e-15, 2.42929e-08)
