# CmdPostContourSettings()

CmdPostContourSettings()

Description​

Contour setting.

Syntax​

CmdPostContourSettings(int Contour, int ContourType, int MaxMinType, float MaxUser, float MinUser, float MaxTotal, float MinTotal, 
int SpectrumType, color UpperColor, color LowerColor, color FrameColor, string strColors, int Log, bool ShowBlankValueAs0, bool OptimizedShape, , float contours, color NoResult)

Inputs​

1. int  ​

Step number

2. int  ​

ContourType

3. int  ​

Max Min Type
0: Visible Entity, 1: Total Entity, 2: User Define, 3: Multiple Result

4. float  ​

Maximum value.

5. float  ​

Minimum value.

6. float  ​

Total maximum value.

7. float  ​

Total Minimum value.

8. int  ​

Spectrum Type

9. color  ​

Out of Maximum color

10. color  ​

Out of Minimum color

11. color  ​

Contour Frame Color

12. string  ​

Colors

13. int  ​

Log type

14. bool  ​

Show blank value as 0 flag.

15. bool  ​

Optimization Toolkit flag.

16. float []  ​

Contour step value.

17. color []  ​

No Result color.

Returint Code​

Nothing.

Sample Code​

CmdPostContourSettings(10, 1, 0, 3.8698804379,  0.0000000000,  3.8698804379,  0.0000000000, 2, 255, 16711680, 65535, [], 0, 0, 0, [100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0], 8421504)
