# DYNAMIC_FREQ_ANALYSIS_LOADCASE()

DYNAMIC_FREQ_ANALYSIS_LOADCASE()

説明​

ぐるり解析のための負荷ケースを作成します。

構文​

DYNAMIC_FREQ_ANALYSIS_LOADCASE(int AnalysisType, cursor ParentAnalysis, string Name, double Factor, int NewID, cursor[] SelectedLoad, double[] TargetFactor, cursor Edit)

入力​

1. Int​

解析の種類を選択します。

2. Cursor​

親解析を特定するカーソルです。

3. String​

負荷ケースの名前です。

4. Double​

負荷ケースの係数です。

5. Int​

負荷ケースの新しいIDです。

6. Cursor[]​

選択した負荷を特定するカーソルのリストです。

7. Double[]​

目標係数を指定するダブルのリストです。

8. Cursor​

既存の負荷ケース条件を特定するカーソルです。

戻り値​

作成されたぐるり負荷ケースを特定するカーソルです。

サンプルコード​

DYNAMIC_FREQ_ANALYSIS_LOADCASE(1, 3:1, "LoadCase_1", 1.0, 1, [], [1.0], 0:0)
