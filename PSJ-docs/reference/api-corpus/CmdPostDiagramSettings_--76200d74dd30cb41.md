# CmdPostDiagramSettings()

CmdPostDiagramSettings()

Description​

Diagram setting.

Syntax​

CmdPostDiagramSettings(int ScaleMethod, float ratioModel, float ratioScreen, color Highlight, color Positive, color Negative, bool UseContour, bool TwoSides, int HighlightTarget, float HighligValue1, float HighligValue2, int DisplayTarget)

Inputs​

1. int ​

Scale Method. 0: Model size ratio, 1:Screen size ratio.

2. float ​

Model size ratio value.

3. float ​

Screen size ratio value.

4. color ​

Highlight color.

5. color ​

Positive color.

6. color ​

Negative color.

7. bool ​

Use Contour flag.

8. bool ​

Two Side flag.

9. int ​

Highlighting type

10. float ​

Highligting Value1

11. float ​

Highligting Value2

12. int ​

DisplayTarget

Return Code​

Nothing.

Sample Code​

CmdPostDiagramSettings(0, 0.03, 0.03, 255, 16777215, 51400, 0, 1, 0, 0, 1, 0)
