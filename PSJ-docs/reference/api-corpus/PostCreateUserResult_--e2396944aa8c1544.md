# PostCreateUserResult()

PostCreateUserResult()

Description​

Create User Result.

Syntax​

PostCreateUserResult(cursor crTargetPostJob, int varType, string name, int resultSet, int timeStep, UserResultVar[] variables, bool useResultExp, bool useContourExp, bool useVectorExp, bool useDispExp, bool vectorType, string strResultExp, string strContourExp, string strVectorExpMag, string strVectorExps[0], string strVectorExps[1], string strVectorExps[2], string strDispExps[0], string strDispExps[1], string strDispExps[2], cursor Edit)

Inputs​

1. cursor ​

Post Job.

2. int ​

Variable type

3. string ​

Result Name.

4. int ​

Result set.

5. int ​

Time step.

6. ResultVar[] ​

Source results.
ResultVar contents are:

cursor - Post Job,

string - Name,

int - Step,

int - inc,

int - Result,

int - Component,

int - Location.

7.bool ​

Result Exp. flag

8. bool ​

Contour Exp. flag.

9.bool ​

Vector Exp. flag.

10. bool ​

Disp. Exp. flag.

11. bool ​

Vector Type.

12. string ​

Result Exp.

13. string ​

Contour Exp.

14. string ​

Vector Exp Magnitude.

15. string ​

Vector Exp X.

16. string ​

Vector Exp Y.

17. string ​

Vector Exp Z.

18. string ​

Disp Exps X.

19. string ​

Disp Exps Y.

20. string ​

Disp Exps Z.

21. cursor ​

Edit

Return Code​

Nothing.

Sample Code​

PostCreateUserResult(183:1, 3, "Expr1", 2, 1, [[183:1, "C1", 1, 1, 1, 0, 1], [183:1, "C2", 1, 1, 1, 1, 1]], 0, 1, 0, 0, 0, "", "C1*C2", "", "", "", "", "", "", "", 0:0)
