# AttachTemplateDiagram()

AttachTemplateDiagram()

Description​

Attach diagram setting to the specific template.

Syntax​

AttachTemplateDiagram(string templateName, int ScaleMethod, float ratioModel, float ratioScreen, color Highlight, color Positive, color Negative, bool UseContour, bool TwoSides, int HighlightTarget, float HighligValue1, float HighligValue2, int DisplayTarget)

Inputs​

1. string ​

Template name.

2. int ​

Scale Method. 0: Model size ratio, 1:Screen size ratio.

3. float ​

Model size ratio value.

4. float ​

Screen size ratio value.

5. color ​

Highlight color.

6. color ​

Positive color.

7. color ​

Negative color.

8. bool ​

Use Contour flag.

9. bool ​

Two Side flag.

10. int ​

Highlighting type

11. float ​

Highligting Value1

12. float ​

Highligting Value2

13. int ​

DisplayTarget

Return Code​

"1": Succeeded.

"0": Failed.

Sample Code​

AttachTemplateDiagram("My Template", 0, 0.03, 0.03, 255, 16777215, 51400, 0, 0, 0, 1, 0)
