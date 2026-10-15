# Property1DPlot()

Property1DPlot()

説明​

1Dプロットのプロパティを作成します。

構文​

Property1DPlot(string strName, int iPlotID, cursor[] taTarget, cursor crCoord)

入力​

1. String​

プロット名

2. Int​

プロットID

3. Cursor[]​

対象エンティティのカーソル

4. Cursor​

ローカル座標を使用するかどうか（True = 27:*、False = 0:0）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Property1DPlot("PLOT_4", 4, [5:104, 10:692], 0:0)
