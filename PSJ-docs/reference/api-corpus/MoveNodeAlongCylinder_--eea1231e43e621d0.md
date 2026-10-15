# MoveNodeAlongCylinder()

MoveNodeAlongCylinder()

Description​

Move Nodes Along desired Cylinder.

Syntax​

MoveNodeAlongCylinder(cursor[] taFace, cursor[] taNode, double dirX, double dirY,
    double dirZ, double circleX, double circleY, double circleZ, double radius, double height)

Inputs​

1. Cursor[]​

Target face cursor([6:Face ID])

2. Cursor[]​

Target node cursor([10:Node ID])

3. Double​

X direction vector of imaginary cylinder

4. Double​

Y direction vector of imaginary cylinder

5. Double​

Z direction vector of imaginary cylinder

6. Double​

X direction center of imaginary cylinder

7. Double​

Y direction center of imaginary cylinder

8. Double​

Z direction center of imaginary cylinder

9. Double​

Radius of imaginary cylinder

10. Double​

Height of imaginary cylinder

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

MoveNodeAlongCylinder([], [10:333, 10:341, 10:342, 10:334], 0, 1, 0, 0, 0, 0, 0.01, 0.02)
