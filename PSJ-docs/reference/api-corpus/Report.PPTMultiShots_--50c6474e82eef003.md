# Report.PPTMultiShots()

Report.PPTMultiShots()

説明​

指定された範囲内の各周波数で読み込まれている結果タイプの画像をキャプチャし、Microsoft Office PowerPoint に自動的に貼り付けます。

構文​

Report.PPTMultiShots(...)

マクロ: CmdPostPPTMultiShots

リボン: Report » PPTMultiShots

入力​

dStartFrequency​

開始周波数を指定する Double です。

デフォルト値は 0.0 です。

dEndFrequency​

終了周波数を指定する Double です。

デフォルト値は 100.0 です。

戻り値​

実行プロセスが成功したかどうかを指定する Boolean 型です：

True: プロセスが正常に実行されました。

False: 機能を実行できません。

サンプルコード​

# ポストモデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# 結果をプロット
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=2, 
                iResultSet=1, 
                iTimeStep=1, 
                strResultName="Displacement", 
                strResultCompName="Translational", 
                iResultPos=1), 
                postDataOp=PostDataOp(
                iResultLocation=1, 
                iOptionCoord=4))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))

# PPT マルチショット
reportFile = Report.PPTMultiShots(dStartFrequency=10000.0, dEndFrequency=100000.0)
JPT.Debugger(reportFile)
