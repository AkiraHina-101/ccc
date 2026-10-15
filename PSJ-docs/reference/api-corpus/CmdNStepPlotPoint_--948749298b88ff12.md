# CmdNStepPlotPoint()

CmdNStepPlotPoint()

説明​

N-ステップ プロット（ポジション）を実行します。

構文​

CmdNStepPlotPoint(cursor PostJob, FacePointItem [] item, stepItem [] item, bool CreateMarkup, string XResult, string XComponent, int XLoc)

入力​

3-6 は位置リストのセットです。
7-9 はプロット対象リストのセットです。

1. cursor  ​

ポストジョブ。

2. FacePointItem[]  ​

以下の項目から構成されるリスト：

int : フェース ポイントが所属する要素の ID。

float : フェース ポイントの X 座標。

float : フェース ポイントの Y 座標。

float : フェース ポイントの Z 座標。

3. stepItem []  ​

以下の項目から構成されるリスト：

int : 解析タイプ

int : 結果セット

int : タイムステップ

4. float  ​

要素にメモを作成するかどうか

5. string  ​

X 軸データ - 結果。

6. int  ​

X 軸データ - コンポーネント

7. int  ​

X 軸データ - データの位置

戻り値​

なし。

サンプルコード​

CmdNStepPlotPoint(183:1, [[2603, 10.427549, -0.598614, 13.343364],[2615, 10.235324, -1.799746, 12.080006],[2666, 9.768378, 3.305036, 14.630617]], [[1,0,0], [1,1,5], [1,2,5], [1,3,5], [1,4,5]], 1)
