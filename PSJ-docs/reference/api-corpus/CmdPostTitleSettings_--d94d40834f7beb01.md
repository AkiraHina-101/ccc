# CmdPostTitleSettings()

CmdPostTitleSettings()

Description​

Title setting.

Syntax​

CmdPostTitleSettings(bool ResultName,bool Convection,bool Unit,bool Coordinate,bool TotalMaxMin,bool FileName,bool Location,bool VisibleMaxMin,bool Animation,bool DeformRatio,bool Detail,int SizeTitleTarget,int SizeDesTarget,int ResultTitle,color ResultTitle,bool ResultTitle,int ResultDescription,color ResultDescription,bool ResultDescription,bool UseBackground,color FillBackground,color BorderBackground,float Percentage)

Inputs​

1. bool ​

Result Name flag.

2. bool ​

Convection flag.

3. bool ​

Unit flag.

4. bool ​

Coordinate flag.

5. bool ​

Total Max/Min flag.

6. bool ​

File Name flag.

7. bool ​

Location flag.

8. bool ​

Visible Max/Min flag.

9. bool ​

Animation flag.

10. bool ​

Deform Ratio flag.

11. bool ​

Detail flag.

12. int ​

Font Size of Result Title.

13. int ​

Font Size of Result Description.

14. int ​

Result Title,

15. color​

Color of Result Title,

16. bool ​

Bold flag of Result Title,

17. int ​

Result Description,

18. color​

Color of Result Description.

19. bool ​

Bold flag of Result Description,

20. bool ​

Use Background flag.

21. color​

Background color

22. color​

BorderBackground,

23. float​

Transparency.

Return Code​

Nothing.

Sample Code​

CmdPostTitleSettings(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 5, 6, 16777215, 1, 5, 16777215, 0, 0, 16777215, 16777215, 0.500000)
