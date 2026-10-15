# CmdGeneralReportModal()

CmdGeneralReportModal()

説明​

指定された範囲内の各周波数での固有値解析の結果を表示されるモーダルイメージをキャプチャし、自動的に Microsoft Office PowerPoint に貼り付けます。

構文​

CmdGeneralReportModal(int ResultsInOnePage, bool UseCurrentView, bool ExportPPT, bool ExportImage, double StartFrequency, double EndFrequency, string ImgFilePath)

入力​

1. int ​

PowerPoint ファイルの1ページに貼り付ける結果画像の数を指定する整数。

2. bool ​

Perspective として現在のビューを使用するかどうかを指定するブール値。

3. bool ​

結果イメージを PowerPoint にエクスポートするかどうかを指定するブール値。

4. bool ​

結果イメージをファイルに保存するかどうかを指定するブール値。
デフォルト値は False です。

5. double ​

開始周波数を指定する倍精度浮動小数点数。

6. double ​

終了周波数を指定する倍精度浮動小数点数。

7. string ​

指定された形式で保存される画像ファイルのパスを指定する文字列。

戻り値​

"1": 関数を実行できます。

"0": 関数を実行できません。

サンプルコード​

CmdGeneralReportModal(2,False,True,False,0.0,100.0,"")
