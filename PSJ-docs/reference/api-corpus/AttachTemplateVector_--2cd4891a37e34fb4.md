# AttachTemplateVector()

AttachTemplateVector()

Description​

Create a new template.

Syntax​

AttachTemplateVector(string templateName, int ScaleMethod, float ratioModel, float ratioScreen, float ratioValue, bool UseArrow, color Highlight, color Positive, color Negative, bool UseContour, int HighlightTarget, float HighligValue1, float HighligValue2, int DisplayTarget, bool Reverse, bool AllModelVector, int ThresholdOpt, float ThresholdValue, float ThresholdValueMax, int ComparisonOpt, bool AllSameLength)

Inputs​

1. string ​

Template name.

2. int ​

Scale Method. 0: Model size ratio, 1: Screen size ratio.

3. float ​

Model size ratio value.

4. float ​

Screen size ratio value.

5. float ​

Ratio value.

6. bool ​

Use Arrow flag.

7. color ​

Highlight color.

8. color ​

Positive color.

9. color ​

Negative color.

10. bool ​

Use Contour flag.

11. int ​

Highlighting target.

12. float ​

Highlight Value1,

13. float ​

Highlight Value2,

14. int ​

Display Target.

15. bool ​

Reverse flag.

16. bool ​

All Model Vector flag.

17. int ​

Threshold target.

18. float ​

Threshold Value.

19. float ​

Threshold Value Max.

20. int ​

Comparison Opt

21. bool ​

All in the same length.

Return Code​

"1": Succeeded.

"0": Failed.

Sample Code​

AttachTemplateVector("My Template", 0, 0.03, 0.03, 1, 1, 255, 16777215, 51400, 0, 0, 0, 1, 0, 0, 0, 0, 0, 100, 0, 0)
