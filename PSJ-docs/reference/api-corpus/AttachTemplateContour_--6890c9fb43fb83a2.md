# AttachTemplateContour()

AttachTemplateContour()

Description​

Attach contour setting to specific template.

Syntax​

AttachTemplateContour(string templateName, int Contour, int ContourType, int MaxMinType, float MaxUser, float MinUser, float MaxTotal, 
float MinTotal, int SpectrumType, color UpperColor, color LowerColor, color FrameColor, string strColors, int Log, bool ShowBlankValueAs0, 
bool OptimizedShape, float contours)

Inputs​

1. string ​

Template name.

2. int  ​

Step number

3. int  ​

ContourType

4. int  ​

Max Min Type
0: Visible Entity, 1: Total Entity, 2: User Define, 3: Multiple Result

5. float  ​

Maximum value.

6. float  ​

Minimum value.

7. float  ​

Total maximum value.

8. float  ​

Total Minimum value.

9. int  ​

Spectrum Type

10. color  ​

Out of Maximum color

11. color  ​

Out of Minimum color

12. color  ​

Contour Frame Color

13. string  ​

Colors

14. int  ​

Log type

15. bool  ​

Show blank value as 0 flag.

16. bool  ​

Optimization Toolkit flag.

17. float []  ​

Contour step value.

Return Code​

"1": Succeeded.

"0": Failed.

Sample Code​

AttachTemplateContour("New Template", 10, 1, 0, 0.000177567, 0, 0.000177567, 0, 2, 255, 16711680, 65535, [], 0, 0, 0, [100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0])
