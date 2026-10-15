# CmdShowPostDeformation()

CmdShowPostDeformation()

説明​

変形を表示します。

構文​

CmdShowPostDeformation(Cursor crPostJob,
    int analysisType, int resultSet, int timeStep, int opComplex, float phaseAngle, int scaleMethod, float dispRatio, bool eachDispComp, 
    float dispRatioEachX,  float dispRatioEachY, float dispRatioEachZ, bool bApplyAll)

入力​

1. Cursor​

ポストジョブのカーソルです。

2. int​

解析タイプです。

3. PostResultKey::int​

解析IDです。

4. int​

結果セットです。

5. int​

タイムステップです。

6. string​

結果の名前です。

7. string​

コンポーネントの名前です。

8. int​

opComplexです。

9. float​

phaseAngleです。

10. int​

スケーリング方法です。

11. float​

表示比率です。

12. bool​

各方向の比率フラグです。

13. float​

変形 X です。

14. float​

変形 Y です。

15. float​

変形 Z です。

16. bool​

すべて適用フラグです。

戻り値​

なし

サンプルコード​

CmdShowPostDeformation(183:1, 2, 0, 1, 1, Displacement, Translational, 0, 0.000000, 0, 0.070000, 0, 0.070000, 0.070000, 0.070000, 0)
