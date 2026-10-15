# Imprint_Circle()

Imprint_Circle()

Description​

Create imprint circle line

Syntax​

Imprint_Circle(double[] Point_xyz,int[] Face_ID,double Inner_Radius,double Outer_Radius,
    int No_of_Layers,int No_of_Divisions,bool BreakFace,Cursor[] bodyCursor)

Inputs​

1. Double[]​

Point xyz [[x1,y1,z1]]

2. Int[]​

Face ID Array

3. Double​

Inner Radius

4. Double​

Outer Radius

5. Int​

No of Layers

6. Int​

No of Divisions

7. Bool​

Flag true = 1,false=0

8. Cursor[]​

Body Cursor([3:*]*=Body ID)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Imprint_Circle([[0.00555556, 0.00444444, 0.01]], [26], 0.001, 0.002, 1, 30, 1, [3:1])
