# JPT.CloseAllGraphViews()

JPT.CloseAllGraphViews()

説明​

すべてのグラフ表示（グラフウィンドウ）を閉じます。

構文​

JPT.CloseAllGraphViews()

入力​

このユーティリティ機能には入力値は必要ありません。

戻り値​

このユーティリティ機能には出力値がありません。

サンプルコード​

# データのインポートと結果のロード
resultDoc=JPT.GetActiveDocument()
samplePath1=JPT.GetProgramPath() + '\\SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2'
Home.ImportResults.Nastran(strPath=samplePath1, dFaceAngle=60.16, dEdgeAngle=60.16)
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(
                    postResultKey=PostResultKey(
                        iAnalysisType=1, 
                        iResultSet=1, 
                        iTimeStep=1, 
                        strResultName="Displacement", 
                        strResultCompName="Translational", 
                        iResultPos=1), 
                        postDataOp=PostDataOp(iResultLocation=1, iOptionCoord=1))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                        iAnalysisType=1, 
                        iResultSet=1, 
                        iTimeStep=1, 
                        strResultName="Displacement", 
                        strResultCompName="Translational"))
Post.EnableMiddleNodes()
JPT.Exec('ViewShowMesh(1)')
Post.Note.Node(crlTargets=[RONode(60, 72, 60, 112, 114, 127)])

# 新しいグラフビューにグラフを作成します。
Chart.CreateGraph(iNumData=6, 
                strLineTitle="Nodal value for X Y Plot", 
                dlAxisDataX=[1.0, 2.0, 3.0, 4.0, 5.0, 6.0], 
                dlAxisDataY=[0.000737, 0.001655, 0.000694, 0.0, 0.000769, 0.0], 
                strChartTitle="Nodal value for X Y Plot", 
                strAxisTitleX="Index", 
                strAxisTitleY="Data", 
                bNewChart=False)
WatchData.Toolbar.DeleteAll(iTabIndex=0)

# 新しいグラフビューに別のグラフを作成します。
JPT.SetActiveDocumentByID(resultDoc.docID, 1)
Post.Note.Node(crlTargets=[RONode(5, 16, 8, 15, 7, 114, 109)])
Chart.CreateGraph(iNumData=7, 
                strLineTitle="Nodal value for X Y Plot", 
                dlAxisDataX=[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0], 
                dlAxisDataY=[0.00071, 0.001655, 0.000864, 0.000871, 0.000813, 0.000379, 0.0], 
                strChartTitle="Nodal value for X Y Plot", 
                strAxisTitleX="Index", 
                strAxisTitleY="Data", 
                bNewChart=False)

# 別のデータをインポートして結果をロードします。
JPT.CreateNewDocument()
samplePath2=JPT.GetProgramPath() + '\\SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2'
Home.ImportResults.Nastran(strPath=samplePath2, dFaceAngle=60.16, dEdgeAngle=60.16)
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(
                    postResultKey=PostResultKey(
                        iAnalysisType=2, 
                        iResultSet=1, 
                        iTimeStep=1, 
                        strResultName="Stress", 
                        strResultCompName="YY", 
                        iResultPos=4), 
                    postDataOp=PostDataOp(
                        iResultLocation=1, 
                        iOptionCoord=1, 
                        iOptionConversion=1, 
                        iOptionContinuous=8))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                        iAnalysisType=2, 
                        iResultSet=1, 
                        iTimeStep=1, 
                        strResultName="Stress", 
                        strResultCompName="YY"))
JPT.Exec('ViewShowMesh(1)')
Post.Note.Node(crlTargets=[RONode(131, 127, 129, 45)])

# 新しいグラフビューにグラフを作成します。
Chart.CreateGraph(iNumData=4, 
                strLineTitle="Nodal value for X Y Plot", 
                dlAxisDataX=[1.0, 2.0, 3.0, 4.0], 
                dlAxisDataY=[-5434540.0, 5421610.0, 3557350.0, 5421610.0], 
                strChartTitle="Nodal value for X Y Plot", 
                strAxisTitleX="Index", 
                strAxisTitleY="Data", 
                bNewChart=False)

# すべてのグラフ表示を閉じます。
JPT.CloseAllGraphViews()
