# AttachTemplateCircle()

AttachTemplateCircle()

Description​

Create a new template.

Syntax​

AttachTemplateCircle(string templateName, int ScaleMethod, float ratioModel, float ratioScreen, float ratioValue, color Highlight, color Positive, color Negative, bool UseContour, int HighlightTarget, float HighligValue1, float HighligValue2, int DisplayTarget, bool Reverse)

Inputs​

1. string ​

Template name.

2. int ​

Scale method. 0: Model size ratio, 1: Screen size ratio.

3. float ​

Value of Model size ratio.

4. float ​

Value of Screen size ratio.

5. float ​

Ratio value = 1.0,

6. color ​

Highlight color.

7. color ​

Positive color.

8. color ​

Negative color

9. bool  ​

UseContour flag.

10 . int ​

Highlighting target.

11. float ​

Highlighting Value 1. Used in GREATER THAN, GREATER THAN ABS and minimum value of RANGE.

12. float ​

Highlighting Value 2. Used in maximum value of RANGE.

13 . int  ​

Threshold

14. bool  ​

Reverse flag.

Return Code​

"1": Succeeded.

"0": Failed.

Sample Code​

AttachTemplateCircle("My Template", 0, 0.03, 0.03, 1, 255, 16777215, 51400, 0, 0, 0, 1, 0, 0)
