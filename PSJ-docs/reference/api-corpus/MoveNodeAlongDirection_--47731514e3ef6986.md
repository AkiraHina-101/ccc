# MoveNodeAlongDirection()

MoveNodeAlongDirection()

Description​

Move node(s) in a specified direction

Syntax​

MoveNodeAlongDirection(double dX, double dY, double dZ, double planept[0][0],
    double planept[0][1], double planept[0][2], double planept[1][0], double planept[1][1],
    double planept[1][2], double planept[2][0], double planept[2][1], double planept[2][2],
    Cursor face, double magnitude, bool facepicked, bool elempicked, int[] node)

Inputs​

1. Double​

Displacement in X Direction

2. Double​

Displacement in Y Direction

3. Double​

Displacement in Z Direction

4. Double​

1st coordinate of plane point1

5. Double​

2nd coordinate of plane point1

6. Double​

3rd coordinate of plane point1

7. Double​

1st coordinate of plane point2

8. Double​

2nd coordinate of plane point2

9. Double​

3rd coordinate of plane point2

10. Double​

1st coordinate of plane point3

11. Double​

2nd coordinate of plane point3

12. Double​

3rd coordinate of plane point3

13. Cursor​

selected face cursor

14. Double​

Magnitude

15. Bool​

is face picked 0=no,1=yes

16. Bool​

is element picked 0=no,1=yes

17. Int[]​

Node List

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MoveNodeAlongDirection(0.00333333, 0, -0.00111111, 0.01, 0, 0, 0.01, 0.00111111, 0,
    0.01, 0.00111111, 0.00111111, 6:24, 0.00351364, 1, 0, [443, 437])
