# DYNAMIC_TRANS_ANALYSIS_LOAD()

DYNAMIC_TRANS_ANALYSIS_LOAD()

説明​

任意の励振条件を設定します。

構文​

DYNAMIC_TRANS_ANALYSIS_LOAD(cursor crParentAnalysis, cursor crCoordinate, str strName, int iLoadType, iLoadDirection, double[] dlForce, double dAmplitude, double dDelay, double dPhase, bool bFt, double dFt, cursor crFtTable, double dT1, double dT2, double dFrequency, double dExponent, double dPower, cursor[] crlTargetNodes, cursor crEdit)

入力​

1. cursor​

ターゲット解析を指定するカーソル。このパラメータがNoneに設定されると、新しい解析が作成されます。

2. cursor​

座標系を指定するカーソル。

3. str​

作成される負荷条件の名前を指定する文字列。

4. int​

負荷のタイプを指定する整数。

5. int​

振動方向を指定する整数。

6. double[]​

振動力のベクトルを指定する倍精度浮動小数点数のリスト。

7. double​

振動負荷の振幅を指定する倍精度浮動小数点数。

8. double​

時間遅延（秒）の値を指定する倍精度浮動小数点数。

9. double​

Cosine（TLOAD2）の負荷タイプの位相遅れ（角度）の値を指定する倍精度浮動小数点数。

10. bool​

時間履歴負荷を入力値または表として使用するかどうかを指定する論理値。

11. double​

時間履歴負荷の値を指定する倍精度浮動小数点数。

12. cursor​

時間履歴負荷のフィールドデータを指定するカーソル。

13. double​

Cosine（TLOAD2）の負荷タイプの振動開始時間を指定する倍精度浮動小数点数。

14. double​

Cosine（TLOAD2）の負荷タイプの振動終了時間を指定する倍精度浮動小数点数。

15. double​

Cosine（TLOAD2）の負荷タイプの周波数の値を指定する倍精度浮動小数点数。

16. double​

Cosine（TLOAD2）の負荷タイプの指数関数の値を指定する倍精度浮動小数点数。

17. double​

Cosine（TLOAD2）の負荷タイプの成長係数の値を指定する倍精度浮動小数点数。

18. cursor[]​

負荷条件を割り当てることができる選択節点を指定するカーソルのリスト。

19. cursor​

既存の負荷条件を指定するカーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

DYNAMIC_TRANS_ANALYSIS_LOAD(0:0, 0:0, "TRNLoad1", 0, 0, [1, 0, 0], 1.0, 0.0, 0.0, 1, 1.0, 0:0, 0.0, 1.0, 0.0, 0.0, 0.0, [0:0], 0:0)
