# ResultOutputList()

ResultOutputList()

説明​

選択した結果をCSVファイルまたは汎用形式でエクスポートします。

構文​

ResultOutputList(string PathFile, cursor[] Bodies, int ResultType, int Output, int OutPutType, int Target, bool MidNode, int[] PostResultKeyAnalysis, int[] PostResultKeyResultSet, int[] PostResultKeyTimeStep, int[] PostResultKeyCatType)

入力​

1. String​

エクスポートするファイルパスを指定する文字列。

2. Cursor[]​

エクスポートするデータの選択された部分を指定するカーソルのリスト。

3. Int​

エクスポートする結果の種類を指定する整数。

4. Int​

すべての選択したサブケースを1つのファイルに出力するか、それとも各選択したサブケースごとに別々のファイルに出力するかを指定する整数。

5. Int​

出力ファイルの形式を指定する整数。

6. Int​

結果の出力位置を指定する整数。

7. Bool​

エクスポートされた結果に中間節点を有効にするかどうかを指定する真偽値。

8. Int[]​

選択した結果の属性を指定するリスト。

9. Int[]​

選択した結果セットの属性を指定するリスト。

10. Int[]​

選択した結果の時間ステップの属性を指定するリスト。

11. Int[]​

選択した結果のカテゴリータイプの属性を指定するリスト。

戻り値​

"1": 関数を実行できます。

"0": 関数を実行できません。

サンプルコード​

ResultOutputList("C:/temp/file.csv", [3:7, 3:8, 3:9, 3:2], 7, 0, 0, 0, 1, [1, 1, 1], [0, 0, 0], [0, 2, 4], [0, 0, 0])
