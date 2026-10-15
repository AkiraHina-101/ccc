# Equivalence()

Equivalence()

Description​

Equivalence Nodes

Syntax​

Equivalence(cursor[] taNode, int iTypeEquiva, double tolerance)

Inputs​

1. Cursor[]​

Target node cursor([10:Node ID])

2. Int​

Equivalence merge toward type

0: First Node

1: Second Node

2: Mid-Node

3. Double​

Equivalence tolerance

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Equivalence([10:489, 10:84], 0, 0.001)
