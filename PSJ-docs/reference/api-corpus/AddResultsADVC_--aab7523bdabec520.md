# AddResultsADVC()

AddResultsADVC()

説明​

現在のJupiterデータベースにADVCの結果を追加します。

構文​

AddResultsADVC(str[] strlPaths, bool bMergeTree, bool bADVCProcessNameRule, bool bDisplayNAResult, str strPathSelectResultFile)

入力​

1. str[]​

インポートに使用されるADVCファイルのリストを指定する文字列のリスト。

2. bool​

既存の文書に含まれていない差異を追加するかどうかを指定するブール値。

3. bool​

ADVC側で定義されたADVCプロセスIDが表示されるかどうかを指定するブール値。

4. bool​

ADVCでの「NA結果表示」オプションが有効になっているかどうかを指定するブール値です。TRUEに設定すると、欠落しているデータに対して「データ：---」、ウォッチデータ注に「データなし」と表示され、節点出力結果にのみ適用されます。 FALSEに設定すると、標準のデータ表示ルールが適用されます。

5. str​

結果ファイルへのパスを指定する文字列。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AddResultsADVC(["path/to/the/file"], 1, 1, 1, "")
