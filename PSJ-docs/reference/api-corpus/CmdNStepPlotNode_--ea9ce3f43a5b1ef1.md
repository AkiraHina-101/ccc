# CmdNStepPlotNode()

CmdNStepPlotNode()

説明​

Nステッププロット（節点）を実行します。

構文​

CmdNStepPlotNode(cursor PostJob, int[] nodes, [int analysisType, int resultSet, int timeStep], bool CreateMarkup, string XResult, string XComponent, int XLoc)

入力​

3-5はプロット対象リストのセットです。

1. int​

ポストジョブ。

2. cursor[]​

対象節点のリスト

3. int​

解析タイプ

4. int​

結果セット

5. int​

タイムステップ

6. bool​

節点にノートを作成するかどうか

7. string​

X軸データ - 結果。

8. int​

X軸データ - コンポーネント

9. int​

X軸データ - データ位置

戻り値​

なし。

サンプルコード​

CmdNStepPlotNode(183:1, [988], [[1,0,0], [1,1,5], [1,2,5], [1,3,5], [1,4,5]], 1)
