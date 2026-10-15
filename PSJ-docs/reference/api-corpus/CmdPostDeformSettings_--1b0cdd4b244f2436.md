# CmdPostDeformSettings()

CmdPostDeformSettings()

Description​

Deform setting.

Syntax​

CmdPostDeformSettings(float DispRatioEach0, float DispRatioEach1, float DispRatioEach2, float DispRatio, int ScaleMethod, bool EachDispComp, bool ShowOriginalShade, bool ShowOriginalMesh, bool ShowOriginalEdge, color OriginalShade, color OriginalMesh, color OriginalEdge, float OriginalShadeTrans)

Inputs​

1. float ​

X direction ratio

2. float ​

Y direction ratio

3. float ​

Z direction ratio

4. float​

Ratio

5. int ​

Displacement Scale. 0:Percentage of Model Size; 1:Percentage of Result.

6. bool ​

Each direction ratio flag. 

7. bool ​

Show Shade of Original Shape. 

8. bool ​

Show Mesh of Original Shape. 

9. bool ​

Show Edge of Original Shape.

10. color​

Shade color of Original Shape

11. color​

Mesh color of Original Shape.

12. color​

Edge color of Original Shape.

13. float​

Transparency of Original Shape.

Return Code​

Nothing.

Sample Code​

CmdPostDeformSettings(0.07, 0.07, 0.07, 0.07, 0, 0, 0, 1, 1, 13158600, 11184810, 11184810, 0.800000)
