# DYNAMIC_FREQ_ANALYSIS_LOAD()

DYNAMIC_FREQ_ANALYSIS_LOAD()

説明​

周波数応答解析のための負荷を作成します。

構文​

DYNAMIC_FREQ_ANALYSIS_LOAD(int AnalysisType, cursor ParentAnalysis, cursor Coord, string Name, int LoadPtn, vector Force, 
donble Amplitude, double Delay, double Phase, bool Bf, double Bf, cursor BfCurve, bool Ff, double Ff, cursor FfCurve, bool UnitLoad, 
bool CentripetalForce, cursor[] Target, cursor Edit)

入力​

1. string  ​

解析タイプ

2. int  ​

親解析

3. cursor  ​

座標

4. string  ​

負荷名

5. int  ​

方向
0: X
1: Y
2: Z
3: RX
4: RY
5: RZ
6: 正常

6. vector  ​

ベクトル形式の力の方向です。

7. double  ​

振幅

8. double  ​

遅延

9. double  ​

位相

10. bool  ​

B(f) テーブルの入力フラグ

11. double  ​

テーブルなしの B(f) 値 = 1.0

12. cursor  ​

B(f) テーブルへのカーソル

13. bool  ​

F(f) テーブルの入力フラグ

14. double  ​

テーブルなしの F(f) 値 = 0.0

15. cursor  ​

F(f) テーブルへのカーソル

16. bool  ​

単位負荷フラグ

17. bool  ​

mr*omega^2 フラグ

18. cursor[]  ​

対象節点

12. cursor  ​

変更時の対象負荷

戻り値​

何もありません。

サンプルコード​

DYNAMIC_FREQ_ANALYSIS_LOAD(0, 0:0, 0:0, "FRQLOAD10", 2, [0, 0, 1], 1, 1, 1, 0, 1, 0:0, 0, 0, 0:0, 0, 0, [10:9513], 0:0)
