# Imprint_Circle

Imprint_Circle Imprint_Circle Description Create imprint circle line Syntax Imprint_Circle(double[] Point_xyz,int[] Face_ID,double Inner_Radius,double Outer_Radius,int No_of_Layers,int No_of_Divisions,bool BreakFace,Cursor[] bodyCursor) Inputs double[] Point xyz [[x1,y1,z1]] int[] Face ID Array double Inner Radius double Outer Radius int No of Layers int No of Divisions bool Flag true = 1,false=0 Cursor[] Body Cursor([3:*]*=Body ID) Return Code 1 Succeeded 0 Failed Sample Code Imprint_Circle([[0.00555556, 0.00444444, 0.01]], [26], 0.001, 0.002, 1, 30, 1, [3:1])
