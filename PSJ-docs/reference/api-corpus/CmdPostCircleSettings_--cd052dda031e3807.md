# CmdPostCircleSettings()

CmdPostCircleSettings()

Description​

Circle setting.

Syntax​

CmdPostCircleSettings(int ScaleMethod, float ratioModel, float ratioScreen, float ratioValue, color Highlight, color Positive, color Negative, bool UseContour, int HighlightTarget, float HighligValue1, float HighligValue2, int DisplayTarget, bool Reverse)

Inputs​

1. int ​

Scale method. 0: Model size ratio, 1: Screen size ratio.

2. float ​

Value of Model size ratio.

3. float ​

Value of Screen size ratio.

4. float ​

Ratio value = 1.0,

5. color ​

Highlight color.

6. color ​

Positive color.

7. color ​

Negative color

8. bool  ​

UseContour flag.

9 . int ​

Highlighting target.

10. float ​

Highlighting Value 1. Used in GREATER THAN, GREATER THAN ABS and minimum value of RANGE.

11. float ​

Highlighting Value 2. Used in maximum value of RANGE.

12 . int  ​

Threshold

13. bool  ​

Reverse flag.

Returint Code​

Nothing.

Sample Code​

CmdPostCircleSettings(0, 0.03, 0.03, 1, 255, 16777215, 51400, 0, 0, 0, 1, 0, 0)
