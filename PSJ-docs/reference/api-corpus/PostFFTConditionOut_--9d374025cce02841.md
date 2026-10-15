# PostFFTConditionOut()

PostFFTConditionOut()

説明​

FFT解析を実行します。

構文​

PostFFTConditionOut(str strName, cursor[] crlTargets, cursor[] crl2DElems, double dAngle, 
    cursor crTopNode, cursor crBotNode, double[] dlCenterPoint, double dBoreRadius, 
    double dBoreHeight, int iAxisDirection, double[] dlAxisDefined, int iDepthDirection, 
    int iNumOfLayerPoint, double[] dlLayers, int iCalculationMethod, double[] dlAxisX, 
    cursor crEdit)

入力​

1. str​

ボアシリンダーの名前を指定する文字列です。

2. cursor[]​

FFT解析を実行する対象パートを指定するCursorのリストです。

3. cursor[]​

選択された2D要素を指定するCursorのリストです。

4. double​

対象シリンダー表面を抽出する角度を指定するDoubleです。

5. cursor​

ボアシリンダー表面の上端を決定する節点を指定するCursorです。

6. cursor​

ボアシリンダー表面の下端を決定し、ボアの高さも定義する節点を指定するCursorです。

7. double[]​

ボア座標系の中心座標を指定するDoubleのリストです。

8. double​

ボアシリンダーの半径を指定するDoubleです。

9. double​

ボアシリンダーの高さを指定するDoubleです。

10. int​

グローバル座標系X、Y、Zまたは任意の方向でボアシリンダーの軸方向を指定する整数です。

11. double[]​

定義されたボアシリンダーの軸方向を指定するDoubleのリストです。

12. int​

深さ方向を指定する整数です。

13. int​

1つの層における計算点の数を指定する整数です。

14. double[]​

各層の深さ値と深さごとの計算点数を指定するDoubleのリストです。

15. int​

計算方法を指定する整数です。

16. double[]​

ボアシリンダーのX軸方向を指定するDoubleのリストです。

17. cursor​

既存のFFT条件を指定するCursorです。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

PostFFTConditionOut("BORE_1", [0:0], [0:0], 20.0, 0:0, 0:0, [0.0, 0.0, 0.0], 0.0, 0.0, 3, [0.0, 0.0, 0.0], 
    0, 36, [], 0, [0.0, 0.0, 0.0], 0:0)
