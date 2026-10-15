# ViewPoint()

ViewPoint()

Description​

Set view point.

Syntax​

ViewPoint(int Direction)

Inputs​

1. Int​

Direction: preset view direction.

0: View Left (-X)

1: View Right (+X)

2: View Bottom (-Y)

3: View Top (+Y)

4: View Rear (-Z)

5: View Front (+Z)

6: User View 1(+Y+Z+X)

7: User View 2(+Y-Z+X)

8: User View 3(+Y-X-Z)

9: User View 4(+Y-X+Z)

11: +Z+X+Y

12: +Z-X-Y

13: +X+Y+Z

14: +X-Z-Y

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ViewPoint(1)
