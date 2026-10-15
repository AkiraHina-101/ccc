# AttachTemplateDeformation()

AttachTemplateDeformation()

Description​

Attach contour setting to specific template.

Syntax​

AttachTemplateDeformation(string templateName, float DispRatioEach0, float DispRatioEach1, float DispRatioEach2, float DispRatio, int ScaleMethod, bool EachDispComp, bool ShowOriginalShade, bool ShowOriginalMesh, bool ShowOriginalEdge, color OriginalShade, color OriginalMesh, color OriginalEdge, float OriginalShadeTrans)

Inputs​

1. string ​

Template name.

2. float ​

X direction ratio

3. float ​

Y direction ratio

4. float ​

Z direction ratio

5. float​

Ratio

6. int ​

Displacement Scale. 0:Percentage of Model Size; 1:Percentage of Result.

7. bool ​

Each direction ratio flag. 

8. bool ​

Show Shade of Original Shape. 

9. bool ​

Show Mesh of Original Shape. 

10. bool ​

Show Edge of Original Shape.

11. color​

Shade color of Original Shape

12. color​

Mesh color of Original Shape.

13. color​

Edge color of Original Shape.

14. float​

Transparency of Original Shape.

Return Code​

"1": Succeeded.

"0": Failed.

Sample Code​

AttachTemplateDeformation("AllDefault", 0.07, 0.07, 0.07, 0.07, 0, 0, 0, 1, 1, 13158600, 11184810, 11184810, 0.8)
