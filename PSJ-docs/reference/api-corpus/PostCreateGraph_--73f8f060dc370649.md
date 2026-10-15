# PostCreateGraph()

PostCreateGraph()

説明​

コンテキストメニューで非表示ターゲットを反転させる

構文​

PostCreateGraph(cursor TargetCurve, int NumData, string LineTitle, double[] AxisDataX, double[] AxisDataY, string ChartTitle, string AxisTitleX, string AxisTitleY, bool NewChart)

入力​

1. Cursor​

曲線ターゲットを指定するCursorです。

2. Int​

データの数を指定する整数です。

3. String​

ラインタイトルを指定する文字列です。

4. Double[]​

X軸のデータを指定するDouble Listです。

5. Double[]​

Y軸のデータを指定するDouble Listです。

6. String​

チャートタイトルを指定する文字列です。

7. String​

X軸のタイトルを指定する文字列です。

8. String​

Y軸のタイトルを指定する文字列です。

9. Bool​

新しいチャートを作成するかどうかを指定する真偽値です。

戻り値​

"1": 関数を実行できます。

"0": 関数を実行できません。

サンプルコード​

PostCreateGraph(3:1,1,"",[0.0,1.0],[1.0,2.0],"","","",True)
