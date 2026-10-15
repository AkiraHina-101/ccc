# PostCreateUserResult()

PostCreateUserResult()

説明​

ユーザー結果を作成します。

構文​

PostCreateUserResult(cursor crTargetPostJob, int varType, string name, int resultSet, int timeStep, UserResultVar[] variables, bool useResultExp, bool useContourExp, bool useVectorExp, bool useDispExp, bool vectorType, string strResultExp, string strContourExp, string strVectorExpMag, string strVectorExps[0], string strVectorExps[1], string strVectorExps[2], string strDispExps[0], string strDispExps[1], string strDispExps[2], cursor Edit)

入力​

1. cursor ​

ポストジョブ。

2. int ​

変数の種類

3. string ​

結果の名前。

4. int ​

結果セット。

5. int ​

時間ステップ。

6. ResultVar[] ​

ソース結果。
ResultVarの内容は次のとおりです：

cursor - ポストジョブ,

string - 名前,

int - ステップ,

int - inc,

int - 結果,

int - コンポーネント,

int - 位置.

7. bool ​

結果Exp. フラグ

8. bool ​

輪郭Exp. フラグ。

9. bool ​

ベクトルExp. フラグ。

10. bool ​

ディスプ. Exp. フラグ。

11. bool ​

ベクトルの種類。

12. string ​

結果Exp.

13. string ​

輪郭Exp.

14. string ​

ベクトルExpの大きさ。

15. string ​

ベクトルExp X.

16. string ​

ベクトルExp Y.

17. string ​

ベクトルExp Z.

18. string ​

ディスプエクスプ X.

19. string ​

ディスプエクスプ Y.

20. string ​

ディスプエクスプ Z.

21. cursor ​

編集

戻り値​

なし。

サンプルコード​

PostCreateUserResult(183:1, 3, "Expr1", 2, 1, [[183:1, "C1", 1, 1, 1, 0, 1], [183:1, "C2", 1, 1, 1, 1, 1]], 0, 1, 0, 0, 0, "", "C1*C2", "", "", "", "", "", "", "", 0:0)
