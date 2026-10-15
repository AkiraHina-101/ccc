# Imprint_ExtendLine

Imprint_ExtendLine Imprint_ExtendLine Description Create imprint Extend line Syntax Imprint_ExtendLine(int Edge_ID,int Method_Type,int Position_Type,bool Break_Face ,Cursor[] bodyCursor) Inputs int Edge ID int Method Type 0=Straight,1=Same Curvature int Position Type 0=Nearest Edge,1=Boundary Edge bool Flag true = 1,false=0 Cursor[] Body Cursor([3:*]*=Body ID) Return Code 1 Succeeded 0 Failed Sample Code Imprint_ExtendLine(27, 0, 0, 1, [3:1])
