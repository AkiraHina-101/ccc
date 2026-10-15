# Imprint_ExtendLine()

Imprint_ExtendLine()

Description​

Create imprint Extend line

Syntax​

Imprint_ExtendLine(int Edge_ID,int Method_Type,int Position_Type,bool Break_Face ,Cursor[] bodyCursor)

Inputs​

1. Int​

Edge ID

2. Int​

Method Type 0=Straight,1=Same Curvature

3. Int​

Position Type 0=Nearest Edge,1=Boundary Edge

4. Bool​

Flag true = 1,false=0

5. Cursor[]​

Body Cursor([3:*]*=Body ID)

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Imprint_ExtendLine(27, 0, 0, 1, [3:1])
