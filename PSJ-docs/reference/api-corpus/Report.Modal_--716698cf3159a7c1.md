# Report.Modal()

Report.Modal()

説明​

指定された範囲内の各周波数で固有値解析の結果を表示されたモーダル画像をキャプチャし、Microsoft Office PowerPoint に自動的に貼り付けます。

構文​

Report.Modal(...)

マクロ: CmdGeneralReportModal

リボン: Report » Modal

入力​

iResultInOnePage​

PowerPoint ファイルの1ページに貼り付ける結果画像の数を指定する Integer です。 オプションは1、2、4、6です。

デフォルト値は 1 です。

bUseCurrentView​

現在のビューを透視として使用するかどうかを指定する Boolean です。

デフォルト値は False です。

bExportPPT​

結果画像を PowerPoint にエクスポートするかどうかを指定する Boolean です。

デフォルト値は True です。

bExportImage​

結果画像をファイルに保存するかどうかを指定する Boolean です。

デフォルト値は False です。

dStartFrequency​

開始周波数を指定する Double です。 この値よりも低い周波数は無視されます。

デフォルト値は 0.0 です。

dEndFrequency​

終了周波数を指定する Double です。 この値よりも高い周波数は無視されます。

デフォルト値は 100.0 です。

strImagePath​

保存される画像ファイルのパスを指定する String です。

デフォルト値は "" です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# ポストモデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60, dEdgeAngle=60)

# モーダルレポートを作成
reportModal = Report.Modal(iResultInOnePage=2, dStartFrequency=10000.0, dEndFrequency=100000.0)
JPT.Debugger(reportModal)
