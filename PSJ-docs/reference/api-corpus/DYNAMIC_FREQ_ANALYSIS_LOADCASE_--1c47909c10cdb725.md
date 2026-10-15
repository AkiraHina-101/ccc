# DYNAMIC_FREQ_ANALYSIS_LOADCASE()

DYNAMIC_FREQ_ANALYSIS_LOADCASE()

説明​

周波数解析の負荷ケースを作成します。

構文​

DYNAMIC_FREQ_ANALYSIS_LOADCASE(int 解析タイプ, cursor 親解析, string 名前, double 係数, int 新しいID, cursor[] 選択された負荷, double[] ターゲット係数, cursor 編集対象)

入力​

1. int​

解析タイプ

2. cursor​

親解析

3. string​

名前

4. double​

係数

5. int​

ID

6. cursor[]​

選択された負荷

7. double[]​

各選択された負荷の係数。

8. cursor​

変更する場合の対象負荷ケース。

戻り値​

なし。

サンプルコード​

DYNAMIC_FREQ_ANALYSIS_LOADCASE(1, 195:1, "LoadCase1", 3, 2, [197:3, 197:4], [1, 4], 0:0)
