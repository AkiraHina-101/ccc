# ALIGNMENTBYOOBB()

ALIGNMENTBYOOBB()

Description​

Align the position of the target part with the position of the reference part by using OOBB (Object Oriented Boundary Box).

Syntax​

ALIGNMENTBYOOBB(Cursor refPart, Cursor movePart, int, coord, double[] translation, double[] rotation)

Inputs​

1. Cursor ​

Specifies the name of the custom note.

2. Cursor ​

Specifies the position of the note by coordinate [x,y,z].

3. int ​

Specifies fit position.

0	: Center of Part

1	: Center of Plane1

2	: Center of Plane2

3	: Center of Plane3

4	: Center of Plane4

5	: Center of Plane5

6	: Center of Plane6

7	: Center of Point 1 and 2

8	: Center of Point 2 and 3

9	: Center of Point 3 and 4

10 : Center of Point 4 and 1

11 : Center of Point 1 and 5

12 : Center of Point 2 and 6

13 : Center of Point 3 and 7

14 : Center of Point 4 and 8

15 : Center of Point 5 and 6

16 : Center of Point 6 and 7

17 : Center of Point 7 and 8

18 : Center of Point 8 and 5

19 : Point 1

20 : Point 2

21 : Point 3

22 : Point 4

23 : Point 5

24 : Point 6

25 : Point 7

26 : Point 8

4. double ​

Specifies a translation value [X, Y, Z]

5. double ​

Specifies a rotation value [X, Y, Z]

Return Code​

Nothing.

Sample Code​

ALIGNMENTBYOOBB(32, 31, 0, [0, 0, 0], [0, 0, 0])
