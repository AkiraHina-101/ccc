# PostToolsSubcaseSafetyFactor()

PostToolsSubcaseSafetyFactor()

説明​

各パートの許容差に基づいて選択したサブケースから安全係数を計算してサブケースを作成します。

構文​

PostToolsSubcaseSafetyFactor(int iAnalysisType, int iResultSet, list int listSubcases, list SAFETY_ITEM listSafetyItems, int iSafetyType, str strResultName)

入力​

1. int​

解析タイプを指定する整数です。

2. int​

結果セットを指定する整数です。

3. list int​

選択したサブケースのIDを指定する整数のリストです。

4. list SAFETY_ITEM​

選択した対象の安全情報を指定する SAFETY_ITEM のリストです。

5. int​

安全計算の種類を指定する整数です。

6. str​

作成されるサブケースの名前を指定する文字列です。

戻り値コード​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

PostToolsSubcaseSafetyFactor(2, 1, [(1, "", 1, 1), (2, "", 1, 1), (3, "", 1, 1), (4, "", 1, 1), (5, "", 1, 1)], [(3:1, 1), (3:2, 1), (3:3, 1)], 1, "Safety Break2")
