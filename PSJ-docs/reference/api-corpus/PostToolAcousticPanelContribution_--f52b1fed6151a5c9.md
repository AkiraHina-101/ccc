# PostToolAcousticPanelContribution()

PostToolAcousticPanelContribution()

説明​

Actranの要素寄与結果に基づいて、各パネルのプロットラインを作成します。

構文​

PostToolAcousticPanelContribution(int[] ilLoadCase, cursor[] crlProperty, int iDocumentAreaUnit, bool bCalSum)

入力​

1. int[]​

要素寄与プロットラインの選択された負荷ケースを指定する整数のリスト。

2. cursor[]​

要素寄与プロットラインのプロパティパネルを指定するカーソルのリスト。

3. int​

面積単位を指定する整数。

4. bool​

要素の寄与を合計するかどうかを指定する真偽値（True = 1、False = 0）。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

PostToolAcousticPanelContribution([], [0:0], 0, 1)
