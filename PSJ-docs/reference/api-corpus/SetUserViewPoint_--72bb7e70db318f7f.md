# SetUserViewPoint()

SetUserViewPoint()

Description​

Set view point by value.

Syntax​

SetUserViewPoint(float trans[0], float trans[1], float trans[2], float trans[3], float trans[4], float trans[5], float trans[6], float trans[7], float trans[8], float trans[9], float trans[10], float trans[11], float trans[12], float trans[13], float trans[14], float trans[15], float Cent[0], float Cent[1], float Cent[2], float PanOffsetX, float PanOffsetY, float ScaleFactor, bool Rotate, bool Pan, bool Scale)

Inputs​

1. float ​

00 of 4x4 transform matrix (00 - 33).

2. float ​

01 of 4x4 transform matrix.

3. float ​

02 of 4x4 transform matrix.

4. float ​

03 of 4x4 transform matrix.

5. float ​

10 of 4x4 transform matrix.

6. float ​

11 of 4x4 transform matrix.

7. float ​

12 of 4x4 transform matrix.

8. float ​

13 of 4x4 transform matrix.

9. float ​

20 of 4x4 transform matrix.

10. float ​

21 of 4x4 transform matrix.

11. float ​

22 of 4x4 transform matrix.

12. float ​

23 of 4x4 transform matrix. 

13. float ​

30 of 4x4 transform matrix.

14. float ​

31 of 4x4 transform matrix. 

15. float ​

32 of 4x4 transform matrix.

16. float ​

33 of 4x4 transform matrix.

17. float ​

Rotation center x. 

18. float ​

Rotation center y.

19. float ​

Rotation center z. 

20. float ​

Offset x. 

21. float ​

Offset y. 

22. float ​

Scale Factor. 

23. bool ​

Rotate flag.

24. bool ​

Pan flag.

25. bool ​

Scale flag.

Return Code​

Nothing.

Sample Code​

SetUserViewPoint(-0.707107, -0.5, 0.5, 0, 0.707107, -0.5, 0.5, 0, 0, 0.707107, 0.707107, 0, 0, 0, 0, 1, 0.00188554, -0.00188527, 0.1, 0, 0, 0.211944, 1, 1, 1)
