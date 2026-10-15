# CmdWriteCSVForGeneralReportModal()

CmdWriteCSVForGeneralReportModal()

説明​

CSVファイルにモーダルレポートをエクスポートします。

構文​

CmdWriteCSVForGeneralReportModal(string strPathFile, int ResultsInOnePage, bool bCheckusecurrentview, double dStartFrequency, double dEndFrequency)

入力​

1. String​

エクスポートするCSVファイルの名前。

2. int​

1スライド内の画像数。

3. bool​

現在の表示点を使用するかどうか。

4. double​

開始周波数。

5. double​

終了周波数。

戻り値​

なし。

サンプルコード​

CmdWriteCSVForGeneralReportModal("C:/Users/TECHNO~1/AppData/Local/Temp/TechnoStar/00/gen_post.csv", 1, 0, 30000, 60000)
