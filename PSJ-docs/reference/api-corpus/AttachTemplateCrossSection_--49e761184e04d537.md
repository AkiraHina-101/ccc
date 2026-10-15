# AttachTemplateCrossSection()

AttachTemplateCrossSection()

Description​

Attach setting of cross section to specified template.

Syntax​

AttachTemplateCrossSection(string NewTemplateName, bool Capping, bool CuttingEdge, bool SectionElem, bool Meshline, bool Show, bool Flip, bool BoxView, bool Tranparency, double PercentTranparency, color Tranparncy, float [] Matrix, vector Pos, vector PrevPos, vector RotationCenter, vector DirectAngle, float Size, float PlnSize, float BoxSize)

Inputs​

1 string ​

Template name

2 bool ​

Capping flag.

3 bool ​

Cutting Edge flag.

4 bool ​

Section Elemments flag.

5 bool ​

Mesh Line flag.

6 bool ​

Show flag.

7 bool ​

Flip flag.

8 bool ​

Box view flag.

9 bool ​

Tranparency flag.

10 double ​

Percent of tranparency.

11 color ​

Color of tranparncy.

12 float [] ​

Transform matrix of cross section.

13 vector ​

Position x,y,z.

14 vector ​

Previous position x,y,z.

15 vector ​

Rotation center x,y,z.

16 vector ​

Direct angle.

17 float ​

Size.

18 float ​

Pln size.

19 float ​

Box size.

Return Code​

"1": Succeeded.

"0": Failed.

Sample Code​

AttachTemplateCrossSection("My Template", 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, [-1, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1], [1e-10, 1e-10, 1e-10], [0, 0, 0], [1e-10, 1e-10, 1e-10], [0, 0, 0], 0.25, 0.2, 0.025)
