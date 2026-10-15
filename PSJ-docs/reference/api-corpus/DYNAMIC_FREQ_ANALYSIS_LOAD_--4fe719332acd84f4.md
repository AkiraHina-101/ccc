# DYNAMIC_FREQ_ANALYSIS_LOAD()

DYNAMIC_FREQ_ANALYSIS_LOAD()

説明​

ぐるりに対して周波数応答定常励振入力を設定します。

構文​

DYNAMIC_FREQ_ANALYSIS_LOAD(int AnalysisType, cursor ParentAnalysis, cursor Coordinate, string Name, int LoadDirection, double[] Force, double Amplitude, double Delay, double Phase, bool Bf, double Bf, cursor BfTable, bool Ff, double Ff, cursor FfTable, bool UnitLoad, bool CentrifugalForce, cursor[] TargetNode, cursor Edit)

入力​

1. Int​

解析の種類を選択します。

2. Cursor​

親解析を指定するカーソル。

3. Cursor​

座標を指定するカーソル。

4. String​

負荷ケースの名前。

5. Int​

負荷の方向を選択します。

6. Double[]​

力を指定する Double リスト。

7. Double​

力の振幅を指定する Double。

8. Double​

力の遅れを指定する Double。

9. Double​

力の位相を指定する Double。

10. Bool​

B(f) の値を Double フォーマットまたはテーブルフォーマットで入力するかどうかを指定します。

11. Double​

B(f) の値を Double フォーマットで指定します。

12. Cursor​

B(f) の値をテーブルフォーマットで指定します。

13. Bool​

F(f) の値を Double フォーマットまたはテーブルフォーマットで入力するかどうかを指定します。

14. Double​

F(f) の値を Double フォーマットで指定します。

15. Cursor​

F(f) の値をテーブルフォーマットで指定します。

16. Bool​

ユニット負荷を使用するかどうかを指定します。

17. Bool​

遠心力を使用するかどうかを指定します。

18. Cursor[]​

対象節点を指定する Cursor リスト。

19. Cursor​

既存の負荷条件を指定する Cursor。

戻り値​

作成されたぐるり負荷条件を指定する Cursor。

サンプルコード​

DYNAMIC_FREQ_ANALYSIS_LOAD(0, 3:1, 2:1, "FRQLOAD_1", 0, [1.0,0.0,0.0], 1.0, 0.0, 0.0, False, 1.0, 2:1, False, 0.0, 2:1, False, False, [], 2:1)
