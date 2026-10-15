# Macro-Calculation-PostToolsSubcasePeakHoldEx()

Macro-Calculation-PostToolsSubcasePeakHoldEx()

説明​

2つ以上の選択されたサブケースから、応力を最大化するサブケース、MISES応力、ビームMAX、MIN、およびAXIALを作成します。

構文​

PostToolsSubcasePeakHoldEx(int iAnalysisType, bool bFatigue, double dQb, double dQw, double dQy, str strSubcaseName, int iSubcaseID, map mapPeakHoldSubcases)

入力​

1. int​

解析タイプを指定する整数です。

2. bool​

疲労計算を使用するかどうかを指定するブール値です。

3. double​

材料の引張強度を指定する倍精度です。

4. double​

材料の疲労限界を指定する倍精度です。

5. double​

材料の降伏応力を指定する倍精度です。

6. str​

作成する新しいサブケースの名前を指定する文字列です。

7. int​

作成する新しいサブケースのIDを指定する整数です。

8. map​

選択されたサブケースを指定してピークホールド結果を作成する PEAKHOLD_SUBCASE_MAP のマップです。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

PostToolsSubcasePeakHoldEx(1, 1, 270.0, 130.0, 165.0, "Subcase 1 Peak Hold", 1, [(1, [(1, "", 1, 1), (2, "", 1, 1), (3, "", 1, 1), (4, "", 1, 1), (5, "", 1, 1)])])
