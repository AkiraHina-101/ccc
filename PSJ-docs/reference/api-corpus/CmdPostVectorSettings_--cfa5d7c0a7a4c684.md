# CmdPostVectorSettings()

CmdPostVectorSettings()

Description​

Vector setting.

Syntax​

CmdPostVectorSettings(int ScaleMethod, float ratioModel, float ratioScreen, float ratioValue, bool UseArrow, color Highlight, color Positive, color Negative, bool UseContour, int HighlightTarget, float HighligValue1, float HighligValue2, int DisplayTarget, bool Reverse, bool AllModelVector, int ThresholdOpt, float ThresholdValue, float ThresholdValueMax, int ComparisonOpt, bool AllSameLength)

Inputs​

1. int ​

Scale Method. 0: Model size ratio, 1: Screen size ratio.

2. float ​

Model size ratio value.

3. float ​

Screen size ratio value.

4. float ​

Ratio value.

5. bool ​

Use Arrow flag.

6. color ​

Highlight color.

7. color ​

Positive color.

8. color ​

Negative color.

9. bool ​

Use Contour flag.

10. int ​

Highlighting target.

11. float ​

Highlight Value1,

12. float ​

Highlight Value2,

13. int ​

Display Target.

14. bool ​

Reverse flag.

15. bool ​

All Model Vector flag.

16. int ​

Threshold target.

17. float ​

Threshold Value.

18. float ​

Threshold Value Max.

19. int ​

Comparison Opt

20. bool ​

All in the same length.

Return Code​

Nothing.

Sample Code​

CmdPostVectorSettings(0, 0.03, 0.03, 1, 1, 255, 16777215, 51400, 0, 0, 0, 1, 0, 0, 0, 0, 0, 100, 0, 0)
