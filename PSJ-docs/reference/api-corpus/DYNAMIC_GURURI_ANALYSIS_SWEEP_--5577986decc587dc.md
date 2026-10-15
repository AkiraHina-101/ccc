# DYNAMIC_GURURI_ANALYSIS_SWEEP()

DYNAMIC_GURURI_ANALYSIS_SWEEP()

説明​

外部ファイルに指定要素/周波数の結果を出力します。

構文​

DYNAMIC_GURURI_ANALYSIS_SWEEP(str strExportFilePath, cursor[] crlTargetElem, cursor crParentAnalysis, cursor crCoordinate, bool bAllModesUsed, str[] strlSelectedModesName, bool bUseDampingFactor, double dDampingFactor, cursor crDampingFactorTable, double[] dlInputFrequency, double dStartPhase, int iStepNumber, bool bOutputMaximumGururiResult, int iPrincipleType, bool bAllCase, cursor crSelectedLoadCase, cursor crEdit)

入力​

1. str​

結果ファイルのパスを指定する文字列です。

2. cursor[]​

対象のソリッド要素を指定するCursorのリストです。

3. cursor​

処理対象のジョブを指定するCursorです。

4. cursor​

応答点の座標系を指定するCursorです。

5. bool​

全モードを使用するかどうかを指定する真偽値です。

6. str[]​

応答計算に使用される選択したモードを指定する文字列のリストです。bAllModesUsedが偽の場合に使用されます。

7. bool​

計算にダンピング係数を使用するかどうかを指定する真偽値です。

8. double​

ダンピング係数の値を指定するDoubleです。

9. cursor​

ダンピング係数のフィールドデータを指定するCursorです。

10. double[]​

解析の周波数値を指定するDoubleのリストです。

11. double​

分析する開始位相を指定するDoubleです。

12. int​

1周期の分割数を指定するIntegerです。

13. bool​

選択した主要タイプの最大結果を出力し、それをアセンブリウィンドウの別ツリーに保存するかどうかを指定する真偽値です。

14. int​

解析される主要結果タイプを指定するIntegerです。

15. bool​

現在のすべての負荷ケースを使用するかどうかを指定する真偽値です。

16. cursor​

分析する選択した負荷ケースを指定するCursorです。bAllLoadCasesが偽の場合に使用されます。

17. cursor​

既存の負荷条件を指定するCursorです。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

DYNAMIC_GURURI_ANALYSIS_SWEEP("path/to/the/file", [0:0], 0:0, 0:0, 1, [], 1, 1.0, 0:0, [], 0.0, 10, 1, 3, 1, 0:0, 0:0)
