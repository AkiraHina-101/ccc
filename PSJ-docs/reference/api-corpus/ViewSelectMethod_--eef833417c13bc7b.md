# ViewSelectMethod()

ViewSelectMethod()

Description​

Change selection filter.

Syntax​

ViewSelectMethod(int FilterType, int Option)

Inputs​

1. Int​

FilterType: Type of selection filter.

0: Nothing

1: Part

2: Bar Part

3: Face

4: Edge

5: Vertex

6: Solid Element

7: 2D Element

8: 1D Element

9: Element Edge

10: Node

11: LBC

12: Coordinate

13: Group

15: Face Point

16: Edge Point

30: Tet4

31: Tet10

32: Hex8

33: Hex20

34: Penta6

35: Penta15

36: Pyramid5

38: Tri3

39: Tri6

40: Quad4

41: Quad8

2. Int​

Option works only for FilterType:10.

0: (The same as no option. Just enables Node filter only.)

1: Enables Select Mid Node filter, too.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ViewSelectMethod(1)
